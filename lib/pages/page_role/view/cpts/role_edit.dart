import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kk_etcd_go/internal/service_hub/role/api_def/RoleGrantPermission.pb.dart';
import 'package:kk_etcd_go/internal/service_hub/role/api_def/RoleRevokePermission.pb.dart';
import 'package:kk_etcd_go/kk_etcd_models/pb_role_kk_etcd.pb.dart';

import 'package:kk_etcd_ui/l10n/l10n.dart';
import 'package:kk_etcd_ui/pages/page_role/logic/state_role.dart';
import 'package:kk_etcd_ui/utils/tools/util_permission.dart';
import 'package:kk_ui/kk_widget/kk_alert_dialog.dart';

import 'package:kk_ui/kk_widget/kk_card.dart';
import 'package:kk_ui/kk_widget/kk_snack_bar.dart';

class RoleEdit extends ConsumerStatefulWidget {
  const RoleEdit({super.key});

  @override
  ConsumerState<RoleEdit> createState() => _RoleEditState();
}

class _RoleEditState extends ConsumerState<RoleEdit> {
  @override
  Widget build(BuildContext context) {
    var readRole = ref.read(roleProvider.notifier);
    var watchRole = ref.watch(roleProvider);
    List<Widget> permissionTitles = [
      Row(
        children: [Text(lTr(context).read), const Icon(Icons.info_outline)],
      ),
      Row(
        children: [Text(lTr(context).write), const Icon(Icons.edit_outlined)],
      ),
      Row(
        children: [
          Text(lTr(context).readWrite),
          const Icon(Icons.all_inclusive_outlined),
        ],
      ),
    ];

    return Scaffold(
      body: Column(
        children: [
          KKCard(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Text("${lTr(context).role}:"),
                const SizedBox(width: 5),
                Text(watchRole.currentRole.name),
                IconButton(
                    onPressed: () {
                      if (watchRole.currentRole.name.isEmpty) {
                        KKSnackBar.warn(
                            context, const Text('select a role first!'));
                        return;
                      }
                      addPermDialog();
                    },
                    icon: const Icon(Icons.add_circle_outline,
                        color: Colors.blue))
              ],
            ),
          ),
          Expanded(
              child: ListView(
                children: [
                  KKCard(
                    padding: const EdgeInsets.all(20),
                    child: DataTable(
                      columns: <DataColumn>[
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              lTr(context).key,
                              style: const TextStyle(
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              lTr(context).rangeEnd,
                              style: const TextStyle(
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              lTr(context).permission,
                              style: const TextStyle(
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              lTr(context).action,
                              style: const TextStyle(
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                      ],
                      rows: assembleData(),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }

  List<DataRow> assembleData() {
    var readRole = ref.read(roleProvider.notifier);
    var watchRole = ref.watch(roleProvider);
    List<DataRow> configDataRows = [];
    for (PBPermission element in watchRole.currentRole.perms) {
      configDataRows.add(
        DataRow(
          cells: <DataCell>[
            DataCell(Text(element.key)),
            DataCell(Text(element.rangeEnd)),
            DataCell(Text(UtilPermission.getPermissionType(
                context, element.permissionType))),
            DataCell(ElevatedButton(
              onPressed: () async {
                bool ok = await readRole
                    .roleRevokePermission(RoleRevokePermission_Input(
                  name: watchRole.currentRole.name,
                  key: element.key,
                  rangeEnd: element.rangeEnd,
                ));
                if (ok) {
                  watchRole.currentRole.perms.removeWhere((e) {
                    return e.key == element.key &&
                        e.rangeEnd == element.rangeEnd;
                  });
                  readRole.setCurrentRole(PBRole(
                    name: watchRole.currentRole.name,
                    perms: watchRole.currentRole.perms,
                  ));
                }
              },
              child: Text(
                lTr(context).delete,
                style: const TextStyle(color: Colors.red),
              ),
            )),
          ],
        ),
      );
    }
    return configDataRows;
  }

  void addPermDialog() {
    int permissionREAD = 0;
    int permissionWRITE = 1;
    int permissionREADWRITE = 2;
    final formKey = GlobalKey<FormState>();

    var readRole = ref.read(roleProvider.notifier);
    var watchRole = ref.watch(roleProvider);
    PBPermission inputPerm = PBPermission();
    kKShowDialog(
      context,
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          // 你的Dialog内容，这里可以使用setState
          return KKAlertDialog(
            title: null,
            content: Form(
              key: formKey,
              child: Column(
                children: [
                  KKCard(
                    padding: const EdgeInsets.all(20),
                    child: TextFormField(
                      initialValue: watchRole.currentRole.name,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        icon: Text(lTr(context).role),
                      ),
                      readOnly: true,
                      maxLines: 10,
                      minLines: 1,
                    ),
                  ),
                  KKCard(
                    padding: const EdgeInsets.all(20),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        icon: Text(lTr(context).key),
                      ),
                      maxLines: 10,
                      minLines: 1,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'key could empty';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        inputPerm.key = value;
                      },
                    ),
                  ),
                  KKCard(
                    padding: const EdgeInsets.all(20),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        icon: Text(lTr(context).rangeEnd),
                      ),
                      maxLines: 10,
                      minLines: 1,
                      onChanged: (value) {
                        inputPerm.rangeEnd = value;
                      },
                    ),
                  ),
                  KKCard(
                    padding: const EdgeInsets.all(20),
                    child: Row(children: [
                      Text(lTr(context).permission),
                      Flexible(
                          child: Column(children: [
                            RadioListTile(
                              title: Text(lTr(context).read),
                              value: permissionREAD,
                              groupValue: inputPerm.permissionType,
                              onChanged: (value) {
                                setState(() {
                                  inputPerm.permissionType = value!;
                                });
                              },
                            ),
                            RadioListTile(
                              title: Text(lTr(context).write),
                              value: permissionWRITE,
                              groupValue: inputPerm.permissionType,
                              onChanged: (value) {
                                setState(() {
                                  inputPerm.permissionType = value!;
                                });
                              },
                            ),
                            RadioListTile(
                              title: Text(lTr(context).readWrite),
                              value: permissionREADWRITE,
                              groupValue: inputPerm.permissionType,
                              onChanged: (value) {
                                setState(() {
                                  inputPerm.permissionType = value!;
                                });
                              },
                            ),
                          ])),
                    ]),
                  ),
                ],
              ),
            ),
            confirmFunc: () async {
              if (formKey.currentState!.validate()) {
                bool ok = await readRole.roleGrantPermission(
                  RoleGrantPermission_Input(
                    name: watchRole.currentRole.name,
                    perm: inputPerm,
                  ),
                );
                if (ok) {
                  watchRole.currentRole.perms.add(inputPerm);
                  readRole.setCurrentRole(PBRole(
                    name: watchRole.currentRole.name,
                    perms: watchRole.currentRole.perms,
                  ));
                  return Future.value(true);
                }
              }
              return Future.value(false);
            },
          );
        },
      ),
    );
  }
}

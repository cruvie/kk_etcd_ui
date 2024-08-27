import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kk_etcd_go/kk_etcd_models/api_role_kk_etcd.pb.dart';
import 'package:kk_etcd_go/kk_etcd_models/pb_role_kk_etcd.pb.dart';

import 'package:kk_etcd_ui/l10n/l10n.dart';
import 'package:kk_etcd_ui/pages/page_role/logic/state_role.dart';
import 'package:kk_etcd_ui/utils/tools/util_permission.dart';
import 'package:kk_ui/kk_widget/kk_alert_dialog.dart';

import 'package:kk_ui/kk_widget/kk_card.dart';

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

    return ListView(
      children: [
        KKCard(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Text(lTr(context).role),
              Text(watchRole.currentRole.name)
            ],
          ),
        ),
        KKCard(
          padding: const EdgeInsets.all(20),
          child: DataTable(
            columns: <DataColumn>[
              DataColumn(
                label: Expanded(
                  child: Text(
                    lTr(context).key,
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    lTr(context).rangeEnd,
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    lTr(context).permission,
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    lTr(context).action,
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            ],
            rows: assembleData(),
          ),
        ),
      ],
    );
  }

  List<DataRow> assembleData() {
    var readRole = ref.read(roleProvider.notifier);
    var watchRole = ref.watch(roleProvider);
    List<DataRow> configDataRows = [];
    for (Permission element in watchRole.currentRole.perms) {
      configDataRows.add(
        DataRow(
          cells: <DataCell>[
            DataCell(Text(element.key)),
            DataCell(Text(element.rangeEnd)),
            DataCell(Text(UtilPermission.getPermissionType(
                context, element.permissionType))),
            DataCell(ElevatedButton(
              onPressed: () {
                //todo change RoleGrantPermissionParam
                readRole.roleRevokePermission(RoleGrantPermissionParam());
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

  int permissionREAD = 0;
  int permissionWRITE = 1;
  int permissionREADWRITE = 2;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final keyController = TextEditingController();
  final rangeEndController = TextEditingController();

  Permission inputPerm = Permission();

  addPermDialog() {
    var readRole = ref.read(roleProvider.notifier);
    var watchRole = ref.watch(roleProvider);
    nameController.text = watchRole.currentRole.name;
    Permission inputPerm = Permission();

    return kKShowDialog(
      context,
      KKAlertDialog(
        content: Form(
          key: _formKey,
          child: ListView(
            children: [
              KKCard(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: nameController,
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
                  controller: keyController,
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
                ),
              ),
              KKCard(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: rangeEndController,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    icon: Text(lTr(context).rangeEnd),
                  ),
                  maxLines: 10,
                  minLines: 1,
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
          if (_formKey.currentState!.validate()) {
            inputPerm.key = keyController.text;
            inputPerm.rangeEnd = rangeEndController.text;
            readRole.addCurrentRolePerm(inputPerm);
            await readRole.roleGrantPermission(
              RoleGrantPermissionParam(
                name: watchRole.currentRole.name,
                perm: inputPerm,
              ),
            );
          }
          return Future.value(true);
        },
      ),
    );
  }
}

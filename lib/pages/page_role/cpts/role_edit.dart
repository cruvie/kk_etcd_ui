import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:kk_etcd_ui/l10n/l10n.dart';
import 'package:kk_etcd_ui/page_logics/logic_etcd/logic_etcd.dart';
import 'package:kk_ui/kk_widget/kk_card.dart';

class RoleEdit extends StatefulWidget {
  const RoleEdit({super.key});

  @override
  State<RoleEdit> createState() => _RoleEditState();
}

class _RoleEditState extends State<RoleEdit> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final keyController = TextEditingController();
  final rangeEndController = TextEditingController();
  final permissionTypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      nameController.text = LogicEtcd.to.currentRole.value.name;
      keyController.text = LogicEtcd.to.currentRole.value.key;
      rangeEndController.text = LogicEtcd.to.currentRole.value.rangeEnd;
      permissionTypeController.text =
          LogicEtcd.to.currentRole.value.permissionType.toString();

      return Form(
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
                    return 'value empty';
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
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'value empty';
                  }
                  return null;
                },
              ),
            ),
            KKCard(
              //todo 改为下拉框
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                controller: permissionTypeController,
                decoration: InputDecoration(
                  icon: Text(lTr(context).permission),
                ),
                readOnly: true,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'value empty';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    LogicEtcd.to.currentRole.value.name = nameController.text;
                    LogicEtcd.to.currentRole.value.key = keyController.text;
                    LogicEtcd.to.currentRole.value.rangeEnd =
                        rangeEndController.text;
                    LogicEtcd.to.currentRole.value.permissionType =
                        int.parse(permissionTypeController.text);

                    await LogicEtcd.to.roleGrantPermission(
                        context, LogicEtcd.to.currentRole.value);
                  }
                },
                child: Text(lTr(context).buttonSave),
              ),
            )
          ],
        ),
      );
    });
  }
}

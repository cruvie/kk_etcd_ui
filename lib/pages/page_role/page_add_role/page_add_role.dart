import 'package:flutter/material.dart';
import 'package:kk_etcd_ui/l10n/l10n.dart';
import 'package:kk_etcd_ui/page_logics/logic_etcd/logic_etcd.dart';
import 'package:kk_ui/kk_widget/kk_card.dart';
import 'package:kk_ui/kk_widget/kk_snack_bar.dart';

class PageAddRole extends StatefulWidget {
  const PageAddRole({super.key});

  @override
  State<PageAddRole> createState() => _PageAddRoleState();
}

class _PageAddRoleState extends State<PageAddRole> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
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
                maxLines: 10,
                minLines: 1,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    bool success =
                        await LogicEtcd.to.roleAdd(nameController.text);
                    if (context.mounted) {
                      if (success) {
                        KKSnackBar.ok(context, const Text("add succeed"));
                        nameController.clear();
                      } else {
                        KKSnackBar.error(context, const Text("add failed"));
                      }
                    }
                  }
                },
                child: Text(lTr(context).buttonSave),
              ),
            )
          ],
        ),
      ),
    );
  }
}

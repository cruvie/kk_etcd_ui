import 'package:flutter/material.dart';
import 'package:kk_etcd_ui/l10n/l10n.dart';
import 'package:kk_etcd_ui/page_logics/logic_etcd/logic_etcd.dart';
import 'package:kk_ui/kk_widget/index.dart';
import 'package:kk_ui/kk_widget/kk_snack_bar.dart';

class PageAddUser extends StatefulWidget {
  const PageAddUser({super.key});

  @override
  State<PageAddUser> createState() => _PageAddUserState();
}

class _PageAddUserState extends State<PageAddUser> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            KKCard(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextFormField(
                controller: _nameController,
                decoration:  InputDecoration(
                  icon: Text(lTr(context).username),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'username empty';
                  }
                  return null;
                },
              ),
            ),
            KKCard(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextFormField(
                controller: _passwordController,
                decoration:  InputDecoration(
                  icon: Text(lTr(context).password),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'password empty';
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
                    bool success = await logicEtcdRead(context).addUser(
                      _nameController.text,
                      _passwordController.text,
                    );
                    if (success && context.mounted) {
                      KKSnackBar.ok(context, const Text("add succeed"));
                      _nameController.clear();
                      _passwordController.clear();
                    } else {
                      KKSnackBar.error(context, const Text("add failed"));
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

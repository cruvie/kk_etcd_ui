import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/user/userAdd/api.pb.dart';
import 'package:kk_etcd_ui/l10n/l10n.dart';
import 'package:kk_etcd_ui/pages/page_user/logic/state_user.dart';

import 'package:kk_ui/kk_widget/kk_card.dart';

class PageAddUser extends ConsumerStatefulWidget {
  const PageAddUser({super.key});

  @override
  ConsumerState<PageAddUser> createState() => _PageAddUserState();
}

class _PageAddUserState extends ConsumerState<PageAddUser> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var readUser = ref.read(userProvider.notifier);
    var watchUser = ref.watch(userProvider);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            KKCard(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
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
                decoration: InputDecoration(
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
                    bool success = await readUser.userAdd(
                      UserAdd_Input(
                        userName: _nameController.text,
                        password: _passwordController.text,
                      ),
                    );
                    if (success && context.mounted) {
                      _nameController.clear();
                      _passwordController.clear();
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

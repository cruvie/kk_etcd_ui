import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/user/api_def/Login.pb.dart';
import 'package:kk_etcd_go/kk_etcd_models/pb_user_kk_etcd.pb.dart';
import 'package:kk_etcd_ui/l10n/l10n.dart';
import 'package:kk_etcd_ui/logic_global/state_global.dart';
import 'package:kk_etcd_ui/page_routes/router_path.dart';
import 'package:kk_etcd_ui/pages/page_user/logic/state_user.dart';
import 'package:kk_etcd_ui/utils/tools/local_storage.dart';

class PageLogin extends ConsumerStatefulWidget {
  const PageLogin({super.key});

  @override
  ConsumerState<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends ConsumerState<PageLogin> {
  bool showPassword = false;
  final _formKey = GlobalKey<FormState>();
  String userName = '';
  String password = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(globalProvider.notifier).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    var readUser = ref.read(userProvider.notifier);
    var watchGlobal = ref.watch(globalProvider);
    return Scaffold(
      appBar: AppBar(title: Text(lTr(context).login), centerTitle: true),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextFormField(
                  initialValue: ref
                      .watch(globalProvider)
                      .serviceAddr,
                  decoration: InputDecoration(
                    labelText: lTr(context).serviceAddress,
                    hintText: "127.0.0.1:2333",
                    icon: const Icon(Icons.link_outlined),
                  ),
                  onChanged: (value) {
                    ref.read(globalProvider.notifier).setServiceAddr(value);
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextFormField(
                  initialValue: watchGlobal.currentUser.userName,
                  decoration: InputDecoration(
                    labelText: lTr(context).username,
                    hintText: lTr(context).enterUsername,
                    icon: const Icon(Icons.account_circle_outlined),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return lTr(context).enterUsername;
                    }
                    return null;
                  },
                  onChanged: (value) {
                    userName = value;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextFormField(
                  initialValue: watchGlobal.currentUser.password,
                  decoration: InputDecoration(
                    labelText: lTr(context).password,
                    hintText: lTr(context).enterPassword,
                    icon: const Icon(Icons.password_outlined),
                    suffixIcon: IconButton(
                      icon: Icon(
                        showPassword ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return lTr(context).enterPassword;
                    }
                    return null;
                  },
                  obscureText: !showPassword,
                  onChanged: (value) {
                    password = value;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await LSServiceAddr.set(
                        ref
                            .watch(globalProvider)
                            .serviceAddr,
                      );
                      await ref
                          .read(globalProvider.notifier)
                          .updateCurrentUser(
                        PBUser(userName: userName, password: password),
                      );
                      bool success = await readUser.login(
                        Login_Input(userName: userName, password: password),
                      );
                      if (context.mounted && success) {
                        context.go(RouterPath.pageHome);
                      }
                    }
                  },
                  child: Text(lTr(context).login),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: ElevatedButton(
                  onPressed: () async {
                    await LSManager.resetAllInfo();
                  },
                  child: Text(lTr(context).clearLocalData),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kk_etcd_ui/global/request_api/api.dart';
import 'package:kk_etcd_ui/global/request_api/const_request_api.dart';
import 'package:kk_etcd_ui/l10n/l10n.dart';
import 'package:kk_etcd_ui/page_logics/logic_etcd/logic_etcd.dart';
import 'package:kk_etcd_ui/page_routes/router_path.dart';
import 'package:kk_ui/kk_util/kku_sp.dart';

class PageLogin extends StatefulWidget {
  const PageLogin({super.key});

  @override
  State<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  bool showPassword = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    LogicEtcd.to.username.value =
        KKUSp.getLocalStorage(ConstRequestApi.username) ?? '';
    LogicEtcd.to.password.value =
        KKUSp.getLocalStorage(ConstRequestApi.password) ?? '';
    Api.serverAddr = KKUSp.getLocalStorage(ConstRequestApi.serverAddr) ?? '';
    return Scaffold(
      appBar: AppBar(
        title: Text(lTr(context).login),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextFormField(
                  initialValue: Api.serverAddr,
                  decoration: InputDecoration(
                    labelText: lTr(context).serverAddress,
                    hintText: "127.0.0.1:2333",
                    icon: const Icon(
                      Icons.link_outlined,
                    ),
                  ),
                  onChanged: (value) {
                    Api.serverAddr = value;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextFormField(
                  initialValue: LogicEtcd.to.username.value,
                  decoration: InputDecoration(
                    labelText: lTr(context).username,
                    hintText: lTr(context).enterUsername,
                    icon: const Icon(
                      Icons.account_circle_outlined,
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return lTr(context).enterUsername;
                    }
                    return null;
                  },
                  onChanged: (value) {
                    LogicEtcd.to.username.value = value;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextFormField(
                  initialValue: LogicEtcd.to.password.value,
                  decoration: InputDecoration(
                    labelText: lTr(context).password,
                    hintText: lTr(context).enterPassword,
                    icon: const Icon(
                      Icons.password_outlined,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(showPassword
                          ? Icons.visibility_off
                          : Icons.visibility),
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
                    LogicEtcd.to.password.value = value;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      bool success = await LogicEtcd.to.login(context);
                      if (context.mounted && success) {
                        context.go(RouterPath.pageHome);
                      }
                    }
                  },
                  child: Text(lTr(context).login),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

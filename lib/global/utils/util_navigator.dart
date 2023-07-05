import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kk_etcd_ui/page_routes/router_path.dart';

class UtilNavigator {

  static late BuildContext globalContext;

  static toPageLogin() {
    UtilNavigator.globalContext.replace(RouterPath.pageLogin);
  }

  static unFocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kk_etcd_ui/page_routes/router_path.dart';
import 'package:kk_etcd_ui/page_routes/router_util.dart';

//对于普通组件页面，使用Navigator.push不使用GoRouter 不方便传递参数
class ToolNavigator {
  static void toPageLogin() {
    if (getCurrentRoute() == RouterPath.pageLogin) {
      return;
    }
    getGlobalCtx().replace(RouterPath.pageLogin);
  }

  static void push(BuildContext context, Widget page) {
    // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    //   return UserHomepage(
    //       userId: momentVO.userId!,
    //       avatar: momentVO.avatar ?? '');
    // }));
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  static void unFocus(BuildContext context) {
    //导航到新页面，先取消当前页面输入框焦点（如果有输入框）
    FocusScope.of(context).unfocus();
  }
}

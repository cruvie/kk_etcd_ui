import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kk_etcd_ui/page_routes/router_cfg.dart';

import 'package:kk_etcd_ui/pages/page_backup/view/page_backup.dart';
import 'package:kk_etcd_ui/pages/page_kv/view/page_add_kv/page_add_kv.dart';
import 'package:kk_etcd_ui/pages/page_kv/view/page_kv.dart';
import 'package:kk_etcd_ui/pages/page_role/view/page_add_role/page_add_role.dart';
import 'package:kk_etcd_ui/pages/page_role/view/page_role.dart';
import 'package:kk_etcd_ui/pages/page_service/view/page_service.dart';
import 'package:kk_etcd_ui/pages/page_user/view/page_add_user/page_add_user.dart';
import 'package:kk_etcd_ui/pages/page_user/view/page_user.dart';


List<Widget> allPages = [
  const PageService(),
  const PageKV(),
  const PageAddKV(),
  const PageUser(),
  const PageAddUser(),
  const PageRole(),
  const PageAddRole(),
  const PageBackup(),
];

BuildContext getGlobalCtx() {
  BuildContext? ctx = RouterCfg.rootNavigatorKey.currentContext;
  if (ctx == null) {
    debugPrint('RouterCfg.rootNavigatorKey.currentContext is null');
  }
  return ctx!;
}

String getCurrentRoute() {
  final RouteMatch lastMatch =
      RouterCfg.routerConfig.routerDelegate.currentConfiguration.last;
  return lastMatch.matchedLocation;
}

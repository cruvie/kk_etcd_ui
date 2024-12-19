import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kk_etcd_ui/page_routes/router_cfg.dart';

import 'package:kk_etcd_ui/pages/page_backup/view/page_backup.dart';
import 'package:kk_etcd_ui/pages/page_kv/view/page_add_kv/page_add_kv.dart';
import 'package:kk_etcd_ui/pages/page_kv/view/page_kv.dart';
import 'package:kk_etcd_ui/pages/page_role/view/page_add_role/page_add_role.dart';
import 'package:kk_etcd_ui/pages/page_role/view/page_role.dart';
import 'package:kk_etcd_ui/pages/page_server/view/page_server.dart';
import 'package:kk_etcd_ui/pages/page_user/view/page_add_user/page_add_user.dart';
import 'package:kk_etcd_ui/pages/page_user/view/page_user.dart';

import '../pages/page_ai/view/page_ai.dart';

List<Widget> allPages = [
  const PageServer(),
  const PageKV(),
  const PageAddKV(),
  const PageUser(),
  const PageAddUser(),
  const PageRole(),
  const PageAddRole(),
  const PageBackup(),
  const PageAI(),
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

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kk_etcd_ui/page_home.dart';
import 'package:kk_etcd_ui/page_routes/router_path.dart';
import 'package:kk_etcd_ui/pages/page_index/view/page_login.dart';
import 'package:kk_etcd_ui/pages/page_not_found/page_not_found.dart';

class RouterCfg {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'rootKey');

  static final GoRouter routerConfig = GoRouter(
    initialLocation: RouterPath.pageInit,
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: true,
    errorBuilder: (context, state) => const PageNotFound(),
    routes: <RouteBase>[
      ///page_index
      GoRoute(
        path: RouterPath.pageLogin,
        builder: (context, state) =>  const PageLogin(),
      ),

      ///page_home
      GoRoute(
        path: RouterPath.pageHome,
        builder: (context, state) => const PageHome(),
      ),

      ///page_not_found
      GoRoute(
        path: RouterPath.pageNotFound,
        builder: (context, state) => const PageNotFound(),
      ),
    ],
  );
}

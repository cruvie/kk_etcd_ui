import 'package:flutter/material.dart';
import 'package:kk_etcd_ui/pages/page_config/page_add_config/page_add_config.dart';
import 'package:kk_etcd_ui/pages/page_config/page_config.dart';

import 'package:kk_etcd_ui/pages/page_user/page_add_user/page_add_user.dart';
import 'package:kk_etcd_ui/pages/page_user/page_user.dart';
import 'package:provider/provider.dart';

LogicNavigation logicNavigationWatch(BuildContext context) {
  return context.watch<LogicNavigation>();
}

LogicNavigation logicNavigationRead(BuildContext context) {
  return context.read<LogicNavigation>();
}

class LogicNavigation with ChangeNotifier {

  static List<Widget> pages = [
    const PageConfig(),
    const PageAddConfig(),
    const PageUser(),
    const PageAddUser(),
  ];

  PageController pageController = PageController();

  initPageController() {
    pageController = PageController();
  }

  disposePageController() {
    pageController.dispose();
  }

  changeDestination(int index) {
    pageController.jumpToPage(index);
    notifyListeners();
  }
}

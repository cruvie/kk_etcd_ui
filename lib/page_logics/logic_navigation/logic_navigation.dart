import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kk_etcd_ui/pages/page_config/page_add_config/page_add_config.dart';
import 'package:kk_etcd_ui/pages/page_config/page_config.dart';

import 'package:kk_etcd_ui/pages/page_user/page_add_user/page_add_user.dart';
import 'package:kk_etcd_ui/pages/page_user/page_user.dart';


class LogicNavigation extends GetxController {
  static LogicNavigation get to => Get.find();
  
  static List<Widget> pages = [
    const PageConfig(),
    const PageAddConfig(),
    const PageUser(),
    const PageAddUser(),
  ];

  Rx<PageController> pageController = PageController().obs;

  initPageController() {
    pageController.value = PageController();
  }

  disposePageController() {
    pageController.value.dispose();
  }

  changeDestination(int index) {
    pageController.value.jumpToPage(index);
    pageController.refresh();
  }
}

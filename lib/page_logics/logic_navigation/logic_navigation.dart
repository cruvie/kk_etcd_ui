import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kk_etcd_ui/pages/page_backup/page_backup.dart';
import 'package:kk_etcd_ui/pages/page_backup/page_kv_backup/page_kv_backup.dart';
import 'package:kk_etcd_ui/pages/page_backup/page_snapshot/page_snapshot.dart';
import 'package:kk_etcd_ui/pages/page_config/page_add_config/page_add_config.dart';
import 'package:kk_etcd_ui/pages/page_config/page_config.dart';
import 'package:kk_etcd_ui/pages/page_kv/page_add_kv/page_add_kv.dart';
import 'package:kk_etcd_ui/pages/page_kv/page_kv.dart';
import 'package:kk_etcd_ui/pages/page_role/page_add_role/page_add_role.dart';
import 'package:kk_etcd_ui/pages/page_role/page_role.dart';
import 'package:kk_etcd_ui/pages/page_server/page_server.dart';
import 'package:kk_etcd_ui/pages/page_user/page_add_user/page_add_user.dart';
import 'package:kk_etcd_ui/pages/page_user/page_user.dart';

class LogicNavigation extends GetxController {
  static LogicNavigation get to => Get.find();

  static List<Widget> pages = [
    const PageConfig(),
    const PageAddConfig(),
    const PageServer(),
    const PageKV(),
    const PageAddKV(),
    const PageUser(),
    const PageAddUser(),

    const PageRole(),
    const PageAddRole(),

    const PageBackup(),
    const PageKVBackup(),
    const PageSnapshot(),
  ];

  Rx<PageController> pageController = PageController().obs;

  initPageController() {
    pageController.value = PageController();
  }

  disposePageController() {
    pageController.value.dispose();
  }

  changeDestination(Widget page) {
    // debugPrint('changeDestination: ${page.toString()}');
    int index =
        pages.indexWhere((element) => element.runtimeType.toString() == page.runtimeType.toString());
    pageController.value.jumpToPage(index);
    pageController.refresh();
  }
}

import 'package:get/get.dart';
import 'package:kk_etcd_ui/page_logics/logic_etcd/logic_etcd.dart';
import 'package:kk_etcd_ui/page_logics/logic_navigation/logic_navigation.dart';

class Initialize {
  static init() {
    Get.put(LogicNavigation());
    Get.put(LogicEtcd());
  }
}

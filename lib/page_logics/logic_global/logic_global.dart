import 'package:get/get.dart';
import 'package:kk_ui/kk_util/kku_log.dart';
import 'package:kk_ui/kk_util/kku_sp.dart';

class LogicGlobal  extends GetxController {
  static LogicGlobal get to => Get.find();
 static Future<bool> cleanAllLocal() async {
    if (await KKUSp.clear() == true) {
      return true;
    } else {
      log.info('Failed to clear the local cache');
      return false;
    }
  }
}

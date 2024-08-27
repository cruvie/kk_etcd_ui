import 'package:kk_etcd_ui/utils/const/static_etcd.dart';
import 'package:kk_ui/kk_util/kku_sp.dart';

class GlobalTool {
  /// clear local storage
  static Future<void> resetAllInfo() async {
    await KKUSp.clear();
  }

  static updateServerAddr(String serverAddr) async {
    await KKUSp.set(StaticEtcd.serverAddr, serverAddr);
  }

  static getServerAddr() {
    return KKUSp.get(StaticEtcd.serverAddr) ?? '';
  }
}

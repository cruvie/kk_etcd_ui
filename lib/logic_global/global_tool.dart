import 'package:kk_etcd_go/kk_etcd_models/pb_user_kk_etcd.pb.dart';
import 'package:kk_etcd_ui/logic_global/state_global.dart';
import 'package:kk_etcd_ui/main.dart';
import 'package:kk_etcd_ui/utils/const/static_etcd.dart';
import 'package:kk_ui/kk_const/kkc_request_api.dart';
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

  static bool loadLoginUser() {
    String? userJson = KKUSp.get(StaticEtcd.myInfo);
    print(userJson);
    if (userJson != null) {
      PBUser user=PBUser.fromJson(userJson);
      globalProviderContainer.read(globalProvider.notifier).updateCurrentUser(user);
      return true;
    }
    if (KKUSp.get(KKCRequestApi.authorizationToken) != null) {
      return true;
    }
    return false;
  }
}

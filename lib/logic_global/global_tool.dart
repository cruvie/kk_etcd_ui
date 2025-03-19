import 'package:kk_etcd_go/kk_etcd_models/pb_user_kk_etcd.pb.dart';
import 'package:kk_etcd_ui/logic_global/state_global.dart';
import 'package:kk_etcd_ui/main.dart';
import 'package:kk_etcd_ui/utils/tools/local_storage.dart';

class GlobalTool {
  static Future<bool> loadLoginUser() async {
    PBUser? user = await LSMyInfo.get();
    if (user != null) {
      globalProviderContainer
          .read(globalProvider.notifier)
          .updateCurrentUser(user);
      return true;
    }
    // if (LSAuthorizationToken.get() != null) {
    //   return true;
    // }
    return false;
  }
}

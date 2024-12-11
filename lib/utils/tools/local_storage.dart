import 'package:kk_etcd_go/kk_etcd_models/pb_user_kk_etcd.pb.dart';
import 'package:kk_ui/kk_util/kku_sp.dart';

/// clear local storage

class LSManager {
  static Future<void> init() async {
    await KKUSp.initPreferences();
  }

  static Future<void> resetAllInfo() async {
    await KKUSp.clear();
  }
}

class LSAuthorizationToken {
  static const authorizationToken = "AuthorizationToken";

  static Future<bool> set(String token) {
    return KKUSp.set(authorizationToken, token);
  }

  static String? get() {
    return KKUSp.get(authorizationToken);
  }

  static bool exists() {
    return KKUSp.containsKey(authorizationToken);
  }

  static Future<bool> remove() {
    return KKUSp.remove(authorizationToken);
  }
}

class LSServerAddr {
  static const serverAddr = "ServerAddr";

  static Future<bool> set(String s) {
    return KKUSp.set(serverAddr, s);
  }

  static String get() {
    return KKUSp.get(serverAddr) ?? "";
  }

  static bool exists() {
    return KKUSp.containsKey(serverAddr);
  }

  static Future<bool> remove() {
    return KKUSp.remove(serverAddr);
  }
}

class LSTheme {
  static const theme = "theme";

  static Future<bool> setTheme(String themeName) {
    return KKUSp.set(theme, themeName);
  }

  static String? getTheme() {
    return KKUSp.get(theme);
  }
}

class LSMyInfo {
  static const myInfo = "MyInfo";

  static Future<bool> set(PBUser info) {
    return KKUSp.set(myInfo, info.writeToJson());
  }

  static PBUser? get() {
    String? userJson = KKUSp.get(myInfo);
    if (userJson == null) {
      return null;
    }
    PBUser user = PBUser.fromJson(userJson);
    return user;
  }

  static remove() {
    KKUSp.remove(myInfo);
  }
}

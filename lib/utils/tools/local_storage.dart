import 'package:kk_etcd_go/kk_etcd_models/pb_user_kk_etcd.pb.dart';
import 'package:kk_ui/kk_util/kku_sp.dart';

/// clear local storage

class LSManager {
  static Future<void> resetAllInfo() async {
    await KKUSp.clear();
  }
}

class LSAuthorizationToken {
  static const authorizationToken = "AuthorizationToken";

  static Future<void> set(String token) async {
    return await KKUSp.set(authorizationToken, token);
  }

  static Future<String?> get() async {
    return await KKUSp.getString(authorizationToken);
  }

  static Future<bool> exists() async {
    return await KKUSp.containsKey(authorizationToken);
  }

  static Future<void> remove() {
    return KKUSp.remove(authorizationToken);
  }
}

class LSServerAddr {
  static const serverAddr = "ServerAddr";

  static Future<void> set(String s) {
    return KKUSp.set(serverAddr, s);
  }

  static Future<String> get() async {
    return await KKUSp.getString(serverAddr) ?? "";
  }

  static Future<bool> exists() {
    return KKUSp.containsKey(serverAddr);
  }

  static Future<void> remove() {
    return KKUSp.remove(serverAddr);
  }
}

class LSTheme {
  static const theme = "theme";

  static Future<void> setTheme(String themeName) {
    return KKUSp.set(theme, themeName);
  }

  static Future<String?> getTheme() async {
    return await KKUSp.getString(theme);
  }
}

class LSMyInfo {
  static const myInfo = "MyInfo";

  static Future<void> set(PBUser info) {
    return KKUSp.set(myInfo, info.writeToJson());
  }

  static Future<PBUser?> get() async {
    String? userJson = await KKUSp.getString(myInfo);
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

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
    return await KKUSp.get(authorizationToken);
  }

  static Future<bool> exists() async {
    return await KKUSp.containsKey(authorizationToken);
  }

  static Future<void> remove() {
    return KKUSp.remove(authorizationToken);
  }
}

class LSServiceAddr {
  LSServiceAddr._();

  static const _keyHost = "ServiceHost";
  static const _keyPort = "ServicePort";

  static String? _cacheHost;
  static int? _cachePort;

  static String? getHost() {
    return _cacheHost;
  }

  static int? getPort() {
    return _cachePort;
  }

  static Future<void> set(String host, int port) {
    _cacheHost = host;
    _cachePort = port;
    KKUSp.set(_keyHost, host);
    KKUSp.set(_keyPort, port);
    return Future.value();
  }

  static Future<void> init() async {
    _cacheHost = await KKUSp.get(_keyHost);
    _cachePort = await KKUSp.get<int>(_keyPort);
  }

  static Future<bool> exists() async {
    return await KKUSp.containsKey(_keyHost) &&
        await KKUSp.containsKey(_keyPort);
  }

  static Future<void> remove() {
    _cacheHost = null;
    _cachePort = null;
    KKUSp.remove(_keyHost);
    KKUSp.remove(_keyPort);
    return Future.value();
  }
}

class LSTheme {
  static const theme = "theme";

  static Future<void> setTheme(String themeName) {
    return KKUSp.set(theme, themeName);
  }

  static Future<String?> getTheme() async {
    return await KKUSp.get(theme);
  }
}

class LSMyInfo {
  static const myInfo = "MyInfo";

  static Future<void> set(PBUser info) {
    return KKUSp.set(myInfo, info.writeToJson());
  }

  static Future<PBUser?> get() async {
    String? userJson = await KKUSp.get(myInfo);
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

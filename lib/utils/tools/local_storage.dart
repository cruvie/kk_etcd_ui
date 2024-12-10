import 'package:kk_ui/kk_const/kkc_locale.dart';
import 'package:kk_ui/kk_const/kkc_theme.dart';
import 'package:kk_ui/kk_util/kku_sp.dart';

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

class LSLocale {
  static Map? get() {
    return KKUSp.get(KKCLocale.locale);
  }
}

class LSTheme {
  static Future<bool> setTheme(String themeName) {
    return KKUSp.set(KKCTheme.theme, themeName);
  }

  static String? getTheme() {
    return KKUSp.get(KKCTheme.theme);
  }

  static String? getThemeMode() {
    return KKUSp.get(KKCTheme.themeMode);
  }
}
//
// class LSMyInfo {
//   static const myInfo = "MyInfo";
//
//   static Future<bool> set(PBVoUserInfo info) {
//     return KKUSp.set(myInfo, info.writeToJson());
//   }
//
//   static PBVoUserInfo? get() {
//     String? userJson = KKUSp.get(myInfo);
//     if (userJson == null) {
//       return null;
//     }
//     PBVoUserInfo user = PBVoUserInfo.fromJson(userJson);
//     return user;
//   }
//
//   static remove() {
//     KKUSp.remove(myInfo);
//   }
// }

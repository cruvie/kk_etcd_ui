import 'package:kk_etcd_ui/logic_global/global_tool.dart';

class RouterPath {
  ///page_init
  static String getPageInit() {
    bool ok = GlobalTool.loadLoginUser();
    if (ok) {
      return pageHome;
    } else {
      return pageLogin;
    }
  }

  ///page_home
  static const String pageHome = '/pageHome';

  ///page_index
  static const String pageLogin = '/pageLogin';

  ///page_not_found
  static const String pageNotFound = '/pageNotFound';
}

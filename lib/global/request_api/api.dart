import 'package:kk_ui/kk_util/kku_sp.dart';

import 'const_request_api.dart';

class Api {
  static String serverAddr = '';

  static String getServerAddr() =>
      KKUSp.getLocalStorage(ConstRequestApi.serverAddr) ?? '';
}

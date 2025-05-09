import 'package:kk_etcd_ui/logic_global/global_tool.dart';

class RouterPath {
  static late String pageInit;

  ///page_init
  static Future<void> init() async {
    /// 准备个人信息
    //获取当前用户信息，目的 1 获取信息 2 保证WebSocketSet连接成功和失败重连有token判断依据
    bool ok = await GlobalTool.loadLoginUser();

    ///未登陆无需初始化 todo 在路由中控制
    if (ok) {
      print('ok=$ok');
      pageInit = pageHome;
    } else {
      pageInit = pageLogin;
    }
  }

  ///page_home
  static const String pageHome = '/pageHome';

  ///page_index
  static const String pageLogin = '/pageLogin';

  ///page_not_found
  static const String pageNotFound = '/pageNotFound';
}

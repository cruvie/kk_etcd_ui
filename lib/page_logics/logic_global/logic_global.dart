import 'package:flutter/cupertino.dart';
import 'package:kk_ui/kk_util/kku_sp.dart';
import 'package:provider/provider.dart';

LogicGlobal logicGlobalWatch(BuildContext context) {
  return context.watch<LogicGlobal>();
}

LogicGlobal logicGlobalRead(BuildContext context) {
  return context.read<LogicGlobal>();
}
class LogicGlobal  with ChangeNotifier {

 static Future<bool> cleanAllLocal() async {
    if (await KKUSp.clear() == true) {
      return true;
    } else {
      debugPrint('Failed to clear the local cache');
      return false;
    }
  }
}

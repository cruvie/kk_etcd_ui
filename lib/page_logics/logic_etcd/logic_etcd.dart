import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kk_etcd_ui/global/request_api/api.dart';
import 'package:kk_etcd_ui/global/request_api/api_resp/api_resp.pb.dart';
import 'package:kk_etcd_ui/global/request_api/const_request_api.dart';
import 'package:kk_etcd_ui/global/request_api/request_http.dart';
import 'package:kk_etcd_ui/page_logics/base_proto_type/dart/pb_base_proto_type.pb.dart';
import 'package:kk_etcd_ui/page_logics/logic_etcd/dart/pb_kv.pb.dart';
import 'package:kk_etcd_ui/page_logics/logic_etcd/static_etcd.dart';
import 'package:kk_etcd_ui/page_routes/router_path.dart';
import 'package:kk_ui/kk_const/index.dart';
import 'package:kk_ui/kk_util/kku_sp.dart';
import 'package:kk_ui/kk_widget/kk_snack_bar.dart';
import 'package:provider/provider.dart';

import 'dart/pb_user.pb.dart';

LogicEtcd logicEtcdWatch(BuildContext context) {
  return context.watch<LogicEtcd>();
}

LogicEtcd logicEtcdRead(BuildContext context) {
  return context.read<LogicEtcd>();
}

class LogicEtcd with ChangeNotifier {
  late PBUser myPBUserInfo = PBUser();

  static String username = '';

  static String password = '';

  Future<bool> login(BuildContext context) async {
    bool result = false;
    if (username.trim() == '' || password.trim() == '') {
      return false;
    }
    PBUser user = PBUser();
    user.userName = username;
    user.password = password;
    KKUSp.setLocalStorage(ConstRequestApi.username, username);
    KKUSp.setLocalStorage(ConstRequestApi.password, password);
    KKUSp.setLocalStorage(ConstRequestApi.serverAddr, Api.serverAddr);
    await RequestHttp.httpPost("/User/Login",
            queryParameters: user.writeToBuffer())
        .then((ApiResp res) async {
      PBString tokenString = PBString();
      if (res.code == 200) {
        res.data.unpackInto(tokenString);
        KKUSp.setLocalStorage(
            KKCRequestApi.authorizationToken, tokenString.value);
        await getMyInfo();
        if (context.mounted) {
          await loadUserInfo();
        }
        if (context.mounted) {
          KKSnackBar.ok(context, Text(res.msg));
        }
        result = true;
      } else {
        KKSnackBar.error(context, Text(res.msg));
        result = false;
      }
    });
    return result;
  }

  Future<bool> getMyInfo() async {
    bool hasData = false;
    await RequestHttp.httpPost("/User/MyInfo").then((ApiResp res) async {
      if (res.code == 200) {
        myPBUserInfo.clear();
        res.data.unpackInto(myPBUserInfo);
        await KKUSp.setLocalStorage(
            StaticEtcd.myInfo, myPBUserInfo.writeToJson());
        hasData = true;
      } else {
        hasData = false;
      }
    });
    return hasData;
  }

  loadUserInfo() async {
    if (KKUSp.getLocalStorage(StaticEtcd.myInfo) == null ||
        !KKUSp.containsKey(StaticEtcd.myInfo)) {
      await getMyInfo();
    }
    myPBUserInfo = PBUser.fromJson(KKUSp.getLocalStorage(StaticEtcd.myInfo));
    // debugPrint('myInfo：${myPBUserInfo }');
  }

  PBListUser pbListUser = PBListUser();

  Future<bool> getUserList() async {
    bool finished = false;
    await RequestHttp.httpPost("/User/UserList").then((ApiResp res) {
      if (res.code == 200) {
        pbListUser.clear();
        res.data.unpackInto(pbListUser);
        finished = true;
      } else {
        debugPrint('failed to get user list!');
        finished = false;
      }
    });
    notifyListeners();
    return finished;
  }

  Future<bool> addUser(String name, String password) async {
    bool finished = false;
    await RequestHttp.httpPost("/User/AddUser",
            queryParameters:
                PBUser(userName: name, password: password).writeToBuffer())
        .then((ApiResp res) {
      if (res.code == 200) {
        finished = true;
      } else {
        debugPrint('failed to add user!');
        finished = false;
      }
    });
    notifyListeners();
    return finished;
  }

  Future<bool> deleteUser(BuildContext context, String userName) async {
    bool finished = false;
    await RequestHttp.httpPost("/User/DeleteUser",
            queryParameters: PBUser(userName: userName).writeToBuffer())
        .then((ApiResp res) {
      if (res.code == 200) {
        pbListUser.listUser
            .removeWhere((element) => element.userName == userName);
        finished = true;
      } else {
        KKSnackBar.error(context, Text(res.msg));
        finished = false;
      }
    });
    notifyListeners();
    return finished;
  }

  PBListKV pbConfigList = PBListKV();

  Future<bool> kVGetConfigList() async {
    bool finished = false;
    await RequestHttp.httpPost("/KV/KVGetConfigList").then((ApiResp res) {
      if (res.code == 200) {
        pbConfigList.clear();
        res.data.unpackInto(pbConfigList);
        finished = true;
      } else {
        debugPrint('failed to get config list!');
        finished = false;
      }
    });
    notifyListeners();
    return finished;
  }

  PBKV currentConfig = PBKV();

  setCurrentConfigValue(String key, String value) {
    currentConfig.key = key;
    currentConfig.value = value;
    notifyListeners();
  }

  Future<bool> kVGetConfig(String key) async {
    bool finished = false;
    await RequestHttp.httpPost("/KV/KVGetConfig",
            queryParameters: PBKV(key: key).writeToBuffer())
        .then((ApiResp res) {
      if (res.code == 200) {
        currentConfig.clear();
        res.data.unpackInto(currentConfig);
        finished = true;
      } else {
        debugPrint('failed to get config !');
        finished = false;
      }
    });
    notifyListeners();
    return finished;
  }

  Future<bool> kVPutConfig(String key, String value) async {
    bool finished = false;
    await RequestHttp.httpPost("/KV/KVPutConfig",
            queryParameters: PBKV(key: key, value: value).writeToBuffer())
        .then((ApiResp res) {
      if (res.code == 200) {
        finished = true;
      } else {
        debugPrint('failed to put config !');
        finished = false;
      }
    });
    return finished;
  }

  Future<bool> kVDelConfig(String key) async {
    bool finished = false;
    await RequestHttp.httpPost("/KV/KVDelConfig",
            queryParameters: PBKV(key: key).writeToBuffer())
        .then((ApiResp res) {
      if (res.code == 200) {
        pbConfigList.listKV.removeWhere((element) => element.key == key);
        finished = true;
      } else {
        debugPrint('failed to delete config !');
        finished = false;
      }
    });
    notifyListeners();
    return finished;
  }

  Future<bool> logout(BuildContext context) async {
    bool result = false;
    await RequestHttp.httpPost("/User/Logout",
            queryParameters: myPBUserInfo.writeToBuffer())
        .then((ApiResp res) async {
      if (context.mounted) {
        context.go(RouterPath.pageLogin);
      }
      result = true;
    });
    return result;
  }
}

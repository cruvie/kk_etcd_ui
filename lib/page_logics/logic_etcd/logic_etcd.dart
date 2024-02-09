import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:kk_etcd_go/key_prefix.dart';
import 'package:kk_etcd_go/kk_etcd_models/pb_kv.pb.dart';
import 'package:kk_etcd_go/kk_etcd_models/pb_role.pb.dart';
import 'package:kk_etcd_go/kk_etcd_models/pb_serer.pb.dart';
import 'package:kk_etcd_go/kk_etcd_models/pb_user.pb.dart';
import 'package:kk_etcd_ui/global/request_api/api.dart';
import 'package:kk_etcd_ui/global/request_api/const_request_api.dart';
import 'package:kk_etcd_ui/global/request_api/request_http.dart';
import 'package:kk_etcd_ui/page_logics/logic_etcd/static_etcd.dart';
import 'package:kk_etcd_ui/page_routes/router_path.dart';
import 'package:kk_go_kit/kk_pb_type/pb_response.pb.dart';
import 'package:kk_go_kit/kk_pb_type/pb_type.pb.dart';
import 'package:kk_ui/kk_const/kkc_request_api.dart';
import 'package:kk_ui/kk_util/kku_log.dart';
import 'package:kk_ui/kk_util/kku_sp.dart';
import 'package:kk_ui/kk_widget/kk_snack_bar.dart';
import 'package:protobuf/protobuf.dart';

class LogicEtcd extends GetxController {
  static LogicEtcd get to => Get.find();

  ///================== User Manage ==================
  late Rx<PBUser> loginUserInfo = PBUser().obs;

  RxString username = ''.obs;

  RxString password = ''.obs;

  Future<bool> login(BuildContext context) async {
    bool result = false;
    if (username.trim() == '' || password.trim() == '') {
      return false;
    }
    PBUser user = PBUser();
    user.userName = username.value;
    user.password = password.value;
    KKUSp.setLocalStorage(ConstRequestApi.username, username.value);
    KKUSp.setLocalStorage(ConstRequestApi.password, password.value);
    KKUSp.setLocalStorage(ConstRequestApi.serverAddr, Api.serverAddr);
    await RequestHttp.httpPost("/User/Login",
            queryParameters: user.writeToBuffer())
        .then((PBResponse res) async {
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
    await RequestHttp.httpPost("/User/MyInfo").then((PBResponse res) async {
      if (res.code == 200) {
        loginUserInfo.value.clear();
        res.data.unpackInto(loginUserInfo.value);
        await KKUSp.setLocalStorage(
            StaticEtcd.myInfo, loginUserInfo.value.writeToJson());
        hasData = true;
      } else {
        hasData = false;
      }
    });
    loginUserInfo.refresh();
    return hasData;
  }

  loadUserInfo() async {
    if (KKUSp.getLocalStorage(StaticEtcd.myInfo) == null ||
        !KKUSp.containsKey(StaticEtcd.myInfo)) {
      await getMyInfo();
    }
    loginUserInfo.value =
        PBUser.fromJson(KKUSp.getLocalStorage(StaticEtcd.myInfo));
    loginUserInfo.refresh();
    // log.info('myInfo：${myPBUserInfo }');
  }

  Rx<PBListUser> pbListUser = PBListUser().obs;

  Future<bool> userList() async {
    bool finished = false;
    await RequestHttp.httpPost("/User/UserList").then((PBResponse res) {
      if (res.code == 200) {
        pbListUser.value.clear();
        res.data.unpackInto(pbListUser.value);
        finished = true;
      } else {
        log.info('failed to get user list!');
        finished = false;
      }
    });
    pbListUser.refresh();
    return finished;
  }

  Future<bool> userAdd(
      BuildContext context, String name, String password) async {
    bool finished = false;
    await RequestHttp.httpPost("/User/UserAdd",
            queryParameters:
                PBUser(userName: name, password: password).writeToBuffer())
        .then((PBResponse res) {
      if (res.code == 200) {
        KKSnackBar.ok(context, Text(res.msg));
        finished = true;
      } else {
        KKSnackBar.error(context, Text(res.msg));
        finished = false;
      }
    });
    return finished;
  }

  Future<bool> userDelete(BuildContext context, String userName) async {
    bool finished = false;
    await RequestHttp.httpPost("/User/UserDelete",
            queryParameters: PBUser(userName: userName).writeToBuffer())
        .then((PBResponse res) {
      if (res.code == 200) {
        pbListUser.value.listUser
            .removeWhere((element) => element.userName == userName);
        finished = true;
      } else {
        KKSnackBar.error(context, Text(res.msg));
        finished = false;
      }
    });
    pbListUser.refresh();
    return finished;
  }

  Future<bool> logout(BuildContext context) async {
    bool result = false;
    await RequestHttp.httpPost("/User/Logout",
            queryParameters: loginUserInfo.value.writeToBuffer())
        .then((PBResponse res) async {
      if (context.mounted) {
        context.go(RouterPath.pageLogin);
      }
      result = true;
    });
    return result;
  }

  Future<bool> userGrantRole(
      BuildContext context, String userName, List<String> roles) async {
    bool finished = false;
    await RequestHttp.httpPost("/User/UserGrantRole",
            queryParameters:
                PBUser(userName: userName, roles: roles).writeToBuffer())
        .then((PBResponse res) {
      if (res.code == 200) {
        KKSnackBar.ok(context, Text(res.msg));
        userList();
        finished = true;
      } else {
        KKSnackBar.error(context, Text(res.msg));
        finished = false;
      }
    });
    return finished;
  }

  ///====================Role Manage====================

  Rx<PBListRole> pbListRole = PBListRole().obs;

  Future<bool> roleList() async {
    bool finished = false;
    await RequestHttp.httpPost("/Role/RoleList").then((PBResponse res) {
      if (res.code == 200) {
        pbListRole.value.clear();
        res.data.unpackInto(pbListRole.value);
        finished = true;
      } else {
        log.info('failed to get role list!');
        finished = false;
      }
    });
    pbListRole.refresh();
    return finished;
  }

  Future<bool> roleAdd(String name) async {
    bool finished = false;

    if (name.isEmpty) {
      return finished;
    }
    await RequestHttp.httpPost("/Role/RoleAdd",
            queryParameters: PBRole(name: name).writeToBuffer())
        .then((PBResponse res) {
      if (res.code == 200) {
        finished = true;
      } else {
        log.info('failed to add role!');
        finished = false;
      }
    });

    return finished;
  }

  Future<bool> roleGrantPermission(BuildContext context, PBRole role) async {
    bool finished = false;

    if (role.name.isEmpty) {
      return finished;
    }
    await RequestHttp.httpPost("/Role/RoleGrantPermission",
            queryParameters: role.writeToBuffer())
        .then((PBResponse res) {
      if (res.code == 200) {
        finished = true;
        KKSnackBar.ok(context, const Text("update succeed"));
        //update role list
        roleList();
      } else {
        log.info(res.msg);
        KKSnackBar.error(context, Text(res.msg));
        finished = false;
      }
    });

    return finished;
  }

  Future<bool> roleDelete(BuildContext context, String userName) async {
    bool finished = false;
    await RequestHttp.httpPost("/Role/RoleDelete",
            queryParameters: PBRole(name: userName).writeToBuffer())
        .then((PBResponse res) {
      if (res.code == 200) {
        pbListRole.value.list
            .removeWhere((element) => element.name == userName);
        finished = true;
      } else {
        KKSnackBar.error(context, Text(res.msg));
        finished = false;
      }
    });
    pbListRole.refresh();
    return finished;
  }

  Rx<PBRole> currentRole = PBRole().obs;

  void setCurrentRole(PBRole role) {
    currentRole.value = role.deepCopy();
  }

  ///====================KV Manage====================
  Rx<PBListKV> pbConfigList = PBListKV().obs;
  Rx<PBListKV> pbKVList = PBListKV().obs;

  Future<bool> kVList({String prefix = ""}) async {
    bool finished = false;
    await RequestHttp.httpPost("/KV/KVList",
            queryParameters: PBString(value: prefix).writeToBuffer())
        .then((PBResponse res) {
      if (res.code == 200) {
        if (prefix == KeyPrefix.config) {
          pbConfigList.value.clear();
          res.data.unpackInto(pbConfigList.value);
          pbConfigList.refresh();
        } else {
          pbKVList.value.clear();
          res.data.unpackInto(pbKVList.value);
          pbKVList.refresh();
        }
        finished = true;
      } else {
        log.info('failed to get config list!');
        finished = false;
      }
    });
    return finished;
  }

  Rx<PBKV> currentKV = PBKV().obs;

  Future<bool> kVGet(BuildContext context, String key) async {
    bool finished = false;
    await RequestHttp.httpPost("/KV/KVGet",
            queryParameters: PBKV(key: key).writeToBuffer())
        .then((PBResponse res) {
      if (res.code == 200) {
        currentKV.value.clear();
        res.data.unpackInto(currentKV.value);
        finished = true;
      } else {
        KKSnackBar.error(context, const Text('failed to get config !'));
        finished = false;
      }
    });
    currentKV.refresh();
    return finished;
  }

  Future<bool> kVPut(BuildContext context, String key, String value) async {
    bool finished = false;
    await RequestHttp.httpPost("/KV/KVPut",
            queryParameters: PBKV(key: key, value: value).writeToBuffer())
        .then((PBResponse res) {
      if (res.code == 200) {
        KKSnackBar.ok(context, const Text("update succeed"));
        finished = true;
      } else {
        log.info(res.msg);
        KKSnackBar.error(context, Text(res.msg));
        finished = false;
      }
    });
    return finished;
  }

  Future<bool> kVDel(BuildContext context, String key) async {
    bool finished = false;
    await RequestHttp.httpPost("/KV/KVDel",
            queryParameters: PBKV(key: key).writeToBuffer())
        .then((PBResponse res) {
      if (res.code == 200) {
        pbConfigList.value.listKV.removeWhere((element) => element.key == key);
        pbKVList.value.listKV.removeWhere((element) => element.key == key);
        finished = true;
        KKSnackBar.ok(context, const Text("delete succeed"));
      } else {
        log.info(res.msg);
        KKSnackBar.error(context, Text(res.msg));
        finished = false;
      }
    });
    pbConfigList.refresh();
    pbKVList.refresh();
    return finished;
  }

  ///====================Server Manage====================
  Rx<PBListServer> pbListServer = PBListServer().obs;

  Future<bool> serverList(BuildContext context, String prefix) async {
    if (prefix.isEmpty) {
      KKSnackBar.error(context, const Text('prefix is empty'));
      return false;
    }
    bool finished = false;
    await RequestHttp.httpPost("/Server/ServerList",
            queryParameters: PBString(value: prefix).writeToBuffer())
        .then((PBResponse res) {
      if (res.code == 200) {
        pbListServer.value.clear();
        res.data.unpackInto(pbListServer.value);
        // log.info(pbListServer.value.listServer.toString());
        pbListServer.refresh();
        finished = true;
      } else {
        KKSnackBar.error(context, const Text('failed to get server list!'));
        finished = false;
      }
    });
    return finished;
  }

  ///======================page_backup===========================
  //backup etcd
  Future<PBFile> snapshot(BuildContext context) async {
    PBFile pbFile = PBFile();
    await RequestHttp.httpPost("/Backup/Snapshot").then((PBResponse res) {
      if (res.code == 200) {
        res.data.unpackInto(pbFile);
      } else {
        KKSnackBar.error(context, const Text('failed to snapshot'));
      }
    });
    return pbFile;
  }

  Future<String> snapshotRestore(BuildContext context) async {
    PBString pbString = PBString();
    await RequestHttp.httpPost("/Backup/SnapshotRestore")
        .then((PBResponse res) {
      if (res.code == 200) {
        res.data.unpackInto(pbString);
      } else {
        KKSnackBar.error(context, const Text('failed to get snapshotRestore'));
      }
    });
    return pbString.value;
  }

  Future<String> snapshotInfo(BuildContext context, PBFile pbFile) async {
    PBString pbString = PBString();
    await RequestHttp.httpPost("/Backup/SnapshotInfo",
            queryParameters: pbFile.writeToBuffer())
        .then((PBResponse res) {
      if (res.code == 200) {
        res.data.unpackInto(pbString);
      } else {
        KKSnackBar.error(context, const Text('failed to snapshotInfo'));
      }
    });
    return pbString.value;
  }

  Future<PBFile> allKVsBackup(BuildContext context) async {
    PBFile pbFile = PBFile();
    await RequestHttp.httpPost("/Backup/AllKVsBackup").then((PBResponse res) {
      if (res.code == 200) {
        res.data.unpackInto(pbFile);
      } else {
        KKSnackBar.error(context, const Text('failed to AllKVsBackup'));
      }
    });
    return pbFile;
  }

  Future<bool> allKVsRestore(BuildContext context, PBFile pbFile) async {
    bool succeed = false;
    await RequestHttp.httpPost("/Backup/AllKVsRestore",
            queryParameters: pbFile.writeToBuffer())
        .then((PBResponse res) {
      if (res.code == 200) {
        KKSnackBar.ok(context, const Text("restore succeed"),
            duration: const Duration(seconds: 10));
        succeed = true;
      } else {
        KKSnackBar.error(context, const Text('failed to AllKVsRestore'),
            duration: const Duration(seconds: 10));
        succeed = false;
      }
    });
    return succeed;
  }
}

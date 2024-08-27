import 'package:flutter/cupertino.dart';
import 'package:kk_etcd_go/kk_etcd_apis/api_user.dart';
import 'package:kk_etcd_go/kk_etcd_models/api_user_kk_etcd.pb.dart';
import 'package:kk_etcd_go/kk_etcd_models/pb_user_kk_etcd.pb.dart';
import 'package:kk_etcd_ui/logic_global/global_tool.dart';
import 'package:kk_etcd_ui/logic_global/state_global.dart';
import 'package:kk_etcd_ui/page_routes/router_util.dart';

import 'package:kk_etcd_ui/utils/request/request.dart';
import 'package:kk_etcd_ui/utils/tools/tool_navigator.dart';
import 'package:kk_ui/kk_const/kkc_request_api.dart';
import 'package:kk_ui/kk_util/kku_sp.dart';
import 'package:kk_ui/kk_widget/kk_snack_bar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'state_user.g.dart';

class StateUser {
  PBListUser pbListUser = PBListUser();
}

@riverpod
class User extends _$User {
  @override
  StateUser build() {
    return StateUser();
  }

  Future<bool> login(LoginParam param) async {
    bool result = false;
    await ApiUser.login(param, HttpTool.postReq, okFunc: (res) async {
      await KKUSp.set(KKCRequestApi.authorizationToken, res.token);
      await ref.read(globalProvider.notifier).refreshCurrentUser();
      result = true;
    }, errorFunc: (res) {
      result = false;
    });
    return result;
  }

  Future<bool> logout(LogoutParam param) async {
    bool result = false;
    await ApiUser.logout(param, HttpTool.postReq, okFunc: (res) async {
      await KKUSp.remove(KKCRequestApi.authorizationToken);
      ToolNavigator.toPageLogin();
      result = true;
    }, errorFunc: (res) {
      result = false;
    });
    return result;
  }

  Future<bool> getMyInfo() async {
    bool hasData = false;
    await ApiUser.myInfo(MyInfoParam(), HttpTool.postReq, okFunc: (res) async {
      await ref.read(globalProvider.notifier).updateCurrentUser(PBUser(
            userName: res.userName,
            password: ref.watch(globalProvider).currentUser.password,
            roles: res.roles,
          ));
      hasData = true;
    }, errorFunc: (res) {
      hasData = false;
    });
    return hasData;
  }

  Future<bool> userList() async {
    bool finished = false;
    await ApiUser.userList(UserListParam(), HttpTool.postReq, okFunc: (res) {
      state.pbListUser.clear();
      state.pbListUser.listUser.addAll(res.listUser.listUser);
      ref.notifyListeners();
      finished = true;
    });
    return finished;
  }

  Future<bool> userAdd(UserAddParam param) async {
    bool finished = false;
    await ApiUser.userAdd(param, HttpTool.postReq, okFunc: (res) {
      KKSnackBar.ok(getGlobalCtx(), const Text('add success'));
      finished = true;
    }, errorFunc: (res) {
      KKSnackBar.error(getGlobalCtx(), const Text('add error'));
      finished = false;
    });
    return finished;
  }

  Future<void> userDelete(UserDeleteParam param) async {
    await ApiUser.userDelete(param, HttpTool.postReq, okFunc: (res) {
      KKSnackBar.ok(getGlobalCtx(), const Text('delete success'));
      state.pbListUser.listUser
          .removeWhere((element) => element.userName == param.userName);
      ref.notifyListeners();
    });
  }

  Future<bool> userGrantRole(UserGrantRoleParam param) async {
    bool finished = false;
    await ApiUser.userGrantRole(param, HttpTool.postReq, okFunc: (res) async {
      KKSnackBar.ok(getGlobalCtx(), const Text('grant success'));
      await userList();
      ref.notifyListeners();
      finished = true;
    }, errorFunc: (res) {
      KKSnackBar.error(getGlobalCtx(), const Text('grant error'));
      finished = false;
    });
    return finished;
  }
}

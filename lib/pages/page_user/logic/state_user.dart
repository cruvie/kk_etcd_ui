import 'package:flutter/cupertino.dart';
import 'package:kk_etcd_go/kk_etcd_apis/api_user.dart';
import 'package:kk_etcd_go/kk_etcd_models/api_user_kk_etcd.pb.dart';
import 'package:kk_etcd_go/kk_etcd_models/pb_user_kk_etcd.pb.dart';
import 'package:kk_etcd_ui/logic_global/state_global.dart';
import 'package:kk_etcd_ui/page_routes/router_util.dart';

import 'package:kk_etcd_ui/utils/request/request.dart';
import 'package:kk_etcd_ui/utils/tools/tool_navigator.dart';
import 'package:kk_etcd_ui/utils/tools/local_storage.dart';
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
    LoginResponse resp = LoginResponse();
    await ApiUser.login(param, resp, HttpTool.postReq, okFunc: () async {
      await LSAuthorizationToken.set(resp.token);
      await ref.read(globalProvider.notifier).refreshCurrentUser();
      result = true;
    }, errorFunc: () {
      result = false;
    });
    return result;
  }

  Future<bool> logout(LogoutParam param) async {
    bool result = false;
    LogoutResponse resp = LogoutResponse();
    await ApiUser.logout(param, resp, HttpTool.postReq, okFunc: () async {
      await LSAuthorizationToken.remove();
      ToolNavigator.toPageLogin();
      result = true;
    }, errorFunc: () {
      result = false;
    });
    return result;
  }

  Future<bool> getMyInfo() async {
    bool hasData = false;
    MyInfoResponse resp = MyInfoResponse();
    await ApiUser.myInfo(MyInfoParam(), resp, HttpTool.postReq,
        okFunc: () async {
      await ref.read(globalProvider.notifier).updateCurrentUser(PBUser(
            userName: resp.userName,
            password: ref.watch(globalProvider).currentUser.password,
            roles: resp.roles,
          ));
      hasData = true;
    }, errorFunc: () {
      hasData = false;
    });
    return hasData;
  }

  Future<bool> userList() async {
    bool finished = false;
    UserListResponse resp = UserListResponse();
    await ApiUser.userList(UserListParam(), resp, HttpTool.postReq, okFunc: () {
      state.pbListUser.clear();
      state.pbListUser.listUser.addAll(resp.listUser.listUser);
      ref.notifyListeners();
      finished = true;
    });
    return finished;
  }

  Future<bool> userAdd(UserAddParam param) async {
    bool finished = false;
    UserAddResponse resp = UserAddResponse();
    await ApiUser.userAdd(param, resp, HttpTool.postReq, okFunc: () {
      KKSnackBar.ok(getGlobalCtx(), const Text('add success'));
      finished = true;
    }, errorFunc: () {
      KKSnackBar.error(getGlobalCtx(), const Text('add error'));
      finished = false;
    });
    return finished;
  }

  Future<void> userDelete(UserDeleteParam param) async {
    UserDeleteResponse resp = UserDeleteResponse();
    await ApiUser.userDelete(param, resp, HttpTool.postReq, okFunc: () {
      KKSnackBar.ok(getGlobalCtx(), const Text('delete success'));
      state.pbListUser.listUser
          .removeWhere((element) => element.userName == param.userName);
      ref.notifyListeners();
    });
  }

  Future<bool> userGrantRole(UserGrantRoleParam param) async {
    bool finished = false;
    UserGrantRoleResponse resp = UserGrantRoleResponse();
    await ApiUser.userGrantRole(param, resp, HttpTool.postReq,
        okFunc: () async {
      KKSnackBar.ok(getGlobalCtx(), const Text('grant success'));
      await userList();
      ref.notifyListeners();
      finished = true;
    }, errorFunc: () {
      KKSnackBar.error(getGlobalCtx(), const Text('grant error'));
      finished = false;
    });
    return finished;
  }
}

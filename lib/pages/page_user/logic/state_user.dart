import 'package:flutter/cupertino.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/user/login/api.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/user/login/api.pb.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/user/logout/api.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/user/logout/api.pb.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/user/myInfo/api.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/user/myInfo/api.pb.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/user/userAdd/api.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/user/userAdd/api.pb.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/user/userDelete/api.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/user/userDelete/api.pb.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/user/userGrantRole/api.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/user/userGrantRole/api.pb.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/user/userList/api.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/user/userList/api.pb.dart';
import 'package:kk_etcd_go/kk_etcd_models/pb_user_kk_etcd.pb.dart';
import 'package:kk_etcd_ui/logic_global/state_global.dart';
import 'package:kk_etcd_ui/page_routes/router_path.dart';
import 'package:kk_etcd_ui/page_routes/router_util.dart';
import 'package:kk_etcd_ui/utils/request/request.dart';
import 'package:kk_etcd_ui/utils/tools/local_storage.dart';
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

  Future<bool> login(Login_Input param) async {
    bool result = false;
    Login_Output resp = Login_Output();
    await apiLogin(param, resp, HttpTool.postReq, okFunc: () async {
      await LSAuthorizationToken.set(resp.token);
      await ref.read(globalProvider.notifier).refreshCurrentUser();
      await RouterPath.init();
      result = true;
    }, errorFunc: () {
      result = false;
    });
    return result;
  }

  Future<bool> logout(Logout_Input param) async {
    bool result = false;
    Logout_Output resp = Logout_Output();
    await apiLogout(param, resp, HttpTool.postReq, okFunc: () async {
      result = true;
    }, errorFunc: () {
      result = false;
    });
    return result;
  }

  Future<bool> getMyInfo() async {
    bool hasData = false;
    MyInfo_Output resp = MyInfo_Output();
    await apiMyInfo(MyInfo_Input(), resp, HttpTool.postReq,
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
    UserList_Output resp = UserList_Output();
    await apiUserList(UserList_Input(), resp, HttpTool.postReq, okFunc: () {
      state.pbListUser.clear();
      state.pbListUser.listUser.addAll(resp.listUser.listUser);
      ref.notifyListeners();
      finished = true;
    });
    return finished;
  }

  Future<bool> userAdd(UserAdd_Input param) async {
    bool finished = false;
    UserAdd_Output resp = UserAdd_Output();
    await apiUserAdd(param, resp, HttpTool.postReq, okFunc: () {
      KKSnackBar.ok(getGlobalCtx(), const Text('add success'));
      finished = true;
    }, errorFunc: () {
      KKSnackBar.error(getGlobalCtx(), const Text('add error'));
      finished = false;
    });
    return finished;
  }

  Future<void> userDelete(UserDelete_Input param) async {
    UserDelete_Output resp = UserDelete_Output();
    await apiUserDelete(param, resp, HttpTool.postReq, okFunc: () {
      KKSnackBar.ok(getGlobalCtx(), const Text('delete success'));
      state.pbListUser.listUser
          .removeWhere((element) => element.userName == param.userName);
      ref.notifyListeners();
    });
  }

  Future<bool> userGrantRole(UserGrantRole_Input param) async {
    bool finished = false;
    UserGrantRole_Output resp = UserGrantRole_Output();
    await apiUserGrantRole(param, resp, HttpTool.postReq,
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

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kk_etcd_go/internal/service_hub/user/api_def/Login.pb.dart';
import 'package:kk_etcd_go/internal/service_hub/user/api_def/Logout.pb.dart';
import 'package:kk_etcd_go/internal/service_hub/user/api_def/MyInfo.pb.dart';
import 'package:kk_etcd_go/internal/service_hub/user/api_def/UserAdd.pb.dart';
import 'package:kk_etcd_go/internal/service_hub/user/api_def/UserDelete.pb.dart';
import 'package:kk_etcd_go/internal/service_hub/user/api_def/UserGrantRole.pb.dart';
import 'package:kk_etcd_go/internal/service_hub/user/api_def/UserList.pb.dart';
import 'package:kk_etcd_go/kk_etcd_models/pb_user_kk_etcd.pb.dart';
import 'package:kk_etcd_ui/logic_global/state_global.dart';
import 'package:kk_etcd_ui/page_routes/router_path.dart';
import 'package:kk_etcd_ui/page_routes/router_util.dart';
import 'package:kk_etcd_ui/utils/grpc/client.dart';
import 'package:kk_etcd_ui/utils/tools/local_storage.dart';

import 'package:kk_ui/kk_util/kk_log.dart';
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

  Future<bool> login(Login_Input param, WidgetRef ref) async {
    bool result = false;
    try {
      Login_Output resp = await userClientStub.login(param);
      await LSAuthorizationToken.set(resp.token);
      await ref.read(globalProvider.notifier).refreshCurrentUser();
      await RouterPath.init();
      result = true;
    } catch (e) {
      log.info("login $e");
      result = false;
    }
    return result;
  }

  Future<bool> logout(Logout_Input param) async {
    bool result = false;
    try {
      await userClientStub.logout(param);
      result = true;
    } catch (e) {
      log.info("logout $e");
      result = false;
    }
    return result;
  }

  Future<bool> getMyInfo() async {
    bool hasData = false;
    try {
      MyInfo_Output resp = await userClientStub.myInfo(MyInfo_Input());
      await ref
          .read(globalProvider.notifier)
          .updateCurrentUser(
            PBUser(
              userName: resp.userName,
              password: ref.watch(globalProvider).currentUser.password,
              roles: resp.roles,
            ),
          );
      hasData = true;
    } catch (e) {
      log.info("getMyInfo $e");
      hasData = false;
    }
    return hasData;
  }

  Future<bool> userList() async {
    bool finished = false;
    try {
      UserList_Output resp = await userClientStub.userList(UserList_Input());
      state.pbListUser.clear();
      state.pbListUser.listUser.addAll(resp.listUser.listUser);
      ref.notifyListeners();
      finished = true;
    } catch (e) {
      log.info("userList $e");
      finished = false;
    }
    return finished;
  }

  Future<bool> userAdd(UserAdd_Input param) async {
    bool finished = false;
    try {
      await userClientStub.userAdd(param);
      KKSnackBar.ok(getGlobalCtx(), const Text('add success'));
      finished = true;
    } catch (e) {
      log.info("userAdd $e");
      KKSnackBar.error(getGlobalCtx(), const Text('add error'));
      finished = false;
    }
    return finished;
  }

  Future<void> userDelete(UserDelete_Input param) async {
    try {
      await userClientStub.userDelete(param);
      KKSnackBar.ok(getGlobalCtx(), const Text('delete success'));
      state.pbListUser.listUser.removeWhere(
        (element) => element.userName == param.userName,
      );
      ref.notifyListeners();
    } catch (e) {
      log.info("userDelete $e");
    }
  }

  Future<bool> userGrantRole(UserGrantRole_Input param) async {
    bool finished = false;
    try {
      await userClientStub.userGrantRole(param);
      KKSnackBar.ok(getGlobalCtx(), const Text('grant success'));
      await userList();
      ref.notifyListeners();
      finished = true;
    } catch (e) {
      log.info("userGrantRole $e");
      KKSnackBar.error(getGlobalCtx(), const Text('grant error'));
      finished = false;
    }
    return finished;
  }
}

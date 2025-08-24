import 'package:flutter/cupertino.dart';
import 'package:kk_etcd_go/internal/service_hub/role/api_def/RoleAdd.pb.dart';
import 'package:kk_etcd_go/internal/service_hub/role/api_def/RoleDelete.pb.dart';
import 'package:kk_etcd_go/internal/service_hub/role/api_def/RoleGrantPermission.pb.dart';
import 'package:kk_etcd_go/internal/service_hub/role/api_def/RoleList.pb.dart';
import 'package:kk_etcd_go/internal/service_hub/role/api_def/RoleRevokePermission.pb.dart';
import 'package:kk_etcd_go/kk_etcd_models/pb_role_kk_etcd.pb.dart';
import 'package:kk_etcd_ui/logic_global/state_global.dart';
import 'package:kk_etcd_ui/page_routes/router_util.dart';
import 'package:kk_etcd_ui/utils/grpc/client.dart';

import 'package:kk_ui/kk_util/kk_log.dart';
import 'package:kk_ui/kk_widget/kk_snack_bar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'state_role.g.dart';

class StateRole {
  PBListRole pbListRole = PBListRole();

  PBRole currentRole = PBRole();
}

@riverpod
class Role extends _$Role {
  @override
  StateRole build() {
    return StateRole();
  }

  Future<bool> roleList() async {
    bool finished = false;
    try {
      RoleList_Output resp = await roleClientStub.roleList(RoleList_Input());
      state.pbListRole.list.clear();
      state.pbListRole.list.addAll(resp.listRole.list);
      ref.notifyListeners();
      finished = true;
    } catch (e) {
      log.info("roleList $e");
    }
    return finished;
  }

  Future<bool> roleAdd(String name) async {
    bool finished = false;
    try {
      await roleClientStub.roleAdd(RoleAdd_Input(name: name));
      KKSnackBar.ok(getGlobalCtx(), const Text("add succeed"));
      finished = true;
    } catch (e) {
      log.info("roleAdd $e");
    }
    return finished;
  }

  Future<bool> roleGrantPermission(RoleGrantPermission_Input role) async {
    bool success = false;
    try {
      await roleClientStub.roleGrantPermission(role);
      KKSnackBar.ok(getGlobalCtx(), const Text("update succeed"));
      ref.read(globalProvider.notifier).refreshCurrentUser();
      //update role list
      roleList();
      success = true;
    } catch (e) {
      log.info("roleGrantPermission $e");
      KKSnackBar.error(getGlobalCtx(), const Text('update failed'));
      success = false;
    }
    return success;
  }

  Future<bool> roleRevokePermission(RoleRevokePermission_Input param) async {
    bool finished = false;
    try {
      await roleClientStub.roleRevokePermission(param);
      KKSnackBar.ok(getGlobalCtx(), const Text("update succeed"));
      //update role list
      roleList();
      finished = true;
    } catch (e) {
      log.info("roleRevokePermission $e");
      KKSnackBar.error(getGlobalCtx(), const Text('update failed'));
      finished = false;
    }
    return finished;
  }

  Future<bool> roleDelete(RoleDelete_Input role) async {
    bool finished = false;
    try {
      await roleClientStub.roleDelete(role);
      KKSnackBar.ok(getGlobalCtx(), const Text("delete succeed"));
      state.pbListRole.list.removeWhere(
            (element) => element.name == role.name,
      );
      ref.notifyListeners();
      finished = true;
    } catch (e) {
      log.info("roleDelete $e");
      KKSnackBar.error(getGlobalCtx(), const Text('delete failed'));
      finished = false;
    }
    return finished;
  }

  void setCurrentRole(PBRole role) {
    state.currentRole = role;
    ref.notifyListeners();
  }
}

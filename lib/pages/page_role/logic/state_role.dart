import 'package:flutter/cupertino.dart';
import 'package:kk_etcd_go/kk_etcd_models/api_role_kk_etcd.pb.dart';
import 'package:kk_etcd_go/kk_etcd_models/pb_role_kk_etcd.pb.dart';
import 'package:kk_etcd_go/kk_etcd_apis/api_role.dart';
import 'package:kk_etcd_ui/logic_global/state_global.dart';
import 'package:kk_etcd_ui/page_routes/router_util.dart';
import 'package:kk_etcd_ui/utils/request/request.dart';
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
    RoleListResponse resp = RoleListResponse();
    await ApiRole.roleList(RoleListParam(), resp, HttpTool.postReq, okFunc: () {
      state.pbListRole.list.clear();
      state.pbListRole.list.addAll(resp.listRole.list);
      ref.notifyListeners();
      finished = true;
    });
    return finished;
  }

  Future<bool> roleAdd(String name) async {
    bool finished = false;
    RoleAddResponse resp = RoleAddResponse();
    await ApiRole.roleAdd(RoleAddParam(name: name), resp, HttpTool.postReq,
        okFunc: () {
      KKSnackBar.ok(getGlobalCtx(), const Text("add succeed"));
      finished = true;
    });
    return finished;
  }

  Future<bool> roleGrantPermission(RoleGrantPermissionParam role) async {
    bool success = false;
    RoleGrantPermissionResponse resp = RoleGrantPermissionResponse();
    await ApiRole.roleGrantPermission(role, resp, HttpTool.postReq, okFunc: () {
      KKSnackBar.ok(getGlobalCtx(), const Text("update succeed"));
      ref.read(globalProvider.notifier).refreshCurrentUser();
      //update role list
      roleList();
      success = true;
    }, errorFunc: () {
      KKSnackBar.error(getGlobalCtx(), const Text('update failed'));
      success = false;
    });
    return success;
  }

  Future<bool> roleRevokePermission(RoleRevokePermissionParam param) async {
    bool finished = false;
    RoleRevokePermissionResponse resp = RoleRevokePermissionResponse();
    await ApiRole.roleRevokePermission(param, resp, HttpTool.postReq, okFunc: () {
      KKSnackBar.ok(getGlobalCtx(), const Text("update succeed"));
      //update role list
      roleList();
      finished = true;
    }, errorFunc: () {
      KKSnackBar.error(getGlobalCtx(), const Text('update failed'));
      finished = false;
    });
    return finished;
  }

  Future<bool> roleDelete(RoleDeleteParam role) async {
    bool finished = false;
    RoleDeleteResponse resp = RoleDeleteResponse();
    await ApiRole.roleDelete(role, resp, HttpTool.postReq, okFunc: () {
      KKSnackBar.ok(getGlobalCtx(), const Text("delete succeed"));
      state.pbListRole.list.removeWhere((element) => element.name == role.name);
      ref.notifyListeners();
      finished = true;
    }, errorFunc: () {
      KKSnackBar.error(getGlobalCtx(), const Text('delete failed'));
      finished = false;
    });
    return finished;
  }

  void setCurrentRole(PBRole role) {
    state.currentRole=role;
    ref.notifyListeners();
  }
}

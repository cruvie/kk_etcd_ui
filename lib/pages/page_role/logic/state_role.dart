import 'package:flutter/cupertino.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/role/roleAdd/api.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/role/roleAdd/api.pb.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/role/roleDelete/api.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/role/roleDelete/api.pb.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/role/roleGrantPermission/api.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/role/roleGrantPermission/api.pb.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/role/roleList/api.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/role/roleList/api.pb.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/role/roleRevokePermission/api.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/role/roleRevokePermission/api.pb.dart';
import 'package:kk_etcd_go/kk_etcd_models/pb_role_kk_etcd.pb.dart';
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
    RoleList_Output resp = RoleList_Output();
    await apiRoleList(RoleList_Input(), resp, HttpTool.postReq, okFunc: () {
      state.pbListRole.list.clear();
      state.pbListRole.list.addAll(resp.listRole.list);
      ref.notifyListeners();
      finished = true;
    });
    return finished;
  }

  Future<bool> roleAdd(String name) async {
    bool finished = false;
    RoleAdd_Output resp = RoleAdd_Output();
    await apiRoleAdd(RoleAdd_Input(name: name), resp, HttpTool.postReq,
        okFunc: () {
      KKSnackBar.ok(getGlobalCtx(), const Text("add succeed"));
      finished = true;
    });
    return finished;
  }

  Future<bool> roleGrantPermission(RoleGrantPermission_Input role) async {
    bool success = false;
    RoleGrantPermission_Output resp = RoleGrantPermission_Output();
    await apiRoleGrantPermission(role, resp, HttpTool.postReq, okFunc: () {
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

  Future<bool> roleRevokePermission(RoleRevokePermission_Input param) async {
    bool finished = false;
    RoleRevokePermission_Output resp = RoleRevokePermission_Output();
    await apiRoleRevokePermission(param, resp, HttpTool.postReq, okFunc: () {
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

  Future<bool> roleDelete(RoleDelete_Input role) async {
    bool finished = false;
    RoleDelete_Output resp = RoleDelete_Output();
    await apiRoleDelete(role, resp, HttpTool.postReq, okFunc: () {
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

import 'package:flutter/cupertino.dart';
import 'package:kk_etcd_go/kk_etcd_apis/api_backup.dart';
import 'package:kk_etcd_go/kk_etcd_models/api_backup_kk_etcd.pb.dart';
import 'package:kk_etcd_go/kk_etcd_models/pb_server_kk_etcd.pb.dart';
import 'package:kk_etcd_ui/page_routes/router_util.dart';
import 'package:kk_etcd_ui/utils/request/request.dart';
import 'package:kk_ui/kk_widget/kk_snack_bar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'state_backup.g.dart';

class StateBackup {
  PBListServer pbListServer = PBListServer();
}
@riverpod
class Backup extends _$Backup {
  @override
  StateBackup build() {
    return StateBackup();
  }

  Future<SnapshotResponse> snapshot(SnapshotParam param) async {
    SnapshotResponse resp = SnapshotResponse();
    await ApiBackup.snapshot(param, resp, HttpTool.postReq, okFunc: () async {

    }, errorFunc: () {
      KKSnackBar.error(getGlobalCtx(), const Text('failed to snapshot'));
    });
    return resp;
  }

  Future<String> snapshotRestore(SnapshotRestoreParam param) async {
    SnapshotRestoreResponse resp = SnapshotRestoreResponse();
    await ApiBackup.snapshotRestore(param, resp, HttpTool.postReq,
        okFunc: () async {

    }, errorFunc: () {
      KKSnackBar.error(
          getGlobalCtx(), const Text('failed to get snapshotRestore'));
    });
    return resp.cmdStr;
  }

  Future<String> snapshotInfo(SnapshotInfoParam param) async {
    SnapshotInfoResponse resp = SnapshotInfoResponse();
    await ApiBackup.snapshotInfo(param, resp, HttpTool.postReq, okFunc: () async {

    });
    return resp.info;
  }

  Future<AllKVsBackupResponse> allKVsBackup(AllKVsBackupParam param) async {
    AllKVsBackupResponse resp = AllKVsBackupResponse();
    await ApiBackup.allKVsBackup(param, resp, HttpTool.postReq, okFunc: () async {

    });
    return resp;
  }

  Future<bool> allKVsRestore(AllKVsRestoreParam param) async {
    bool succeed = false;
    AllKVsRestoreResponse resp = AllKVsRestoreResponse();
    await ApiBackup.allKVsRestore(param, resp, HttpTool.postReq, okFunc: () async {
      KKSnackBar.ok(getGlobalCtx(), const Text("restore succeed"),
          duration: const Duration(seconds: 10));
      succeed = true;
    }, errorFunc: () {
      KKSnackBar.error(getGlobalCtx(), const Text('failed to AllKVsRestore'),
          duration: const Duration(seconds: 10));
    });
    return succeed;
  }
}

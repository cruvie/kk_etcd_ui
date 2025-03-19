import 'package:flutter/cupertino.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/backup/allKVsBackup/api.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/backup/allKVsBackup/api.pb.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/backup/allKVsRestore/api.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/backup/allKVsRestore/api.pb.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/backup/snapshot/api.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/backup/snapshot/api.pb.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/backup/snapshotInfo/api.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/backup/snapshotInfo/api.pb.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/backup/snapshotRestore/api.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/backup/snapshotRestore/api.pb.dart';

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

  Future<Snapshot_Output> snapshot(Snapshot_Input param) async {
    Snapshot_Output resp = Snapshot_Output();
    await apiSnapshot(
      param,
      resp,
      HttpTool.postReq,
      okFunc: () async {},
      errorFunc: () {
        KKSnackBar.error(getGlobalCtx(), const Text('failed to snapshot'));
      },
    );
    return resp;
  }

  Future<String> snapshotRestore(SnapshotRestore_Input param) async {
    SnapshotRestore_Output resp = SnapshotRestore_Output();
    await apiSnapshotRestore(
      param,
      resp,
      HttpTool.postReq,
      okFunc: () async {},
      errorFunc: () {
        KKSnackBar.error(
          getGlobalCtx(),
          const Text('failed to get snapshotRestore'),
        );
      },
    );
    return resp.cmdStr;
  }

  Future<String> snapshotInfo(SnapshotInfo_Input param) async {
    SnapshotInfo_Output resp = SnapshotInfo_Output();
    await apiSnapshotInfo(
      param,
      resp,
      HttpTool.postReq,
      okFunc: () async {},
    );
    return resp.info;
  }

  Future<AllKVsBackup_Output> allKVsBackup(AllKVsBackup_Input param) async {
    AllKVsBackup_Output resp = AllKVsBackup_Output();
    await apiAllKVsBackup(param, resp, HttpTool.postReq, okFunc: () async {});
    return resp;
  }

  Future<bool> allKVsRestore(AllKVsRestore_Input param) async {
    bool succeed = false;
    AllKVsRestore_Output resp = AllKVsRestore_Output();
    await apiAllKVsRestore(
      param,
      resp,
      HttpTool.postReq,
      okFunc: () async {
        KKSnackBar.ok(
          getGlobalCtx(),
          const Text("restore succeed"),
          duration: const Duration(seconds: 10),
        );
        succeed = true;
      },
      errorFunc: () {
        KKSnackBar.error(
          getGlobalCtx(),
          const Text('failed to AllKVsRestore'),
          duration: const Duration(seconds: 10),
        );
      },
    );
    return succeed;
  }
}

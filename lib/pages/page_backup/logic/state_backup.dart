import 'package:flutter/cupertino.dart';
import 'package:kk_etcd_go/internal/service_hub/backup/api_def/AllKVsBackup.pb.dart';
import 'package:kk_etcd_go/internal/service_hub/backup/api_def/AllKVsRestore.pb.dart';
import 'package:kk_etcd_go/internal/service_hub/backup/api_def/Snapshot.pb.dart';
import 'package:kk_etcd_go/internal/service_hub/backup/api_def/SnapshotInfo.pb.dart';
import 'package:kk_etcd_go/internal/service_hub/backup/api_def/SnapshotRestore.pb.dart';
import 'package:kk_etcd_go/kk_etcd_models/pb_service_kk_etcd.pb.dart';
import 'package:kk_etcd_ui/page_routes/router_util.dart';
import 'package:kk_etcd_ui/utils/grpc/client.dart';

import 'package:kk_ui/kk_util/kk_log.dart';
import 'package:kk_ui/kk_widget/kk_snack_bar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'state_backup.g.dart';

class StateBackup {
  PBListService pbListService = PBListService();
}

@riverpod
class Backup extends _$Backup {
  @override
  StateBackup build() {
    return StateBackup();
  }

  Future<Snapshot_Output> snapshot(Snapshot_Input param) async {
    Snapshot_Output resp = Snapshot_Output();
    try {
      resp = await backupClientStub.snapshot(param);
    } catch (e) {
      log.info("snapshot $e");
      KKSnackBar.error(getGlobalCtx(), const Text('failed to snapshot'));
    }
    return resp;
  }

  Future<String> snapshotRestore(SnapshotRestore_Input param) async {
    SnapshotRestore_Output resp = SnapshotRestore_Output();
    try {
      resp = await backupClientStub.snapshotRestore(param);
    } catch (e) {
      log.info("snapshotRestore $e");
      KKSnackBar.error(
        getGlobalCtx(),
        const Text('failed to get snapshotRestore'),
      );
    }
    return resp.cmdStr;
  }

  Future<String> snapshotInfo(SnapshotInfo_Input param) async {
    SnapshotInfo_Output resp = SnapshotInfo_Output();
    try {
      resp = await backupClientStub.snapshotInfo(param);
    } catch (e) {
      log.info("snapshotInfo $e");
    }
    return resp.info;
  }

  Future<AllKVsBackup_Output> allKVsBackup(AllKVsBackup_Input param) async {
    AllKVsBackup_Output resp = AllKVsBackup_Output();
    try {
      resp = await backupClientStub.allKVsBackup(param);
    } catch (e) {
      log.info("allKVsBackup $e");
    }
    return resp;
  }

  Future<bool> allKVsRestore(AllKVsRestore_Input param) async {
    bool succeed = false;
    try {
      await backupClientStub.allKVsRestore(param);
      KKSnackBar.ok(
        getGlobalCtx(),
        const Text("restore succeed"),
        duration: const Duration(seconds: 10),
      );
      succeed = true;
    } catch (e) {
      log.info("allKVsRestore $e");
      KKSnackBar.error(
        getGlobalCtx(),
        const Text('failed to AllKVsRestore'),
        duration: const Duration(seconds: 10),
      );
    }
    return succeed;
  }
}
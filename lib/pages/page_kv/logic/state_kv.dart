import 'package:flutter/cupertino.dart';
import 'package:kk_etcd_go/internal/service_hub/kv/api_def/KVList.pb.dart';
import 'package:kk_etcd_go/internal/service_hub/kv/api_def/KVDel.pb.dart';
import 'package:kk_etcd_go/internal/service_hub/kv/api_def/KVGet.pb.dart';
import 'package:kk_etcd_go/internal/service_hub/kv/api_def/KVPut.pb.dart';
import 'package:kk_etcd_go/kk_etcd_models/pb_kv_kk_etcd.pb.dart';
import 'package:kk_etcd_ui/page_routes/router_util.dart';
import 'package:kk_etcd_ui/utils/grpc/client.dart';

import 'package:kk_ui/kk_util/kk_log.dart';
import 'package:kk_ui/kk_widget/kk_snack_bar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'state_kv.g.dart';

class StateKV {
  PBListKV pbKVList = PBListKV();

  PBKV currentKV = PBKV();
}

@riverpod
class KV extends _$KV {
  @override
  StateKV build() {
    return StateKV();
  }

  // Future<bool> kVList(KVList_Input param) async {
  //   bool result = false;
  //   KVList_Output out = KVList_Output();
  //   await kkBaseRequest(
  //     ApiKv.kVList,
  //     param,
  //     resp,
  //     HttpTool.postReq,
  //     okFunc: () {
  //       state.pbKVList.clear();
  //       state.pbKVList = resp.kVList;
  //       ref.notifyListeners();
  //       result = true;
  //     },
  //   );
  //   return result;
  // }
  Future<bool> kVList(KVList_Input param) async {
    bool result = false;
    try {
      KVList_Output out = await kvClientStub.kVList(param);
      state.pbKVList.clear();
      state.pbKVList = out.kVList;
      ref.notifyListeners();
      result = true;
    } catch (e) {
      log.info("kVList $e");
    }
    return result;
  }

  Future<bool> kVGet(KVGet_Input param) async {
    bool result = false;
    try {
      KVGet_Output out = await kvClientStub.kVGet(param);
      state.currentKV = out.kV;
      ref.notifyListeners();
      result = true;
    } catch (e) {
      log.info("kVGet $e");
      KKSnackBar.error(getGlobalCtx(), const Text('failed to get config !'));
      result = false;
    }
    return result;
  }

  Future<bool> kVPut(KVPut_Input param) async {
    bool finished = false;
    try {
      await kvClientStub.kVPut(param);
      KKSnackBar.ok(getGlobalCtx(), const Text("update succeed"));
      finished = true;
    } catch (e) {
      log.info("kVPut $e");
      KKSnackBar.error(getGlobalCtx(), const Text('update failed'));
    }
    return finished;
  }

  Future<bool> kVDel(KVDel_Input param) async {
    bool finished = false;
    try {
      await kvClientStub.kVDel(param);
      KKSnackBar.ok(getGlobalCtx(), const Text("delete succeed"));
      state.pbKVList.listKV.removeWhere(
        (element) => element.key == param.key,
      );
      ref.notifyListeners();
      finished = true;
    } catch (e) {
      log.info("kVDel $e");
      KKSnackBar.error(getGlobalCtx(), const Text('delete failed'));
    }
    return finished;
  }
}

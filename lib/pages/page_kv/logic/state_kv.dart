import 'package:flutter/cupertino.dart';
import 'package:kk_etcd_go/kk_etcd_apis/api_kv.dart';
import 'package:kk_etcd_go/kk_etcd_models/api_kv_kk_etcd.pb.dart';
import 'package:kk_etcd_go/kk_etcd_models/pb_kv_kk_etcd.pb.dart';
import 'package:kk_etcd_ui/page_routes/router_util.dart';
import 'package:kk_etcd_ui/utils/request/request.dart';
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

  Future<bool> kVList(KVListParam param) async {
    bool result = false;
    await ApiKV.kVList(param, HttpTool.postReq, okFunc: (res) {
      state.pbKVList.clear();
      state.pbKVList = res.kVList;
      ref.notifyListeners();
      result = true;
    });
    return result;
  }

  Future<bool> kVGet(KVGetParam param) async {
    // KVGetResponse resp = KVGetResponse();
    bool result = false;
    await ApiKV.kVGet(param, HttpTool.postReq, okFunc: (res) {
      state.currentKV = res.kV;
      ref.notifyListeners();
      result = true;
    }, errorFunc: (_) {
      KKSnackBar.error(getGlobalCtx(), const Text('failed to get config !'));
      result = false;
    });
    return result;
  }

  Future<bool> kVPut(KVPutParam param) async {
    bool finished = false;
    await ApiKV.kVPut(param, HttpTool.postReq, okFunc: (res) {
      KKSnackBar.ok(getGlobalCtx(), const Text("update succeed"));
      finished = true;
    }, errorFunc: (res) {
      KKSnackBar.error(getGlobalCtx(), const Text('update failed'));
    });
    return finished;
  }

  Future<bool> kVDel(KVDelParam param) async {
    bool finished = false;
    await ApiKV.kVDel(param, HttpTool.postReq, okFunc: (res) {
      KKSnackBar.ok(getGlobalCtx(), const Text("delete succeed"));
      state.pbKVList.listKV.removeWhere((element) => element.key == param.key);
      ref.notifyListeners();
      finished = true;
    }, errorFunc: (res) {
      KKSnackBar.error(getGlobalCtx(), const Text('delete failed'));
    });
    return finished;
  }
}

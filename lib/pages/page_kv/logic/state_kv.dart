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
    KVListResponse resp = KVListResponse();
    await ApiKV.kVList(param, resp, HttpTool.postReq, okFunc: () {
      state.pbKVList.clear();
      state.pbKVList = resp.kVList;
      ref.notifyListeners();
      result = true;
    });
    return result;
  }

  Future<bool> kVGet(KVGetParam param) async {
    // KVGetResponse resp = KVGetResponse();
    bool result = false;
    KVGetResponse resp = KVGetResponse();
    await ApiKV.kVGet(param, resp, HttpTool.postReq, okFunc: () {
      state.currentKV = resp.kV;
      ref.notifyListeners();
      result = true;
    }, errorFunc: () {
      KKSnackBar.error(getGlobalCtx(), const Text('failed to get config !'));
      result = false;
    });
    return result;
  }

  Future<bool> kVPut(KVPutParam param) async {
    bool finished = false;
    KVPutResponse resp = KVPutResponse();
    await ApiKV.kVPut(param, resp, HttpTool.postReq, okFunc: () {
      KKSnackBar.ok(getGlobalCtx(), const Text("update succeed"));
      finished = true;
    }, errorFunc: () {
      KKSnackBar.error(getGlobalCtx(), const Text('update failed'));
    });
    return finished;
  }

  Future<bool> kVDel(KVDelParam param) async {
    bool finished = false;
    KVDelResponse resp = KVDelResponse();
    await ApiKV.kVDel(param, resp, HttpTool.postReq, okFunc: () {
      KKSnackBar.ok(getGlobalCtx(), const Text("delete succeed"));
      state.pbKVList.listKV.removeWhere((element) => element.key == param.key);
      ref.notifyListeners();
      finished = true;
    }, errorFunc: () {
      KKSnackBar.error(getGlobalCtx(), const Text('delete failed'));
    });
    return finished;
  }
}

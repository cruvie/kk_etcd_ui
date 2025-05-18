import 'package:flutter/cupertino.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/api_kv.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/kv/api_def/KVDel.pb.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/kv/api_def/KVGet.pb.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/kv/api_def/KVList.pb.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/kv/api_def/KVPut.pb.dart';
import 'package:kk_etcd_go/kk_etcd_models/pb_kv_kk_etcd.pb.dart';
import 'package:kk_etcd_ui/page_routes/router_util.dart';
import 'package:kk_etcd_ui/utils/request/request.dart';
import 'package:kk_go_kit/kk_http/base_request.dart';
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

  Future<bool> kVList(KVList_Input param) async {
    bool result = false;
    KVList_Output resp = KVList_Output();
    await kkBaseRequest(
      ApiKv.kVList,
      param,
      resp,
      HttpTool.postReq,
      okFunc: () {
        state.pbKVList.clear();
        state.pbKVList = resp.kVList;
        ref.notifyListeners();
        result = true;
      },
    );
    return result;
  }

  Future<bool> kVGet(KVGet_Input param) async {
    // KVGet_Output resp = KVGet_Output();
    bool result = false;
    KVGet_Output resp = KVGet_Output();
    await kkBaseRequest(
      ApiKv.kVGet,
      param,
      resp,
      HttpTool.postReq,
      okFunc: () {
        state.currentKV = resp.kV;
        ref.notifyListeners();
        result = true;
      },
      errorFunc: () {
        KKSnackBar.error(getGlobalCtx(), const Text('failed to get config !'));
        result = false;
      },
    );
    return result;
  }

  Future<bool> kVPut(KVPut_Input param) async {
    bool finished = false;
    KVPut_Output resp = KVPut_Output();
    await kkBaseRequest(
      ApiKv.kVPut,
      param,
      resp,
      HttpTool.postReq,
      okFunc: () {
        KKSnackBar.ok(getGlobalCtx(), const Text("update succeed"));
        finished = true;
      },
      errorFunc: () {
        KKSnackBar.error(getGlobalCtx(), const Text('update failed'));
      },
    );
    return finished;
  }

  Future<bool> kVDel(KVDel_Input param) async {
    bool finished = false;
    KVDel_Output resp = KVDel_Output();
    await kkBaseRequest(
      ApiKv.kVDel,
      param,
      resp,
      HttpTool.postReq,
      okFunc: () {
        KKSnackBar.ok(getGlobalCtx(), const Text("delete succeed"));
        state.pbKVList.listKV.removeWhere(
          (element) => element.key == param.key,
        );
        ref.notifyListeners();
        finished = true;
      },
      errorFunc: () {
        KKSnackBar.error(getGlobalCtx(), const Text('delete failed'));
      },
    );
    return finished;
  }
}

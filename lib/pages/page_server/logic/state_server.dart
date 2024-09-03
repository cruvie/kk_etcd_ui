import 'package:flutter/cupertino.dart';
import 'package:kk_etcd_go/kk_etcd_apis/api_server.dart';
import 'package:kk_etcd_go/kk_etcd_models/api_server_kk_etcd.pb.dart';
import 'package:kk_etcd_go/kk_etcd_models/pb_server_kk_etcd.pb.dart';
import 'package:kk_etcd_ui/page_routes/router_util.dart';
import 'package:kk_etcd_ui/utils/request/request.dart';
import 'package:kk_ui/kk_widget/kk_snack_bar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'state_server.g.dart';

class StateServer {
  //todo separate http grpc server
  PBListServer pbListServer = PBListServer()
}

@riverpod
class Server extends _$Server {
  @override
  StateServer build() {
    return StateServer();
  }

  Future<bool> serverList(ServerListParam param) async {
    bool finished = false;
    await ApiServer.serverList(param, HttpTool.postReq, okFunc: (res) {
      state.pbListServer.clear();
      state.pbListServer.listServer.addAll(res.serverList.listServer);
      ref.notifyListeners();
      finished = true;
    }, errorFunc: (res) {
      KKSnackBar.error(
          getGlobalCtx(), const Text('failed to get server list!'));
      finished = false;
    });
    return finished;
  }

  Future<bool> deregisterServer(DeregisterServerParam param) async {
    bool finished = false;
    await ApiServer.deregisterServer(param, HttpTool.postReq, okFunc: (res) {
      state.pbListServer.listServer.removeWhere((e) {
        return (e.serverType == param.server.serverType) &&
            (e.serverName == param.server.serverName) &&
            (e.serverAddr == param.server.serverAddr);
      });
      ref.notifyListeners();
      KKSnackBar.ok(getGlobalCtx(), const Text("deregister success"));
      finished = true;
    }, errorFunc: (res) {
      finished = false;
    });
    return finished;
  }
}

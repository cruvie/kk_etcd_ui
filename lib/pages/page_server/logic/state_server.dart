import 'package:flutter/cupertino.dart';
import 'package:kk_etcd_go/key_prefix.dart';
import 'package:kk_etcd_go/kk_etcd_apis/api_server.dart';
import 'package:kk_etcd_go/kk_etcd_models/api_server_kk_etcd.pb.dart';
import 'package:kk_etcd_go/kk_etcd_models/pb_server_kk_etcd.pb.dart';
import 'package:kk_etcd_ui/page_routes/router_util.dart';
import 'package:kk_etcd_ui/utils/request/request.dart';
import 'package:kk_ui/kk_widget/kk_snack_bar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'state_server.g.dart';

class StateServer {
  PBListServer pbListServerHttp = PBListServer();
  PBListServer pbListServerGrpc = PBListServer();
}

@riverpod
class Server extends _$Server {
  @override
  StateServer build() {
    return StateServer();
  }

  Future<bool> serverList(ServerListParam param) async {
    bool finished = false;
    ServerListResponse resp = ServerListResponse();
    await ApiServer.serverList(param, resp, HttpTool.postReq, okFunc: () {
      switch (param.serverType) {
        case ServerType.Http:
          {
            state.pbListServerHttp.clear();
            state.pbListServerHttp.listServer.addAll(resp.serverList.listServer);
          }
        case ServerType.Grpc:
          {
            state.pbListServerGrpc.clear();
            state.pbListServerGrpc.listServer.addAll(resp.serverList.listServer);
          }
      }

      ref.notifyListeners();
      finished = true;
    }, errorFunc: () {
      KKSnackBar.error(
          getGlobalCtx(), const Text('failed to get server list!'));
      finished = false;
    });
    return finished;
  }

  Future<bool> deregisterServer(DeregisterServerParam param) async {
    bool finished = false;
    DeregisterServerResponse resp = DeregisterServerResponse();
    await ApiServer.deregisterServer(param, resp, HttpTool.postReq, okFunc: () {
      switch (param.server.serverType) {
        case ServerType.Http:
          {
            state.pbListServerHttp.listServer.removeWhere((e) {
              return (e.endpointKey == param.server.endpointKey) &&
                  (e.endpointAddr == param.server.endpointAddr);
            });
          }
        case ServerType.Grpc:
          {
            state.pbListServerGrpc.listServer.removeWhere((e) {
              return (e.endpointKey == param.server.endpointKey) &&
                  (e.endpointAddr == param.server.endpointAddr);
            });
          }
      }

      ref.notifyListeners();
      KKSnackBar.ok(getGlobalCtx(), const Text("deregister success"));
      finished = true;
    }, errorFunc: () {
      finished = false;
    });
    return finished;
  }
}

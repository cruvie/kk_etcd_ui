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
    await ApiServer.serverList(param, HttpTool.postReq, okFunc: (res) {
      switch (param.serverType) {
        case ServiceType.Http:
          {
            state.pbListServerHttp.clear();
            state.pbListServerHttp.listServer.addAll(res.serverList.listServer);
          }
        case ServiceType.Grpc:
          {
            state.pbListServerGrpc.clear();
            state.pbListServerGrpc.listServer.addAll(res.serverList.listServer);
          }
      }

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
      switch (param.server.serverType) {
        case ServiceType.Http:
          {
            state.pbListServerHttp.listServer.removeWhere((e) {
              return (e.serverName == param.server.serverName) &&
                  (e.serverAddr == param.server.serverAddr);
            });
          }
        case ServiceType.Grpc:
          {
            state.pbListServerGrpc.listServer.removeWhere((e) {
              return (e.serverName == param.server.serverName) &&
                  (e.serverAddr == param.server.serverAddr);
            });
          }
      }

      ref.notifyListeners();
      KKSnackBar.ok(getGlobalCtx(), const Text("deregister success"));
      finished = true;
    }, errorFunc: (res) {
      finished = false;
    });
    return finished;
  }
}

import 'package:flutter/cupertino.dart';
import 'package:kk_etcd_go/key_prefix.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/api_server.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/server/api_def/DeregisterServer.pb.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/server/api_def/ServerList.pb.dart';
import 'package:kk_etcd_go/kk_etcd_models/pb_server_kk_etcd.pb.dart';
import 'package:kk_etcd_go/kk_etcd_models/pb_server_registration.pb.dart';
import 'package:kk_etcd_ui/page_routes/router_util.dart';
import 'package:kk_etcd_ui/utils/request/request.dart';
import 'package:kk_go_kit/kk_http/base_request.dart';
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

  Future<bool> serverList(ServerList_Input param) async {
    bool finished = false;
    ServerList_Output resp = ServerList_Output();
    await kkBaseRequest(
      ApiServer.serverList,
      param,
      resp,
      HttpTool.postReq,
      okFunc: () {
        switch (param.serverType) {
          case PBServerType.Http:
            {
              state.pbListServerHttp.clear();
              state.pbListServerHttp.listServer.addAll(
                resp.serverList.listServer,
              );
            }
          case PBServerType.Grpc:
            {
              state.pbListServerGrpc.clear();
              state.pbListServerGrpc.listServer.addAll(
                resp.serverList.listServer,
              );
            }
          case PBServerType.Unknown:
            // TODO: Handle this case.
            break;
        }

        ref.notifyListeners();
        finished = true;
      },
      errorFunc: () {
        KKSnackBar.error(
          getGlobalCtx(),
          const Text('failed to get server list!'),
        );
        finished = false;
      },
    );
    return finished;
  }

  Future<bool> deregisterServer(DeregisterServer_Input param) async {
    bool finished = false;
    DeregisterServer_Output resp = DeregisterServer_Output();
    await kkBaseRequest(
      ApiServer.deregisterServer,
      param,
      resp,
      HttpTool.postReq,
      okFunc: () {
        switch (param.server.serverRegistration.serverType) {
          case PBServerType.Http:
            {
              state.pbListServerHttp.listServer.removeWhere((e) {
                return (e.serverRegistration.serverName ==
                        param.server.serverRegistration.serverName) &&
                    (e.serverRegistration.serverAddr ==
                        param.server.serverRegistration.serverAddr);
              });
            }
          case PBServerType.Grpc:
            {
              state.pbListServerGrpc.listServer.removeWhere((e) {
                return (e.serverRegistration.serverName ==
                        param.server.serverRegistration.serverName) &&
                    (e.serverRegistration.serverAddr ==
                        param.server.serverRegistration.serverAddr);
              });
            }
          case PBServerType.Unknown:
            // TODO: Handle this case.
            break;
        }

        ref.notifyListeners();
        KKSnackBar.ok(getGlobalCtx(), const Text("deregister success"));
        finished = true;
      },
      errorFunc: () {
        finished = false;
      },
    );
    return finished;
  }
}

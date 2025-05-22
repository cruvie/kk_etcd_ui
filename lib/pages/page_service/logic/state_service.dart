import 'package:flutter/cupertino.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/api_service.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/service/api_def/DeregisterService.pb.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/service/api_def/ServiceList.pb.dart';
import 'package:kk_etcd_go/kk_etcd_models/pb_service_kk_etcd.pb.dart';
import 'package:kk_etcd_go/kk_etcd_models/pb_service_registration.pb.dart';
import 'package:kk_etcd_ui/page_routes/router_util.dart';
import 'package:kk_etcd_ui/utils/request/request.dart';
import 'package:kk_go_kit/kk_http/base_request.dart';
import 'package:kk_ui/kk_widget/kk_snack_bar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'state_service.g.dart';

class StateService {
  PBListService pbListServiceHttp = PBListService();
  PBListService pbListServiceGrpc = PBListService();
}

@riverpod
class Service extends _$Service {
  @override
  StateService build() {
    return StateService();
  }

  Future<bool> serviceList(ServiceList_Input param) async {
    bool finished = false;
    ServiceList_Output resp = ServiceList_Output();
    await kkBaseRequest(
      ApiService.serviceList,
      param,
      resp,
      HttpTool.postReq,
      okFunc: () {
        switch (param.serviceType) {
          case PBServiceType.Http:
            {
              state.pbListServiceHttp.clear();
              state.pbListServiceHttp.listService.addAll(
                resp.serviceList.listService,
              );
            }
          case PBServiceType.Grpc:
            {
              state.pbListServiceGrpc.clear();
              state.pbListServiceGrpc.listService.addAll(
                resp.serviceList.listService,
              );
            }
          case PBServiceType.Unknown:
          // TODO: Handle this case.
            break;
        }

        ref.notifyListeners();
        finished = true;
      },
      errorFunc: () {
        KKSnackBar.error(
          getGlobalCtx(),
          const Text('failed to get service list!'),
        );
        finished = false;
      },
    );
    return finished;
  }

  Future<bool> deregisterService(DeregisterService_Input param) async {
    bool finished = false;
    DeregisterService_Output resp = DeregisterService_Output();
    await kkBaseRequest(
      ApiService.deregisterService,
      param,
      resp,
      HttpTool.postReq,
      okFunc: () {
        switch (param.service.serviceRegistration.serviceType) {
          case PBServiceType.Http:
            {
              state.pbListServiceHttp.listService.removeWhere((e) {
                return (e.serviceRegistration.serviceName ==
                    param.service.serviceRegistration.serviceName) &&
                    (e.serviceRegistration.serviceAddr ==
                        param.service.serviceRegistration.serviceAddr);
              });
            }
          case PBServiceType.Grpc:
            {
              state.pbListServiceGrpc.listService.removeWhere((e) {
                return (e.serviceRegistration.serviceName ==
                    param.service.serviceRegistration.serviceName) &&
                    (e.serviceRegistration.serviceAddr ==
                        param.service.serviceRegistration.serviceAddr);
              });
            }
          case PBServiceType.Unknown:
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

import 'package:flutter/cupertino.dart';
import 'package:kk_etcd_go/internal/service_hub/service/api_def/DeregisterService.pb.dart';
import 'package:kk_etcd_go/internal/service_hub/service/api_def/ServiceList.pb.dart';
import 'package:kk_etcd_go/kk_etcd_models/pb_service_kk_etcd.pb.dart';
import 'package:kk_etcd_go/kk_etcd_models/pb_service_registration.pb.dart';
import 'package:kk_etcd_ui/page_routes/router_util.dart';
import 'package:kk_etcd_ui/utils/grpc/client.dart';

import 'package:kk_ui/kk_util/kk_log.dart';
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
    try {
      ServiceList_Output resp = await serviceClientStub.serviceList(param);
      
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
    } catch (e) {
      log.info("serviceList $e");
      KKSnackBar.error(
        getGlobalCtx(),
        const Text('failed to get service list!'),
      );
      finished = false;
    }
    return finished;
  }

  Future<bool> deregisterService(DeregisterService_Input param) async {
    bool finished = false;
    try {
      await serviceClientStub.deregisterService(param);
      
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
    } catch (e) {
      log.info("deregisterService $e");
      finished = false;
    }
    return finished;
  }
}

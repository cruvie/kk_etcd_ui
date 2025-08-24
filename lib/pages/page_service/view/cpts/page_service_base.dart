import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kk_etcd_go/internal/service_hub/service/api_def/DeregisterService.pb.dart';
import 'package:kk_etcd_go/internal/service_hub/service/api_def/ServiceList.pb.dart';
import 'package:kk_etcd_go/kk_etcd_models/pb_service_kk_etcd.pb.dart';
import 'package:kk_etcd_go/kk_etcd_models/pb_service_registration.pb.dart';
import 'package:kk_etcd_ui/l10n/l10n.dart';
import 'package:kk_etcd_ui/pages/page_service/logic/state_service.dart';

class PageServiceBase extends ConsumerStatefulWidget {
  const PageServiceBase(this.serviceType, this.pbListService, {super.key});

  final PBServiceType serviceType;
  final PBListService pbListService;

  @override
  ConsumerState createState() => _PageServiceBaseState();
}

class _PageServiceBaseState extends ConsumerState<PageServiceBase> {
  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    await ref
        .read(serviceProvider.notifier)
        .serviceList(ServiceList_Input(serviceType: widget.serviceType));
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          heroTag: null,
          onPressed: initData,
          child: const Icon(Icons.refresh_outlined),
        ),
        body: Row(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Scrollbar(
                    controller: _scrollController,
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        dataRowMaxHeight: 70,
                        columns: <DataColumn>[
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                lTr(context).name,
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                lTr(context).address,
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                lTr(context).status,
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                lTr(context).action,
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),
                        ],
                        rows: assembleData(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // const Expanded(child: ConfigEdit())
          ],
        ),
      ),
    );
  }

  List<DataRow> assembleData() {
    // switch (widget.serviceType) {
    //   case ServiceType.Http:
    //     {
    //       state.pbListServiceHttp.clear();
    //       state.pbListServiceHttp.listService.addAll(resp.serviceList.listService);
    //     }
    //   case ServiceType.Grpc:
    //     {
    //       state.pbListServiceGrpc.clear();
    //       state.pbListServiceGrpc.listService.addAll(resp.serviceList.listService);
    //     }
    // }
    var readService = ref.read(serviceProvider.notifier);
    var watchService = ref.watch(serviceProvider);
    List<DataRow> configDataRows = [];
    for (PBService element in widget.pbListService.listService) {
      configDataRows.add(
        DataRow(
          cells: <DataCell>[
            //remove prefix
            DataCell(Text(element.serviceRegistration.serviceName)),
            DataCell(Text(element.serviceRegistration.serviceAddr)),
            DataCell(getServiceStatus(element.status)),
            DataCell(
              Row(
                children: [
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () async {
                        await readService.deregisterService(
                          DeregisterService_Input(service: element),
                        );
                      },
                      child: Text(
                        lTr(context).delete,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    return configDataRows;
  }

  Widget getServiceStatus(PBService_ServiceStatus status) {
    switch (status) {
      case PBService_ServiceStatus.Running:
        {
          return const Chip(
            label: Text("Running"),
            backgroundColor: Colors.green,
          );
        }
      case PBService_ServiceStatus.Stop:
        return const Chip(label: Text("Stop"), backgroundColor: Colors.red);
      case PBService_ServiceStatus.UnKnown:
        return const Chip(
          label: Text("UnKnown"),
          backgroundColor: Colors.orange,
        );
    }
    return const Chip(label: Text("UnKnown"), backgroundColor: Colors.orange);
  }
}

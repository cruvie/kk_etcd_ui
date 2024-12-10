
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kk_etcd_go/kk_etcd_models/api_server_kk_etcd.pb.dart';
import 'package:kk_etcd_go/kk_etcd_models/pb_server_kk_etcd.pb.dart';
import 'package:kk_etcd_ui/l10n/l10n.dart';
import 'package:kk_etcd_ui/pages/page_server/logic/state_server.dart';

class PageServerBase extends ConsumerStatefulWidget {
  const PageServerBase(this.serverType, this.pbListServer, {super.key});

  final String serverType;
  final PBListServer pbListServer;

  @override
  ConsumerState createState() => _PageServerBaseState();
}

class _PageServerBaseState extends ConsumerState<PageServerBase> {
  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    await ref
        .read(serverProvider.notifier)
        .serverList(ServerListParam(serverType: widget.serverType));
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
                        columns: <DataColumn>[
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                lTr(context).name,
                                style: const TextStyle(
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                lTr(context).address,
                                style: const TextStyle(
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                lTr(context).status,
                                style: const TextStyle(
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                          const DataColumn(
                            label: Expanded(
                              child: Text(
                                "last check time",
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                          const DataColumn(
                            label: Expanded(
                              child: Text(
                                "check msg",
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                lTr(context).action,
                                style: const TextStyle(
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                        ],
                        rows: assembleData(),
                      ),
                    ),
                  )
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
    // switch (widget.serverType) {
    //   case ServerType.Http:
    //     {
    //       state.pbListServerHttp.clear();
    //       state.pbListServerHttp.listServer.addAll(resp.serverList.listServer);
    //     }
    //   case ServerType.Grpc:
    //     {
    //       state.pbListServerGrpc.clear();
    //       state.pbListServerGrpc.listServer.addAll(resp.serverList.listServer);
    //     }
    // }
    var readServer = ref.read(serverProvider.notifier);
    var watchServer = ref.watch(serverProvider);
    List<DataRow> configDataRows = [];
    for (PBServer element in widget.pbListServer.listServer) {
      configDataRows.add(
        DataRow(
          cells: <DataCell>[
            //remove prefix
            DataCell(Text(element.endpointKey)),
            DataCell(Text(element.endpointAddr)),
            DataCell(
              getServerStatus(element.status),
            ),
            DataCell(Text('${element.lastCheck.toDateTime(toLocal: true)}')),
            DataCell(Text(element.msg)),
            DataCell(
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await readServer.deregisterServer(
                        DeregisterServerParam(
                          server: element,
                        ),
                      );
                    },
                    child: Text(
                      lTr(context).delete,
                      style: const TextStyle(color: Colors.red),
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

  Widget getServerStatus(PBServer_ServerStatus status) {
    switch (status) {
      case PBServer_ServerStatus.Init:
        {
          return const Chip(
            label: Text("Init"),
            backgroundColor: Colors.blue,
          );
        }
      case PBServer_ServerStatus.Running:
        {
          return const Chip(
            label: Text("Running"),
            backgroundColor: Colors.green,
          );
        }
      case PBServer_ServerStatus.Stop:
        return const Chip(
          label: Text("Stop"),
          backgroundColor: Colors.red,
        );
      case PBServer_ServerStatus.UnKnown:
        return const Chip(
          label: Text("UnKnown"),
          backgroundColor: Colors.orange,
        );
    }
    return const Chip(
      label: Text("UnKnown"),
      backgroundColor: Colors.orange,
    );
  }
}

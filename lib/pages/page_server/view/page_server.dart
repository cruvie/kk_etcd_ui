import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kk_etcd_go/key_prefix.dart';
import 'package:kk_etcd_go/kk_etcd_models/api_server_kk_etcd.pb.dart';
import 'package:kk_etcd_go/kk_etcd_models/pb_server_kk_etcd.pb.dart';
import 'package:kk_etcd_ui/l10n/l10n.dart';
import 'package:kk_etcd_ui/pages/page_server/logic/state_server.dart';


class PageServer extends ConsumerStatefulWidget {
  const PageServer({super.key});

  @override
  ConsumerState<PageServer> createState() => _PageServerState();
}

class _PageServerState extends ConsumerState<PageServer>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    await ref.read(serverProvider.notifier).serverList(ServerListParam(
      prefix: "/"
    ));
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var readServer = ref.read(serverProvider.notifier);
    var watchServer = ref.watch(serverProvider);
    return Scaffold(
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
                                  lTr(context).type,
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
        );
  }

  List<DataRow> assembleData() {
    List<DataRow> configDataRows = [];
    for (PBServer element in ref.watch(serverProvider).pbListServer.listServer) {
      configDataRows.add(
        DataRow(
          cells: <DataCell>[
            //remove prefix
            DataCell(Text(element.serviceName
                .replaceFirst(KeyPrefix.serviceHttp, '')
                .replaceFirst(KeyPrefix.serviceGrpc, '')
                .replaceFirst('/', ''))),
            DataCell(Text(element.serviceAddr)),
            DataCell(getServiceTypeTag(element.serviceName)),
            //一个绿色的里面有个对勾的图标
            const DataCell(
              Icon(
                Icons.check_circle_outline,
                color: Colors.green,
              ),
            ),
          ],
        ),
      );
    }
    return configDataRows;
  }

  Widget getServiceTypeTag(String serviceName) {
    if (serviceName.startsWith(KeyPrefix.serviceHttp)) {
      return const Chip(
        label: Text("HTTP"),
        backgroundColor: Colors.blue,
      );
    } else if (serviceName.startsWith(KeyPrefix.serviceGrpc)) {
      return const Chip(
        label: Text("GRPC"),
        backgroundColor: Colors.orange,
      );
    } else {
      return const Chip(
        label: Text("UNKNOWN"),
        backgroundColor: Colors.grey,
      );
    }
  }
}

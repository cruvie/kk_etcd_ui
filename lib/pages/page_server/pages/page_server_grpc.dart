import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kk_etcd_go/key_prefix.dart';
import 'package:kk_etcd_go/kk_etcd_models/pb_serer.pb.dart';
import 'package:kk_etcd_ui/l10n/l10n.dart';
import 'package:kk_etcd_ui/page_logics/logic_etcd/logic_etcd.dart';

class PageServerGrpc extends StatefulWidget {
  const PageServerGrpc({Key? key}) : super(key: key);

  @override
  State<PageServerGrpc> createState() => _PageServerGrpcState();
}

class _PageServerGrpcState extends State<PageServerGrpc>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    await LogicEtcd.to.serverList(context, KeyPrefix.serviceGrpc);
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Obx(() => Scaffold(
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
                                  lTr(context).name,
                                  style: const TextStyle(
                                      fontStyle: FontStyle.italic),
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
        ));
  }

  List<DataRow> assembleData() {
    List<DataRow> configDataRows = [];
    for (PBServer element in LogicEtcd.to.pbListGrpcServer.value.listServer) {
      configDataRows.add(
        DataRow(
          cells: <DataCell>[
            //remove prefix
            DataCell(Text(element.serviceName.replaceFirst(KeyPrefix.serviceGrpc, ''))),
            DataCell(Text(element.serviceAddr)),
            DataCell(
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // LogicEtcd.to.kVGet(context, element.key);
                    },
                    child: Text(lTr(context).view),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // LogicEtcd.to.kVDel(context, element.key);
                    },
                    child: Text(
                      lTr(context).delete,
                      style: const TextStyle(color: Colors.red),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }
    return configDataRows;
  }
}

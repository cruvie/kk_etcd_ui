import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kk_etcd_go/kk_etcd_models/pb_kv.pb.dart';
import 'package:kk_etcd_ui/l10n/l10n.dart';
import 'package:kk_etcd_ui/page_logics/logic_etcd/logic_etcd.dart';

import 'cpts/kv_edit.dart';

class PageKV extends StatefulWidget {
  const PageKV({Key? key}) : super(key: key);

  @override
  State<PageKV> createState() => _PageKVState();
}

class _PageKVState extends State<PageKV> {
  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    await LogicEtcd.to.kVList();
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
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
              const Expanded(child: KVEdit())
            ],
          ),
        ));
  }

  List<DataRow> assembleData() {
    List<DataRow> kvDataRows = [];
    for (PBKV element in LogicEtcd.to.pbKVList.value.listKV) {
      kvDataRows.add(
        DataRow(
          cells: <DataCell>[
            DataCell(
              Text(element.key, overflow: TextOverflow.visible),
            ),
            DataCell(
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      LogicEtcd.to.kVGet(context, element.key);
                    },
                    child: Text(lTr(context).view),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      LogicEtcd.to.kVDel(context, element.key);
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
    return kvDataRows;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/kv/api_def/KVDel.pb.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/kv/api_def/KVGet.pb.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/kv/api_def/KVList.pb.dart';
import 'package:kk_etcd_go/kk_etcd_models/pb_kv_kk_etcd.pb.dart';

import 'package:kk_etcd_ui/l10n/l10n.dart';
import 'package:kk_etcd_ui/pages/page_kv/logic/state_kv.dart';

import 'cpts/kv_edit.dart';

class PageKV extends ConsumerStatefulWidget {
  const PageKV({super.key});

  @override
  ConsumerState<PageKV> createState() => _PageKVState();
}

class _PageKVState extends ConsumerState<PageKV> {
  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    await ref.read(kVProvider.notifier).kVList(KVList_Input());
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var readKV = ref.read(kVProvider.notifier);
    var watchKV = ref.watch(kVProvider);
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
      ),
    );
  }

  List<DataRow> assembleData() {
    var readKV = ref.read(kVProvider.notifier);
    var watchKV = ref.watch(kVProvider);
    List<DataRow> kvDataRows = [];
    for (PBKV element in watchKV.pbKVList.listKV) {
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
                      readKV.kVGet(
                        KVGet_Input(
                          key: element.key,
                        ),
                      );
                    },
                    child: Text(lTr(context).view),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      readKV.kVDel(KVDel_Input(
                        key: element.key,
                      ));
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

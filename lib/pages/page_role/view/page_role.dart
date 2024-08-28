import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kk_etcd_go/kk_etcd_models/api_role_kk_etcd.pb.dart';

import 'package:kk_etcd_go/kk_etcd_models/pb_role_kk_etcd.pb.dart';
import 'package:kk_etcd_ui/l10n/l10n.dart';
import 'package:kk_etcd_ui/pages/page_role/logic/state_role.dart';

import 'cpts/role_edit.dart';

class PageRole extends ConsumerStatefulWidget {
  const PageRole({super.key});

  @override
  ConsumerState<PageRole> createState() => _PageRoleState();
}

class _PageRoleState extends ConsumerState<PageRole> {
  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    await ref.read(roleProvider.notifier).roleList();
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var readRole = ref.read(roleProvider.notifier);
    var watchRole = ref.watch(roleProvider);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
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
                              lTr(context).role,
                              style:
                                  const TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              lTr(context).action,
                              style:
                                  const TextStyle(fontStyle: FontStyle.italic),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
            FloatingActionButton(
              heroTag: null,
              onPressed: initData,
              child: const Icon(Icons.refresh_outlined),
            ),
          ],),
          const Divider(),
          const Expanded(flex: 3, child: RoleEdit())
        ],
      ),
    );
  }

  List<DataRow> assembleData() {
    var readRole = ref.read(roleProvider.notifier);
    var watchRole = ref.watch(roleProvider);
    List<DataRow> configDataRows = [];
    for (PBRole element in watchRole.pbListRole.list) {
      configDataRows.add(
        DataRow(
          cells: <DataCell>[
            DataCell(Text(element.name)),
            DataCell(
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      readRole.setCurrentRole(element);
                    },
                    child: Text(lTr(context).view),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      readRole.roleDelete(RoleDeleteParam(
                        name: element.name,
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
    return configDataRows;
  }
}

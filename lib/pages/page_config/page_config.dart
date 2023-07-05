import 'package:flutter/material.dart';
import 'package:kk_etcd_ui/l10n/l10n.dart';
import 'package:kk_etcd_ui/page_logics/logic_etcd/logic_etcd.dart';

import 'cpts/config_edit.dart';

class PageConfig extends StatefulWidget {
  const PageConfig({Key? key}) : super(key: key);

  @override
  State<PageConfig> createState() => _PageConfigState();
}

class _PageConfigState extends State<PageConfig> {
  @override
  void initState() {
    super.initState();
    logicEtcdRead(context).kVGetConfigList();
  }

  List<DataRow> configDataRows = [];
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    assembleData();
    return Scaffold(
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
                      columns:  <DataColumn>[
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              lTr(context).name,
                              style: const TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              lTr(context).action,
                              style: const TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                      ],
                      rows: configDataRows,
                    ),
                  ),
                )
              ],
            ),
          ),
          const Expanded(child: ConfigEdit())
        ],
      ),
    );
  }

  assembleData() {
    configDataRows.clear();
    logicEtcdWatch(context).pbConfigList.listKV.forEach(
      (element) {
        configDataRows.add(
          DataRow(
            cells: <DataCell>[
              DataCell(Text(element.key)),
              DataCell(
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        logicEtcdRead(context).kVGetConfig(element.key);
                      },
                      child:  Text(lTr(context).view),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        logicEtcdRead(context).kVDelConfig(element.key);
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
      },
    );
  }
}

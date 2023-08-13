import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kk_etcd_go/models/pb_role.pb.dart';
import 'package:kk_etcd_ui/global/utils/util_permission.dart';
import 'package:kk_etcd_ui/l10n/l10n.dart';
import 'package:kk_etcd_ui/page_logics/logic_etcd/logic_etcd.dart';

import 'cpts/role_edit.dart';

class PageRole extends StatefulWidget {
  const PageRole({Key? key}) : super(key: key);

  @override
  State<PageRole> createState() => _PageRoleState();
}

class _PageRoleState extends State<PageRole> {
  @override
  void initState() {
    super.initState();
    LogicEtcd.to.roleList();
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: Row(
            children: [
              Expanded(
                flex: 3,
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
                                  style: const TextStyle(
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  lTr(context).permission,
                                  style: const TextStyle(
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  lTr(context).key,
                                  style: const TextStyle(
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  lTr(context).rangeEnd,
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
              const Expanded(flex: 2, child: RoleEdit())
            ],
          ),
        ));
  }

  List<DataRow> assembleData() {
    List<DataRow> configDataRows = [];
    for (PBRole element in LogicEtcd.to.pbListRole.value.list) {
      configDataRows.add(
        DataRow(
          cells: <DataCell>[
            DataCell(Text(element.name)),
            DataCell(Text(UtilPermission.getPermissionType(
                context, element.permissionType))),
            DataCell(Text(element.key)),
            DataCell(Text(element.rangeEnd)),
            DataCell(
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      LogicEtcd.to.setCurrentRole(element);
                    },
                    child: Text(lTr(context).view),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      LogicEtcd.to.roleDelete(context, element.name);
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

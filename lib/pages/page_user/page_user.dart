import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kk_etcd_go/kk_etcd_models/pb_user.pb.dart';
import 'package:kk_etcd_ui/l10n/l10n.dart';
import 'package:kk_etcd_ui/page_logics/logic_etcd/logic_etcd.dart';

import 'cpts/add_role_dialog.dart';

class PageUser extends StatefulWidget {
  const PageUser({super.key});

  @override
  State<PageUser> createState() => _PageUserState();
}

class _PageUserState extends State<PageUser> {
  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    await LogicEtcd.to.userList();
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    assembleData();
    return Obx(
      () => Scaffold(
        floatingActionButton: FloatingActionButton(
          heroTag: null,
          onPressed: initData,
          child: const Icon(Icons.refresh_outlined),
        ),
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
                                lTr(context).name,
                                style: const TextStyle(
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<DataRow> assembleData() {
    List<DataRow> userDataRows = [];
    for (PBUser element in LogicEtcd.to.pbListUser.value.listUser) {
      userDataRows.add(
        DataRow(
          cells: <DataCell>[
            DataCell(Text(element.userName)),
            DataCell(
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(element.roles.toString()),
                  IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AddRoleDialog(
                                userName: element.userName,
                                roles: List.from(element.roles));
                          },
                        );
                      },
                      icon: const Icon(Icons.add_circle_outline,
                          color: Colors.blue))
                ],
              ),
            ),
            DataCell(Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    LogicEtcd.to.userDelete(context, element.userName);
                  },
                  child: Text(
                    lTr(context).delete,
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              ],
            )),
          ],
        ),
      );
    }
    return userDataRows;
  }
}

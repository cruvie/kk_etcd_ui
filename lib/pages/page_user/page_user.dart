import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kk_etcd_go/models/pb_user.pb.dart';
import 'package:kk_etcd_ui/l10n/l10n.dart';
import 'package:kk_etcd_ui/page_logics/logic_etcd/logic_etcd.dart';

class PageUser extends StatefulWidget {
  const PageUser({Key? key}) : super(key: key);

  @override
  State<PageUser> createState() => _PageUserState();
}

class _PageUserState extends State<PageUser> {
  @override
  void initState() {
    super.initState();
    LogicEtcd.to.getUserList();
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    assembleData();
    return Obx(() => Scaffold(
      body: ListView(
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
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        lTr(context).role,
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
                rows: assembleData(),
              ),
            ),
          )
        ],
      ),
    ));
  }

  List<DataRow> assembleData() {
    List<DataRow> userDataRows = [];
    for (PBUser element in LogicEtcd.to.pbListUser.value.listUser) {
      userDataRows.add(
        DataRow(
          cells: <DataCell>[
            DataCell(Text(element.userName)),
            DataCell(Text(element.roles.toString())),
            DataCell(Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    LogicEtcd.to.deleteUser(context, element.userName);
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

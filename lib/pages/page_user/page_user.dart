import 'package:flutter/material.dart';
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
    logicEtcdRead(context).getUserList();
  }

  List<DataRow> userDataRows = [];
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    assembleData();
    return Scaffold(
      body: ListView(
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
                rows: userDataRows,
              ),
            ),
          )
        ],
      ),
    );
  }

  assembleData() {
    userDataRows.clear();
    logicEtcdWatch(context).pbListUser.listUser.forEach((element) {
      userDataRows.add(
        DataRow(
          cells: <DataCell>[
            DataCell(Text(element.userName)),
            DataCell(Text(element.roles.toString())),
            DataCell(Row(
              children: [
                  ElevatedButton(
                    onPressed: () {
                      logicEtcdRead(context).deleteUser(context,element.userName);
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
    });
  }
}

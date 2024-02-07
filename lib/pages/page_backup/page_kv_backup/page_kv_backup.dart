import 'dart:io';
import 'dart:typed_data';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:kk_etcd_ui/l10n/l10n.dart';
import 'package:kk_etcd_ui/page_logics/logic_etcd/logic_etcd.dart';
import 'package:kk_go_kit/kk_pb_type/pb_type.pb.dart';
import 'package:kk_ui/kk_file/kk_file.dart';
import 'package:kk_ui/kk_util/kk_log.dart';
import 'package:kk_ui/kk_widget/kk_card.dart';

class PageKVBackup extends StatefulWidget {
  const PageKVBackup({super.key});

  @override
  State<PageKVBackup> createState() => _PageKVBackupState();
}

class _PageKVBackupState extends State<PageKVBackup> {
  String allKVsRestoreInfo = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const Padding(padding: EdgeInsets.only(top: 20)),
          ElevatedButton(
            onPressed: () async {
              PBFile pbFile = await LogicEtcd.to.allKVsBackup(context);
              if (context.mounted) {
                KKDownload.savaFile(
                    context, pbFile.name, Uint8List.fromList(pbFile.bytes));
              }
            },
            child: Text(lTr(context).allKVsBackup),
          ),
          Row(
            children: [
              ElevatedButton(
                  onPressed: () async {
                    await pickFile();
                    if (filePath != "") {
                      //read file
                      allKVsRestoreInfo = File(filePath).readAsStringSync();
                      PBFile pbFile =
                          PBFile(bytes: allKVsRestoreInfo.codeUnits);
                      if (context.mounted) {
                        await LogicEtcd.to.allKVsRestore(context, pbFile);
                      }
                      setState(() {});
                    }
                  },
                  child: Text(lTr(context).allKVsRestore)),
              Expanded(
                child: KKCard(
                  padding: const EdgeInsets.all(20),
                  child: Text(allKVsRestoreInfo),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  String filePath = "";

  pickFile() async {
    const XTypeGroup typeGroup = XTypeGroup(
      extensions: <String>['json'],
    );
    final XFile? file =
        await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);
    log.info(file);
    if (file != null) {
      filePath = file.path;
    }
  }
}

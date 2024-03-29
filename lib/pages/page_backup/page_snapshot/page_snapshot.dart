import 'dart:typed_data';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:kk_etcd_ui/l10n/l10n.dart';
import 'package:kk_etcd_ui/page_logics/logic_etcd/logic_etcd.dart';
import 'package:kk_go_kit/kk_pb_type/pb_type.pb.dart';
import 'package:kk_ui/kk_file/io.dart'
    if (dart.library.html) 'package:kk_ui/kk_file/web.dart';
import 'package:kk_ui/kk_widget/kk_card.dart';

class PageSnapshot extends StatefulWidget {
  const PageSnapshot({super.key});

  @override
  State<PageSnapshot> createState() => _PageSnapshotState();
}

class _PageSnapshotState extends State<PageSnapshot> {
  String snapshotRestoreCmd = "";
  String snapshotInfo = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const Padding(padding: EdgeInsets.only(top: 20)),
          ElevatedButton(
            onPressed: () async {
              PBFile pbFile = await LogicEtcd.to.snapshot(context);
              // debugPrint('${KKUPlatform.platformType()}');
              if (context.mounted) {
                KKDownload.savaFile(
                    context, pbFile.name, Uint8List.fromList(pbFile.bytes));
              }
            },
            child: Text(lTr(context).snapshot),
          ),
          Row(
            children: [
              ElevatedButton(
                  onPressed: () async {
                    snapshotRestoreCmd =
                        await LogicEtcd.to.snapshotRestore(context);
                    setState(() {});
                  },
                  child: Text(lTr(context).snapshotRestore)),
              Expanded(
                child: KKCard(
                  padding: const EdgeInsets.all(10),
                  child: SelectableText(snapshotRestoreCmd),
                ),
              )
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                  onPressed: () async {
                    await pickFile();
                    if (file != null) {
                      //read file
                      Uint8List bytes = await file!.readAsBytes();
                      PBFile pbFile = PBFile(bytes: bytes);
                      if (context.mounted) {
                        snapshotInfo =
                            await LogicEtcd.to.snapshotInfo(context, pbFile);
                      }
                      setState(() {});
                    }
                  },
                  child: Text(lTr(context).snapshotInfo)),
              Expanded(
                child: KKCard(
                  padding: const EdgeInsets.all(20),
                  child: SelectableText(snapshotInfo),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  XFile? file;

  pickFile() async {
    const XTypeGroup typeGroup = XTypeGroup(
      extensions: <String>['snapshot'],
    );
    file = await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);
    // log.info(file);
  }
}

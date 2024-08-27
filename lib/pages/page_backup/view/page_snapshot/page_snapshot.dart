import 'dart:typed_data';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kk_etcd_go/kk_etcd_models/api_backup_kk_etcd.pb.dart';
import 'package:kk_etcd_ui/l10n/l10n.dart';
import 'package:kk_etcd_ui/pages/page_backup/logic/state_backup.dart';

import 'package:kk_ui/kk_file/io.dart'
    if (dart.library.html) 'package:kk_ui/kk_file/web.dart';
import 'package:kk_ui/kk_widget/kk_card.dart';

class PageSnapshot extends ConsumerStatefulWidget {
  const PageSnapshot({super.key});

  @override
  ConsumerState<PageSnapshot> createState() => _PageSnapshotState();
}

class _PageSnapshotState extends ConsumerState<PageSnapshot> {
  String snapshotRestoreCmd = "";
  String snapshotInfo = "";

  @override
  Widget build(BuildContext context) {
    var readBackup = ref.read(backupProvider.notifier);
    return Scaffold(
      body: ListView(
        children: [
          const Padding(padding: EdgeInsets.only(top: 20)),
          ElevatedButton(
            onPressed: () async {
              SnapshotResponse resp = await readBackup.snapshot(SnapshotParam());
              // debugPrint('${KKUPlatform.platformType()}');
              if (context.mounted) {
                KKDownload.savaFile(
                    context, resp.name, Uint8List.fromList(resp.file));
              }
            },
            child: Text(lTr(context).snapshot),
          ),
          Row(
            children: [
              ElevatedButton(
                  onPressed: () async {
                    snapshotRestoreCmd =
                        await readBackup.snapshotRestore(SnapshotRestoreParam());
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
                      if (context.mounted) {
                        snapshotInfo =
                            await readBackup.snapshotInfo(SnapshotInfoParam(
                              file:bytes.toList()
                            ));
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

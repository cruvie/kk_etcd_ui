import 'dart:typed_data';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kk_etcd_go/internal/service_hub/backup/api_def/AllKVsBackup.pb.dart';
import 'package:kk_etcd_go/internal/service_hub/backup/api_def/AllKVsRestore.pb.dart';
import 'package:kk_etcd_ui/l10n/l10n.dart';
import 'package:kk_etcd_ui/pages/page_backup/logic/state_backup.dart';
import 'package:kk_ui/kk_file/io.dart'
if (dart.library.html) 'package:kk_ui/kk_file/web.dart';
import 'package:kk_ui/kk_widget/kk_card.dart';

class PageKVBackup extends ConsumerStatefulWidget {
  const PageKVBackup({super.key});

  @override
  ConsumerState<PageKVBackup> createState() => _PageKVBackupState();
}

class _PageKVBackupState extends ConsumerState<PageKVBackup> {
  String allKVsRestoreInfo = "";

  @override
  Widget build(BuildContext context) {
    var readBackup = ref.read(backupProvider.notifier);
    return Scaffold(
      body: ListView(
        children: [
          const Padding(padding: EdgeInsets.only(top: 20)),
          ElevatedButton(
            onPressed: () async {
              AllKVsBackup_Output response =
              await readBackup.allKVsBackup(AllKVsBackup_Input());
              if (context.mounted) {
                KKDownload.savaFile(
                    context, response.name, Uint8List.fromList(response.file));
              }
            },
            child: Text(lTr(context).allKVsBackup),
          ),
          Row(
            children: [
              ElevatedButton(
                  onPressed: () async {
                    await pickFile();
                    if (file != null) {
                      //read file
                      allKVsRestoreInfo = await file!.readAsString();
                      if (context.mounted) {
                        await readBackup.allKVsRestore(AllKVsRestore_Input(
                          file: allKVsRestoreInfo.codeUnits,
                        ));
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

  XFile? file;

  pickFile() async {
    const XTypeGroup typeGroup = XTypeGroup(
      extensions: <String>['json'],
    );
    file = await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);
    // log.info(file);
  }
}

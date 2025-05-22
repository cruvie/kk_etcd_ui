import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kk_etcd_ui/l10n/l10n.dart';
import 'package:kk_etcd_ui/pages/page_backup/view/page_kv_backup/page_kv_backup.dart';
import 'package:kk_etcd_ui/pages/page_backup/view/page_snapshot/page_snapshot.dart';

class PageBackup extends ConsumerStatefulWidget {
  const PageBackup({super.key});

  @override
  ConsumerState<PageBackup> createState() => _PageBackupState();
}

class _PageBackupState extends ConsumerState<PageBackup>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late final tabController =
  TabController(vsync: this, length: getTabs().length);

  List<Tab> getTabs() {
    return [
      Tab(text: lTr(context).snapshot),
      Tab(text: lTr(context).kVBackup),
    ];
  }

  List<Widget> pages = [
    const PageSnapshot(),
    const PageKVBackup(),
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TabBar(
          controller: tabController,
          tabs: getTabs(),
          tabAlignment: TabAlignment.center,
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: pages,
      ),
    );
  }
}

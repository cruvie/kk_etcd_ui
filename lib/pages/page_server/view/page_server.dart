import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kk_etcd_go/key_prefix.dart';
import 'package:kk_etcd_ui/pages/page_server/logic/state_server.dart';
import 'package:kk_etcd_ui/pages/page_server/view/cpts/page_server_base.dart';

class PageServer extends ConsumerStatefulWidget {
  const PageServer({super.key});

  @override
  ConsumerState<PageServer> createState() => _PageServerState();
}

class _PageServerState extends ConsumerState<PageServer>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late final tabController =
      TabController(vsync: this, length: getTabs().length);

  List<Tab> getTabs() {
    return [
      const Tab(text: 'HTTP'),
      const Tab(text: 'GRPC'),
    ];
  }

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
        children: [
          PageServerBase(
              ServerType.Http, ref.watch(serverProvider).pbListServerHttp),
          PageServerBase(
              ServerType.Grpc, ref.watch(serverProvider).pbListServerGrpc),
        ],
      ),
    );
  }
}

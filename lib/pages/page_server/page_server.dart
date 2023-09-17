import 'package:flutter/material.dart';
import 'package:kk_etcd_ui/pages/page_server/pages/page_server_grpc.dart';
import 'package:kk_etcd_ui/pages/page_server/pages/page_server_http.dart';

class PageServer extends StatefulWidget {
  const PageServer({Key? key}) : super(key: key);

  @override
  State<PageServer> createState() => _PageServerState();
}

class _PageServerState extends State<PageServer>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late final _tabController =
      TabController(vsync: this, length: _getTabs(context).length);

  List<Tab> _getTabs(BuildContext context) {
    return [
      const Tab(text: "Http"),
      const Tab(text: "gRPC"),
    ];
  }

  List<Widget> pages = [
    const PageServerHttp(),
    const PageServerGrpc(),
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TabBar(
          controller: _tabController,
          tabs: _getTabs(context),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: pages,
      ),
    );
  }
}

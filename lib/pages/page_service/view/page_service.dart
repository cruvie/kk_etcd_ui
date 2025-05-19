import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kk_etcd_go/kk_etcd_models/pb_service_registration.pbenum.dart';
import 'package:kk_etcd_ui/pages/page_service/logic/state_service.dart';

import 'cpts/page_service_base.dart';

class PageService extends ConsumerStatefulWidget {
  const PageService({super.key});

  @override
  ConsumerState<PageService> createState() => _PageServiceState();
}

class _PageServiceState extends ConsumerState<PageService>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late final tabController = TabController(
    vsync: this,
    length: getTabs().length,
  );

  List<Tab> getTabs() {
    return [const Tab(text: 'HTTP'), const Tab(text: 'GRPC')];
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
          PageServiceBase(
            PBServiceType.Http,
            ref.watch(serviceProvider).pbListServiceHttp,
          ),
          PageServiceBase(
            PBServiceType.Grpc,
            ref.watch(serviceProvider).pbListServiceGrpc,
          ),
        ],
      ),
    );
  }
}

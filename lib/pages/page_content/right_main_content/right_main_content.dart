import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import 'package:kk_etcd_ui/logic_global/state_global.dart';
import 'package:kk_etcd_ui/page_routes/router_util.dart';

class RightMainContent extends ConsumerStatefulWidget {
  const RightMainContent({super.key});

  @override
  ConsumerState<RightMainContent> createState() => _RightMainContentState();
}

class _RightMainContentState extends ConsumerState<RightMainContent> {
  @override
  Widget build(BuildContext context) {
    return PageView(
        controller: ref.watch(globalProvider).pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: allPages);
  }
}

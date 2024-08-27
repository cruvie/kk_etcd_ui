import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kk_etcd_ui/logic_global/state_global.dart';

import 'package:kk_etcd_ui/pages/page_content/right_main_content/right_main_content.dart';

import 'left_side_menu/left_side_menu.dart';

class PageContent extends ConsumerStatefulWidget {
  const PageContent({super.key});

  @override
  ConsumerState<PageContent> createState() => _PageNavigation();
}

class _PageNavigation extends ConsumerState<PageContent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const SizedBox(
            width: 240,
            child: LeftSideMenu(),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10),
              child: const RightMainContent(),
            ),
          ),
        ],
      ),
    );
  }
}

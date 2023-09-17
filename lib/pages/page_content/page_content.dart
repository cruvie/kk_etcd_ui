import 'package:flutter/material.dart';
import 'package:kk_etcd_ui/page_logics/logic_etcd/logic_etcd.dart';
import 'package:kk_etcd_ui/pages/page_content/right_main_content/right_main_content.dart';

import 'left_side_menu/left_side_menu.dart';

  class PageContent extends StatefulWidget {
  const PageContent({super.key});

  @override
  State<PageContent> createState() => _PageNavigation();
}

class _PageNavigation extends State<PageContent> {
  @override
  void initState() {
    super.initState();

 LogicEtcd.to.loadUserInfo();
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

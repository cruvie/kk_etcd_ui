import 'package:flutter/material.dart';
import 'package:kk_etcd_ui/page_logics/logic_navigation/logic_navigation.dart';

class RightMainContent extends StatefulWidget {
  const RightMainContent({Key? key}) : super(key: key);

  @override
  State<RightMainContent> createState() => _RightMainContentState();
}

class _RightMainContentState extends State<RightMainContent> {
  @override
  Widget build(BuildContext context) {
    return PageView(
        controller: logicNavigationWatch(context).pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: LogicNavigation.pages);
  }
}

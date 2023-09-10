import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kk_etcd_ui/l10n/l10n.dart';
import 'package:kk_etcd_ui/page_logics/logic_etcd/logic_etcd.dart';
import 'package:kk_etcd_ui/page_logics/logic_navigation/logic_navigation.dart';
import 'package:kk_ui/kk_widget/kk_card.dart';
import 'package:kk_ui/kk_widget/kk_theme_mode_switcher.dart';

import 'cpts/about_info.dart';
import 'cpts/show_language_popup_menu.dart';

class LeftSideMenu extends StatefulWidget {
  const LeftSideMenu({super.key});

  @override
  State<LeftSideMenu> createState() => _LeftSideMenuState();
}

class _LeftSideMenuState extends State<LeftSideMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView(
              children: [
                DrawerHeader(
                  margin: const EdgeInsets.all(0),
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    children: [
                      Image.asset(
                        'lib/assets/logo.png',
                        width: 90,
                        height: 90,
                      ),
                      Text(lTr(context).title),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          showLanguagePopupMenu(context),
                          const KKThemeModeSwitcher(),
                        ],
                      ),
                    ],
                  ),
                ),
                ExpansionTile(
                    leading: const Icon(CupertinoIcons.doc_text),
                    title: GestureDetector(
                      child: Text(lTr(context).pageConfig),
                      onTap: () {
                        LogicNavigation.to.changeDestination(0);
                      },
                    ),
                    childrenPadding: const EdgeInsets.only(left: 20),
                    children: [
                      ListTile(
                        onTap: () {
                          LogicNavigation.to.changeDestination(1);
                        },
                        leading: const Icon(Icons.edit_note_outlined),
                        title: Text(lTr(context).pageAddConfig),
                      ),
                    ]),
                ExpansionTile(
                    leading: const Icon(CupertinoIcons.doc_text),
                    title: GestureDetector(
                      child: Text(lTr(context).pageKV),
                      onTap: () {
                        LogicNavigation.to.changeDestination(2);
                      },
                    ),
                    childrenPadding: const EdgeInsets.only(left: 20),
                    children: [
                      ListTile(
                        onTap: () {
                          LogicNavigation.to.changeDestination(3);
                        },
                        leading: const Icon(Icons.edit_note_outlined),
                        title: Text(lTr(context).pageAddKV),
                      ),
                    ]),
                ExpansionTile(
                    leading: const Icon(CupertinoIcons.person_crop_circle),
                    title: GestureDetector(
                      child: Text(lTr(context).pageUser),
                      onTap: () {
                        LogicNavigation.to.changeDestination(4);
                      },
                    ),
                    childrenPadding: const EdgeInsets.only(left: 20),
                    children: [
                      ListTile(
                        onTap: () {
                          LogicNavigation.to.changeDestination(5);
                        },
                        leading: const Icon(Icons.edit_note_outlined),
                        title: Text(lTr(context).pageAddUser),
                      ),
                    ]),
                ExpansionTile(
                    leading: const Icon(Icons.accessibility_new_outlined),
                    title: GestureDetector(
                      child: Text(lTr(context).pageRole),
                      onTap: () {
                        LogicNavigation.to.changeDestination(6);
                      },
                    ),
                    childrenPadding: const EdgeInsets.only(left: 20),
                    children: [
                      ListTile(
                        onTap: () {
                          LogicNavigation.to.changeDestination(7);
                        },
                        leading: const Icon(Icons.edit_note_outlined),
                        title: Text(lTr(context).pageAddRole),
                      ),
                    ]),
              ],
            ),
          ),
          Column(
            children: [
              KKCard(
                padding: const EdgeInsets.all(10),
                child: Column(children: [
                  const Icon(Icons.person_pin_circle_outlined),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(LogicEtcd.to.loginUserInfo.value.userName),
                    Text(LogicEtcd.to.loginUserInfo.value.roles.toString()),
                  ],
                )
                ],),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                IconButton(
                  onPressed: () {
                    aboutInfo(context);
                  },
                  icon: const Icon(Icons.info_outline),
                ),
                IconButton(
                  onPressed: () {
                    LogicEtcd.to.logout(context);
                  },
                  icon: const Icon(Icons.logout_outlined),
                ),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}

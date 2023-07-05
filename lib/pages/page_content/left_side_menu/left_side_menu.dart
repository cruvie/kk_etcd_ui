import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kk_etcd_ui/l10n/l10n.dart';
import 'package:kk_etcd_ui/page_logics/logic_etcd/logic_etcd.dart';
import 'package:kk_etcd_ui/page_logics/logic_navigation/logic_navigation.dart';
import 'package:kk_ui/kk_const/kkc_theme.dart';
import 'package:kk_ui/kk_util/kku_theme.dart';
import 'package:kk_ui/kk_util/kku_theme_mode.dart';

import 'cpts/about_info.dart';
import 'cpts/show_language_popup_menu.dart';

class LeftSideMenu extends StatefulWidget {
  const LeftSideMenu({super.key});

  @override
  State<LeftSideMenu> createState() => _LeftSideMenuState();
}

class _LeftSideMenuState extends State<LeftSideMenu> {
  bool isLight = false;

  @override
  Widget build(BuildContext context) {
    isLight = !KKUTheme.isAppInDarkMode(context);
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
                          Material(
                            color: Colors.transparent,
                            child: Transform.scale(
                              scale: 0.7,
                              child: Switch(
                                value: isLight,
                                onChanged: (bool value) {
                                  if (value) {
                                    KKUThemeMode.changeThemeMode(
                                        context, KKCTheme.themeLight);
                                  } else {
                                    KKUThemeMode.changeThemeMode(
                                        context, KKCTheme.themeDark);
                                  }
                                  setState(() {
                                    isLight = value;
                                  });
                                },
                                thumbIcon: MaterialStateProperty.resolveWith(
                                  (states) => isLight
                                      ? const Icon(
                                          Icons.wb_sunny_outlined,
                                          color: Colors.yellow,
                                        )
                                      : const Icon(Icons.nights_stay_outlined,
                                          color: Color.fromRGBO(
                                              255, 255, 82, 1.0)),
                                ),
                              ),
                            ),
                          ),
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
                        logicNavigationRead(context).changeDestination(0);
                      },
                    ),
                    childrenPadding: const EdgeInsets.only(left: 20),
                    children: [
                      ListTile(
                        onTap: () {
                          logicNavigationRead(context).changeDestination(1);
                        },
                        leading: const Icon(Icons.edit_note_outlined),
                        title: Text(lTr(context).pageAddConfig),
                      ),
                    ]),
                ExpansionTile(
                    leading: const Icon(CupertinoIcons.person_crop_circle),
                    title: GestureDetector(
                      child: Text(lTr(context).pageUser),
                      onTap: () {
                        logicNavigationRead(context).changeDestination(2);
                      },
                    ),
                    childrenPadding: const EdgeInsets.only(left: 20),
                    children: [
                      ListTile(
                        onTap: () {
                          logicNavigationRead(context).changeDestination(3);
                        },
                        leading: const Icon(Icons.edit_note_outlined),
                        title: Text(lTr(context).pageAddUser),
                      ),
                    ]),
              ],
            ),
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
                logicEtcdRead(context).logout(context);
              },
              icon: const Icon(Icons.logout_outlined),
            ),
          ]),
        ],
      ),
    );
  }
}

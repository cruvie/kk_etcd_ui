import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kk_etcd_go/kk_etcd_models/api_user_kk_etcd.pb.dart';
import 'package:kk_etcd_ui/l10n/l10n.dart';

import 'package:kk_etcd_ui/logic_global/state_global.dart';
import 'package:kk_etcd_ui/pages/page_ai/view/page_ai.dart';
import 'package:kk_etcd_ui/pages/page_backup/view/page_backup.dart';
import 'package:kk_etcd_ui/pages/page_kv/view/page_add_kv/page_add_kv.dart';
import 'package:kk_etcd_ui/pages/page_kv/view/page_kv.dart';
import 'package:kk_etcd_ui/pages/page_role/view/page_add_role/page_add_role.dart';
import 'package:kk_etcd_ui/pages/page_role/view/page_role.dart';
import 'package:kk_etcd_ui/pages/page_server/view/page_server.dart';
import 'package:kk_etcd_ui/pages/page_user/logic/state_user.dart';
import 'package:kk_etcd_ui/pages/page_user/view/page_add_user/page_add_user.dart';
import 'package:kk_etcd_ui/pages/page_user/view/page_user.dart';
import 'package:kk_etcd_ui/utils/tools/local_storage.dart';
import 'package:kk_etcd_ui/utils/tools/tool_navigator.dart';
import 'package:kk_ui/kk_widget/kk_card.dart';
import 'package:kk_ui/kk_widget/kk_theme_mode_switcher.dart';

import 'cpts/about_info.dart';
import 'cpts/show_language_popup_menu.dart';

class LeftSideMenu extends ConsumerStatefulWidget {
  const LeftSideMenu({super.key});

  @override
  ConsumerState<LeftSideMenu> createState() => _LeftSideMenuState();
}

class _LeftSideMenuState extends ConsumerState<LeftSideMenu> {
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
                          showLanguagePopupMenu(ref),
                          const KKThemeModeSwitcher(),
                        ],
                      ),
                    ],
                  ),
                ),
                ExpansionTile(
                  leading: const Icon(Icons.alt_route_outlined),
                  title: GestureDetector(
                    child: Text(lTr(context).pageServer),
                    onTap: () {
                      ref
                          .read(globalProvider.notifier)
                          .changeDestination(const PageServer());
                    },
                  ),
                  childrenPadding: const EdgeInsets.only(left: 20),
                ),
                ExpansionTile(
                    leading: const Icon(Icons.auto_awesome_motion_outlined),
                    title: GestureDetector(
                      child: Text(lTr(context).pageKV),
                      onTap: () {
                        ref
                            .read(globalProvider.notifier)
                            .changeDestination(const PageKV());
                      },
                    ),
                    childrenPadding: const EdgeInsets.only(left: 20),
                    children: [
                      ListTile(
                        onTap: () {
                          ref
                              .read(globalProvider.notifier)
                              .changeDestination(const PageAddKV());
                        },
                        leading: const Icon(Icons.edit_note_outlined),
                        title: Text(lTr(context).pageAddKV),
                      ),
                    ]),
                ExpansionTile(
                  leading: const Icon(Icons.backup_outlined),
                  title: GestureDetector(
                    child: Text(lTr(context).pageBackup),
                    onTap: () {
                      ref
                          .read(globalProvider.notifier)
                          .changeDestination(const PageBackup());
                    },
                  ),
                  childrenPadding: const EdgeInsets.only(left: 20),
                ),
                ExpansionTile(
                    leading: const Icon(Icons.supervised_user_circle_outlined),
                    title: GestureDetector(
                      child: Text(lTr(context).pageUser),
                      onTap: () {
                        ref
                            .read(globalProvider.notifier)
                            .changeDestination(const PageUser());
                      },
                    ),
                    childrenPadding: const EdgeInsets.only(left: 20),
                    children: [
                      ListTile(
                        onTap: () {
                          ref
                              .read(globalProvider.notifier)
                              .changeDestination(const PageAddUser());
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
                        ref
                            .read(globalProvider.notifier)
                            .changeDestination(const PageRole());
                      },
                    ),
                    childrenPadding: const EdgeInsets.only(left: 20),
                    children: [
                      ListTile(
                        onTap: () {
                          ref
                              .read(globalProvider.notifier)
                              .changeDestination(const PageAddRole());
                        },
                        leading: const Icon(Icons.edit_note_outlined),
                        title: Text(lTr(context).pageAddRole),
                      ),
                    ]),
                ExpansionTile(
                    leading: const Icon(Icons.chat_outlined),
                    title: GestureDetector(
                      child: Text("AI"),
                      onTap: () {
                        ref
                            .read(globalProvider.notifier)
                            .changeDestination(const PageAI());
                      },
                    ),
                    childrenPadding: const EdgeInsets.only(left: 20),
                    children: []),
              ],
            ),
          ),
          Column(
            children: [
              KKCard(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const Icon(Icons.person_pin_circle_outlined),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(ref.watch(globalProvider).currentUser.userName),
                        Text(ref
                            .watch(globalProvider)
                            .currentUser
                            .roles
                            .toString()),
                      ],
                    )
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
                  onPressed: () async {
                    ref.read(userProvider.notifier).logout(LogoutParam());
                    // no matter success or not, we should remove token and return to login page
                    await LSAuthorizationToken.remove();
                    await LSMyInfo.remove();
                    ref.read(globalProvider.notifier).resetCurrentUser();
                    ToolNavigator.toPageLogin();
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

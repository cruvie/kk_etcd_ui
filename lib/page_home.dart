import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kk_etcd_ui/pages/page_content/page_content.dart';
import 'package:kk_ui/kk_util/kku_language.dart';
import 'package:kk_ui/kk_util/kku_theme_mode.dart';


class PageHome extends ConsumerStatefulWidget {
  const PageHome({super.key});

  @override
  ConsumerState<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends ConsumerState<PageHome> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ///设置语言
      ref
          .read(kKULanguageProvider.notifier)
          .changeLang(StateKKULanguage.getLocale());
      ///设置主题模式
      ref
          .read(kKUThemeModeProvider.notifier)
          .changeThemeMode(StateKKUThemeMode.getThemeMode());
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageContent(),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kk_etcd_ui/pages/page_content/page_content.dart';
import 'package:kk_ui/kk_const/kkc_locale.dart';
import 'package:kk_ui/kk_const/kkc_theme.dart';
import 'package:kk_ui/kk_util/kku_language.dart';
import 'package:kk_ui/kk_util/kku_sp.dart';
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
      Map? local = KKUSp.get<Map>(KKCLocale.locale);
      if (local != null) {
        // log.info(local.toString());
        String languageCode = local.keys.first;
        String countryCode = local[languageCode]!;
        ref
            .read(kKULanguageProvider.notifier)
            .changeLang(languageCode, countryCode);
      }
      String? mode = KKUSp.get(KKCTheme.themeMode);
      if (mode != null) {
        // log.info(KKUSp.get(KKCTheme.themeMode));
        ref.read(kKUThemeModeProvider.notifier).changeThemeMode(mode);
      }
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kk_etcd_ui/pages/page_content/page_content.dart';
import 'package:kk_etcd_ui/pages/page_index/view/page_login.dart';
import 'package:kk_ui/kk_const/kkc_locale.dart';
import 'package:kk_ui/kk_const/kkc_request_api.dart';
import 'package:kk_ui/kk_const/kkc_theme.dart';
import 'package:kk_ui/kk_util/kku_language.dart';
import 'package:kk_ui/kk_util/kku_sp.dart';
import 'package:kk_ui/kk_util/kku_theme_mode.dart';

import 'logic_global/state_global.dart';

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
      if (KKUSp.containsKey(KKCLocale.locale)) {
        Map local = KKUSp.get(KKCLocale.locale);
        // log.info(local.toString());
        String languageCode = local.keys.first;
        String countryCode = local[languageCode]!;
        ref
            .read(kKULanguageProvider.notifier)
            .changeLang(languageCode, countryCode);
      }

      if (KKUSp.containsKey(KKCTheme.themeMode)) {
        // log.info(KKUSp.get(KKCTheme.themeMode));
        ref
            .read(kKUThemeModeProvider.notifier)
            .changeThemeMode(KKUSp.get(KKCTheme.themeMode));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: (KKUSp.get(KKCRequestApi.authorizationToken) == null)
                ? const PageLogin()
                : const PageContent(),
          ),
        ],
      ),
    );
  }
}

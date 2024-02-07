import 'package:flutter/material.dart';
import 'package:kk_etcd_ui/global/utils/util_navigator.dart';
import 'package:kk_etcd_ui/pages/page_content/page_content.dart';
import 'package:kk_etcd_ui/pages/page_index/page_login.dart';
import 'package:kk_ui/kk_const/kkc_locale.dart';
import 'package:kk_ui/kk_const/kkc_request_api.dart';
import 'package:kk_ui/kk_const/kkc_theme.dart';
import 'package:kk_ui/kk_util/kku_language.dart';
import 'package:kk_ui/kk_util/kku_sp.dart';
import 'package:kk_ui/kk_util/kku_theme_mode.dart';

class PageHome extends StatefulWidget {
  const PageHome({super.key});

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (KKUSp.containsKey(KKCLocale.locale)) {
        Map local = KKUSp.getMap(KKCLocale.locale);
        // log.info(local.toString());
        String languageCode = local.keys.first;
        String countryCode = local[languageCode]!;
        KKULanguage.changeLang(languageCode, countryCode);
      }

      if (KKUSp.containsKey(KKCTheme.themeMode)) {
        // log.info(KKUSp.getLocalStorage(KKCTheme.themeMode));
        KKUThemeMode.changeThemeMode(KKUSp.getLocalStorage(KKCTheme.themeMode));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    UtilNavigator.globalContext = context;
    // log.info(KKUSp.getLocalStorage(KKCRequestApi.authorizationToken));
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: (KKUSp.getLocalStorage(KKCRequestApi.authorizationToken) ==
                    null)
                ? const PageLogin()
                : const PageContent(),
          ),
        ],
      ),
    );
  }
}

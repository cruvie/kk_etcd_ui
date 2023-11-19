import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:kk_etcd_ui/page_routes/router_cfg.dart';
import 'package:kk_ui/kk_util/kku_language.dart';
import 'package:kk_ui/kk_util/kku_sp.dart';
import 'package:kk_ui/kk_util/kku_theme_mode.dart';

import 'initialize/initialize.dart';
import 'l10n/l10n.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await KKUSp.initPreferences();
  Initialize.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => MaterialApp.router(
          routerConfig: RouterCfg.routerConfig,
          onGenerateTitle: (context) {
            return lTr(context).title;
          },
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          localizationsDelegates: L10n.localizationsDelegates(),
          supportedLocales: L10n.supportedLocales(),
          debugShowCheckedModeBanner: false,
          themeMode: KKUThemeMode.currentThemeMode.value,
          locale: KKULanguage.currentLocale.value,
        ));
  }
}

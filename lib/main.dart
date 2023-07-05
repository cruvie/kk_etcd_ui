import 'package:flutter/material.dart';
import 'package:kk_etcd_ui/page_logics/logic_etcd/logic_etcd.dart';
import 'package:kk_etcd_ui/page_logics/logic_global/logic_global.dart';
import 'package:kk_etcd_ui/page_logics/logic_navigation/logic_navigation.dart';
import 'package:kk_etcd_ui/page_routes/router_cfg.dart';
import 'package:kk_ui/kk_util/kku_language.dart';
import 'package:kk_ui/kk_util/kku_sp.dart';
import 'package:kk_ui/kk_util/kku_theme_mode.dart';
import 'package:provider/provider.dart';

import 'l10n/l10n.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await KKUSp.initPreferences();

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => KKULanguage()),
        ChangeNotifierProvider(create: (_) => KKUThemeMode()),
        ChangeNotifierProvider(create: (_) => LogicNavigation()),
        ChangeNotifierProvider(create: (_) => LogicEtcd()),
        ChangeNotifierProvider(create: (_) => LogicGlobal()),
      ],
      child: Consumer2<KKULanguage, KKUThemeMode>(
        builder: (context, langModel, themeModel, _) {
          return MaterialApp.router(
            routerConfig: RouterCfg.routerConfig,
            onGenerateTitle: (context) {
              return lTr(context).title;
            },
            theme: ThemeData.light(useMaterial3: true),
            darkTheme: ThemeData.dark(useMaterial3: true),
            localizationsDelegates: L10n.localizationsDelegates(),
            supportedLocales: L10n.supportedLocales(),
            debugShowCheckedModeBanner: false,
            themeMode: themeModel.currentThemeMode,
            locale: langModel.currentLocale,
          );
        },
      ),
    );
  }
}

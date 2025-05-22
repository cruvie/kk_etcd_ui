import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kk_etcd_ui/page_routes/router_cfg.dart';
import 'package:kk_etcd_ui/page_routes/router_path.dart';
import 'package:kk_ui/kk_util/kk_log.dart';
import 'package:kk_ui/kk_util/kku_language.dart';
import 'package:kk_ui/kk_util/kku_theme_mode.dart';

import 'l10n/generated/app_localizations.dart';
import 'l10n/l10n.dart';

final globalProviderContainer = ProviderContainer();

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  KKLog.initLog();

  await RouterPath.init();

  runApp(UncontrolledProviderScope(
      container: globalProviderContainer, child: const MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: RouterCfg.routerConfig,
      onGenerateTitle: (context) {
        if (AppLocalizations.of(context) == null) {
          return "KK ETCD";
        }
        return AppLocalizations.of(context)!.title;
      },
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      localizationsDelegates: L10n.localizationsDelegates(),
      supportedLocales: L10n.supportedLocales(),
      debugShowCheckedModeBanner: false,
      themeMode: ref
          .watch(kKUThemeModeProvider)
          .currentThemeMode,
      locale: ref
          .watch(kKULanguageProvider)
          .currentLocale,
    );
  }
}

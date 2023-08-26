import 'package:flutter/cupertino.dart';

import 'generated/app_localizations.dart';

AppLocalizations lTr(BuildContext context) {
  return AppLocalizations.of(context)!;
}

class L10n {
  static List<Locale> supportedLocales() {
    return AppLocalizations.supportedLocales;
  }

  static List<LocalizationsDelegate<dynamic>> localizationsDelegates() {
    return AppLocalizations.localizationsDelegates;
  }
}

import 'package:flutter/material.dart';
import 'package:kk_etcd_ui/l10n/language_map.dart';
import 'package:kk_ui/kk_util/kku_language.dart';

showLanguagePopupMenu(BuildContext context) {
  late List<String> languageList =
      LanguageMap.languageMap.entries.map((entry) => entry.key).toList();
  List<PopupMenuEntry<String>> list = [];
  for (int i = 0; i < languageList.length; i++) {
    list.add(
      PopupMenuItem<String>(
        child: Text(languageList[i]),
        onTap: () {
          String languageCode =
              LanguageMap.languageMap[languageList[i]]!.keys.first;
          String countryCode =
              LanguageMap.languageMap[languageList[i]]![languageCode]!;
          KKULanguage.changeLang(context, languageCode, countryCode);
        },
      ),
    );
    if (i < languageList.length - 1) {
      list.add(const PopupMenuDivider());
    }
  }
  return PopupMenuButton<String>(
    icon: const Icon(
      Icons.language_outlined,
      color: Colors.deepPurple,
    ),
    itemBuilder: (context) {
      return list;
    },
  );
}

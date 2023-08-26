import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh')
  ];

  /// No description provided for @ccGlobal.
  ///
  /// In en, this message translates to:
  /// **''**
  String get ccGlobal;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'KK ETCD'**
  String get title;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @pageError.
  ///
  /// In en, this message translates to:
  /// **'Page error'**
  String get pageError;

  /// No description provided for @sureToExit.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to exit?'**
  String get sureToExit;

  /// No description provided for @confirmDelete.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete it?'**
  String get confirmDelete;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @value.
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get value;

  /// No description provided for @action.
  ///
  /// In en, this message translates to:
  /// **'Action'**
  String get action;

  /// No description provided for @ccButton.
  ///
  /// In en, this message translates to:
  /// **''**
  String get ccButton;

  /// No description provided for @buttonCancel.
  ///
  /// In en, this message translates to:
  /// **'CANCEL'**
  String get buttonCancel;

  /// No description provided for @buttonOK.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get buttonOK;

  /// No description provided for @buttonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get buttonSave;

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// No description provided for @ccDialog.
  ///
  /// In en, this message translates to:
  /// **''**
  String get ccDialog;

  /// No description provided for @dialogInfo.
  ///
  /// In en, this message translates to:
  /// **'Info'**
  String get dialogInfo;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @warning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warning;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @successMsg.
  ///
  /// In en, this message translates to:
  /// **'Operation Succeed!'**
  String get successMsg;

  /// No description provided for @errorMsg.
  ///
  /// In en, this message translates to:
  /// **'Operation failed!'**
  String get errorMsg;

  /// No description provided for @pageIndex.
  ///
  /// In en, this message translates to:
  /// **''**
  String get pageIndex;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get login;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @enterUsername.
  ///
  /// In en, this message translates to:
  /// **'Please enter your user name'**
  String get enterUsername;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get enterPassword;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @serverAddress.
  ///
  /// In en, this message translates to:
  /// **'Server Address'**
  String get serverAddress;

  /// No description provided for @ccPageConfigManager.
  ///
  /// In en, this message translates to:
  /// **''**
  String get ccPageConfigManager;

  /// No description provided for @pageConfig.
  ///
  /// In en, this message translates to:
  /// **'Config Manager'**
  String get pageConfig;

  /// No description provided for @pageAddConfig.
  ///
  /// In en, this message translates to:
  /// **'Add config'**
  String get pageAddConfig;

  /// No description provided for @ccPageUser.
  ///
  /// In en, this message translates to:
  /// **''**
  String get ccPageUser;

  /// No description provided for @pageUser.
  ///
  /// In en, this message translates to:
  /// **'User Manager'**
  String get pageUser;

  /// No description provided for @pageAddUser.
  ///
  /// In en, this message translates to:
  /// **'Add user'**
  String get pageAddUser;

  /// No description provided for @pageRole.
  ///
  /// In en, this message translates to:
  /// **'Role Manager'**
  String get pageRole;

  /// No description provided for @pageAddRole.
  ///
  /// In en, this message translates to:
  /// **'Add role'**
  String get pageAddRole;

  /// No description provided for @permission.
  ///
  /// In en, this message translates to:
  /// **'permission'**
  String get permission;

  /// No description provided for @role.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get role;

  /// No description provided for @key.
  ///
  /// In en, this message translates to:
  /// **'key'**
  String get key;

  /// No description provided for @rangeEnd.
  ///
  /// In en, this message translates to:
  /// **'rangeEnd'**
  String get rangeEnd;

  /// No description provided for @read.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get read;

  /// No description provided for @write.
  ///
  /// In en, this message translates to:
  /// **'Write'**
  String get write;

  /// No description provided for @readWrite.
  ///
  /// In en, this message translates to:
  /// **'ReadWrite'**
  String get readWrite;

  /// No description provided for @ccPageContent.
  ///
  /// In en, this message translates to:
  /// **''**
  String get ccPageContent;

  /// No description provided for @donate.
  ///
  /// In en, this message translates to:
  /// **'Buy me ice cream🍦!'**
  String get donate;

  /// No description provided for @alipay.
  ///
  /// In en, this message translates to:
  /// **'Alipay'**
  String get alipay;

  /// No description provided for @wechatPay.
  ///
  /// In en, this message translates to:
  /// **'Wechat'**
  String get wechatPay;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'zh': return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}

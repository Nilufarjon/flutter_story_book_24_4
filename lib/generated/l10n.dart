// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Озор надеҳ`
  String get appname {
    return Intl.message(
      'Озор надеҳ',
      name: 'appname',
      desc: '',
      args: [],
    );
  }

  /// `Асосӣ`
  String get home {
    return Intl.message(
      'Асосӣ',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Einige lokalisierte Zeichenfolgen:`
  String get pageHomeListTitle {
    return Intl.message(
      'Einige lokalisierte Zeichenfolgen:',
      name: 'pageHomeListTitle',
      desc: '',
      args: [],
    );
  }

  /// `pageHomeListTitle`
  String get pagehomelisttitle {
    return Intl.message(
      'pageHomeListTitle',
      name: 'pagehomelisttitle',
      desc: '',
      args: [],
    );
  }

  /// `Quick Read`
  String get quickRead {
    return Intl.message(
      'Quick Read',
      name: 'quickRead',
      desc: '',
      args: [],
    );
  }

  /// `Интихобшуда`
  String get favourite {
    return Intl.message(
      'Интихобшуда',
      name: 'favourite',
      desc: '',
      args: [],
    );
  }

  /// `Ҷурсозӣ`
  String get more {
    return Intl.message(
      'Ҷурсозӣ',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `Тестро/гузаред`
  String get yourStory {
    return Intl.message(
      'Тестро/гузаред',
      name: 'yourStory',
      desc: '',
      args: [],
    );
  }

  /// `Маълумот ёфт нашуд`
  String get dataNotFound {
    return Intl.message(
      'Маълумот ёфт нашуд',
      name: 'dataNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Добавление названия`
  String get enterStoryTitle {
    return Intl.message(
      'Добавление названия',
      name: 'enterStoryTitle',
      desc: '',
      args: [],
    );
  }

  /// `Выбор изображения`
  String get selectImage {
    return Intl.message(
      'Выбор изображения',
      name: 'selectImage',
      desc: '',
      args: [],
    );
  }

  /// `Ҷурсозӣ`
  String get setting {
    return Intl.message(
      'Ҷурсозӣ',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `Успешно обновлено`
  String get storyUpdatedSuccessfully {
    return Intl.message(
      'Успешно обновлено',
      name: 'storyUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Успешно добавлено`
  String get storyAddedSuccessfully {
    return Intl.message(
      'Успешно добавлено',
      name: 'storyAddedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Отправить`
  String get shareVia {
    return Intl.message(
      'Отправить',
      name: 'shareVia',
      desc: '',
      args: [],
    );
  }

  /// `Добавить фото`
  String get photoLibrary {
    return Intl.message(
      'Добавить фото',
      name: 'photoLibrary',
      desc: '',
      args: [],
    );
  }

  /// `Камера`
  String get camera {
    return Intl.message(
      'Камера',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Вы хотите сохранить добавленную тему?`
  String get doYouWantToSaveEditedStory {
    return Intl.message(
      'Вы хотите сохранить добавленную тему?',
      name: 'doYouWantToSaveEditedStory',
      desc: '',
      args: [],
    );
  }

  /// `YES`
  String get yes {
    return Intl.message(
      'YES',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Exit?`
  String get exit {
    return Intl.message(
      'Exit?',
      name: 'exit',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure want to exit app?`
  String get areYouSureWantToExitApp {
    return Intl.message(
      'Are you sure want to exit app?',
      name: 'areYouSureWantToExitApp',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Did this app hurt you physically ?`
  String get didThisAppHurtYouPhysically {
    return Intl.message(
      'Did this app hurt you physically ?',
      name: 'didThisAppHurtYouPhysically',
      desc: '',
      args: [],
    );
  }

  /// `That's not really cool man`
  String get thatsNotReallyCoolMan {
    return Intl.message(
      'That\'s not really cool man',
      name: 'thatsNotReallyCoolMan',
      desc: '',
      args: [],
    );
  }

  /// `Well, it's average.`
  String get wellItsAverage {
    return Intl.message(
      'Well, it\'s average.',
      name: 'wellItsAverage',
      desc: '',
      args: [],
    );
  }

  /// `This is cool, like this app.`
  String get thisIsCoolLikeThisApp {
    return Intl.message(
      'This is cool, like this app.',
      name: 'thisIsCoolLikeThisApp',
      desc: '',
      args: [],
    );
  }

  /// `Great ! <3`
  String get great3 {
    return Intl.message(
      'Great ! <3',
      name: 'great3',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Режим День Ночь`
  String get dayNightMode {
    return Intl.message(
      'Режим День Ночь',
      name: 'dayNightMode',
      desc: '',
      args: [],
    );
  }

  /// `Поделится`
  String get share {
    return Intl.message(
      'Поделится',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `Интихоби ранг`
  String get selectAColor {
    return Intl.message(
      'Интихоби ранг',
      name: 'selectAColor',
      desc: '',
      args: [],
    );
  }

  /// `Тема`
  String get theme {
    return Intl.message(
      'Тема',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Обратная связь`
  String get feedback {
    return Intl.message(
      'Обратная связь',
      name: 'feedback',
      desc: '',
      args: [],
    );
  }

  /// `Оцените нас`
  String get rateUs {
    return Intl.message(
      'Оцените нас',
      name: 'rateUs',
      desc: '',
      args: [],
    );
  }

  /// `Интихоби ҳаҷми ҳуруф`
  String get pickAFontSize {
    return Intl.message(
      'Интихоби ҳаҷми ҳуруф',
      name: 'pickAFontSize',
      desc: '',
      args: [],
    );
  }

  /// `Выберите язык`
  String get selectLanguage {
    return Intl.message(
      'Выберите язык',
      name: 'selectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Саҳифаи алоқа`
  String get contactPage {
    return Intl.message(
      'Саҳифаи алоқа',
      name: 'contactPage',
      desc: '',
      args: [],
    );
  }

  /// `ТҶ “Ташаббуси ҳуқуқӣ” Дар ҳолати дучор шудан ба зуроварӣ падару модар метавонанд ба рақамҳои зерин занд задан`
  String get poLegalInitiativeTheseAreTheNumbersThatParentsCan {
    return Intl.message(
      'ТҶ “Ташаббуси ҳуқуқӣ” Дар ҳолати дучор шудан ба зуроварӣ падару модар метавонанд ба рақамҳои зерин занд задан',
      name: 'poLegalInitiativeTheseAreTheNumbersThatParentsCan',
      desc: '',
      args: [],
    );
  }

  /// `text 1`
  String get text1 {
    return Intl.message(
      'text 1',
      name: 'text1',
      desc: '',
      args: [],
    );
  }

  /// `text 2`
  String get text2 {
    return Intl.message(
      'text 2',
      name: 'text2',
      desc: '',
      args: [],
    );
  }

  /// `text 3 `
  String get text3 {
    return Intl.message(
      'text 3 ',
      name: 'text3',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

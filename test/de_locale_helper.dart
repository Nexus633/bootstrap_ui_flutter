import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Localizations delegates for the 'de' locale to allow testing localized widgets.
const List<LocalizationsDelegate<dynamic>> deLocalizationsDelegates = [
  _DeMaterialLocalizationsDelegate(),
  _DeCupertinoLocalizationsDelegate(),
  _DeWidgetsLocalizationsDelegate(),
];

class _DeMaterialLocalizationsDelegate extends LocalizationsDelegate<MaterialLocalizations> {
  const _DeMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'de';

  @override
  Future<MaterialLocalizations> load(Locale locale) => Future.value(const DefaultMaterialLocalizations());

  @override
  bool shouldReload(_DeMaterialLocalizationsDelegate old) => false;
}

class _DeCupertinoLocalizationsDelegate extends LocalizationsDelegate<CupertinoLocalizations> {
  const _DeCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'de';

  @override
  Future<CupertinoLocalizations> load(Locale locale) => Future.value(const DefaultCupertinoLocalizations());

  @override
  bool shouldReload(_DeCupertinoLocalizationsDelegate old) => false;
}

class _DeWidgetsLocalizationsDelegate extends LocalizationsDelegate<WidgetsLocalizations> {
  const _DeWidgetsLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'de';

  @override
  Future<WidgetsLocalizations> load(Locale locale) => Future.value(const DefaultWidgetsLocalizations());

  @override
  bool shouldReload(_DeWidgetsLocalizationsDelegate old) => false;
}

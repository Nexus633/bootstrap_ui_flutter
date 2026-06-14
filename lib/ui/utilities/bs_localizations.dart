import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Localization class for Bootstrap UI Flutter.
///
/// It loads JSON translation files from the assets dynamically
/// based on the app's current locale.
class BsLocalizations {
  /// Creates a [BsLocalizations] for the given [locale].
  BsLocalizations(this.locale);

  /// The active locale.
  final Locale locale;

  /// Retrieves the [BsLocalizations] instance from the given [BuildContext].
  ///
  /// Returns `null` if the delegate is not registered in the widget tree.
  static BsLocalizations? of(BuildContext context) {
    return Localizations.of<BsLocalizations>(context, BsLocalizations);
  }

  /// The localization delegate instance.
  static const LocalizationsDelegate<BsLocalizations> delegate =
      _BsLocalizationsDelegate();

  late Map<String, String> _localizedStrings;

  /// Loads the localized JSON assets.
  ///
  /// Falls back to English (`en.json`) if the requested language is not supported
  /// or fails to load.
  Future<bool> load() async {
    try {
      final jsonString = await rootBundle.loadString(
        'packages/bootstrap_ui_flutter/assets/l10n/${locale.languageCode}.json',
      );
      final Map<String, dynamic> jsonMap =
          json.decode(jsonString) as Map<String, dynamic>;
      _localizedStrings = jsonMap.map(
        (key, value) => MapEntry(key, value.toString()),
      );
      return true;
    } catch (_) {
      // Fallback to English on error
      try {
        final jsonString = await rootBundle.loadString(
          'packages/bootstrap_ui_flutter/assets/l10n/en.json',
        );
        final Map<String, dynamic> jsonMap =
            json.decode(jsonString) as Map<String, dynamic>;
        _localizedStrings = jsonMap.map(
          (key, value) => MapEntry(key, value.toString()),
        );
        return true;
      } catch (e) {
        _localizedStrings = {};
        return false;
      }
    }
  }

  /// Translates a key using the loaded translations, falling back to [fallback] or the [key] itself.
  String translate(String key, {String? fallback}) {
    return _localizedStrings[key] ?? fallback ?? key;
  }

  /// Resolves the validation error prefix.
  String get errorPrefix => translate('errorPrefix', fallback: 'Error');

  /// Resolves the screen reader label for the carousel's next control.
  String get carouselNext => translate('carouselNext', fallback: 'Next slide');

  /// Resolves the screen reader label for the carousel's previous control.
  String get carouselPrev =>
      translate('carouselPrev', fallback: 'Previous slide');

  /// Resolves the screen reader label for the carousel's container description.
  String get carouselContainer =>
      translate('carouselContainer', fallback: 'Image carousel');

  /// Resolves the screen reader label for the spinner status.
  String get spinner => translate('spinner', fallback: 'Loading...');

  /// Resolves the screen reader label for the progress bar.
  String get progressBar => translate('progressBar', fallback: 'Progress bar');

  /// Resolves the screen reader label for a carousel slide indicator.
  String carouselIndicator(int index) {
    final pattern = translate(
      'carouselIndicator',
      fallback: 'Go to slide {index}',
    );
    return pattern.replaceAll('{index}', (index + 1).toString());
  }
}

class _BsLocalizationsDelegate extends LocalizationsDelegate<BsLocalizations> {
  const _BsLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<BsLocalizations> load(Locale locale) async {
    final localizations = BsLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(LocalizationsDelegate<BsLocalizations> old) => false;
}

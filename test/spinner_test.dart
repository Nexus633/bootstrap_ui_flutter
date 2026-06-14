import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';
import 'de_locale_helper.dart';

void main() {
  group('BsSpinner Tests', () {
    testWidgets('BsSpinner.border creates a border spinner', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(extensions: [BsThemeData.lightTheme]),
          home: const Scaffold(
            body: BsSpinner.border(variant: BsVariant.primary),
          ),
        ),
      );

      final spinnerFinder = find.byType(BsSpinner);
      expect(spinnerFinder, findsOneWidget);

      final BsSpinner spinner = tester.widget(spinnerFinder);
      expect(spinner.type, BsSpinnerType.border);
      expect(spinner.variant, BsVariant.primary);
      expect(spinner.size, BsSpinnerSize.md);
    });

    testWidgets('BsSpinner.grow creates a grow spinner', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(extensions: [BsThemeData.lightTheme]),
          home: const Scaffold(
            body: BsSpinner.grow(variant: BsVariant.danger, size: BsSpinnerSize.sm),
          ),
        ),
      );

      final spinnerFinder = find.byType(BsSpinner);
      expect(spinnerFinder, findsOneWidget);

      final BsSpinner spinner = tester.widget(spinnerFinder);
      expect(spinner.type, BsSpinnerType.grow);
      expect(spinner.variant, BsVariant.danger);
      expect(spinner.size, BsSpinnerSize.sm);
    });

    testWidgets('BsSpinner handles custom colors', (WidgetTester tester) async {
      const customColor = Colors.teal;
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(extensions: [BsThemeData.lightTheme]),
          home: const Scaffold(
            body: BsSpinner(color: customColor),
          ),
        ),
      );

      final spinnerFinder = find.byType(BsSpinner);
      expect(spinnerFinder, findsOneWidget);

      final BsSpinner spinner = tester.widget(spinnerFinder);
      expect(spinner.color, customColor);
    });
    testWidgets('BsSpinner supports semantics and custom semanticsLabel', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(extensions: [BsThemeData.lightTheme]),
          home: const Scaffold(
            body: BsSpinner.border(semanticsLabel: 'Loading profile data'),
          ),
        ),
      );

      final Finder spinnerSemanticsFinder = find.byWidgetPredicate(
        (widget) => widget is Semantics &&
            widget.properties.label == 'Loading profile data' &&
            widget.properties.liveRegion == true,
      );
      expect(spinnerSemanticsFinder, findsOneWidget);
    });

    testWidgets('BsSpinner automatically localizes semantics label when locale is de', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(extensions: [BsThemeData.lightTheme]),
          locale: const Locale('de'),
          supportedLocales: const [Locale('de'), Locale('en')],
          localizationsDelegates: const [
            ...deLocalizationsDelegates,
            DefaultMaterialLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
            _TestBsLocalizationsDelegate(spinner: 'Ladevorgang'),
          ],
          home: const Scaffold(
            body: BsSpinner.grow(),
          ),
        ),
      );

      await tester.pump();

      final Finder spinnerSemanticsFinder = find.byWidgetPredicate(
        (widget) => widget is Semantics &&
            widget.properties.label == 'Ladevorgang' &&
            widget.properties.liveRegion == true,
      );
      expect(spinnerSemanticsFinder, findsOneWidget);
    });
  });
}

class _TestBsLocalizations extends BsLocalizations {
  _TestBsLocalizations(super.locale, {required this.customSpinner});
  final String customSpinner;

  @override
  String get spinner => customSpinner;
}

class _TestBsLocalizationsDelegate extends LocalizationsDelegate<BsLocalizations> {
  const _TestBsLocalizationsDelegate({required this.spinner});
  final String spinner;

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<BsLocalizations> load(Locale locale) async {
    return _TestBsLocalizations(locale, customSpinner: spinner);
  }

  @override
  bool shouldReload(_TestBsLocalizationsDelegate old) => false;
}

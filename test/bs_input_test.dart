import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';
import 'de_locale_helper.dart';

void main() {
  Widget buildTestableWidget(Widget widget) {
    return MaterialApp(
      theme: ThemeData(
        extensions: [BsThemeData.lightTheme],
      ),
      home: Scaffold(
        body: widget,
      ),
    );
  }

  group('BsInput', () {
    testWidgets('renders correctly with default settings', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          BsInput(placeholder: 'Enter text'),
        ),
      );

      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('Enter text'), findsOneWidget);
    });

    testWidgets('respects disabled state', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          BsInput(disabled: true),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.enabled, isFalse);
    });

    testWidgets('respects readonly state', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          BsInput(readonly: true),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.readOnly, isTrue);
    });

    testWidgets('updates value and calls onChanged', (WidgetTester tester) async {
      String? changedValue;
      await tester.pumpWidget(
        buildTestableWidget(
          BsInput(
            onChanged: (val) => changedValue = val,
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'Hello');
      expect(changedValue, equals('Hello'));
    });

    testWidgets('shows validation feedback on error', (WidgetTester tester) async {
      final formKey = GlobalKey<FormState>();
      
      await tester.pumpWidget(
        buildTestableWidget(
          Form(
            key: formKey,
            child: BsInput(
              validator: (val) => val == null || val.isEmpty ? 'Required' : null,
            ),
          ),
        ),
      );

      // Initially no error
      expect(find.text('Required'), findsNothing);

      // Trigger validation
      formKey.currentState!.validate();
      await tester.pumpAndSettle();

      // Error should be visible
      expect(find.text('Required'), findsOneWidget);
      // Feedback widget should be present
      expect(find.byType(BsFormFeedback), findsOneWidget);
    });

    testWidgets('renders floating label correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          BsInput(
            floatingLabel: 'Email address',
            placeholder: 'name@example.com',
          ),
        ),
      );

      // Label should be visible
      expect(find.text('Email address'), findsOneWidget);
      
      // Hint text should be visible since it's floating
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('supports accessibility/semantics with labels, hints, and error prefix', (WidgetTester tester) async {
      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        buildTestableWidget(
          Form(
            key: formKey,
            child: BsInput(
              floatingLabel: 'Email address',
              placeholder: 'name@example.com',
              validator: (val) => 'Required',
            ),
          ),
        ),
      );

      formKey.currentState!.validate();
      await tester.pumpAndSettle();

      final Finder inputSemanticsFinder = find.byWidgetPredicate(
        (widget) => widget is Semantics && widget.properties.label == 'Email address - Error: Required',
      );
      expect(inputSemanticsFinder, findsOneWidget);

      final Semantics inputSemantics = tester.widget(inputSemanticsFinder);
      expect(inputSemantics.properties.hint, equals('name@example.com'));
    });

    testWidgets('uses German error translation in BsInput when locale is de', (WidgetTester tester) async {
      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [BsThemeData.lightTheme],
          ),
          locale: const Locale('de'),
          supportedLocales: const [Locale('de'), Locale('en')],
          localizationsDelegates: const [
            ...deLocalizationsDelegates,
            DefaultMaterialLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
            _TestBsLocalizationsDelegate(errorPrefix: 'Fehler'),
          ],
          home: Scaffold(
            body: Form(
              key: formKey,
              child: BsInput(
                floatingLabel: 'Email address',
                validator: (val) => 'Required',
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      formKey.currentState!.validate();
      await tester.pumpAndSettle();

      final Finder inputSemanticsFinder = find.byWidgetPredicate(
        (widget) => widget is Semantics && widget.properties.label == 'Email address - Fehler: Required',
      );
      expect(inputSemanticsFinder, findsOneWidget);
    });

    testWidgets('respects BsLocalizations custom errorSemanticsPrefix in BsInput', (WidgetTester tester) async {
      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [BsThemeData.lightTheme],
          ),
          localizationsDelegates: const [
            DefaultMaterialLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
            _TestBsLocalizationsDelegate(errorPrefix: 'CustomError'),
          ],
          home: Scaffold(
            body: Form(
              key: formKey,
              child: BsInput(
                floatingLabel: 'Email address',
                validator: (val) => 'Required',
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      formKey.currentState!.validate();
      await tester.pumpAndSettle();

      final Finder inputSemanticsFinder = find.byWidgetPredicate(
        (widget) => widget is Semantics && widget.properties.label == 'Email address - CustomError: Required',
      );
      expect(inputSemanticsFinder, findsOneWidget);
    });
  });
}

class _TestBsLocalizations extends BsLocalizations {
  _TestBsLocalizations(super.locale, {required this.customErrorPrefix});
  final String customErrorPrefix;

  @override
  String get errorPrefix => customErrorPrefix;
}

class _TestBsLocalizationsDelegate extends LocalizationsDelegate<BsLocalizations> {
  const _TestBsLocalizationsDelegate({required this.errorPrefix});
  final String errorPrefix;

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<BsLocalizations> load(Locale locale) async {
    return _TestBsLocalizations(locale, customErrorPrefix: errorPrefix);
  }

  @override
  bool shouldReload(_TestBsLocalizationsDelegate old) => false;
}

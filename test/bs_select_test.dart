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

  group('BsSelect', () {
    final List<DropdownMenuItem<String>> sampleItems = [
      const DropdownMenuItem(value: '1', child: Text('Option 1')),
      const DropdownMenuItem(value: '2', child: Text('Option 2')),
      const DropdownMenuItem(value: '3', child: Text('Option 3')),
    ];

    testWidgets('renders correctly with placeholder', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          BsSelect<String>(
            items: sampleItems,
            placeholder: const Text('Open this select menu'),
          ),
        ),
      );

      expect(find.byType(DropdownButton<String>), findsOneWidget);
      expect(find.text('Open this select menu'), findsOneWidget);
    });

    testWidgets('respects disabled state', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          BsSelect<String>(
            items: sampleItems,
            disabled: true,
          ),
        ),
      );

      final dropdown = tester.widget<DropdownButton<String>>(find.byType(DropdownButton<String>));
      expect(dropdown.onChanged, isNull);
    });

    testWidgets('updates value and calls onChanged', (WidgetTester tester) async {
      String? changedValue;
      await tester.pumpWidget(
        buildTestableWidget(
          BsSelect<String>(
            items: sampleItems,
            onChanged: (val) => changedValue = val,
          ),
        ),
      );

      // Open dropdown
      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();

      // Select 'Option 2'
      await tester.tap(find.text('Option 2').last); // .last because it's rendered twice (one in menu, one in button)
      await tester.pumpAndSettle();

      expect(changedValue, equals('2'));
    });

    testWidgets('shows validation feedback on error', (WidgetTester tester) async {
      final formKey = GlobalKey<FormState>();
      
      await tester.pumpWidget(
        buildTestableWidget(
          Form(
            key: formKey,
            child: BsSelect<String>(
              items: sampleItems,
              validator: (val) => val == null ? 'Please select an option' : null,
            ),
          ),
        ),
      );

      // Initially no error
      expect(find.text('Please select an option'), findsNothing);

      // Trigger validation
      formKey.currentState!.validate();
      await tester.pumpAndSettle();

      // Error should be visible
      expect(find.text('Please select an option'), findsOneWidget);
      expect(find.byType(BsFormFeedback), findsOneWidget);
    });

    testWidgets('renders floating label correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          BsSelect<String>(
            floatingLabel: 'Choose wisely',
            placeholder: const Text('Open this select menu'),
            items: sampleItems,
          ),
        ),
      );

      // Label should be visible
      expect(find.text('Choose wisely'), findsOneWidget);
    });

    testWidgets('supports accessibility/semantics with labels, hints, and values', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          BsSelect<String>(
            floatingLabel: 'Choose wisely',
            placeholder: const Text('Open this select menu'),
            items: sampleItems,
            value: '2',
          ),
        ),
      );

      final Finder selectSemanticsFinder = find.byWidgetPredicate(
        (widget) => widget is Semantics && widget.properties.label == 'Choose wisely',
      );
      expect(selectSemanticsFinder, findsOneWidget);

      final Semantics selectSemantics = tester.widget(selectSemanticsFinder);
      expect(selectSemantics.properties.hint, equals('Open this select menu'));
      expect(selectSemantics.properties.value, equals('Option 2'));
    });

    testWidgets('appends validation error to semantics label when floatingLabel is present', (WidgetTester tester) async {
      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        buildTestableWidget(
          Form(
            key: formKey,
            child: BsSelect<String>(
              floatingLabel: 'Choose wisely',
              placeholder: const Text('Open this select menu'),
              items: sampleItems,
              validator: (val) => 'Validation Error',
            ),
          ),
        ),
      );

      formKey.currentState!.validate();
      await tester.pumpAndSettle();

      final Finder selectSemanticsFinder = find.byWidgetPredicate(
        (widget) => widget is Semantics && widget.properties.label == 'Choose wisely - Error: Validation Error',
      );
      expect(selectSemanticsFinder, findsOneWidget);

      final Semantics selectSemantics = tester.widget(selectSemanticsFinder);
      expect(selectSemantics.properties.hint, equals('Open this select menu'));
    });

    testWidgets('appends validation error to semantics hint when floatingLabel is null', (WidgetTester tester) async {
      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        buildTestableWidget(
          Form(
            key: formKey,
            child: BsSelect<String>(
              placeholder: const Text('Open this select menu'),
              items: sampleItems,
              validator: (val) => 'Validation Error',
            ),
          ),
        ),
      );

      formKey.currentState!.validate();
      await tester.pumpAndSettle();

      final Finder selectSemanticsFinder = find.byWidgetPredicate(
        (widget) => widget is Semantics && widget.properties.hint == 'Open this select menu - Error: Validation Error',
      );
      expect(selectSemanticsFinder, findsOneWidget);

      final Semantics selectSemantics = tester.widget(selectSemanticsFinder);
      expect(selectSemantics.properties.label, isNull);
    });

    testWidgets('appends validation error to semantics label when both floatingLabel and placeholder are null', (WidgetTester tester) async {
      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        buildTestableWidget(
          Form(
            key: formKey,
            child: BsSelect<String>(
              items: sampleItems,
              validator: (val) => 'Validation Error',
            ),
          ),
        ),
      );

      formKey.currentState!.validate();
      await tester.pumpAndSettle();

      final Finder selectSemanticsFinder = find.byWidgetPredicate(
        (widget) => widget is Semantics && widget.properties.label == 'Error: Validation Error',
      );
      expect(selectSemanticsFinder, findsOneWidget);

      final Semantics selectSemantics = tester.widget(selectSemanticsFinder);
      expect(selectSemantics.properties.hint, isNull);
    });

    testWidgets('uses German error translation when locale is de', (WidgetTester tester) async {
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
              child: BsSelect<String>(
                floatingLabel: 'Choose wisely',
                items: sampleItems,
                validator: (val) => 'Validation Error',
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      formKey.currentState!.validate();
      await tester.pumpAndSettle();

      final Finder selectSemanticsFinder = find.byWidgetPredicate(
        (widget) => widget is Semantics && widget.properties.label == 'Choose wisely - Fehler: Validation Error',
      );
      expect(selectSemanticsFinder, findsOneWidget);
    });

    testWidgets('respects BsLocalizations custom errorSemanticsPrefix in BsSelect', (WidgetTester tester) async {
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
              child: BsSelect<String>(
                floatingLabel: 'Choose wisely',
                items: sampleItems,
                validator: (val) => 'Validation Error',
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      formKey.currentState!.validate();
      await tester.pumpAndSettle();

      final Finder selectSemanticsFinder = find.byWidgetPredicate(
        (widget) => widget is Semantics && widget.properties.label == 'Choose wisely - CustomError: Validation Error',
      );
      expect(selectSemanticsFinder, findsOneWidget);
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

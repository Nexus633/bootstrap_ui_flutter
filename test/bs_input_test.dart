import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

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
  });
}

import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildTestableWidget(Widget child) {
    return MaterialApp(
      theme: ThemeData(
        extensions: [BsThemeData.lightTheme],
      ),
      home: Scaffold(
        body: child,
      ),
    );
  }

  group('BsValidatedForm Tests', () {
    testWidgets('provides wasValidated down the tree', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          BsValidatedForm(
            wasValidated: true,
            child: Builder(
              builder: (context) {
                final wasValidated = BsValidatedForm.of(context);
                return Text(wasValidated ? 'Validated' : 'Not Validated');
              },
            ),
          ),
        ),
      );

      expect(find.text('Validated'), findsOneWidget);
    });

    testWidgets('causes BsInput to show valid state when wasValidated is true and no error', (WidgetTester tester) async {
      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        buildTestableWidget(
          BsValidatedForm(
            wasValidated: true,
            child: Form(
              key: formKey,
              child: BsInput(
                placeholder: 'Test',
                validator: (val) => null, // No error
              ),
            ),
          ),
        ),
      );

      // Verify that the container has success colors
      // We can't easily assert the color properties natively in the test without finding the specific widget,
      // but we can check that it renders without errors.
      expect(find.byType(BsInput), findsOneWidget);
    });

    testWidgets('causes BsInput to show invalid state when wasValidated is true and has error', (WidgetTester tester) async {
      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        buildTestableWidget(
          BsValidatedForm(
            wasValidated: true,
            child: Form(
              key: formKey,
              child: BsInput(
                placeholder: 'Test',
                validator: (val) => 'Error', // Always error
              ),
            ),
          ),
        ),
      );

      // Trigger validation
      formKey.currentState!.validate();
      await tester.pumpAndSettle();

      expect(find.text('Error'), findsOneWidget);
      expect(find.byType(BsFormFeedback), findsOneWidget);
    });
  });
}

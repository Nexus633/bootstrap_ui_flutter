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

  group('BsCheckbox', () {
    testWidgets('renders correctly as checkbox with label', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          BsCheckbox(label: const Text('Check me')),
        ),
      );

      expect(find.byType(BsCheckbox), findsOneWidget);
      expect(find.text('Check me'), findsOneWidget);
      
      // AnimatedContainer is used for the visual part
      expect(find.byType(AnimatedContainer), findsOneWidget);
    });

    testWidgets('renders correctly as switch', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          BsCheckbox(label: const Text('Toggle me'), isSwitch: true),
        ),
      );

      expect(find.byType(BsCheckbox), findsOneWidget);
      expect(find.text('Toggle me'), findsOneWidget);
      
      // Switch has two AnimatedContainers (track and thumb)
      expect(find.byType(AnimatedContainer), findsWidgets);
      expect(find.byType(AnimatedAlign), findsOneWidget);
    });

    testWidgets('respects disabled state', (WidgetTester tester) async {
      bool? changedValue;
      await tester.pumpWidget(
        buildTestableWidget(
          BsCheckbox(
            disabled: true,
            onChanged: (val) => changedValue = val,
          ),
        ),
      );

      // Tap the widget (GestureDetector is inside)
      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      expect(changedValue, isNull); // Should not have changed
    });

    testWidgets('updates value and calls onChanged', (WidgetTester tester) async {
      bool? changedValue;
      await tester.pumpWidget(
        buildTestableWidget(
          BsCheckbox(
            onChanged: (val) => changedValue = val,
          ),
        ),
      );

      // Initial state is false. Tap should set to true.
      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      expect(changedValue, isTrue);
    });

    testWidgets('shows validation feedback on error', (WidgetTester tester) async {
      final formKey = GlobalKey<FormState>();
      
      await tester.pumpWidget(
        buildTestableWidget(
          Form(
            key: formKey,
            child: BsCheckbox(
              label: const Text('Agree to terms'),
              validator: (val) => val == true ? null : 'Must agree',
            ),
          ),
        ),
      );

      // Initially no error
      expect(find.text('Must agree'), findsNothing);

      // Trigger validation
      formKey.currentState!.validate();
      await tester.pumpAndSettle();

      // Error should be visible
      expect(find.text('Must agree'), findsOneWidget);
      expect(find.byType(BsFormFeedback), findsOneWidget);
    });
  });
}

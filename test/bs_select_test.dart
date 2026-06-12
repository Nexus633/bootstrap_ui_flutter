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
  });
}

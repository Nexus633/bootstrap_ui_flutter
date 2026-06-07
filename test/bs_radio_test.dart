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

  group('BsRadio', () {
    testWidgets('renders correctly with label', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          BsRadio<int>(
            value: 1,
            groupValue: 0,
            onChanged: (_) {},
            label: const Text('Radio Option 1'),
          ),
        ),
      );

      expect(find.byType(BsRadio<int>), findsOneWidget);
      expect(find.text('Radio Option 1'), findsOneWidget);
      expect(find.byType(AnimatedContainer), findsOneWidget);
    });

    testWidgets('calls onChanged when tapped and value changes', (WidgetTester tester) async {
      int? selectedValue = 0;
      await tester.pumpWidget(
        buildTestableWidget(
          BsRadio<int>(
            value: 1,
            groupValue: selectedValue,
            onChanged: (val) => selectedValue = val,
            label: const Text('Option 1'),
          ),
        ),
      );

      await tester.tap(find.text('Option 1'));
      await tester.pumpAndSettle();

      expect(selectedValue, equals(1));
    });

    testWidgets('respects disabled state', (WidgetTester tester) async {
      int? selectedValue = 0;
      await tester.pumpWidget(
        buildTestableWidget(
          BsRadio<int>(
            value: 1,
            groupValue: selectedValue,
            onChanged: (val) => selectedValue = val,
            disabled: true,
            label: const Text('Disabled Option'),
          ),
        ),
      );

      await tester.tap(find.text('Disabled Option'));
      await tester.pumpAndSettle();

      expect(selectedValue, equals(0)); // Should not change
    });

    testWidgets('renders dot inside visual box when selected', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const BsRadio<int>(
            value: 1,
            groupValue: 1,
            onChanged: null,
            label: Text('Selected Option'),
          ),
        ),
      );

      // Selected radio should render the inner Container (dot)
      expect(find.byType(Container), findsWidgets);
    });
  });
}

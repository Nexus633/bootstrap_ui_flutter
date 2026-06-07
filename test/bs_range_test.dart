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

  group('BsRange', () {
    testWidgets('renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          BsRange(initialValue: 30.0),
        ),
      );

      expect(find.byType(Slider), findsOneWidget);
      final slider = tester.widget<Slider>(find.byType(Slider));
      expect(slider.value, equals(30.0));
    });

    testWidgets('respects disabled state', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          BsRange(disabled: true),
        ),
      );

      final slider = tester.widget<Slider>(find.byType(Slider));
      expect(slider.onChanged, isNull);
    });

    testWidgets('updates value and calls onChanged', (WidgetTester tester) async {
      double? changedValue;
      await tester.pumpWidget(
        buildTestableWidget(
          BsRange(
            initialValue: 50.0,
            onChanged: (val) => changedValue = val,
          ),
        ),
      );

      // Drag the slider to the right
      await tester.drag(find.byType(Slider), const Offset(100.0, 0.0));
      await tester.pumpAndSettle();

      expect(changedValue, isNotNull);
      expect(changedValue! > 50.0, isTrue);
    });

    testWidgets('shows validation feedback on error', (WidgetTester tester) async {
      final formKey = GlobalKey<FormState>();
      
      await tester.pumpWidget(
        buildTestableWidget(
          Form(
            key: formKey,
            child: BsRange(
              initialValue: 0.0,
              validator: (val) => val == 0.0 ? 'Value must be greater than 0' : null,
            ),
          ),
        ),
      );

      // Initially no error
      expect(find.text('Value must be greater than 0'), findsNothing);

      // Trigger validation
      formKey.currentState!.validate();
      await tester.pumpAndSettle();

      // Error should be visible
      expect(find.text('Value must be greater than 0'), findsOneWidget);
      expect(find.byType(BsFormFeedback), findsOneWidget);
    });
  });
}

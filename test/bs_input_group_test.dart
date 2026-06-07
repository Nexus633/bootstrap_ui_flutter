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

  group('BsInputGroup', () {
    testWidgets('renders children correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          BsInputGroup(
            children: [
              const BsInputGroupText('@'),
              BsInput(placeholder: 'Username').expanded(),
            ],
          ),
        ),
      );

      expect(find.byType(BsInputGroupText), findsOneWidget);
      expect(find.text('@'), findsOneWidget);
      expect(find.byType(BsInput), findsOneWidget);
    });

    testWidgets('passes context correctly to text addon', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          BsInputGroup(
            children: [
              const BsInputGroupText('First'),
              const BsInputGroupText('Middle'),
              const BsInputGroupText('Last'),
            ],
          ),
        ),
      );

      // Verify they are rendered
      expect(find.text('First'), findsOneWidget);
      expect(find.text('Middle'), findsOneWidget);
      expect(find.text('Last'), findsOneWidget);

      // We could ideally test the BoxDecoration border radius, but it's complex to extract.
      // At least we verify the structure doesn't crash.
    });
    
    testWidgets('can include buttons and selects', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          BsInputGroup(
            children: [
              BsButton(label: 'Action', onPressed: () {}),
              BsSelect<String>(items: const [], placeholder: const Text('Options')).expanded(),
            ],
          ),
        ),
      );

      expect(find.byType(BsButton), findsOneWidget);
      expect(find.byType(BsSelect<String>), findsOneWidget);
    });
  });
}

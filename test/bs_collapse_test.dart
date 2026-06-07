import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

void main() {
  Widget wrap(Widget child) {
    return MaterialApp(
      theme: ThemeData(extensions: [BsThemeData.lightTheme]),
      home: Scaffold(body: child),
    );
  }

  group('BsCollapse Tests', () {
    testWidgets('renders child content and animates vertical transition', (WidgetTester tester) async {
      bool isExpanded = false;

      // We use StatefulBuilder so we can trigger updates to isExpanded in the test
      await tester.pumpWidget(
        wrap(
          StatefulBuilder(
            builder: (context, setState) {
              return Column(
                children: [
                  ElevatedButton(
                    onPressed: () => setState(() => isExpanded = !isExpanded),
                    child: const Text('Toggle'),
                  ),
                  BsCollapse(
                    isExpanded: isExpanded,
                    child: const SizedBox(
                      key: Key('collapse-child'),
                      height: 100,
                      child: Text('Collapsible Content'),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );

      // Verify the text is present in the tree
      expect(find.text('Collapsible Content'), findsOneWidget);

      // Verify that initially, the SizeTransition sizeFactor is 0.0 (collapsed)
      SizeTransition sizeTransition = tester.widget<SizeTransition>(find.byType(SizeTransition));
      expect(sizeTransition.sizeFactor.value, 0.0);
      expect(sizeTransition.axis, Axis.vertical);

      // Click to toggle/expand
      await tester.tap(find.text('Toggle'));
      await tester.pump(); // Starts animation
      
      // Let's pump for a fraction of the duration to check that animation is in progress
      await tester.pump(const Duration(milliseconds: 100));
      sizeTransition = tester.widget<SizeTransition>(find.byType(SizeTransition));
      expect(sizeTransition.sizeFactor.value, greaterThan(0.0));
      expect(sizeTransition.sizeFactor.value, lessThan(1.0));

      // Wait for animation to finish
      await tester.pumpAndSettle();
      sizeTransition = tester.widget<SizeTransition>(find.byType(SizeTransition));
      expect(sizeTransition.sizeFactor.value, 1.0);

      // Toggle again to collapse
      await tester.tap(find.text('Toggle'));
      await tester.pump(); // Starts reverse animation
      await tester.pumpAndSettle();
      
      sizeTransition = tester.widget<SizeTransition>(find.byType(SizeTransition));
      expect(sizeTransition.sizeFactor.value, 0.0);
    });

    testWidgets('supports horizontal transition mode', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          const BsCollapse(
            isExpanded: true,
            horizontal: true,
            child: SizedBox(
              width: 100,
              child: Text('Horizontal Content'),
            ),
          ),
        ),
      );

      final sizeTransition = tester.widget<SizeTransition>(find.byType(SizeTransition));
      expect(sizeTransition.axis, Axis.horizontal);
      expect(sizeTransition.sizeFactor.value, 1.0);
      expect(sizeTransition.alignment, Alignment.centerLeft);
    });
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bootstrap_flutter/bootstrap_flutter.dart';

void main() {
  Widget wrap(Widget child) {
    return MaterialApp(
      theme: ThemeData(extensions: [BsThemeData.lightTheme]),
      home: Scaffold(body: child),
    );
  }

  group('BsAccordion Tests', () {
    testWidgets('renders all items and toggles expansion', (WidgetTester tester) async {
      await tester.pumpWidget(wrap(
        const BsAccordion(
          items: [
            BsAccordionItem(title: 'Item 1', body: Text('Content 1')),
            BsAccordionItem(title: 'Item 2', body: Text('Content 2')),
          ],
        ),
      ));

      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
      
      // Content should not be visible initially
      expect(find.text('Content 1'), findsNothing);

      // Tap to expand
      await tester.tap(find.text('Item 1'));
      await tester.pumpAndSettle();

      expect(find.text('Content 1'), findsOneWidget);

      // Tap Item 2, Item 1 should close (alwaysOpen is false by default)
      await tester.tap(find.text('Item 2'));
      await tester.pumpAndSettle();

      expect(find.text('Content 1'), findsNothing);
      expect(find.text('Content 2'), findsOneWidget);
    });

    testWidgets('alwaysOpen allows multiple items expanded', (WidgetTester tester) async {
      await tester.pumpWidget(wrap(
        const BsAccordion(
          alwaysOpen: true,
          items: [
            BsAccordionItem(title: 'Item 1', body: Text('Content 1')),
            BsAccordionItem(title: 'Item 2', body: Text('Content 2')),
          ],
        ),
      ));

      await tester.tap(find.text('Item 1'));
      await tester.tap(find.text('Item 2'));
      await tester.pumpAndSettle();

      expect(find.text('Content 1'), findsOneWidget);
      expect(find.text('Content 2'), findsOneWidget);
    });

    testWidgets('flush removes border', (WidgetTester tester) async {
      await tester.pumpWidget(wrap(
        const BsAccordion(
          flush: true,
          items: [BsAccordionItem(title: 'Item 1', body: Text('Content 1'))],
        ),
      ));

      final container = tester.widget<Container>(find.byType(Container).first);
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.border, isNull);
    });
  });
}

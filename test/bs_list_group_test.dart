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

  group('BsListGroup Tests', () {
    testWidgets('renders list group and children correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          const BsListGroup(
            children: [
              BsListGroupItem(child: Text('Item 1')),
              BsListGroupItem(child: Text('Item 2')),
            ],
          ),
        ),
      );

      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
    });

    testWidgets('renders numbered list correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          const BsListGroup(
            numbered: true,
            children: [
              BsListGroupItem(child: Text('First')),
              BsListGroupItem(child: Text('Second')),
            ],
          ),
        ),
      );

      expect(find.text('1.'), findsOneWidget);
      expect(find.text('2.'), findsOneWidget);
      expect(find.text('First'), findsOneWidget);
      expect(find.text('Second'), findsOneWidget);
    });

    testWidgets('horizontal list distributes items as Expanded in Row', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          const BsListGroup(
            horizontal: true,
            children: [
              BsListGroupItem(child: Text('Left')),
              BsListGroupItem(child: Text('Right')),
            ],
          ),
        ),
      );

      expect(find.byType(Row), findsOneWidget);
      expect(find.byType(Expanded), findsNWidgets(2));
    });

    testWidgets('active state styling', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          const BsListGroup(
            children: [
              BsListGroupItem(
                active: true,
                child: Text('Active Item'),
              ),
            ],
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, BsColors.primary);
    });

    testWidgets('disabled state does not trigger onPressed', (WidgetTester tester) async {
      int count = 0;
      await tester.pumpWidget(
        wrap(
          BsListGroup(
            children: [
              BsListGroupItem(
                disabled: true,
                onPressed: () {
                  count++;
                },
                child: const Text('Disabled Item'),
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.text('Disabled Item'));
      await tester.pump();
      expect(count, 0);
    });

    testWidgets('enabled state triggers onPressed on tap', (WidgetTester tester) async {
      int count = 0;
      await tester.pumpWidget(
        wrap(
          BsListGroup(
            children: [
              BsListGroupItem(
                onPressed: () {
                  count++;
                },
                child: const Text('Clickable Item'),
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.text('Clickable Item'));
      await tester.pump();
      expect(count, 1);
    });

    testWidgets('renders variant colors', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          const BsListGroup(
            children: [
              BsListGroupItem(
                variant: BsVariant.success,
                child: Text('Success'),
              ),
            ],
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      
      // Theme successBgSubtle is BsColors.green[100] = Color(0xFFD1E7DD)
      expect(decoration.color, const Color(0xFFD1E7DD));
    });
  });
}


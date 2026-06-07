import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

void main() {
  Widget wrap(Widget child) {
    return MaterialApp(
      theme: ThemeData(
        extensions: [BsThemeData.lightTheme],
      ),
      home: Scaffold(body: child),
    );
  }

  group('BsNav and BsNavLink Tests', () {
    testWidgets('renders simple horizontal nav and links', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          BsNav(
            children: [
              BsNavLink(
                label: 'Home',
                active: true,
                onPressed: () {},
              ),
              BsNavLink(
                label: 'Profile',
                onPressed: () {},
              ),
              const BsNavLink(
                label: 'Disabled',
                disabled: true,
              ),
            ],
          ),
        ),
      );

      expect(find.byType(BsNav), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
      expect(find.text('Disabled'), findsOneWidget);

      // Verify row layout
      final row = tester.widget<Row>(find.byType(Row));
      expect(row.children.length, 3);
    });

    testWidgets('renders vertical layout', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          BsNav(
            vertical: true,
            children: [
              BsNavLink(label: 'Home', onPressed: () {}),
              BsNavLink(label: 'Profile', onPressed: () {}),
            ],
          ),
        ),
      );

      expect(find.byType(Column), findsOneWidget);
      final col = tester.widget<Column>(find.byType(Column));
      expect(col.children.length, 2);
    });

    testWidgets('handles tap events on non-disabled links', (WidgetTester tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        wrap(
          BsNav(
            children: [
              BsNavLink(
                label: 'Click me',
                onPressed: () => tapped = true,
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.text('Click me'));
      expect(tapped, isTrue);
    });

    testWidgets('does not tap on disabled links', (WidgetTester tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        wrap(
          BsNav(
            children: [
              BsNavLink(
                label: 'Disabled',
                disabled: true,
                onPressed: () => tapped = true,
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.text('Disabled'));
      expect(tapped, isFalse);
    });

    testWidgets('applies tabs variant borders and translations', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          BsNav(
            variant: BsNavVariant.tabs,
            children: [
              BsNavLink(
                label: 'Home',
                active: true,
                onPressed: () {},
              ),
              BsNavLink(
                label: 'Profile',
                onPressed: () {},
              ),
            ],
          ),
        ),
      );

      // Should have Stacks for container bottom border and active tab masking overlay
      expect(find.byType(Stack), findsAtLeastNWidgets(2));

      // Active tab has shift translation
      expect(find.byType(Transform), findsAtLeastNWidgets(1));
    });

    testWidgets('applies pills variant decorations', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          BsNav(
            variant: BsNavVariant.pills,
            children: [
              BsNavLink(
                label: 'Active Pill',
                active: true,
                onPressed: () {},
              ),
            ],
          ),
        ),
      );

      // The container wrapping the active link should have pill background color (theme.primary)
      final container = tester.widget<Container>(
        find.ancestor(
          of: find.text('Active Pill'),
          matching: find.byType(Container),
        ).first,
      );
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, BsThemeData.lightTheme.primary);
      expect(decoration.borderRadius, BorderRadius.circular(6.0));
    });

    testWidgets('applies underline variant decorations', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          BsNav(
            variant: BsNavVariant.underline,
            children: [
              BsNavLink(
                label: 'Underline',
                active: true,
                onPressed: () {},
              ),
            ],
          ),
        ),
      );

      final container = tester.widget<Container>(
        find.ancestor(
          of: find.text('Underline'),
          matching: find.byType(Container),
        ).first,
      );
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.border!.bottom.color, BsThemeData.lightTheme.primary);
      expect(decoration.border!.bottom.width, 2.0);
    });
  });

  group('BsTabContent and BsTabPane Tests', () {
    testWidgets('renders active tab content pane and switches', (WidgetTester tester) async {
      int activeIndex = 0;

      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) {
            return wrap(
              Column(
                children: [
                  BsNav(
                    variant: BsNavVariant.tabs,
                    children: [
                      BsNavLink(
                        label: 'Tab 1',
                        active: activeIndex == 0,
                        onPressed: () => setState(() => activeIndex = 0),
                      ),
                      BsNavLink(
                        label: 'Tab 2',
                        active: activeIndex == 1,
                        onPressed: () => setState(() => activeIndex = 1),
                      ),
                    ],
                  ),
                  Expanded(
                    child: BsTabContent(
                      activeIndex: activeIndex,
                      children: const [
                        BsTabPane(
                          child: Text('Content 1'),
                        ),
                        BsTabPane(
                          child: Text('Content 2'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );

      // Verify active content 1 is shown
      expect(find.text('Content 1'), findsOneWidget);
      expect(find.text('Content 2'), findsNothing);

      // Tap tab 2
      await tester.tap(find.text('Tab 2'));
      await tester.pumpAndSettle();

      // Verify active content 2 is shown
      expect(find.text('Content 1'), findsNothing);
      expect(find.text('Content 2'), findsOneWidget);
    });

    testWidgets('respects custom color and activeColor overrides', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          BsNav(
            children: [
              BsNavLink(
                label: 'Custom Link 1',
                active: true,
                color: Colors.green,
                activeColor: Colors.red,
                onPressed: () {},
              ),
              BsNavLink(
                label: 'Custom Link 2',
                active: false,
                color: Colors.green,
                activeColor: Colors.red,
                onPressed: () {},
              ),
            ],
          ),
        ),
      );

      final text1 = tester.widget<Text>(find.text('Custom Link 1'));
      expect(text1.style?.color, Colors.red);

      final text2 = tester.widget<Text>(find.text('Custom Link 2'));
      expect(text2.style?.color, Colors.green.withValues(alpha: 0.8));
    });
  });
}

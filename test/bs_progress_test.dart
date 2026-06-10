import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

void main() {
  Widget buildTestWidget(Widget child) {
    return MaterialApp(
      theme: ThemeData(
        extensions: [BsThemeData.lightTheme],
      ),
      home: Scaffold(
        body: child,
      ),
    );
  }

  group('BsProgress and BsProgressBar Tests', () {
    testWidgets('renders single progress bar correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          BsProgress.single(
            value: 60.0,
            label: '60%',
            height: 20.0,
          ),
        ),
      );

      // Verify the outer container exists with correct height
      final containerFinder = find.byType(BsProgress);
      expect(containerFinder, findsOneWidget);

      final progressWidget = tester.widget<BsProgress>(containerFinder);
      expect(progressWidget.height, 20.0);
      expect(progressWidget.bars.length, 1);

      // Verify the inner progress bar exists and displays the label
      expect(find.text('60%'), findsOneWidget);
      expect(find.byType(BsProgressBar), findsOneWidget);

      final barWidget = tester.widget<BsProgressBar>(find.byType(BsProgressBar));
      expect(barWidget.value, 60.0);
    });

    testWidgets('renders empty track spacer when sum < 100.0', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          BsProgress.single(
            value: 45.0,
          ),
        ),
      );

      // In the Row there should be two children:
      // 1. The progress bar (45%)
      // 2. The spacer (55% SizedBox)
      final rowFinder = find.descendant(of: find.byType(BsProgress), matching: find.byType(Row));
      expect(rowFinder, findsOneWidget);

      final rowWidget = tester.widget<Row>(rowFinder);
      expect(rowWidget.children.length, 2);

      final expandedWidgets = rowWidget.children.whereType<Expanded>();
      expect(expandedWidgets.length, 2);

      final expandedList = expandedWidgets.toList();
      expect(expandedList[0].flex, 45000); // 45.0 * 1000
      expect(expandedList[1].flex, 55000); // 55.0 * 1000
    });

    testWidgets('renders custom background color and border radius', (WidgetTester tester) async {
      final customRadius = BorderRadius.circular(10.0);
      await tester.pumpWidget(
        buildTestWidget(
          BsProgress.single(
            value: 50.0,
            backgroundColor: Colors.yellow,
            borderRadius: customRadius,
          ),
        ),
      );

      final containerFinder = find.descendant(
        of: find.byType(BsProgress),
        matching: find.byType(Container),
      ).first;

      final containerWidget = tester.widget<Container>(containerFinder);
      final decoration = containerWidget.decoration as BoxDecoration;

      expect(decoration.color, Colors.yellow);
      expect(decoration.borderRadius, customRadius);
    });

    testWidgets('respects variant colors and custom colors', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          BsProgress.single(
            value: 20.0,
            variant: BsVariant.success,
            barColor: Colors.purple,
            textColor: Colors.orange,
            label: 'Custom Colors',
          ),
        ),
      );

      final barWidget = tester.widget<BsProgressBar>(find.byType(BsProgressBar));
      expect(barWidget.variant, BsVariant.success);
      expect(barWidget.color, Colors.purple);
      expect(barWidget.textColor, Colors.orange);

      // Open progress bar and inspect calculated colors in build
      final containerFinder = find.descendant(
        of: find.byType(BsProgressBar),
        matching: find.byType(Container),
      );
      final containerWidget = tester.widget<Container>(containerFinder);
      expect(containerWidget.color, Colors.purple);

      // Verify text style color
      final textWidget = tester.widget<Text>(find.text('Custom Colors'));
      expect(textWidget.style?.color, Colors.orange);
    });

    testWidgets('renders striped pattern and animated stripes', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          BsProgress.single(
            value: 75.0,
            striped: true,
            animated: true,
          ),
        ),
      );

      // CustomPaint should be present for drawing stripes
      expect(
        find.descendant(of: find.byType(BsProgressBar), matching: find.byType(CustomPaint)),
        findsOneWidget,
      );

      final barState = tester.state(find.byType(BsProgressBar));
      expect(barState, isNotNull);

      // Since animated is true, there should be an AnimationController running
      // Let's pump again to verify it animates (no errors)
      await tester.pump(const Duration(milliseconds: 100));
    });

    testWidgets('renders stacked progress bars correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const BsProgress(
            bars: [
              BsProgressBar(value: 15.0, variant: BsVariant.primary),
              BsProgressBar(value: 30.0, variant: BsVariant.success),
              BsProgressBar(value: 20.0, variant: BsVariant.info),
            ],
          ),
        ),
      );

      final rowFinder = find.descendant(of: find.byType(BsProgress), matching: find.byType(Row));
      final rowWidget = tester.widget<Row>(rowFinder);

      // Three bars + one spacer at the end (sum = 65, so spacer flex is 35)
      expect(rowWidget.children.length, 4);

      final expandedList = rowWidget.children.whereType<Expanded>().toList();
      expect(expandedList[0].flex, 15000);
      expect(expandedList[1].flex, 30000);
      expect(expandedList[2].flex, 20000);
      expect(expandedList[3].flex, 35000); // spacer
    });
  });
}

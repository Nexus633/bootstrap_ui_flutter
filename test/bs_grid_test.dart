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

  group('Grid System Tests', () {
    testWidgets('BsContainer constrains width correctly', (WidgetTester tester) async {
      // Set viewport to a large size (XXL)
      tester.view.physicalSize = const Size(1600 * 3, 1000 * 3);
      tester.view.devicePixelRatio = 3.0;

      await tester.pumpWidget(wrap(
        const BsContainer(
          child: SizedBox(height: 10, width: double.infinity),
        ),
      ));

      final constrainedBox = tester.widget<ConstrainedBox>(
        find.descendant(
          of: find.byType(BsContainer),
          matching: find.byType(ConstrainedBox),
        ).first,
      );
      expect(constrainedBox.constraints.maxWidth, BsBreakpoints.containerXxl);

      // Clean up
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    testWidgets('BsRow and BsCol distribute space', (WidgetTester tester) async {
      await tester.pumpWidget(wrap(
        BsRow(
          children: [
            BsCol(
              config: const BsColConfig.all(6),
              child: const Text('Col 1'),
            ),
            BsCol(
              config: const BsColConfig.all(6),
              child: const Text('Col 2'),
            ),
          ],
        ),
      ));

      expect(find.text('Col 1'), findsOneWidget);
      expect(find.text('Col 2'), findsOneWidget);

      final expandedWidgets = tester.widgetList<Expanded>(find.byType(Expanded));
      expect(expandedWidgets.length, 2);
      expect(expandedWidgets.first.flex, 6);
      expect(expandedWidgets.last.flex, 6);
    });

    testWidgets('BsRow wraps columns when they exceed 12', (WidgetTester tester) async {
      await tester.pumpWidget(wrap(
        BsRow(
          children: const [
            BsCol(config: BsColConfig.all(8), child: Text('Col 1')),
            BsCol(config: BsColConfig.all(8), child: Text('Col 2')),
          ],
        ),
      ));

      // Check that they are in different internal Rows (or a Column of Rows)
      // Our implementation builds a Column of Rows.
      expect(find.byType(Row), findsNWidgets(2));
    });
  });
}

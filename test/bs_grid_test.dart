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

  group('Grid System Tests', () {
    testWidgets('BsContainer constrains width correctly', (
      WidgetTester tester,
    ) async {
      // Set viewport to a large size (XXL)
      tester.view.physicalSize = const Size(1600 * 3, 1000 * 3);
      tester.view.devicePixelRatio = 3.0;

      await tester.pumpWidget(
        wrap(
          const BsContainer(
            child: SizedBox(height: 10, width: double.infinity),
          ),
        ),
      );

      final constrainedBox = tester.widget<ConstrainedBox>(
        find
            .descendant(
              of: find.byType(BsContainer),
              matching: find.byType(ConstrainedBox),
            )
            .first,
      );
      expect(constrainedBox.constraints.maxWidth, BsBreakpoints.containerXxl);

      // Clean up
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    testWidgets('BsRow and BsCol distribute space with explicit spans (SizedBox)', (
      WidgetTester tester,
    ) async {
      // Force viewport width to 1000px
      tester.view.physicalSize = const Size(1000 * 3, 600 * 3);
      tester.view.devicePixelRatio = 3.0;

      await tester.pumpWidget(
        wrap(
          BsRow(
            gutterX: 16.0,
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
        ),
      );

      expect(find.text('Col 1'), findsOneWidget);
      expect(find.text('Col 2'), findsOneWidget);

      // Explicit spans are now rendered as SizedBoxes with mathematically calculated widths
      // Width = (span / 12) * (W + G) - G
      // For span 6 on W = 1000, G = 16: (6/12) * (1000+16) - 16 = 508 - 16 = 492
      final sizedBoxes = tester.widgetList<SizedBox>(
        find.descendant(
          of: find.byType(Row),
          matching: find.byType(SizedBox),
        ),
      ).toList();


      // We expect 3 SizedBoxes: Col 1 (492), Gutter (16), Col 2 (492)
      expect(sizedBoxes.length, 3);
      expect(sizedBoxes[0].width, 492.0);
      expect(sizedBoxes[1].width, 16.0);
      expect(sizedBoxes[2].width, 492.0);

      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    testWidgets('BsRow and BsCol distribute space with auto spans (Expanded)', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrap(
          BsRow(
            children: [
              BsCol(
                child: const Text('Col Auto 1'),
              ),
              BsCol(
                child: const Text('Col Auto 2'),
              ),
            ],
          ),
        ),
      );

      expect(find.text('Col Auto 1'), findsOneWidget);
      expect(find.text('Col Auto 2'), findsOneWidget);

      // Auto-columns are rendered as Expanded widgets
      final expandedWidgets = tester.widgetList<Expanded>(
        find.byType(Expanded),
      );
      expect(expandedWidgets.length, 2);
    });

    testWidgets('BsCol Offset shifts column correctly', (
      WidgetTester tester,
    ) async {
      // Force viewport width to 1000px
      tester.view.physicalSize = const Size(1000 * 3, 600 * 3);
      tester.view.devicePixelRatio = 3.0;

      await tester.pumpWidget(
        wrap(
          BsRow(
            gutterX: 16.0,
            children: [
              BsCol(
                config: const BsColConfig.all(6),
                offset: const BsOffsetConfig.all(6),
                child: const Text('Col with Offset'),
              ),
            ],
          ),
        ),
      );

      // Width of offset = (O / 12) * (W + G)
      // For offset 6 on W = 1000, G = 16: (6/12) * (1000+16) = 508.0
      // We look for a SizedBox that represents the offset spacer.
      final sizedBoxesInRow = tester.widgetList<SizedBox>(
        find.descendant(
          of: find.byType(Row),
          matching: find.byType(SizedBox),
        ),
      );

      // The first child is the offset spacer, the second is the column itself.
      expect(sizedBoxesInRow.length, 2);
      expect(sizedBoxesInRow.first.width, 508.0); // Offset spacer
      expect(sizedBoxesInRow.last.width, 492.0);  // Column width (Span 6)

      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    testWidgets('BsRow wraps columns and respects offset in layout calculation', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrap(
          BsRow(
            children: const [
              BsCol(
                config: BsColConfig.all(6),
                offset: BsOffsetConfig.all(3),
                child: Text('Col 1'),
              ),
              BsCol(
                config: BsColConfig.all(6), // 6 + 3 (offset) + 6 = 15 > 12 -> wraps
                child: Text('Col 2'),
              ),
            ],
          ),
        ),
      );

      // Check that they are in different rows
      expect(find.byType(Row), findsNWidgets(2));
    });

    testWidgets('BsRow horizontal and vertical alignments are mapped correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrap(
          BsRow(
            justify: BsRowJustify.center,
            alignItems: BsRowAlignItems.center,
            children: const [
              BsCol(child: Text('Center Col')),
            ],
          ),
        ),
      );

      final rowWidget = tester.widget<Row>(find.byType(Row));
      expect(rowWidget.mainAxisAlignment, MainAxisAlignment.center);
      expect(rowWidget.crossAxisAlignment, CrossAxisAlignment.stretch); // Always stretch to let Align work

      // Check that the child is wrapped in an Align with center alignment
      final alignWidget = tester.widget<Align>(
        find.descendant(
          of: find.byType(Row),
          matching: find.byType(Align),
        ).first,
      );
      expect(alignWidget.alignment, Alignment.center);
    });


    testWidgets('BsCol alignSelf overrides row vertical alignment', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrap(
          BsRow(
            alignItems: BsRowAlignItems.start,
            children: const [
              BsCol(
                alignSelf: BsColAlignSelf.end,
                child: Text('Align Self End'),
              ),
            ],
          ),
        ),
      );

      // If alignSelf is end, it wraps the child inside an Align(alignment: Alignment.bottomCenter)
      final alignWidget = tester.widget<Align>(
        find.descendant(
          of: find.byType(Row),
          matching: find.byType(Align),
        ).first,
      );
      expect(alignWidget.alignment, Alignment.bottomCenter);
    });
  });
}

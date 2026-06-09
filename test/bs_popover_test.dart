import 'package:flutter/gestures.dart';
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

  group('BsPopover Tests', () {
    testWidgets('renders child trigger and displays popover on click', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const Center(
            child: BsPopover(
              titleText: 'Test Title',
              contentText: 'Test Content',
              child: Text('Click Me'),
            ),
          ),
        ),
      );

      // Verify trigger is visible and popover is not yet shown
      expect(find.text('Click Me'), findsOneWidget);
      expect(find.text('Test Title'), findsNothing);
      expect(find.text('Test Content'), findsNothing);

      // Click the trigger
      await tester.tap(find.text('Click Me'));
      await tester.pumpAndSettle();

      // Verify popover is now visible
      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Test Content'), findsOneWidget);

      // Click outside (at 0,0) to close it
      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();

      // Verify popover is closed
      expect(find.text('Test Title'), findsNothing);
      expect(find.text('Test Content'), findsNothing);
    });

    testWidgets('triggers on hover', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const Center(
            child: BsPopover(
              titleText: 'Hover Title',
              contentText: 'Hover Content',
              trigger: BsPopoverTrigger.hover,
              child: Text('Hover Me'),
            ),
          ),
        ),
      );

      expect(find.text('Hover Title'), findsNothing);

      // Hover over the trigger
      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: Offset.zero);
      addTearDown(gesture.removePointer);

      final center = tester.getCenter(find.text('Hover Me'));
      await gesture.moveTo(center);
      await tester.pumpAndSettle();

      // Verify popover is shown
      expect(find.text('Hover Title'), findsOneWidget);

      // Hover away
      await gesture.moveTo(Offset.zero);
      await tester.pumpAndSettle();

      // Verify popover is closed
      expect(find.text('Hover Title'), findsNothing);
    });

    testWidgets('respects placements and can be controlled programmatically', (WidgetTester tester) async {
      final controller = BsPopoverController();

      await tester.pumpWidget(
        buildTestWidget(
          Center(
            child: BsPopover(
              titleText: 'Controlled Title',
              contentText: 'Controlled Content',
              placement: BsPopoverPlacement.bottom,
              controller: controller,
              child: const Text('Trigger'),
            ),
          ),
        ),
      );

      expect(find.text('Controlled Title'), findsNothing);

      // Open programmatically
      controller.open();
      await tester.pumpAndSettle();

      expect(find.text('Controlled Title'), findsOneWidget);
      expect(controller.isOpen, isTrue);

      // Close programmatically
      controller.close();
      await tester.pumpAndSettle();

      expect(find.text('Controlled Title'), findsNothing);
      expect(controller.isOpen, isFalse);
    });

    testWidgets('auto-flips placement when screen space is limited', (WidgetTester tester) async {
      // Place it at the very top of the screen (y=0) and specify placement top.
      // Since there is no space above, it should flip to bottom placement.
      await tester.pumpWidget(
        buildTestWidget(
          const Align(
            alignment: Alignment.topCenter,
            child: BsPopover(
              titleText: 'Flipped Title',
              contentText: 'Flipped Content',
              placement: BsPopoverPlacement.top,
              child: Text('Top Trigger'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Top Trigger'));
      await tester.pumpAndSettle();

      // It should be visible
      expect(find.text('Flipped Title'), findsOneWidget);
      
      // Let's verify it is flipped. The popover card should be below the trigger.
      final triggerY = tester.getCenter(find.text('Top Trigger')).dy;
      final popoverY = tester.getCenter(find.text('Flipped Title')).dy;
      
      expect(popoverY, greaterThan(triggerY)); // popover card is below the trigger
    });

    testWidgets('supports custom styling (colors and padding)', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const Center(
            child: BsPopover(
              titleText: 'Custom Title',
              contentText: 'Custom Content',
              backgroundColor: Colors.yellow,
              borderColor: Colors.red,
              headerBackgroundColor: Colors.blue,
              headerTextColor: Colors.green,
              bodyTextColor: Colors.orange,
              headerPadding: EdgeInsets.all(5.0),
              bodyPadding: EdgeInsets.all(15.0),
              child: Text('Styling Trigger'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Styling Trigger'));
      await tester.pumpAndSettle();

      // Find the containers and verify their colors and padding
      // The popover box container should have yellow background and red border.
      final containerFinder = find.byWidgetPredicate((widget) =>
          widget is Container &&
          widget.decoration is BoxDecoration &&
          (widget.decoration as BoxDecoration).color == Colors.yellow &&
          (widget.decoration as BoxDecoration).border is Border &&
          ((widget.decoration as BoxDecoration).border as Border).top.color == Colors.red);
      expect(containerFinder, findsOneWidget);

      // The header container should have blue background, red bottom border, and 5.0 padding.
      final headerFinder = find.byWidgetPredicate((widget) =>
          widget is Container &&
          widget.padding == const EdgeInsets.all(5.0) &&
          widget.decoration is BoxDecoration &&
          (widget.decoration as BoxDecoration).color == Colors.blue &&
          (widget.decoration as BoxDecoration).border is Border &&
          ((widget.decoration as BoxDecoration).border as Border).bottom.color == Colors.red);
      expect(headerFinder, findsOneWidget);

      // The body container should have 15.0 padding.
      final bodyFinder = find.byWidgetPredicate((widget) =>
          widget is Container &&
          widget.padding == const EdgeInsets.all(15.0));
      expect(bodyFinder, findsOneWidget);

      // Text colors using BuildContext to resolve Inherited DefaultTextStyle
      final BuildContext titleContext = tester.element(find.text('Custom Title'));
      final titleStyle = DefaultTextStyle.of(titleContext).style;
      expect(titleStyle.color, Colors.green);

      final BuildContext bodyContext = tester.element(find.text('Custom Content'));
      final bodyStyle = DefaultTextStyle.of(bodyContext).style;
      expect(bodyStyle.color, Colors.orange);
    });
  });
}

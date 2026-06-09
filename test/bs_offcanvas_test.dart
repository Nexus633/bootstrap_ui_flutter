import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

void main() {
  Widget buildTestableWidget(WidgetBuilder builder, {
    BsOffcanvasPlacement placement = BsOffcanvasPlacement.start,
    BsBackdrop backdrop = BsBackdrop.enabled,
    bool keyboard = true,
  }) {
    return MaterialApp(
      theme: ThemeData(
        extensions: [BsThemeData.lightTheme],
      ),
      home: Scaffold(
        body: Builder(
          builder: (context) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  showBsOffcanvas<void>(
                    context: context,
                    placement: placement,
                    backdrop: backdrop,
                    keyboard: keyboard,
                    builder: builder,
                  );
                },
                child: const Text('Open Offcanvas'),
              ),
            );
          },
        ),
      ),
    );
  }

  group('BsOffcanvas Tests', () {
    testWidgets('renders offcanvas header and body correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          (context) => const BsOffcanvas(
            header: BsOffcanvasHeader(child: Text('Offcanvas Title')),
            body: BsOffcanvasBody(child: Text('Offcanvas Body Text')),
          ),
        ),
      );

      // Open the offcanvas
      await tester.tap(find.text('Open Offcanvas'));
      await tester.pumpAndSettle();

      expect(find.text('Offcanvas Title'), findsOneWidget);
      expect(find.text('Offcanvas Body Text'), findsOneWidget);
      expect(find.byType(BsCloseButton), findsOneWidget);
    });

    testWidgets('closes offcanvas when tapping default close button', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          (context) => const BsOffcanvas(
            header: BsOffcanvasHeader(child: Text('Title')),
            body: BsOffcanvasBody(child: Text('Body')),
          ),
        ),
      );

      await tester.tap(find.text('Open Offcanvas'));
      await tester.pumpAndSettle();
      expect(find.text('Title'), findsOneWidget);

      // Tap close button
      await tester.tap(find.byType(BsCloseButton));
      await tester.pumpAndSettle();

      expect(find.text('Title'), findsNothing);
    });

    testWidgets('closes offcanvas when tapping backdrop if enabled', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          (context) => const BsOffcanvas(
            body: BsOffcanvasBody(child: Text('Body')),
          ),
          backdrop: BsBackdrop.enabled,
        ),
      );

      await tester.tap(find.text('Open Offcanvas'));
      await tester.pumpAndSettle();
      expect(find.text('Body'), findsOneWidget);

      // Tap outside (empty area, top right or center depending on placement)
      // Since default placement is 'start' (left edge, width 400), we tap on the right side of the screen
      await tester.tapAt(const Offset(700, 300));
      await tester.pumpAndSettle();

      expect(find.text('Body'), findsNothing);
    });

    testWidgets('does not close when tapping backdrop if static', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          (context) => const BsOffcanvas(
            body: BsOffcanvasBody(child: Text('Body')),
          ),
          backdrop: BsBackdrop.static,
        ),
      );

      await tester.tap(find.text('Open Offcanvas'));
      await tester.pumpAndSettle();
      expect(find.text('Body'), findsOneWidget);

      // Tap outside
      await tester.tapAt(const Offset(700, 300));
      await tester.pumpAndSettle();

      // Should still be open
      expect(find.text('Body'), findsOneWidget);
    });

    testWidgets('closes when Escape key is pressed', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          (context) => const BsOffcanvas(
            body: BsOffcanvasBody(child: Text('Body')),
          ),
        ),
      );

      await tester.tap(find.text('Open Offcanvas'));
      await tester.pumpAndSettle();
      expect(find.text('Body'), findsOneWidget);

      // Press Escape
      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      await tester.pumpAndSettle();

      expect(find.text('Body'), findsNothing);
    });

    testWidgets('renders with correct dimensions for start and bottom placement', (WidgetTester tester) async {
      // Test Start placement
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(extensions: [BsThemeData.lightTheme]),
          home: const Scaffold(
            body: BsOffcanvas(
              placement: BsOffcanvasPlacement.start,
              width: 250.0,
              body: BsOffcanvasBody(child: Text('Start Content')),
            ),
          ),
        ),
      );

      final startContainer = tester.widget<Container>(find.byType(Container).last);
      expect(startContainer.constraints?.maxWidth, 250.0);
      expect(find.text('Start Content'), findsOneWidget);

      // Test Bottom placement
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(extensions: [BsThemeData.lightTheme]),
          home: const Scaffold(
            body: BsOffcanvas(
              placement: BsOffcanvasPlacement.bottom,
              height: 150.0,
              body: BsOffcanvasBody(child: Text('Bottom Content')),
            ),
          ),
        ),
      );

      final bottomContainer = tester.widget<Container>(find.byType(Container).last);
      expect(bottomContainer.constraints?.maxHeight, 150.0);
      expect(find.text('Bottom Content'), findsOneWidget);
    });

    testWidgets('applies color and variant styling correctly', (WidgetTester tester) async {
      // Test custom color
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(extensions: [BsThemeData.lightTheme]),
          home: const Scaffold(
            body: BsOffcanvas(
              color: Colors.red,
              body: BsOffcanvasBody(child: Text('Custom Color')),
            ),
          ),
        ),
      );

      final redContainer = tester.widget<Container>(find.byType(Container).last);
      final redDec = redContainer.decoration as BoxDecoration;
      expect(redDec.color, Colors.red);

      // Test dark variant (background dark, text white/light)
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(extensions: [BsThemeData.lightTheme]),
          home: const Scaffold(
            body: BsOffcanvas(
              variant: BsVariant.dark,
              body: BsOffcanvasBody(child: Text('Dark Variant')),
            ),
          ),
        ),
      );

      final darkContainer = tester.widget<Container>(find.byType(Container).last);
      final darkDec = darkContainer.decoration as BoxDecoration;
      expect(darkDec.color, BsThemeData.lightTheme.dark);

      // Verify text inherits light color (onDark)
      final textWidget = tester.widget<DefaultTextStyle>(
        find.descendant(
          of: find.byType(BsOffcanvasBody),
          matching: find.byType(DefaultTextStyle),
        ).last,
      );
      expect(textWidget.style.color, BsThemeData.lightTheme.onDark);
    });
  });
}


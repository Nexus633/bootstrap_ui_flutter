import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

void main() {
  Widget buildTestableWidget(WidgetBuilder builder) {
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
                  showBsModal(
                    context: context,
                    builder: builder,
                  );
                },
                child: const Text('Open Modal'),
              ),
            );
          },
        ),
      ),
    );
  }

  group('BsModal Tests', () {
    testWidgets('renders modal header, body, and footer correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          (context) => const BsModal(
            header: BsModalHeader(child: Text('Modal Header Title')),
            body: BsModalBody(child: Text('Modal Body Text')),
            footer: BsModalFooter(
              children: [
                Text('Footer Action'),
              ],
            ),
          ),
        ),
      );

      // Open the modal
      await tester.tap(find.text('Open Modal'));
      await tester.pumpAndSettle();

      expect(find.text('Modal Header Title'), findsOneWidget);
      expect(find.text('Modal Body Text'), findsOneWidget);
      expect(find.text('Footer Action'), findsOneWidget);
      expect(find.byType(BsCloseButton), findsOneWidget);
    });

    testWidgets('closes modal when tapping default close button', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          (context) => const BsModal(
            header: BsModalHeader(child: Text('Title')),
            body: BsModalBody(child: Text('Body')),
          ),
        ),
      );

      // Open the modal
      await tester.tap(find.text('Open Modal'));
      await tester.pumpAndSettle();
      expect(find.text('Title'), findsOneWidget);

      // Tap close button
      await tester.tap(find.byType(BsCloseButton));
      await tester.pumpAndSettle();

      expect(find.text('Title'), findsNothing);
    });

    testWidgets('closes modal when tapping backdrop if enabled', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(extensions: [BsThemeData.lightTheme]),
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  showBsModal(
                    context: context,
                    backdrop: BsModalBackdrop.enabled,
                    builder: (context) => const BsModal(
                      body: BsModalBody(child: Text('Body')),
                    ),
                  );
                },
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      expect(find.text('Body'), findsOneWidget);

      // Tap outside (empty area, top left)
      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();

      expect(find.text('Body'), findsNothing);
    });

    testWidgets('does not close when tapping backdrop if static', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(extensions: [BsThemeData.lightTheme]),
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  showBsModal(
                    context: context,
                    backdrop: BsModalBackdrop.static,
                    builder: (context) => const BsModal(
                      body: BsModalBody(child: Text('Body')),
                    ),
                  );
                },
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      expect(find.text('Body'), findsOneWidget);

      // Tap outside
      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();

      // Should still be open!
      expect(find.text('Body'), findsOneWidget);
    });

    testWidgets('closes when Escape key is pressed', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          (context) => const BsModal(
            body: BsModalBody(child: Text('Body')),
          ),
        ),
      );

      await tester.tap(find.text('Open Modal'));
      await tester.pumpAndSettle();
      expect(find.text('Body'), findsOneWidget);

      // Press Escape
      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      await tester.pumpAndSettle();

      expect(find.text('Body'), findsNothing);
    });
  });
}

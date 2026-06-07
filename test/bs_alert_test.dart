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

  group('BsAlert Tests', () {
    testWidgets('renders child content', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(const BsAlert(child: Text('Alert Message'))),
      );
      expect(find.text('Alert Message'), findsOneWidget);
    });

    testWidgets('dismissible alert shows close icon and can be closed', (
      WidgetTester tester,
    ) async {
      bool closed = false;
      await tester.pumpWidget(
        wrap(
          BsAlert(
            dismissible: true,
            onClose: () => closed = true,
            child: const Text('Dismissible'),
          ),
        ),
      );

      final closeIcon = find.byIcon(Icons.close_rounded);
      expect(closeIcon, findsOneWidget);

      await tester.pumpAndSettle(); // Finish "In" animation
      await tester.tap(closeIcon);
      await tester.pumpAndSettle(); // Finish "Out" animation

      expect(closed, isTrue);
    });

    testWidgets('autoCloseDuration triggers onClose', (
      WidgetTester tester,
    ) async {
      bool closed = false;
      await tester.pumpWidget(
        wrap(
          BsAlert(
            autoCloseDuration: const Duration(milliseconds: 100),
            onClose: () => closed = true,
            child: const Text('Auto Close'),
          ),
        ),
      );

      // Initially not closed
      expect(closed, isFalse);

      // Wait for auto close duration + animation
      await tester.pump(const Duration(milliseconds: 150));
      await tester.pumpAndSettle();

      expect(closed, isTrue);
    });

    testWidgets('renders icon if provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(const BsAlert(icon: Icons.info, child: Text('With Icon'))),
      );
      expect(find.byIcon(Icons.info), findsOneWidget);
    });
  });
}

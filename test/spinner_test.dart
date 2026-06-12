import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

void main() {
  group('BsSpinner Tests', () {
    testWidgets('BsSpinner.border creates a border spinner', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(extensions: [BsThemeData.lightTheme]),
          home: const Scaffold(
            body: BsSpinner.border(variant: BsVariant.primary),
          ),
        ),
      );

      final spinnerFinder = find.byType(BsSpinner);
      expect(spinnerFinder, findsOneWidget);

      final BsSpinner spinner = tester.widget(spinnerFinder);
      expect(spinner.type, BsSpinnerType.border);
      expect(spinner.variant, BsVariant.primary);
      expect(spinner.size, BsSpinnerSize.md);
    });

    testWidgets('BsSpinner.grow creates a grow spinner', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(extensions: [BsThemeData.lightTheme]),
          home: const Scaffold(
            body: BsSpinner.grow(variant: BsVariant.danger, size: BsSpinnerSize.sm),
          ),
        ),
      );

      final spinnerFinder = find.byType(BsSpinner);
      expect(spinnerFinder, findsOneWidget);

      final BsSpinner spinner = tester.widget(spinnerFinder);
      expect(spinner.type, BsSpinnerType.grow);
      expect(spinner.variant, BsVariant.danger);
      expect(spinner.size, BsSpinnerSize.sm);
    });

    testWidgets('BsSpinner handles custom colors', (WidgetTester tester) async {
      const customColor = Colors.teal;
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(extensions: [BsThemeData.lightTheme]),
          home: const Scaffold(
            body: BsSpinner(color: customColor),
          ),
        ),
      );

      final spinnerFinder = find.byType(BsSpinner);
      expect(spinnerFinder, findsOneWidget);

      final BsSpinner spinner = tester.widget(spinnerFinder);
      expect(spinner.color, customColor);
    });
  });
}

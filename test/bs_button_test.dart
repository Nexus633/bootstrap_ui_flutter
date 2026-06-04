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

  group('AppButton Tests', () {
    testWidgets('renders label and handles tap', (WidgetTester tester) async {
      bool pressed = false;
      await tester.pumpWidget(
        wrap(AppButton(label: 'Click Me', onPressed: () => pressed = true)),
      );

      expect(find.text('Click Me'), findsOneWidget);
      await tester.tap(find.text('Click Me'));
      expect(pressed, isTrue);
    });

    testWidgets('shows loading indicator when isLoading is true', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrap(const AppButton(label: 'Loading', isLoading: true)),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('disabled when onPressed is null', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(const AppButton(label: 'Disabled', onPressed: null)),
      );

      // Try to tap - nothing should happen (we can check the internal state or just existence)
      // The cursor would be forbidden, but that's hard to test here.
      // We check that the background color is the disabled color.
      final container = tester.widget<AnimatedContainer>(
        find.byType(AnimatedContainer),
      );
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, BsThemeData.lightTheme.bodyBgSecondary);
    });

    testWidgets('renders icon correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(const AppButton(label: 'Icon Button', icon: Icons.add)),
      );

      expect(find.byIcon(Icons.add), findsOneWidget);
    });
  });
}

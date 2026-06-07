import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

void main() {
  Widget wrap(Widget child, {ThemeMode themeMode = ThemeMode.light}) {
    return MaterialApp(
      themeMode: themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        extensions: [BsThemeData.lightTheme],
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        extensions: [BsThemeData.darkTheme],
      ),
      home: Scaffold(body: child),
    );
  }

  group('BsCloseButton Tests', () {
    testWidgets('renders close icon and handles tap', (WidgetTester tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        wrap(
          BsCloseButton(
            onPressed: () => pressed = true,
          ),
        ),
      );

      final buttonFinder = find.byIcon(Icons.close_rounded);
      expect(buttonFinder, findsOneWidget);

      await tester.tap(buttonFinder);
      await tester.pump();

      expect(pressed, isTrue);
    });

    testWidgets('respects disabled state', (WidgetTester tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        wrap(
          BsCloseButton(
            disabled: true,
            onPressed: () => pressed = true,
          ),
        ),
      );

      final buttonFinder = find.byIcon(Icons.close_rounded);
      expect(buttonFinder, findsOneWidget);

      // Verify that the widget is wrapped in an Opacity widget with 0.25 opacity
      final opacityWidget = tester.widget<Opacity>(
        find.ancestor(of: buttonFinder, matching: find.byType(Opacity)).first,
      );
      expect(opacityWidget.opacity, 0.25);

      // Tap should not trigger callback
      await tester.tap(buttonFinder);
      await tester.pump();

      expect(pressed, isFalse);
    });

    testWidgets('applies white color override', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          const BsCloseButton(
            white: true,
          ),
        ),
      );

      final icon = tester.widget<Icon>(find.byIcon(Icons.close_rounded));
      expect(icon.color, const Color(0xFFFFFFFF));
    });

    testWidgets('applies custom color override', (WidgetTester tester) async {
      const customColor = Colors.red;

      await tester.pumpWidget(
        wrap(
          const BsCloseButton(
            color: customColor,
          ),
        ),
      );

      final icon = tester.widget<Icon>(find.byIcon(Icons.close_rounded));
      expect(icon.color, customColor);
    });

    testWidgets('adapts icon color to light and dark themes', (WidgetTester tester) async {
      // Light Theme
      await tester.pumpWidget(
        wrap(
          const BsCloseButton(),
          themeMode: ThemeMode.light,
        ),
      );

      final iconLight = tester.widget<Icon>(find.byIcon(Icons.close_rounded));
      expect(iconLight.color, const Color(0xFF000000));

      // Dark Theme
      await tester.pumpWidget(
        wrap(
          const BsCloseButton(),
          themeMode: ThemeMode.dark,
        ),
      );
      await tester.pumpAndSettle(); // Allow theme transition animation to settle

      final iconDark = tester.widget<Icon>(find.byIcon(Icons.close_rounded));
      expect(iconDark.color, const Color(0xFFFFFFFF));
    });
  });
}

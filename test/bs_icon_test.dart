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

  group('BsIcon Tests', () {
    testWidgets('renders basic icon correctly', (WidgetTester tester) async {
      await tester.pumpWidget(wrap(const BsIcon(BsIcons.alarm)));
      expect(find.byType(BsIcon), findsOneWidget);
      expect(find.byIcon(BsIcons.alarm), findsOneWidget);
    });

    testWidgets('respects custom size and color', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(const BsIcon(BsIcons.alarm, size: 32.0, color: Colors.red)),
      );
      final iconWidget = tester.widget<Icon>(find.byType(Icon));
      expect(iconWidget.size, 32.0);
      expect(iconWidget.color, Colors.red);
    });

    testWidgets('resolves theme variant colors correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(const BsIcon(BsIcons.alarm, variant: BsIconVariant.primary)),
      );
      final iconWidget = tester.widget<Icon>(find.byType(Icon));
      expect(iconWidget.color, BsColors.primary);

      await tester.pumpWidget(
        wrap(const BsIcon(BsIcons.alarm, variant: BsIconVariant.danger)),
      );
      final iconWidgetDanger = tester.widget<Icon>(find.byType(Icon));
      expect(iconWidgetDanger.color, BsColors.danger);
    });

    testWidgets('custom color takes precedence over variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(const BsIcon(BsIcons.alarm, color: Colors.blue, variant: BsIconVariant.primary)),
      );
      final iconWidget = tester.widget<Icon>(find.byType(Icon));
      expect(iconWidget.color, Colors.blue);
    });
  });
}

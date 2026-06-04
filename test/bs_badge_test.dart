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

  group('BsBadge Tests', () {
    testWidgets('renders label correctly', (WidgetTester tester) async {
      await tester.pumpWidget(wrap(const BsBadge(label: 'Test Badge')));
      expect(find.text('Test Badge'), findsOneWidget);
    });

    testWidgets('renders different variants', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(const BsBadge(label: 'Primary', variant: BsBadgeVariant.primary)),
      );
      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, BsColors.primary);

      await tester.pumpWidget(
        wrap(const BsBadge(label: 'Danger', variant: BsBadgeVariant.danger)),
      );
      final container2 = tester.widget<Container>(find.byType(Container));
      final decoration2 = container2.decoration as BoxDecoration;
      expect(decoration2.color, BsColors.danger);
    });

    testWidgets('renders pill style', (WidgetTester tester) async {
      await tester.pumpWidget(wrap(const BsBadge(label: 'Pill', isPill: true)));
      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.borderRadius, BorderRadius.circular(50.0));
    });
  });
}

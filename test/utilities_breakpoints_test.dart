import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

void main() {
  group('Utilities Breakpoints Tests', () {
    Widget buildTestWidget(Widget child, double screenWidth) {
      return MaterialApp(
        home: MediaQuery(
          data: MediaQueryData(size: Size(screenWidth, 800)),
          child: Scaffold(
            body: child,
          ),
        ),
      );
    }

    testWidgets('Spacing extension applies padding only when breakpoint is met', (WidgetTester tester) async {
      // Screen width 600 (larger than sm: 576, smaller than md: 768)
      await tester.pumpWidget(buildTestWidget(
        const Text('test').p3(BsBreakpoints.md),
        600.0,
      ));

      // Should NOT have padding
      expect(find.byType(Padding), findsNothing);

      // Now with screen width 800 (>= md)
      await tester.pumpWidget(buildTestWidget(
        const Text('test').p3(BsBreakpoints.md),
        800.0,
      ));

      // Should HAVE padding
      expect(find.byType(Padding), findsOneWidget);
    });

    testWidgets('Display extension dNone applies visibility only when breakpoint is met', (WidgetTester tester) async {
      // Screen width 600 (< md)
      await tester.pumpWidget(buildTestWidget(
        const Text('test').dNone(BsBreakpoints.md),
        600.0,
      ));

      // Should be visible (no Visibility wrapper applied)
      expect(find.byType(Visibility), findsNothing);

      // Now with screen width 800 (>= md)
      await tester.pumpWidget(buildTestWidget(
        const Text('test').dNone(BsBreakpoints.md),
        800.0,
      ));

      // Should be hidden
      final visibilityOn = tester.widget<Visibility>(find.byType(Visibility));
      expect(visibilityOn.visible, false);
    });

    testWidgets('Display extension dBlock acts as d-none d-{bp}-block', (WidgetTester tester) async {
      // Screen width 600 (< md)
      await tester.pumpWidget(buildTestWidget(
        const Text('test').dBlock(BsBreakpoints.md),
        600.0,
      ));

      // Should be hidden on smaller screens!
      final visibilityHidden = tester.widget<Visibility>(find.byType(Visibility));
      expect(visibilityHidden.visible, false);

      // Now with screen width 800 (>= md)
      await tester.pumpWidget(buildTestWidget(
        const Text('test').dBlock(BsBreakpoints.md),
        800.0,
      ));

      // Should be visible on larger screens!
      final visibilityVisible = tester.widget<Visibility>(find.byType(Visibility));
      expect(visibilityVisible.visible, true);
    });

    testWidgets('Alignment extension applies alignment only when breakpoint is met', (WidgetTester tester) async {
      // Screen width 600 (< md)
      await tester.pumpWidget(buildTestWidget(
        const Text('test').center(BsBreakpoints.md),
        600.0,
      ));

      // Should NOT be centered
      expect(find.byType(Center), findsNothing);

      // Now with screen width 800 (>= md)
      await tester.pumpWidget(buildTestWidget(
        const Text('test').center(BsBreakpoints.md),
        800.0,
      ));

      // Should BE centered
      expect(find.byType(Center), findsOneWidget);
    });
  });
}

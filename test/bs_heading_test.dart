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

  group('BsHeading Tests', () {
    testWidgets('renders text correctly', (WidgetTester tester) async {
      await tester.pumpWidget(wrap(const BsHeading('Hello World')));
      expect(find.text('Hello World'), findsOneWidget);
    });

    testWidgets('renders all heading levels with correct font sizes', (WidgetTester tester) async {
      final levels = {
        BsHeadingLevel.h1: BsTypography.h1,
        BsHeadingLevel.h2: BsTypography.h2,
        BsHeadingLevel.h3: BsTypography.h3,
        BsHeadingLevel.h4: BsTypography.h4,
        BsHeadingLevel.h5: BsTypography.h5,
        BsHeadingLevel.h6: BsTypography.h6,
      };

      for (final entry in levels.entries) {
        await tester.pumpWidget(wrap(BsHeading('Level', level: entry.key)));
        final textWidget = tester.widget<Text>(find.text('Level'));
        expect(textWidget.style?.fontSize, entry.value);
        expect(textWidget.style?.fontWeight, BsTypography.weightHeadings);
        expect(textWidget.style?.height, BsTypography.lineHeightHeadings);
      }
    });

    testWidgets('applies color override or defaults to theme bodyText', (WidgetTester tester) async {
      // Default color from theme
      await tester.pumpWidget(wrap(const BsHeading('Default Color')));
      final textWidget = tester.widget<Text>(find.text('Default Color'));
      expect(textWidget.style?.color, BsThemeData.lightTheme.bodyText);

      // Custom color
      await tester.pumpWidget(wrap(const BsHeading('Custom Color', color: Colors.red)));
      final textWidgetCustom = tester.widget<Text>(find.text('Custom Color'));
      expect(textWidgetCustom.style?.color, Colors.red);
    });

    testWidgets('applies textAlign property', (WidgetTester tester) async {
      await tester.pumpWidget(wrap(const BsHeading('Centered Text', textAlign: TextAlign.center)));
      final textWidget = tester.widget<Text>(find.text('Centered Text'));
      expect(textWidget.textAlign, TextAlign.center);
    });

    testWidgets('applies bottom margin by default, and removes it when removeMargin is true', (WidgetTester tester) async {
      // With margin (default) -> wrapped in Padding (from pb2)
      await tester.pumpWidget(wrap(const BsHeading('With Margin')));
      final paddingFinder = find.ancestor(
        of: find.text('With Margin'),
        matching: find.byType(Padding),
      );
      final paddingWidget = tester.widget<Padding>(paddingFinder.first);
      expect(paddingWidget.padding, const EdgeInsets.only(bottom: 8.0));

      // Without margin -> no padding wrapping it (except maybe scaffold content padding if any, but the immediate ancestor is not Padding with bottom 8.0)
      await tester.pumpWidget(wrap(const BsHeading('Without Margin', removeMargin: true)));
      final parentFinder = find.ancestor(
        of: find.text('Without Margin'),
        matching: find.byType(Padding),
      );
      
      for (final element in parentFinder.evaluate()) {
        final pWidget = element.widget as Padding;
        final padding = pWidget.padding;
        if (padding is EdgeInsets) {
          expect(padding.bottom, isNot(8.0));
        }
      }
    });
  });
}

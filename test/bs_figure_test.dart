import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

void main() {
  Widget buildTestableWidget(Widget widget) {
    return MaterialApp(
      theme: ThemeData(
        extensions: [BsThemeData.lightTheme],
      ),
      home: Scaffold(
        body: widget,
      ),
    );
  }

  group('BsFigure', () {
    testWidgets('renders image and caption', (WidgetTester tester) async {
      const captionText = 'A simple caption';
      await tester.pumpWidget(
        buildTestableWidget(
          const BsFigure(
            image: SizedBox(width: 100, height: 100, key: Key('test-image')),
            caption: Text(captionText),
          ),
        ),
      );

      expect(find.byKey(const Key('test-image')), findsOneWidget);
      expect(find.text(captionText), findsOneWidget);
    });

    testWidgets('applies default styling to caption', (WidgetTester tester) async {
      const captionText = 'Styled caption';
      await tester.pumpWidget(
        buildTestableWidget(
          const BsFigure(
            image: Placeholder(),
            caption: Text(captionText),
          ),
        ),
      );

      final textFinder = find.text(captionText);
      final DefaultTextStyle defaultStyle = DefaultTextStyle.of(tester.element(textFinder));

      expect(defaultStyle.style.fontSize, equals(BsTypography.fontSizeSm));
      expect(defaultStyle.style.color, equals(BsThemeData.lightTheme.bodyTextSecondary));
      expect(defaultStyle.style.height, equals(BsTypography.lineHeightBase));
    });

    testWidgets('applies alignment to caption', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const BsFigure(
            image: Placeholder(),
            caption: Text('Aligned caption'),
            captionAlignment: Alignment.centerRight,
          ),
        ),
      );

      // Find the Align widget that wraps the caption
      final alignFinder = find.ancestor(
        of: find.text('Aligned caption'),
        matching: find.byType(Align),
      );
      
      expect(alignFinder, findsOneWidget);

      final align = tester.widget<Align>(alignFinder);
      expect(align.alignment, equals(Alignment.centerRight));
    });

    testWidgets('applies custom margins', (WidgetTester tester) async {
      const customMargin = EdgeInsets.all(21.0);
      const customImageMargin = EdgeInsets.all(11.0);
      
      await tester.pumpWidget(
        buildTestableWidget(
          const BsFigure(
            image: Placeholder(key: Key('image')),
            caption: Text('Caption'),
            margin: customMargin,
            imageMargin: customImageMargin,
          ),
        ),
      );

      // Outer margin (Padding widget wrapping the Column)
      final outerPaddingFinder = find.ancestor(
        of: find.byType(Column),
        matching: find.byType(Padding),
      ).first;
      final outerPadding = tester.widget<Padding>(outerPaddingFinder);
      expect(outerPadding.padding, equals(customMargin));

      // Image margin (Padding widget wrapping the Image)
      final imagePaddingFinder = find.ancestor(
        of: find.byKey(const Key('image')),
        matching: find.byType(Padding),
      ).first;
      final imagePadding = tester.widget<Padding>(imagePaddingFinder);
      expect(imagePadding.padding, equals(customImageMargin));
    });

    testWidgets('renders without caption', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const BsFigure(
            image: Placeholder(),
          ),
        ),
      );

      expect(find.byType(Placeholder), findsOneWidget);
      expect(find.byType(Text), findsNothing);
    });
  });
}

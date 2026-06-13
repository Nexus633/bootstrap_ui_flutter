import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

void main() {
  Widget buildTestWidget(Widget child) {
    return MaterialApp(
      theme: ThemeData(
        extensions: [BsThemeData.lightTheme],
      ),
      home: Scaffold(
        body: child,
      ),
    );
  }

  group('BsTextExtension', () {
    testWidgets('truncate() applies ellipsis and maxLines', (WidgetTester tester) async {
      final text = const Text('Very long text').truncate();
      expect(text.overflow, TextOverflow.ellipsis);
      expect(text.maxLines, 1);
      expect(text.softWrap, false);
    });

    testWidgets('fs1 to fs6 apply correct font sizes', (WidgetTester tester) async {
      expect(const Text('test').fs1().style?.fontSize, BsTypography.h1);
      expect(const Text('test').fs2().style?.fontSize, BsTypography.h2);
      expect(const Text('test').fs3().style?.fontSize, BsTypography.h3);
      expect(const Text('test').fs4().style?.fontSize, BsTypography.h4);
      expect(const Text('test').fs5().style?.fontSize, BsTypography.h5);
      expect(const Text('test').fs6().style?.fontSize, BsTypography.h6);
    });

    testWidgets('display1 to display6 apply correct font sizes, weights, and line heights', (WidgetTester tester) async {
      final t1 = const Text('test').display1();
      expect(t1.style?.fontSize, BsTypography.display1);
      expect(t1.style?.fontWeight, BsTypography.weightDisplay);
      expect(t1.style?.height, BsTypography.lineHeightDisplay);

      final t2 = const Text('test').display2();
      expect(t2.style?.fontSize, BsTypography.display2);
      expect(t2.style?.fontWeight, BsTypography.weightDisplay);
      expect(t2.style?.height, BsTypography.lineHeightDisplay);

      final t3 = const Text('test').display3();
      expect(t3.style?.fontSize, BsTypography.display3);
      expect(t3.style?.fontWeight, BsTypography.weightDisplay);
      expect(t3.style?.height, BsTypography.lineHeightDisplay);

      final t4 = const Text('test').display4();
      expect(t4.style?.fontSize, BsTypography.display4);
      expect(t4.style?.fontWeight, BsTypography.weightDisplay);
      expect(t4.style?.height, BsTypography.lineHeightDisplay);

      final t5 = const Text('test').display5();
      expect(t5.style?.fontSize, BsTypography.display5);
      expect(t5.style?.fontWeight, BsTypography.weightDisplay);
      expect(t5.style?.height, BsTypography.lineHeightDisplay);

      final t6 = const Text('test').display6();
      expect(t6.style?.fontSize, BsTypography.display6);
      expect(t6.style?.fontWeight, BsTypography.weightDisplay);
      expect(t6.style?.height, BsTypography.lineHeightDisplay);
    });

    testWidgets('fw weights apply correct FontWeights', (WidgetTester tester) async {
      expect(const Text('test').fwBold().style?.fontWeight, BsTypography.weightBold);
      expect(const Text('test').fwBolder().style?.fontWeight, FontWeight.w800);
      expect(const Text('test').fwSemibold().style?.fontWeight, FontWeight.w600);
      expect(const Text('test').fwMedium().style?.fontWeight, BsTypography.weightMedium);
      expect(const Text('test').fwNormal().style?.fontWeight, BsTypography.weightNormal);
      expect(const Text('test').fwLight().style?.fontWeight, BsTypography.weightLight);
      expect(const Text('test').fwLighter().style?.fontWeight, FontWeight.w200);
    });

    testWidgets('fst styles apply correct FontStyles', (WidgetTester tester) async {
      expect(const Text('test').fstItalic().style?.fontStyle, FontStyle.italic);
      expect(const Text('test').fstNormal().style?.fontStyle, FontStyle.normal);
    });

    testWidgets('lh heights apply correct line heights', (WidgetTester tester) async {
      expect(const Text('test').lh1().style?.height, 1.0);
      expect(const Text('test').lhSm().style?.height, BsTypography.lineHeightSm);
      expect(const Text('test').lhBase().style?.height, BsTypography.lineHeightBase);
      expect(const Text('test').lhLg().style?.height, BsTypography.lineHeightLg);
    });

    testWidgets('text alignment applies correct TextAlign', (WidgetTester tester) async {
      expect(const Text('test').textStart().textAlign, TextAlign.start);
      expect(const Text('test').textCenter().textAlign, TextAlign.center);
      expect(const Text('test').textEnd().textAlign, TextAlign.end);
    });

    testWidgets('text decoration applies correct TextDecoration', (WidgetTester tester) async {
      expect(const Text('test').textDecorationUnderline().style?.decoration, TextDecoration.underline);
      expect(const Text('test').textDecorationLineThrough().style?.decoration, TextDecoration.lineThrough);
      expect(const Text('test').textDecorationNone().style?.decoration, TextDecoration.none);
    });
  });

  group('BsVStack', () {
    testWidgets('renders children with gaps', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          BsVStack(
            gap: 10,
            children: [
              Text('A'),
              Text('B'),
            ],
          ),
        ),
      );

      expect(find.text('A'), findsOneWidget);
      expect(find.text('B'), findsOneWidget);
      expect(find.byType(SizedBox), findsOneWidget); // One gap for two items
    });
  });

  group('BsHStack', () {
    testWidgets('renders children with gaps', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          BsHStack(
            gap: 10,
            children: [
              Text('A'),
              Text('B'),
            ],
          ),
        ),
      );

      expect(find.text('A'), findsOneWidget);
      expect(find.text('B'), findsOneWidget);
      expect(find.byType(SizedBox), findsOneWidget);
    });
  });

  group('BsVerticalRule', () {
    testWidgets('renders with default border color', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          SizedBox(
            height: 100,
            child: BsVerticalRule(),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container).last);
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, BsThemeData.lightTheme.border);
    });
  });

  group('BsRatio', () {
    testWidgets('applies AspectRatio', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          BsRatio(
            type: BsRatioType.ratio16x9,
            child: Container(),
          ),
        ),
      );

      final aspect = tester.widget<AspectRatio>(find.byType(AspectRatio));
      expect(aspect.aspectRatio, 16 / 9);
    });
  });

  group('BsLink', () {
    testWidgets('calls onPressed', (WidgetTester tester) async {
      bool pressed = false;
      await tester.pumpWidget(
        buildTestWidget(
          BsLink(
            label: Text('Link'),
            onPressed: () => pressed = true,
          ),
        ),
      );

      await tester.tap(find.text('Link'));
      expect(pressed, isTrue);
    });

    testWidgets('has link semantics and focusable ActionDetector', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          BsLink(
            label: Text('Link'),
            onPressed: () {},
          ),
        ),
      );

      final SemanticsHandle semantics = tester.ensureSemantics();
      expect(
        tester.getSemantics(find.text('Link')),
        matchesSemantics(
          label: 'Link',
          isLink: true,
          hasTapAction: true,
        ),
      );
      semantics.dispose();

      expect(find.byType(FocusableActionDetector), findsOneWidget);
    });
  });

  group('BsIconLink', () {
    testWidgets('renders icon and label', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          BsIconLink(
            label: Text('Link'),
            icon: Icon(Icons.arrow_forward),
            onPressed: () {},
          ),
        ),
      );

      expect(find.text('Link'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
    });
  });

  group('BsVerticalAlignExtension', () {
    testWidgets('alignBaseline() returns WidgetSpan with baseline alignment', (WidgetTester tester) async {
      final widget = const SizedBox();
      final span = widget.alignBaseline();
      expect(span.alignment, PlaceholderAlignment.baseline);
      expect(span.baseline, TextBaseline.alphabetic);
    });

    testWidgets('alignTopInline() returns WidgetSpan with top alignment', (WidgetTester tester) async {
      final widget = const SizedBox();
      final span = widget.alignTopInline();
      expect(span.alignment, PlaceholderAlignment.top);
    });

    testWidgets('alignMiddle() returns WidgetSpan with middle alignment', (WidgetTester tester) async {
      final widget = const SizedBox();
      final span = widget.alignMiddle();
      expect(span.alignment, PlaceholderAlignment.middle);
    });

    testWidgets('alignBottomInline() returns WidgetSpan with bottom alignment', (WidgetTester tester) async {
      final widget = const SizedBox();
      final span = widget.alignBottomInline();
      expect(span.alignment, PlaceholderAlignment.bottom);
    });

    testWidgets('alignTextTop() returns WidgetSpan with aboveBaseline alignment', (WidgetTester tester) async {
      final widget = const SizedBox();
      final span = widget.alignTextTop();
      expect(span.alignment, PlaceholderAlignment.aboveBaseline);
      expect(span.baseline, TextBaseline.alphabetic);
    });

    testWidgets('alignTextBottom() returns WidgetSpan with belowBaseline alignment', (WidgetTester tester) async {
      final widget = const SizedBox();
      final span = widget.alignTextBottom();
      expect(span.alignment, PlaceholderAlignment.belowBaseline);
      expect(span.baseline, TextBaseline.alphabetic);
    });
  });
}

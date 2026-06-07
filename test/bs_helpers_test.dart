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
      final text = Text('Very long text').truncate();
      expect(text.overflow, TextOverflow.ellipsis);
      expect(text.maxLines, 1);
      expect(text.softWrap, false);
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
}

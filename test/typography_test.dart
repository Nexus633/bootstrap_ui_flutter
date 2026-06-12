import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

void main() {
  group('Typography Components Tests', () {
    Widget buildTestApp(Widget child) {
      return MaterialApp(
        theme: ThemeData(extensions: [BsThemeData.lightTheme]),
        home: Scaffold(body: child),
      );
    }

    testWidgets('BsCode renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestApp(const BsCode('import bs;')));

      final textFinder = find.text('import bs;');
      expect(textFinder, findsOneWidget);

      final textWidget = tester.widget<Text>(textFinder);
      expect(textWidget.style?.fontFamily, 'monospace');
      expect(textWidget.style?.color, BsColors.pink[500]);
    });

    testWidgets('BsKbd renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestApp(const BsKbd('Ctrl + C')));

      final textFinder = find.text('Ctrl + C');
      expect(textFinder, findsOneWidget);

      final containerFinder = find.byType(Container).first;
      final container = tester.widget<Container>(containerFinder);
      final decoration = container.decoration as BoxDecoration;

      expect(decoration.color, BsThemeData.lightTheme.dark);
    });

    testWidgets('BsBlockquote renders without footer', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestApp(
        const BsBlockquote(
          child: Text('A well-known quote, contained in a blockquote element.'),
        ),
      ));

      expect(find.text('A well-known quote, contained in a blockquote element.'), findsOneWidget);
      expect(find.text('— '), findsNothing);
    });

    testWidgets('BsBlockquote renders with footer', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestApp(
        const BsBlockquote(
          footer: Text('Someone famous'),
          child: Text('A well-known quote.'),
        ),
      ));

      expect(find.text('A well-known quote.'), findsOneWidget);
      expect(find.text('— '), findsOneWidget);
      expect(find.text('Someone famous'), findsOneWidget);
    });
  });
}

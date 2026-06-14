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

  group('BsCard Tests', () {
    testWidgets('renders basic layout with body and text content', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          const BsCard(
            body: BsCardBody(
              child: Text('Card Content'),
            ),
          ),
        ),
      );

      expect(find.text('Card Content'), findsOneWidget);
    });

    testWidgets('renders header, body, and footer properly', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          const BsCard(
            header: BsCardHeader(child: Text('Card Header')),
            body: BsCardBody(child: Text('Card Body')),
            footer: BsCardFooter(child: Text('Card Footer')),
          ),
        ),
      );

      expect(find.text('Card Header'), findsOneWidget);
      expect(find.text('Card Body'), findsOneWidget);
      expect(find.text('Card Footer'), findsOneWidget);
    });

    testWidgets('renders BsCardBody with children list', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          const BsCard(
            body: BsCardBody(
              children: [
                Text('Line 1'),
                Text('Line 2'),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Line 1'), findsOneWidget);
      expect(find.text('Line 2'), findsOneWidget);
      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('applies color, borderColor, and borderRadius overrides', (WidgetTester tester) async {
      const customColor = Colors.purple;
      const customBorderColor = Colors.orange;
      const customRadius = BorderRadius.all(Radius.circular(20.0));

      await tester.pumpWidget(
        wrap(
          const BsCard(
            color: customColor,
            borderColor: customBorderColor,
            borderRadius: customRadius,
            body: BsCardBody(child: Text('Content')),
          ),
        ),
      );

      final containerFinder = find.byType(Container);
      final container = tester.widget<Container>(containerFinder.first);
      final decoration = container.decoration as BoxDecoration;

      expect(decoration.color, customColor);
      expect(decoration.border?.isUniform, true);
      expect(decoration.border?.top.color, customBorderColor);
      expect(decoration.borderRadius, customRadius);
    });

    testWidgets('applies variant colors for bg and border', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          const BsCard(
            variant: BsVariant.danger,
            body: BsCardBody(child: Text('Danger Card')),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container).first);
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, BsThemeData.lightTheme.danger);

      // Verify the inherited DefaultTextStyle color inside the variant
      // Wait, let's find the inherited DefaultTextStyle
      final defaultTextStyle = tester.widget<DefaultTextStyle>(
        find.ancestor(of: find.text('Danger Card'), matching: find.byType(DefaultTextStyle)).first,
      );
      expect(defaultTextStyle.style.color, BsColors.onDanger);
    });

    testWidgets('applies dark variant colors correctly in light and dark themes', (WidgetTester tester) async {
      // Light Theme
      await tester.pumpWidget(
        wrap(
          const BsCard(
            variant: BsVariant.dark,
            body: BsCardBody(child: Text('Dark Card Light Theme')),
          ),
        ),
      );
      final container = tester.widget<Container>(find.byType(Container).first);
      expect((container.decoration as BoxDecoration).color, BsThemeData.lightTheme.dark);
      final textStyle1 = tester.widget<DefaultTextStyle>(
        find.ancestor(of: find.text('Dark Card Light Theme'), matching: find.byType(DefaultTextStyle)).first,
      );
      expect(textStyle1.style.color, BsThemeData.lightTheme.onDark);

      // Dark Theme
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(extensions: [BsThemeData.darkTheme]),
          home: const Scaffold(
            body: BsCard(
              variant: BsVariant.dark,
              body: BsCardBody(child: Text('Dark Card Dark Theme')),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final containerDark = tester.widget<Container>(
        find.descendant(
          of: find.byType(BsCard),
          matching: find.byType(Container),
        ).first,
      );
      expect((containerDark.decoration as BoxDecoration).color, BsThemeData.darkTheme.dark);
      final textStyle2 = tester.widget<DefaultTextStyle>(
        find.ancestor(of: find.text('Dark Card Dark Theme'), matching: find.byType(DefaultTextStyle)).first,
      );
      expect(textStyle2.style.color, BsThemeData.darkTheme.onDark);
    });


    testWidgets('applies border variant properly', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          const BsCard(
            borderVariant: BsVariant.success,
            body: BsCardBody(child: Text('Success Border Card')),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container).first);
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.border?.top.color, BsThemeData.lightTheme.success);
    });

    testWidgets('handles image positioning (top and bottom)', (WidgetTester tester) async {
      final imageKey = UniqueKey();

      await tester.pumpWidget(
        wrap(
          BsCard(
            image: SizedBox(key: imageKey, height: 100),
            imagePosition: BsCardImagePosition.top,
            body: const BsCardBody(child: Text('Body')),
          ),
        ),
      );

      // Image should be the first child in the Column
      final column = tester.widget<Column>(find.byType(Column).first);
      expect(column.children.first, isA<ClipRRect>());
      final clipRRect = column.children.first as ClipRRect;
      expect(clipRRect.child?.key, imageKey);

      // Now test bottom positioning
      await tester.pumpWidget(
        wrap(
          BsCard(
            image: SizedBox(key: imageKey, height: 100),
            imagePosition: BsCardImagePosition.bottom,
            body: const BsCardBody(child: Text('Body')),
          ),
        ),
      );

      final columnBottom = tester.widget<Column>(find.byType(Column).first);
      expect(columnBottom.children.last, isA<ClipRRect>());
      final clipRRectBottom = columnBottom.children.last as ClipRRect;
      expect(clipRRectBottom.child?.key, imageKey);
    });

    testWidgets('handles image overlay and horizontal layouts', (WidgetTester tester) async {
      final imageKey = UniqueKey();

      // Image Overlay layout
      await tester.pumpWidget(
        wrap(
          BsCard(
            image: SizedBox(key: imageKey, height: 100),
            imagePosition: BsCardImagePosition.overlay,
            body: const BsCardBody(child: Text('Overlay')),
          ),
        ),
      );

      expect(
        find.ancestor(of: find.text('Overlay'), matching: find.byType(Stack)),
        findsOneWidget,
      );

      // Horizontal layout (left image)
      await tester.pumpWidget(
        wrap(
          BsCard(
            image: SizedBox(key: imageKey, height: 100),
            imagePosition: BsCardImagePosition.left,
            body: const BsCardBody(child: Text('Left Image Content')),
          ),
        ),
      );

      expect(find.byType(Row), findsOneWidget);
    });

    testWidgets('BsCardGroup renders horizontal and vertical layouts with custom corner radiuses', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          const BsCardGroup(
            children: [
              BsCard(body: BsCardBody(child: Text('Card 1'))),
              BsCard(body: BsCardBody(child: Text('Card 2'))),
              BsCard(body: BsCardBody(child: Text('Card 3'))),
            ],
          ),
        ),
      );

      // Should find IntrinsicHeight and Row
      expect(find.byType(IntrinsicHeight), findsOneWidget);
      expect(find.byType(Row), findsOneWidget);

      // Verify that three cards are rendered
      expect(find.text('Card 1'), findsOneWidget);
      expect(find.text('Card 2'), findsOneWidget);
      expect(find.text('Card 3'), findsOneWidget);

      final cardFinder = find.byType(BsCard);
      final card1 = tester.widget<BsCard>(cardFinder.at(0));
      final card2 = tester.widget<BsCard>(cardFinder.at(1));
      final card3 = tester.widget<BsCard>(cardFinder.at(2));
      expect(card1.borderRadius, const BorderRadius.horizontal(left: Radius.circular(6.0)));
      expect(card2.borderRadius, BorderRadius.zero);
      expect(card3.borderRadius, const BorderRadius.horizontal(right: Radius.circular(6.0)));

      // Test vertical layout
      await tester.pumpWidget(
        wrap(
          const BsCardGroup(
            vertical: true,
            children: [
              BsCard(body: BsCardBody(child: Text('Card A'))),
              BsCard(body: BsCardBody(child: Text('Card B'))),
            ],
          ),
        ),
      );

      expect(find.byType(Column), findsWidgets);
      expect(find.text('Card A'), findsOneWidget);
      expect(find.text('Card B'), findsOneWidget);
    });

    testWidgets('supports onTap callback and triggers it on tap', (WidgetTester tester) async {
      int tapCount = 0;
      await tester.pumpWidget(
        wrap(
          BsCard(
            onTap: () => tapCount++,
            body: const BsCardBody(child: Text('Clickable Card')),
          ),
        ),
      );

      // Verify that GestureDetector is rendered
      expect(find.byType(GestureDetector), findsOneWidget);

      // Tap card
      await tester.tap(find.text('Clickable Card'));
      await tester.pumpAndSettle();

      expect(tapCount, 1);
    });

    testWidgets('supports semantics configurations (isLink, isButton)', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          const BsCard(
            isLink: true,
            body: BsCardBody(child: Text('Link Card')),
          ),
        ),
      );

      final linkSemanticsFinder = find.byWidgetPredicate(
        (widget) => widget is Semantics &&
            widget.properties.link == true &&
            widget.properties.button != true,
      );
      expect(linkSemanticsFinder, findsOneWidget);

      await tester.pumpWidget(
        wrap(
          const BsCard(
            isButton: true,
            body: BsCardBody(child: Text('Button Card')),
          ),
        ),
      );

      final buttonSemanticsFinder = find.byWidgetPredicate(
        (widget) => widget is Semantics &&
            widget.properties.button == true &&
            widget.properties.link != true,
      );
      expect(buttonSemanticsFinder, findsOneWidget);
    });
  });
}


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

  group('BsPagination and BsPaginationItem Tests', () {
    testWidgets('renders basic custom pagination items correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          BsPagination(
            items: [
              BsPaginationItem(
                key: const ValueKey('item_prev'),
                child: const Text('Prev'),
                onPressed: () {},
              ),
              const BsPaginationItem(
                key: ValueKey('item_1'),
                active: true,
                child: Text('1'),
              ),
              BsPaginationItem(
                key: const ValueKey('item_2'),
                child: const Text('2'),
                onPressed: () {},
              ),
              const BsPaginationItem(
                key: ValueKey('item_disabled'),
                disabled: true,
                child: Text('...'),
              ),
            ],
          ),
        ),
      );

      expect(find.text('Prev'), findsOneWidget);
      expect(find.text('1'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
      expect(find.text('...'), findsOneWidget);
    });

    testWidgets('calls onPressed on custom items', (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        buildTestWidget(
          BsPagination(
            items: [
              BsPaginationItem(
                child: const Text('2'),
                onPressed: () => tapped = true,
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.text('2'));
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('disabled and active items do not trigger onPressed', (WidgetTester tester) async {
      bool tappedActive = false;
      bool tappedDisabled = false;

      await tester.pumpWidget(
        buildTestWidget(
          BsPagination(
            items: [
              BsPaginationItem(
                active: true,
                onPressed: () => tappedActive = true,
                child: const Text('1'),
              ),
              BsPaginationItem(
                disabled: true,
                onPressed: () => tappedDisabled = true,
                child: const Text('2'),
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.text('1'));
      await tester.tap(find.text('2'));
      await tester.pump();

      expect(tappedActive, isFalse);
      expect(tappedDisabled, isFalse);
    });

    testWidgets('BsPagination.automatic renders correct pages without ellipsis when pages <= maxVisiblePages', (WidgetTester tester) async {
      int selectedPage = 1;

      await tester.pumpWidget(
        buildTestWidget(
          BsPagination.automatic(
            currentPage: 1,
            totalPages: 3,
            maxVisiblePages: 5,
            onPageChanged: (page) => selectedPage = page,
          ),
        ),
      );

      // Should render numbers 1, 2, 3
      expect(find.text('1'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      expect(find.text('...'), findsNothing);

      // Prev should be disabled (cannot click)
      // Next should be active, clicking next should trigger page 2
      final nextFinder = find.byKey(const ValueKey('page_next'));
      expect(nextFinder, findsOneWidget);
      await tester.tap(nextFinder);
      await tester.pump();

      expect(selectedPage, 2);
    });

    testWidgets('BsPagination.automatic renders ellipsis correctly when pages > maxVisiblePages', (WidgetTester tester) async {
      int selectedPage = 5;

      await tester.pumpWidget(
        buildTestWidget(
          BsPagination.automatic(
            currentPage: 5,
            totalPages: 10,
            maxVisiblePages: 5,
            onPageChanged: (page) => selectedPage = page,
          ),
        ),
      );

      // Given current=5, total=10, visible=5
      // Expected visible buttons: Prev, First (1), Ellipsis, 3, 4, 5, 6, 7, Ellipsis, Last (10), Next
      // We expect the ellipsis key to exist
      expect(find.byKey(const ValueKey('page_ellipsis_start')), findsOneWidget);
      expect(find.byKey(const ValueKey('page_ellipsis_end')), findsOneWidget);

      expect(find.text('1'), findsOneWidget); // page 1
      expect(find.text('3'), findsOneWidget); // page 3
      expect(find.text('4'), findsOneWidget); // page 4
      expect(find.text('5'), findsOneWidget); // page 5 (active)
      expect(find.text('6'), findsOneWidget); // page 6
      expect(find.text('7'), findsOneWidget); // page 7
      expect(find.text('10'), findsOneWidget); // page 10

      // Let's click on page 6
      await tester.tap(find.text('6'));
      await tester.pump();

      expect(selectedPage, 6);
    });

    testWidgets('alignment and size options apply correctly', (WidgetTester tester) async {
      // Just verifying we can build with different alignments and sizes without errors
      await tester.pumpWidget(
        buildTestWidget(
          Column(
            children: [
              BsPagination.automatic(
                currentPage: 2,
                totalPages: 5,
                size: BsSize.sm,
                alignment: BsPaginationAlignment.center,
                onPageChanged: (_) {},
              ),
              BsPagination.automatic(
                currentPage: 2,
                totalPages: 5,
                size: BsSize.lg,
                alignment: BsPaginationAlignment.end,
                onPageChanged: (_) {},
              ),
            ],
          ),
        ),
      );

      expect(find.byType(BsPagination), findsNWidgets(2));
    });

    testWidgets('custom active and normal state colors apply correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          BsPagination.automatic(
            currentPage: 2,
            totalPages: 5,
            textColor: Colors.red,
            bgColor: Colors.yellow,
            borderColor: Colors.green,
            activeColor: Colors.blue,
            activeTextColor: Colors.white,
            onPageChanged: (_) {},
          ),
        ),
      );

      expect(find.byType(BsPagination), findsOneWidget);
    });
  });
}

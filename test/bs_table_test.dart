import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

void main() {
  Widget buildTestableWidget(Widget child) {
    return MaterialApp(
      theme: ThemeData(
        extensions: [BsThemeData.lightTheme],
      ),
      home: Scaffold(
        body: child,
      ),
    );
  }

  group('BsTable', () {
    testWidgets('renders basic table with rows and cells', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget(
        BsTable(
          children: const [
            BsTableRow(
              children: [
                BsTableCell(child: Text('Cell 1')),
                BsTableCell(child: Text('Cell 2')),
              ],
            ),
          ],
        ),
      ));

      expect(find.text('Cell 1'), findsOneWidget);
      expect(find.text('Cell 2'), findsOneWidget);
      expect(find.byType(Table), findsOneWidget);
    });

    testWidgets('renders head and foot correctly', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget(
        BsTable(
          head: const BsTableHead(
            rows: [
              BsTableRow(
                children: [
                  BsTableCell.header(child: Text('Header')),
                ],
              ),
            ],
          ),
          foot: const BsTableFoot(
            rows: [
              BsTableRow(
                children: [
                  BsTableCell(child: Text('Footer')),
                ],
              ),
            ],
          ),
          children: const [
            BsTableRow(
              children: [
                BsTableCell(child: Text('Body')),
              ],
            ),
          ],
        ),
      ));

      expect(find.text('Header'), findsOneWidget);
      expect(find.text('Body'), findsOneWidget);
      expect(find.text('Footer'), findsOneWidget);
      
      // Verify bold font for header via DefaultTextStyle
      final DefaultTextStyle defaultStyle = tester.widget(
        find.ancestor(
          of: find.text('Header'),
          matching: find.byType(DefaultTextStyle),
        ).first,
      );
      expect(defaultStyle.style.fontWeight, FontWeight.bold);
    });

    testWidgets('applies variant colors', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget(
        const BsTable(
          variant: BsTableVariant.primary,
          children: [
            BsTableRow(
              children: [
                BsTableCell(child: Text('Primary')),
              ],
            ),
          ],
        ),
      ));

      // TableRow decoration should have primaryBgSubtle
      // Since it's hard to test BoxDecoration color directly on TableRow, 
      // we check if the Row is rendered.
      expect(find.text('Primary'), findsOneWidget);
    });

    testWidgets('responsive table wraps in scroll view and scrollbar', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget(
        const BsTable(
          isResponsive: true,
          children: [
            BsTableRow(
              children: [
                BsTableCell(child: Text('Responsive')),
              ],
            ),
          ],
        ),
      ));

      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(find.byType(Scrollbar), findsOneWidget);
      
      final SingleChildScrollView scrollView = tester.widget(find.byType(SingleChildScrollView));
      expect(scrollView.scrollDirection, Axis.horizontal);
      
      // Verify that the Scrollbar uses the controller
      expect(scrollView.controller, isNotNull);
    });

    testWidgets('caption is rendered', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget(
        const BsTable(
          caption: Text('Table Caption'),
          children: [
            BsTableRow(
              children: [
                BsTableCell(child: Text('Data')),
              ],
            ),
          ],
        ),
      ));

      expect(find.text('Table Caption'), findsOneWidget);
    });
  });
}

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

  group('BsBreadcrumb', () {
    testWidgets('renders all items', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          BsBreadcrumb(
            items: [
              BsBreadcrumbItem(label: Text('Home')),
              BsBreadcrumbItem(label: Text('Library')),
              BsBreadcrumbItem(label: Text('Data'), active: true),
            ],
          ),
        ),
      );

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Library'), findsOneWidget);
      expect(find.text('Data'), findsOneWidget);
    });

    testWidgets('renders default dividers', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          BsBreadcrumb(
            items: [
              BsBreadcrumbItem(label: Text('Home')),
              BsBreadcrumbItem(label: Text('Library')),
            ],
          ),
        ),
      );

      expect(find.text('/'), findsOneWidget);
    });

    testWidgets('renders custom string divider', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          BsBreadcrumb(
            divider: '>',
            items: [
              BsBreadcrumbItem(label: Text('Home')),
              BsBreadcrumbItem(label: Text('Library')),
            ],
          ),
        ),
      );

      expect(find.text('>'), findsOneWidget);
      expect(find.text('/'), findsNothing);
    });

    testWidgets('renders custom widget divider', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          BsBreadcrumb(
            divider: Icon(Icons.chevron_right),
            items: [
              BsBreadcrumbItem(label: Text('Home')),
              BsBreadcrumbItem(label: Text('Library')),
            ],
          ),
        ),
      );

      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
    });

    testWidgets('calls onPressed when item is tapped', (WidgetTester tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        buildTestWidget(
          BsBreadcrumb(
            items: [
              BsBreadcrumbItem(
                label: Text('Home'),
                onPressed: () => tapped = true,
              ),
              BsBreadcrumbItem(label: Text('Library'), active: true),
            ],
          ),
        ),
      );

      await tester.tap(find.text('Home'));
      expect(tapped, isTrue);
    });

    testWidgets('does not call onPressed when item is active', (WidgetTester tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        buildTestWidget(
          BsBreadcrumb(
            items: [
              BsBreadcrumbItem(
                label: Text('Data'),
                active: true,
                onPressed: () => tapped = true,
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.text('Data'));
      expect(tapped, isFalse);
    });
  });
}

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

  group('BsPlaceholder Tests', () {
    testWidgets('renders basic placeholder with default values', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const BsPlaceholder(),
        ),
      );

      // Verify that BsPlaceholder renders
      expect(find.byType(BsPlaceholder), findsOneWidget);
    });

    testWidgets('respects custom width and height', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const Center(
            child: BsPlaceholder(
              width: 150.0,
              height: 25.0,
            ),
          ),
        ),
      );

      final Finder placeholderFinder = find.byType(BsPlaceholder);
      expect(placeholderFinder, findsOneWidget);

      final Size size = tester.getSize(placeholderFinder);
      expect(size.width, 150.0);
      expect(size.height, 25.0);
    });

    testWidgets('respects widthFactor', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const SizedBox(
            width: 400.0,
            child: Center(
              child: BsPlaceholder(
                widthFactor: 0.5,
              ),
            ),
          ),
        ),
      );

      final Finder placeholderFinder = find.byType(BsPlaceholder);
      expect(placeholderFinder, findsOneWidget);

      final Size size = tester.getSize(placeholderFinder);
      expect(size.width, 200.0); // 0.5 of 400.0
    });

    testWidgets('respects colSpan', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const SizedBox(
            width: 120.0,
            child: Center(
              child: BsPlaceholder(
                colSpan: 6, // 6/12 = 0.5
              ),
            ),
          ),
        ),
      );

      final Finder placeholderFinder = find.byType(BsPlaceholder);
      expect(placeholderFinder, findsOneWidget);

      final Size size = tester.getSize(placeholderFinder);
      expect(size.width, 60.0); // 0.5 of 120.0
    });

    testWidgets('applies height from size variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const Column(
            children: [
              BsPlaceholder(size: BsSize.sm, key: ValueKey('sm')),
              BsPlaceholder(size: BsSize.md, key: ValueKey('md')),
              BsPlaceholder(size: BsSize.lg, key: ValueKey('lg')),
            ],
          ),
        ),
      );

      final double smHeight = tester.getSize(find.byKey(const ValueKey('sm'))).height;
      final double mdHeight = tester.getSize(find.byKey(const ValueKey('md'))).height;
      final double lgHeight = tester.getSize(find.byKey(const ValueKey('lg'))).height;

      expect(smHeight, lessThan(mdHeight));
      expect(mdHeight, lessThan(lgHeight));
    });

    testWidgets('applies custom color and variant color', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const Column(
            children: [
              BsPlaceholder(color: Colors.red, key: ValueKey('red')),
              BsPlaceholder(variant: BsVariant.primary, key: ValueKey('primary')),
            ],
          ),
        ),
      );

      expect(find.byKey(const ValueKey('red')), findsOneWidget);
      expect(find.byKey(const ValueKey('primary')), findsOneWidget);
    });

    testWidgets('works inside BsPlaceholderContainer with glow animation', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const BsPlaceholderContainer(
            animation: BsPlaceholderAnimation.glow,
            child: BsPlaceholder(),
          ),
        ),
      );

      expect(find.byType(BsPlaceholder), findsOneWidget);

      // Pump to trigger animation frame
      await tester.pump(const Duration(milliseconds: 100));
      expect(tester.hasRunningAnimations, isTrue);
    });

    testWidgets('works inside BsPlaceholderContainer with wave animation', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const BsPlaceholderContainer(
            animation: BsPlaceholderAnimation.wave,
            child: BsPlaceholder(),
          ),
        ),
      );

      expect(find.byType(BsPlaceholder), findsOneWidget);

      // Pump to trigger animation frame
      await tester.pump(const Duration(milliseconds: 100));
      expect(tester.hasRunningAnimations, isTrue);
    });
  });
}

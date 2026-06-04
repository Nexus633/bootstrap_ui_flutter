import 'dart:typed_data';
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

  final transparentImage = Uint8List.fromList([
    0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D, 0x49,
    0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x08, 0x06,
    0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00, 0x0A, 0x49, 0x44,
    0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00, 0x05, 0x00, 0x01, 0x0D,
    0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE, 0x42,
    0x60, 0x82,
  ]);

  group('BsImage', () {
    testWidgets('renders a simple image', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          BsImage(image: MemoryImage(transparentImage)),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('applies thumbnail styling', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          BsImage(
            image: MemoryImage(transparentImage),
            thumbnail: true,
          ),
        ),
      );

      final containerFinder = find.byType(Container);
      expect(containerFinder, findsOneWidget);

      final container = tester.widget<Container>(containerFinder);
      final decoration = container.decoration as BoxDecoration;

      expect(decoration.border, isA<Border>());
      expect(decoration.borderRadius, equals(BsRadius.md));
      expect(container.padding, equals(const EdgeInsets.all(BsSpacing.s1)));
      
      // Should contain a ClipRRect for the image
      expect(find.descendant(of: containerFinder, matching: find.byType(ClipRRect)), findsOneWidget);
    });

    testWidgets('applies rounded corners', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          BsImage(
            image: MemoryImage(transparentImage),
            rounded: true,
          ),
        ),
      );

      final clipFinder = find.byType(ClipRRect);
      expect(clipFinder, findsOneWidget);

      final clip = tester.widget<ClipRRect>(clipFinder);
      expect(clip.borderRadius, equals(BsRadius.md));
    });

    testWidgets('applies circle shape', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          BsImage(
            image: MemoryImage(transparentImage),
            circle: true,
          ),
        ),
      );

      expect(find.byType(ClipOval), findsOneWidget);
    });

    testWidgets('applies alignment', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          BsImage(
            image: MemoryImage(transparentImage),
            alignment: Alignment.centerRight,
          ),
        ),
      );

      final alignFinder = find.byType(Align);
      expect(alignFinder, findsOneWidget);

      final align = tester.widget<Align>(alignFinder);
      expect(align.alignment, equals(Alignment.centerRight));
    });

    testWidgets('applies fluid constraints', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          BsImage(
            image: MemoryImage(transparentImage),
            fluid: true,
          ),
        ),
      );

      // Find ConstrainedBox that is a parent of Image
      final constrainedBoxFinder = find.ancestor(
        of: find.byType(Image),
        matching: find.byType(ConstrainedBox),
      );
      
      expect(constrainedBoxFinder, findsAtLeast(1));
      
      final constrainedBox = tester.widget<ConstrainedBox>(constrainedBoxFinder.first);
      expect(constrainedBox.constraints.maxWidth, equals(double.infinity));
    });
  });
}

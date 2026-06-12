import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BsScrollspy and BsScrollspyController', () {
    testWidgets('should register and update active target on scroll',
        (WidgetTester tester) async {
      final controller = BsScrollspyController();
      final key1 = GlobalKey();
      final key2 = GlobalKey();

      controller.registerTarget('section1', key1);
      controller.registerTarget('section2', key2);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BsScrollspy(
              controller: controller,
              child: SingleChildScrollView(
                controller: controller.scrollController,
                child: Column(
                  children: [
                    Container(
                      key: key1,
                      height: 800,
                      color: Colors.red,
                      child: const Text('Section 1'),
                    ),
                    Container(
                      key: key2,
                      height: 800,
                      color: Colors.blue,
                      child: const Text('Section 2'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      // Initially, section1 should be visible
      expect(controller.activeTargetId, 'section1');

      // Scroll down
      controller.scrollController.jumpTo(780);
      await tester.pumpAndSettle();

      // Since we jumped to 780, section 2 is at offset 800-780 = 20,
      // which is <= 50 (activation margin).
      // So section2 should become active.
      expect(controller.activeTargetId, 'section2');
      
      // Scroll back up
      controller.scrollController.jumpTo(0);
      await tester.pumpAndSettle();

      expect(controller.activeTargetId, 'section1');
    });

    testWidgets('should scroll to target', (WidgetTester tester) async {
      final controller = BsScrollspyController();
      final key1 = GlobalKey();
      final key2 = GlobalKey();

      controller.registerTarget('section1', key1);
      controller.registerTarget('section2', key2);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BsScrollspy(
              controller: controller,
              child: SingleChildScrollView(
                controller: controller.scrollController,
                child: Column(
                  children: [
                    Container(
                      key: key1,
                      height: 800,
                    ),
                    Container(
                      key: key2,
                      height: 800,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      await controller.scrollToTarget('section2', smooth: false);
      await tester.pumpAndSettle();

      expect(controller.scrollController.offset, 800.0);
      expect(controller.activeTargetId, 'section2');
    });
  });
}

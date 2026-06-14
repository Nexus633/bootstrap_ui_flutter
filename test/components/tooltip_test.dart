import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

void main() {
  Widget wrap(Widget child) {
    return MaterialApp(
      theme: ThemeData(extensions: [BsThemeData.lightTheme]),
      home: Scaffold(body: Center(child: child)),
    );
  }

  group('BsTooltip Tests', () {
    testWidgets('renders child and shows tooltip on hover', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          BsTooltip(
            message: 'Tooltip Content',
            child: const Text('Hover Me'),
          ),
        ),
      );

      expect(find.text('Hover Me'), findsOneWidget);
      expect(find.text('Tooltip Content'), findsNothing);

      // Simulate mouse enter
      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: Offset.zero);
      addTearDown(gesture.removePointer);
      await tester.pump();
      await gesture.moveTo(tester.getCenter(find.text('Hover Me')));
      await tester.pumpAndSettle();

      expect(find.text('Tooltip Content'), findsOneWidget);
    });
  });
}

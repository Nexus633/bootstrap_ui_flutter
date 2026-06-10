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

  group('BsToast Tests', () {
    testWidgets('renders body and header correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          BsToast(
            header: BsToastHeader(
              title: const Text('Header Title'),
              subtitle: const Text('Header Subtitle'),
              onClose: () {},
            ),
            child: const Text('Toast Body Content'),
          ),
        ),
      );

      expect(find.text('Header Title'), findsOneWidget);
      expect(find.text('Header Subtitle'), findsOneWidget);
      expect(find.text('Toast Body Content'), findsOneWidget);
      expect(find.byType(BsCloseButton), findsOneWidget);
    });

    testWidgets('handles color variants', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          const BsToast(
            variant: BsVariant.danger,
            child: Text('Danger Toast'),
          ),
        ),
      );

      expect(find.text('Danger Toast'), findsOneWidget);
      
      final container = tester.widget<Container>(find.byType(Container).first);
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, BsThemeData.lightTheme.danger);
    });
  });
}

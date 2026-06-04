import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bootstrap_flutter/bootstrap_flutter.dart';

void main() {
  Widget wrap(Widget child) {
    return MaterialApp(
      theme: ThemeData(extensions: [BsThemeData.lightTheme]),
      home: Scaffold(body: child),
    );
  }

  group('BsButtonGroup Tests', () {
    testWidgets('renders all children buttons', (WidgetTester tester) async {
      await tester.pumpWidget(wrap(
        BsButtonGroup(
          children: [
            AppButton(label: 'Button 1', onPressed: () {}),
            AppButton(label: 'Button 2', onPressed: () {}),
          ],
        ),
      ));

      expect(find.text('Button 1'), findsOneWidget);
      expect(find.text('Button 2'), findsOneWidget);
    });

    testWidgets('applies vertical layout', (WidgetTester tester) async {
      await tester.pumpWidget(wrap(
        BsButtonGroup(
          vertical: true,
          children: [
            AppButton(label: 'Button 1', onPressed: () {}),
            AppButton(label: 'Button 2', onPressed: () {}),
          ],
        ),
      ));

      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('applies group size to all buttons', (WidgetTester tester) async {
      await tester.pumpWidget(wrap(
        BsButtonGroup(
          groupSize: BsButtonSize.lg,
          children: [
            AppButton(label: 'Button 1', onPressed: () {}, size: BsButtonSize.sm),
            AppButton(label: 'Button 2', onPressed: () {}),
          ],
        ),
      ));

      // Buttons are "rebuilt" in BsButtonGroup with the group size.
      // We check if they have the LG font size.
      final text1 = tester.widget<Text>(find.text('Button 1'));
      expect(text1.style!.fontSize, BsTypography.fontSizeLg);

      final text2 = tester.widget<Text>(find.text('Button 2'));
      expect(text2.style!.fontSize, BsTypography.fontSizeLg);
    });
  });
}

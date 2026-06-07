import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

void main() {
  Widget wrap(Widget child, {ThemeMode themeMode = ThemeMode.light}) {
    return MaterialApp(
      themeMode: themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        extensions: [BsThemeData.lightTheme],
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        extensions: [BsThemeData.darkTheme],
      ),
      home: Scaffold(
        body: Center(
          child: child,
        ),
      ),
    );
  }

  Future<void> tapToggle(WidgetTester tester, Finder finder) async {
    await tester.tap(finder, warnIfMissed: false);
    await tester.pumpAndSettle();
  }

  group('BsDropdown Tests', () {
    testWidgets('toggles menu open and close on tap', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          BsDropdown(
            toggle: const Text('Toggle Button'),
            menu: BsDropdownMenu(
              children: [
                BsDropdownItem(
                  child: const Text('Item 1'),
                  onPressed: () {},
                ),
                const BsDropdownItem(
                  child: Text('Item 2'),
                ),
              ],
            ),
          ),
        ),
      );

      // Verify menu is closed initially
      expect(find.text('Item 1'), findsNothing);
      expect(find.text('Item 2'), findsNothing);

      // Tap to open
      await tapToggle(tester, find.text('Toggle Button'));

      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);

      // Tap to close
      await tapToggle(tester, find.text('Toggle Button'));

      expect(find.text('Item 1'), findsNothing);
      expect(find.text('Item 2'), findsNothing);
    });

    testWidgets('renders default trigger button with label and caret', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          BsDropdown(
            label: 'Default Trigger',
            menu: BsDropdownMenu(
              children: [
                BsDropdownItem(
                  child: const Text('Item 1'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );

      // Verify label is present
      expect(find.text('Default Trigger'), findsOneWidget);

      // Verify caret icon is present
      expect(find.byIcon(Icons.arrow_drop_down_rounded), findsOneWidget);

      // Tap to open
      await tapToggle(tester, find.text('Default Trigger'));
      expect(find.text('Item 1'), findsOneWidget);
    });

    testWidgets('respects showCaret = false on default trigger button', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          BsDropdown(
            label: 'No Arrow Trigger',
            showCaret: false,
            menu: BsDropdownMenu(
              children: [
                BsDropdownItem(
                  child: const Text('Item 1'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );

      // Verify label is present
      expect(find.text('No Arrow Trigger'), findsOneWidget);

      // Verify caret icon is NOT present
      expect(find.byIcon(Icons.arrow_drop_down_rounded), findsNothing);
    });

    testWidgets('autoClose = always: closes on item tap and outside tap', (WidgetTester tester) async {
      int pressedCount = 0;

      await tester.pumpWidget(
        wrap(
          BsDropdown(
            autoClose: BsDropdownAutoClose.always,
            toggle: const Text('Toggle Button'),
            menu: BsDropdownMenu(
              children: [
                BsDropdownItem(
                  child: const Text('Item 1'),
                  onPressed: () => pressedCount++,
                ),
              ],
            ),
          ),
        ),
      );

      // 1. Test close on item tap
      await tapToggle(tester, find.text('Toggle Button'));
      expect(find.text('Item 1'), findsOneWidget);

      await tester.tap(find.text('Item 1'));
      await tester.pumpAndSettle();
      expect(find.text('Item 1'), findsNothing);
      expect(pressedCount, 1);

      // 2. Test close on outside tap
      await tapToggle(tester, find.text('Toggle Button'));
      expect(find.text('Item 1'), findsOneWidget);

      // Tap somewhere outside (e.g. top left corner of the screen)
      await tester.tapAt(const Offset(10.0, 10.0));
      await tester.pumpAndSettle();
      expect(find.text('Item 1'), findsNothing);
    });

    testWidgets('autoClose = inside: closes only on item tap', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          BsDropdown(
            autoClose: BsDropdownAutoClose.inside,
            toggle: const Text('Toggle Button'),
            menu: BsDropdownMenu(
              children: [
                BsDropdownItem(
                  child: const Text('Item 1'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );

      // Open
      await tapToggle(tester, find.text('Toggle Button'));
      expect(find.text('Item 1'), findsOneWidget);

      // Tap outside -> should NOT close
      await tester.tapAt(const Offset(10.0, 10.0));
      await tester.pumpAndSettle();
      expect(find.text('Item 1'), findsOneWidget);

      // Tap item -> should close
      await tester.tap(find.text('Item 1'));
      await tester.pumpAndSettle();
      expect(find.text('Item 1'), findsNothing);
    });

    testWidgets('autoClose = outside: closes only on outside tap', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          BsDropdown(
            autoClose: BsDropdownAutoClose.outside,
            toggle: const Text('Toggle Button'),
            menu: BsDropdownMenu(
              children: [
                BsDropdownItem(
                  child: const Text('Item 1'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );

      // Open
      await tapToggle(tester, find.text('Toggle Button'));
      expect(find.text('Item 1'), findsOneWidget);

      // Tap item -> should NOT close
      await tester.tap(find.text('Item 1'));
      await tester.pumpAndSettle();
      expect(find.text('Item 1'), findsOneWidget);

      // Tap outside -> should close
      await tester.tapAt(const Offset(10.0, 10.0));
      await tester.pumpAndSettle();
      expect(find.text('Item 1'), findsNothing);
    });

    testWidgets('autoClose = none: does not close on either tap', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          BsDropdown(
            autoClose: BsDropdownAutoClose.none,
            toggle: const Text('Toggle Button'),
            menu: BsDropdownMenu(
              children: [
                BsDropdownItem(
                  child: const Text('Item 1'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );

      // Open
      await tapToggle(tester, find.text('Toggle Button'));
      expect(find.text('Item 1'), findsOneWidget);

      // Tap item -> should NOT close
      await tester.tap(find.text('Item 1'));
      await tester.pumpAndSettle();
      expect(find.text('Item 1'), findsOneWidget);

      // Tap outside -> should NOT close
      await tester.tapAt(const Offset(10.0, 10.0));
      await tester.pumpAndSettle();
      expect(find.text('Item 1'), findsOneWidget);
    });

    testWidgets('autoClose = none: closes when trigger button is tapped again', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          BsDropdown(
            autoClose: BsDropdownAutoClose.none,
            toggle: const Text('Toggle Button'),
            menu: BsDropdownMenu(
              children: [
                BsDropdownItem(
                  child: const Text('Item 1'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );

      // Open
      await tapToggle(tester, find.text('Toggle Button'));
      expect(find.text('Item 1'), findsOneWidget);

      // Tap trigger button again -> should close
      await tapToggle(tester, find.text('Toggle Button'));
      expect(find.text('Item 1'), findsNothing);
    });

    testWidgets('respects disabled state on dropdown trigger', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          BsDropdown(
            disabled: true,
            toggle: const Text('Toggle Button'),
            menu: BsDropdownMenu(
              children: [
                BsDropdownItem(
                  child: const Text('Item 1'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );

      // Tap to open
      await tapToggle(tester, find.text('Toggle Button'));

      expect(find.text('Item 1'), findsNothing);
    });

    testWidgets('respects disabled state on dropdown item', (WidgetTester tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        wrap(
          BsDropdown(
            toggle: const Text('Toggle Button'),
            menu: BsDropdownMenu(
              children: [
                BsDropdownItem(
                  disabled: true,
                  onPressed: () => pressed = true,
                  child: const Text('Disabled Item'),
                ),
              ],
            ),
          ),
        ),
      );

      // Open
      await tapToggle(tester, find.text('Toggle Button'));

      // Tap disabled item
      await tester.tap(find.text('Disabled Item'));
      await tester.pumpAndSettle();

      // Should not trigger callback and should not close the menu
      expect(pressed, isFalse);
      expect(find.text('Disabled Item'), findsOneWidget);
    });

    testWidgets('supports split toggleBuilder', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          BsDropdown(
            toggleBuilder: (context, toggleMenu, isOpen) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Main Button'),
                  ElevatedButton(
                    onPressed: toggleMenu,
                    child: Text(isOpen ? 'Close Caret' : 'Open Caret'),
                  ),
                ],
              );
            },
            menu: BsDropdownMenu(
              children: [
                BsDropdownItem(
                  child: const Text('Item 1'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Item 1'), findsNothing);
      expect(find.text('Open Caret'), findsOneWidget);

      // Tap caretaker to open
      await tapToggle(tester, find.text('Open Caret'));

      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Close Caret'), findsOneWidget);

      // Tap caret to close
      await tapToggle(tester, find.text('Close Caret'));

      expect(find.text('Item 1'), findsNothing);
      expect(find.text('Open Caret'), findsOneWidget);
    });

    testWidgets('applies variant colors on BsDropdownMenu', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          BsDropdown(
            toggle: const Text('Toggle'),
            menu: BsDropdownMenu(
              variant: BsCardVariant.success,
              children: [
                BsDropdownItem(
                  child: const Text('Item 1'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );

      await tapToggle(tester, find.text('Toggle'));

      final menuContainer = tester.widget<Container>(
        find.descendant(of: find.byType(BsDropdownMenu), matching: find.byType(Container)).first,
      );
      final decoration = menuContainer.decoration as BoxDecoration;
      // Success variant background color
      expect(decoration.color, BsColors.success);
    });

    testWidgets('applies custom color override on BsDropdownMenu', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          BsDropdown(
            toggle: const Text('Toggle'),
            menu: BsDropdownMenu(
              color: Colors.purple,
              children: [
                BsDropdownItem(
                  child: const Text('Item 1'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );

      await tapToggle(tester, find.text('Toggle'));

      final menuContainerCustom = tester.widget<Container>(
        find.descendant(of: find.byType(BsDropdownMenu), matching: find.byType(Container)).first,
      );
      final decorationCustom = menuContainerCustom.decoration as BoxDecoration;
      expect(decorationCustom.color, Colors.purple);
    });

    testWidgets('auto-flips from down to up if not enough space below', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(extensions: [BsThemeData.lightTheme]),
          home: Scaffold(
            body: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BsDropdown(
                  direction: BsDropdownDirection.down,
                  label: 'Flip Trigger',
                  menu: BsDropdownMenu(
                    children: [
                      BsDropdownItem(
                        child: const Text('Menu Item'),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      // Open
      await tapToggle(tester, find.text('Flip Trigger'));

      final triggerBox = tester.renderObject<RenderBox>(find.text('Flip Trigger'));
      final triggerTopY = triggerBox.localToGlobal(Offset.zero).dy;

      final menuBox = tester.renderObject<RenderBox>(find.byType(BsDropdownMenu));
      final menuTopY = menuBox.localToGlobal(Offset.zero).dy;

      expect(menuTopY, lessThan(triggerTopY));
    });

    testWidgets('dropdown menu shrink-wraps height and obeys maxWidth constraint', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          BsDropdown(
            toggle: const Text('Toggle'),
            menu: BsDropdownMenu(
              maxWidth: 200.0,
              children: [
                BsDropdownItem(
                  onPressed: () {},
                  child: const Text('Short Item'),
                ),
              ],
            ),
          ),
        ),
      );

      // Open
      await tapToggle(tester, find.text('Toggle'));

      final menuFinder = find.byType(BsDropdownMenu);
      expect(menuFinder, findsOneWidget);

      final Size menuSize = tester.getSize(menuFinder);

      // 1. Verify height is shrink-wrapped, not filling the full screen or maxMenuHeight
      expect(menuSize.height, lessThan(120.0));

      // 2. Verify width is constrained by maxWidth
      expect(menuSize.width, lessThanOrEqualTo(200.0));
    });

    testWidgets('dropdown wraps long text inside BsDropdownText and BsDropdownItem', (WidgetTester tester) async {
      const String veryLongText = 'This is an extremely long text run that would normally push the dropdown menu to expand horizontally forever if it was not wrapping automatically.';

      await tester.pumpWidget(
        wrap(
          BsDropdown(
            toggle: const Text('Toggle'),
            menu: const BsDropdownMenu(
              maxWidth: 250.0,
              children: [
                BsDropdownText(
                  child: Text(veryLongText),
                ),
                BsDropdownItem(
                  child: Text(veryLongText),
                ),
              ],
            ),
          ),
        ),
      );

      // Open
      await tapToggle(tester, find.text('Toggle'));

      final menuFinder = find.byType(BsDropdownMenu);
      expect(menuFinder, findsOneWidget);

      final Size menuSize = tester.getSize(menuFinder);

      // Width must be constrained to maxWidth (250.0)
      expect(menuSize.width, lessThanOrEqualTo(250.0));

      // Verify that the text wrapped
      expect(tester.takeException(), isNull);
    });
  });
}

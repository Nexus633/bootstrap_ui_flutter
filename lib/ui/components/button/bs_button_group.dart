import 'package:flutter/material.dart';
import '../../tokens/spacing.dart';
import '../../tokens/enums.dart';
import 'bs_button.dart';

/// A Bootstrap-style button group component.
///
/// Group a series of buttons together on a single line with the button group.
class BsButtonGroup extends StatelessWidget {
  /// Creates a [BsButtonGroup] widget.
  const BsButtonGroup({
    super.key,
    required this.children,
    this.vertical = false,
    this.groupSize,
  });

  /// The list of [BsButton] widgets to group together.
  final List<BsButton> children;

  /// Whether the buttons should be stacked vertically.
  final bool vertical;

  /// Overrides the size of all buttons in the group.
  final BsButtonSize? groupSize;

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) return const SizedBox.shrink();
    if (children.length == 1) return children.first;

    final List<Widget> groupedButtons = [];

    for (int i = 0; i < children.length; i++) {
      final button = children[i];
      final bool isFirst = i == 0;
      final bool isLast = i == children.length - 1;

      final BsButtonSize finalSize = groupSize ?? button.size;
      // 1. Calculate specific radius for the position in the group
      final BorderRadius groupRadius = _calculateRadius(
        finalSize,
        isFirst,
        isLast,
      );

      // 2. We "clone" the button and inject the new radius
      Widget modifiedButton = BsButton(
        key: button.key,
        label: button.label,
        onPressed: button.onPressed,
        variant: button.variant,
        size: finalSize,
        isLoading: button.isLoading,
        icon: button.icon,
        fullWidth: button.fullWidth,
        badge: button.badge,
        badgePosition: button.badgePosition,
        customBorderRadius: groupRadius, // Here we override the corners!
      );

      // 3. Simulate CSS "margin-left: -1px"
      // If we place outline buttons next to each other, double 2px borders are otherwise created.
      // We move each button (except the first one) visually by 1px to the left (or top).
      if (i > 0) {
        modifiedButton = Transform.translate(
          offset: vertical ? const Offset(0, -1) : const Offset(-1, 0),
          child: modifiedButton,
        );
      }

      groupedButtons.add(modifiedButton);
    }

    // 4. Render in Row or Column
    return vertical
        ? Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: groupedButtons,
          )
        : Row(mainAxisSize: MainAxisSize.min, children: groupedButtons);
  }

  /// Calculates which corners should remain rounded based on position in group.
  BorderRadius _calculateRadius(BsButtonSize size, bool isFirst, bool isLast) {
    // Get base radius from tokens
    final BorderRadius baseRadius = switch (size) {
      BsButtonSize.sm => BsRadius.sm,
      BsButtonSize.md => BsRadius.md,
      BsButtonSize.lg => BsRadius.lg,
    };

    // We extract the pure radius value (e.g. Radius.circular(6)) from the top left,
    // as we assemble it again for specific sides (left/right/top/bottom).
    final Radius r = baseRadius.topLeft;

    if (vertical) {
      if (isFirst) return BorderRadius.vertical(top: r);
      if (isLast) return BorderRadius.vertical(bottom: r);
    } else {
      if (isFirst) return BorderRadius.horizontal(left: r);
      if (isLast) return BorderRadius.horizontal(right: r);
    }

    // Middle buttons (neither first nor last) are completely square
    return BorderRadius.zero;
  }
}

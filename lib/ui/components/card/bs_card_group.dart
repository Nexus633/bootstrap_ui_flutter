import 'package:flutter/material.dart';
import '../../tokens/spacing.dart';
import 'bs_card.dart';

/// A Bootstrap-style card group component.
///
/// Use card groups to render cards as a single, attached element with equal width and height columns.
class BsCardGroup extends StatelessWidget {
  /// Creates a [BsCardGroup] widget.
  const BsCardGroup({
    super.key,
    required this.children,
    this.vertical = false,
  });

  /// The list of [BsCard] widgets to group together.
  final List<BsCard> children;

  /// Whether the cards should stack vertically.
  ///
  /// Defaults to `false` (cards side-by-side).
  final bool vertical;

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) return const SizedBox.shrink();
    if (children.length == 1) return children.first;

    final List<Widget> groupedCards = [];

    for (int i = 0; i < children.length; i++) {
      final card = children[i];
      final bool isFirst = i == 0;
      final bool isLast = i == children.length - 1;

      // 1. Calculate specific radius for the position in the group
      final BorderRadius groupRadius = _calculateRadius(isFirst, isLast);

      // 2. Clone the card with the new border radius
      Widget modifiedCard = card.copyWith(
        borderRadius: groupRadius,
      );

      // 3. Translate cards by 1px to prevent double borders
      if (i > 0) {
        modifiedCard = Transform.translate(
          offset: vertical ? const Offset(0, -1) : const Offset(-1, 0),
          child: modifiedCard,
        );
      }

      // 4. Wrap with Expanded in horizontal layout for equal width columns
      if (!vertical) {
        modifiedCard = Expanded(child: modifiedCard);
      }

      groupedCards.add(modifiedCard);
    }

    if (vertical) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: groupedCards,
      );
    } else {
      return IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: groupedCards,
        ),
      );
    }
  }

  BorderRadius _calculateRadius(bool isFirst, bool isLast) {
    final Radius r = BsRadius.md.topLeft; // 6.0px standard border radius

    if (vertical) {
      if (isFirst) return BorderRadius.vertical(top: r);
      if (isLast) return BorderRadius.vertical(bottom: r);
    } else {
      if (isFirst) return BorderRadius.horizontal(left: r);
      if (isLast) return BorderRadius.horizontal(right: r);
    }

    return BorderRadius.zero;
  }
}

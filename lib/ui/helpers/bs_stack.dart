import 'package:flutter/material.dart';
import '../tokens/spacing.dart';

/// A Bootstrap-style stack helper (Vertical and Horizontal).
///
/// Stacks provide a streamlined way to lay out components in a vertical
/// or horizontal direction with a consistent gap between items.
///
/// See: <https://getbootstrap.com/docs/5.3/helpers/stacks/>

/// A vertical stack helper.
class BsVStack extends StatelessWidget {
  /// Creates a [BsVStack].
  const BsVStack({
    super.key,
    required this.children,
    this.gap,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.stretch,
    this.mainAxisSize = MainAxisSize.min,
  });

  /// The widgets to stack vertically.
  final List<Widget> children;

  /// The gap between items. Defaults to 0. 
  /// Usually set to one of the [BsSpacing] values.
  final double? gap;

  /// How the children should be placed along the main axis.
  final MainAxisAlignment mainAxisAlignment;

  /// How the children should be placed along the cross axis.
  final CrossAxisAlignment crossAxisAlignment;

  /// How much space the stack should occupy along the main axis.
  final MainAxisSize mainAxisSize;

  @override
  Widget build(BuildContext context) {
    final List<Widget> spacedChildren = [];
    
    for (int i = 0; i < children.length; i++) {
      spacedChildren.add(children[i]);
      if (i < children.length - 1 && gap != null && gap! > 0) {
        spacedChildren.add(SizedBox(height: gap));
      }
    }

    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: spacedChildren,
    );
  }
}

/// A horizontal stack helper.
class BsHStack extends StatelessWidget {
  /// Creates a [BsHStack].
  const BsHStack({
    super.key,
    required this.children,
    this.gap,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.min,
  });

  /// The widgets to stack horizontally.
  final List<Widget> children;

  /// The gap between items. Defaults to 0.
  /// Usually set to one of the [BsSpacing] values.
  final double? gap;

  /// How the children should be placed along the main axis.
  final MainAxisAlignment mainAxisAlignment;

  /// How the children should be placed along the cross axis.
  final CrossAxisAlignment crossAxisAlignment;

  /// How much space the stack should occupy along the main axis.
  final MainAxisSize mainAxisSize;

  @override
  Widget build(BuildContext context) {
    final List<Widget> spacedChildren = [];
    
    for (int i = 0; i < children.length; i++) {
      spacedChildren.add(children[i]);
      if (i < children.length - 1 && gap != null && gap! > 0) {
        spacedChildren.add(SizedBox(width: gap));
      }
    }

    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: spacedChildren,
    );
  }
}

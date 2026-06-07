import 'package:flutter/material.dart';
import '../tokens/bootstrap_theme.dart';

/// A Bootstrap-style vertical rule helper.
///
/// Used to create vertical dividers that inherit their height from their
/// container or context.
///
/// See: <https://getbootstrap.com/docs/5.3/helpers/vertical-rule/>
class BsVerticalRule extends StatelessWidget {
  /// Creates a [BsVerticalRule].
  const BsVerticalRule({
    super.key,
    this.width = 1.0,
    this.color,
  });

  /// The width of the rule. Defaults to 1.0.
  final double width;

  /// The color of the rule. Defaults to the theme's border color.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: color ?? context.bs.border,
      ),
      // To behave like a character in height, we can use a Transparent box 
      // with a minimum height or let it expand.
      child: const SizedBox(height: double.infinity),
    );
  }
}

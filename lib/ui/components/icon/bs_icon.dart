import 'package:flutter/material.dart';
import '../../tokens/bootstrap_theme.dart';
import '../../tokens/bs_icons.dart';
import '../../tokens/enums.dart';

/// A widget that displays a Bootstrap Icon.
///
/// Designed to be used with the icon constants defined in [BsIcons].
///
/// Example:
/// ```dart
/// const BsIcon(
///   BsIcons.alarm,
///   size: 24,
///   variant: BsIconVariant.danger,
/// )
/// ```
class BsIcon extends StatelessWidget {
  /// Creates a [BsIcon].
  const BsIcon(
    this.icon, {
    super.key,
    this.size,
    this.color,
    this.variant,
    this.semanticLabel,
    this.textDirection,
  });

  /// The icon data to display (e.g. from [BsIcons]).
  final IconData icon;

  /// The size of the icon.
  final double? size;

  /// The color of the icon.
  ///
  /// If provided, this overrides the [variant] color.
  final Color? color;

  /// The Bootstrap icon color variant to use.
  ///
  /// If [color] is also provided, [color] takes precedence.
  final BsVariant? variant;

  /// The semantic label for the icon, used for accessibility.
  final String? semanticLabel;

  /// The text direction to use for rendering the icon.
  final TextDirection? textDirection;

  @override
  Widget build(BuildContext context) {
    Color? resolvedColor = color;
    if (resolvedColor == null && variant != null) {
      final bs = context.bs;
      resolvedColor = switch (variant!) {
        .primary => bs.primary,
        .secondary => bs.secondary,
        .success => bs.success,
        .danger => bs.danger,
        .warning => bs.warning,
        .info => bs.info,
        .light => bs.light,
        .dark => bs.dark,
      };
    }

    return Icon(
      icon,
      size: size,
      color: resolvedColor,
      semanticLabel: semanticLabel,
      textDirection: textDirection,
    );
  }
}

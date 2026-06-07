import 'package:flutter/material.dart';
import '../../tokens/bootstrap_theme.dart';
import '../../tokens/enums.dart';
import '../../tokens/typography.dart';
import '../../utilities/spacing_extension.dart';

/// A Bootstrap-compatible heading widget.
///
/// Represents `<h1>` to `<h6>` heading elements, applying Bootstrap's typography
/// standards, such as the default bottom margin of `0.5rem` (8px) and correct line height.
class BsHeading extends StatelessWidget {
  /// Creates a [BsHeading] widget.
  ///
  /// The [text] parameter is required and represents the heading's content.
  /// The [level] defaults to [BsHeadingLevel.h1].
  /// The [removeMargin] parameter removes the default bottom margin if set to `true`.
  const BsHeading(
    this.text, {
    super.key,
    this.level = BsHeadingLevel.h1,
    this.color,
    this.textAlign,
    this.removeMargin = false,
  });

  /// The text content of the heading.
  final String text;

  /// The level of the heading (from [BsHeadingLevel.h1] to [BsHeadingLevel.h6]).
  ///
  /// Determines the font size of the heading based on Bootstrap typography tokens.
  final BsHeadingLevel level;

  /// The color of the heading text.
  ///
  /// If not specified, defaults to the theme's body text color.
  final Color? color;

  /// How the heading text should be aligned horizontally.
  final TextAlign? textAlign;

  /// Whether to remove the default bottom margin (0.5rem / 8px).
  ///
  /// By default, a bottom margin is applied using `pb2()` spacing extension.
  final bool removeMargin;

  @override
  Widget build(BuildContext context) {
    final theme = context.bs;

    final double fontSize = switch (level) {
      BsHeadingLevel.h1 => BsTypography.h1,
      BsHeadingLevel.h2 => BsTypography.h2,
      BsHeadingLevel.h3 => BsTypography.h3,
      BsHeadingLevel.h4 => BsTypography.h4,
      BsHeadingLevel.h5 => BsTypography.h5,
      BsHeadingLevel.h6 => BsTypography.h6,
    };

    final TextStyle style = TextStyle(
      fontSize: fontSize,
      fontWeight: BsTypography.weightHeadings,
      color: color ?? theme.bodyText,
      height: BsTypography.lineHeightHeadings,
    );

    Widget heading = Text(text, style: style, textAlign: textAlign);

    return removeMargin ? heading : heading.pb2();
  }
}

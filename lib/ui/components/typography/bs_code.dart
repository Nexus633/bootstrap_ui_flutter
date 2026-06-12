import 'package:flutter/material.dart';
import '../../tokens/colors.dart';

/// Bootstrap-style `<code>` component for inline code snippets.
///
/// Uses Bootstrap's pink color and a monospaced font.
class BsCode extends StatelessWidget {
  /// Creates a [BsCode] widget.
  const BsCode(
    this.text, {
    super.key,
    this.color,
    this.fontSize,
  });

  /// The code text to display.
  final String text;

  /// Custom color override. Defaults to [BsColors.pink.shade500] (`#d63384`).
  final Color? color;

  /// Custom font size. Defaults to inherited text size (em).
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    // Bootstrap defaults: color #d63384, word-wrap break-word.
    // In Flutter, we use the default pink[500] defined in BsColors.
    final effectiveColor = color ?? BsColors.pink[500];

    return Text(
      text,
      style: TextStyle(
        color: effectiveColor,
        fontFamily: 'monospace',
        fontSize: fontSize ?? (DefaultTextStyle.of(context).style.fontSize != null 
            ? DefaultTextStyle.of(context).style.fontSize! * 0.875 
            : 14.0),
      ),
    );
  }
}

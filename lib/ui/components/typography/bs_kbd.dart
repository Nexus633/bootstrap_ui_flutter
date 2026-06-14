import 'package:flutter/material.dart';
import '../../tokens/bootstrap_theme.dart';
import '../../tokens/colors.dart';

/// Bootstrap-style `<kbd>` component for inline keyboard input text.
class BsKbd extends StatelessWidget {
  /// Creates a [BsKbd] widget.
  const BsKbd(
    this.text, {
    super.key,
  });

  /// The text content, usually a key combination (e.g., 'Ctrl + P').
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<BsThemeData>();
    final bgColor = theme?.dark ?? BsColors.gray[900]!;
    final textColor = theme?.onDark ?? Colors.white;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(3.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontFamily: 'monospace',
          fontSize: (DefaultTextStyle.of(context).style.fontSize != null 
              ? DefaultTextStyle.of(context).style.fontSize! * 0.875 
              : 14.0),
        ),
      ),
    );
  }
}

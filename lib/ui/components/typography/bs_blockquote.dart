import 'package:flutter/material.dart';
import '../../tokens/bootstrap_theme.dart';
import '../../tokens/colors.dart';


/// Bootstrap-style `<blockquote class="blockquote">` component.
class BsBlockquote extends StatelessWidget {
  /// Creates a [BsBlockquote] widget.
  const BsBlockquote({
    super.key,
    required this.child,
    this.footer,
    this.footerAlignment = TextAlign.start,
  });

  /// The main content of the quote. Often a [Text] widget.
  final Widget child;

  /// Optional footer (citation/author). Usually a [Text] widget.
  final Widget? footer;

  /// Alignment of the footer text.
  final TextAlign footerAlignment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<BsThemeData>();
    final mutedColor = theme?.bodyTextSecondary ?? BsColors.gray[600]!;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0), // .mb-3 by default for blockquote
      child: Column(
        crossAxisAlignment: footerAlignment == TextAlign.end 
            ? CrossAxisAlignment.end 
            : (footerAlignment == TextAlign.center ? CrossAxisAlignment.center : CrossAxisAlignment.start),
        children: [
          DefaultTextStyle(
            style: DefaultTextStyle.of(context).style.copyWith(
                  fontSize: 20.0, // 1.25rem
                  fontWeight: FontWeight.w400,
                ),
            child: child,
          ),
          if (footer != null) ...[
            const SizedBox(height: 8.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('— ', style: TextStyle(color: mutedColor, fontSize: 14.0)),
                DefaultTextStyle(
                  style: TextStyle(color: mutedColor, fontSize: 14.0), // .875em
                  child: footer!,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

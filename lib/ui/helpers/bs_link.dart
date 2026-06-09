import 'package:flutter/material.dart';
import '../tokens/bootstrap_theme.dart';

/// A Bootstrap-style link component.
///
/// Links are used for navigation and can be colored with Bootstrap's
/// semantic color variants.
///
/// See: <https://getbootstrap.com/docs/5.3/helpers/colored-links/>
class BsLink extends StatefulWidget {
  /// Creates a [BsLink].
  const BsLink({
    super.key,
    required this.label,
    required this.onPressed,
    this.color,
    this.underline = true,
  });

  /// The label of the link.
  final Widget label;

  /// Callback when the link is pressed.
  final VoidCallback onPressed;

  /// The color of the link. Defaults to the theme's link color.
  final Color? color;

  /// Whether the link should be underlined by default. Defaults to true.
  final bool underline;

  @override
  State<BsLink> createState() => _BsLinkState();
}

class _BsLinkState extends State<BsLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bsTheme = context.bs;
    final baseColor = widget.color ?? bsTheme.linkColor;
    final hoverColor = widget.color != null
        ? widget.color!.withValues(alpha: 0.8)
        : bsTheme.linkHoverColor;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: DefaultTextStyle.merge(
          style: TextStyle(
            color: _isHovered ? hoverColor : baseColor,
            decoration: widget.underline || _isHovered
                ? TextDecoration.underline
                : TextDecoration.none,
            decorationColor: _isHovered ? hoverColor : baseColor,
          ),
          child: widget.label,
        ),
      ),
    );
  }
}

/// A Bootstrap-style icon link component.
///
/// Combines an icon with a text link, often used for "Read more" or
/// action-oriented navigation.
///
/// See: <https://getbootstrap.com/docs/5.3/helpers/icon-link/>
class BsIconLink extends StatelessWidget {
  /// Creates a [BsIconLink].
  const BsIconLink({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.iconAfter = true,
    this.color,
    this.gap = 8.0,
  });

  /// The label of the link.
  final Widget label;

  /// The icon to display.
  final Widget icon;

  /// Callback when the link is pressed.
  final VoidCallback onPressed;

  /// Whether the icon should be displayed after the text. Defaults to true.
  final bool iconAfter;

  /// The color of the link. Defaults to the theme's link color.
  final Color? color;

  /// The gap between the text and the icon. Defaults to 8.0.
  final double gap;

  @override
  Widget build(BuildContext context) {
    return BsLink(
      color: color,
      onPressed: onPressed,
      underline: false,
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!iconAfter) ...[icon, SizedBox(width: gap)],
          label,
          if (iconAfter) ...[SizedBox(width: gap), icon],
        ],
      ),
    );
  }
}

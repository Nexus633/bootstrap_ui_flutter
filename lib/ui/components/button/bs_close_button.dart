import 'package:flutter/material.dart';

/// A Bootstrap-style close button component (`.btn-close`).
///
/// Used for dismissing content like alerts, modals, dropdowns, and cards.
/// Adapts its color to the dark/light theme dynamically, supports disabled states,
/// explicit white/light color overrides, and custom color overrides.
class BsCloseButton extends StatefulWidget {
  /// Creates a [BsCloseButton].
  const BsCloseButton({
    super.key,
    this.onPressed,
    this.disabled = false,
    this.white = false,
    this.color,
    this.size = 16.0,
    this.padding = const EdgeInsets.all(4.0),
  });

  /// Called when the button is tapped.
  final VoidCallback? onPressed;

  /// Whether the button is disabled.
  ///
  /// If true, opacity is reduced and the button ignores taps.
  final bool disabled;

  /// Explicitly forces the button color to be white.
  ///
  /// Useful for placing the close button on dark backgrounds.
  final bool white;

  /// A custom color override for the close icon.
  ///
  /// If provided, overrides the default theme/white color mapping.
  final Color? color;

  /// The size of the close icon.
  ///
  /// Defaults to `16.0` (matching Bootstrap's base close button size).
  final double size;

  /// Padding around the close icon to increase the tap target.
  ///
  /// Defaults to `EdgeInsets.all(4.0)`.
  final EdgeInsetsGeometry padding;

  @override
  State<BsCloseButton> createState() => _BsCloseButtonState();
}

class _BsCloseButtonState extends State<BsCloseButton> {
  bool _isHovered = false;
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    // Resolve base color
    Color baseColor;
    if (widget.color != null) {
      baseColor = widget.color!;
    } else if (widget.white) {
      baseColor = const Color(0xFFFFFFFF);
    } else {
      // Bootstrap close buttons adapt to the theme brightness
      final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
      baseColor = isDarkTheme ? const Color(0xFFFFFFFF) : const Color(0xFF000000);
    }

    // Resolve opacity based on state (Bootstrap standard: 0.5 default, 0.75 hover, 0.25 disabled)
    double opacity = 0.5;
    if (widget.disabled) {
      opacity = 0.25;
    } else if (_isHovered) {
      opacity = 0.75;
    }

    Widget buttonIcon = Opacity(
      opacity: opacity,
      child: Padding(
        padding: widget.padding,
        child: Icon(
          Icons.close_rounded,
          size: widget.size,
          color: baseColor,
        ),
      ),
    );

    if (widget.disabled) {
      return buttonIcon;
    }

    return FocusableActionDetector(
      onShowHoverHighlight: (value) => setState(() => _isHovered = value),
      onShowFocusHighlight: (value) => setState(() => _isFocused = value),
      mouseCursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _isHovered
                ? baseColor.withValues(alpha: 0.08)
                : (_isFocused ? baseColor.withValues(alpha: 0.12) : Colors.transparent),
          ),
          child: buttonIcon,
        ),
      ),
    );
  }
}

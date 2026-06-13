import 'package:flutter/material.dart';
import '../../tokens/bootstrap_theme.dart';
import '../../tokens/colors.dart';
import '../../tokens/spacing.dart';
import '../../tokens/typography.dart';
import '../../tokens/enums.dart';
import '../../tokens/shadows.dart';
import '../../tokens/transitions.dart';
import '../forms/bs_input_group.dart';
import '../spinner/bs_spinner.dart';

// ─── Widget ───────────────────────────────────────────────────────────────────

/// A Bootstrap-style button component.
///
/// Use [BsButton] for actions in forms, dialogs, and more with support for
/// multiple sizes, states, and variants.
///
/// ### Example Usage
///
/// ```dart
/// // Standard Primary Button
/// BsButton(
///   label: 'Submit',
///   onPressed: () => print('Pressed'),
/// )
///
/// // Outline Secondary Button
/// BsButton(
///   label: 'Cancel',
///   variant: BsButtonVariant.secondary,
///   outline: true,
///   onPressed: () => Navigator.pop(context),
/// )
/// ```
class BsButton extends StatefulWidget {
  /// Creates a [BsButton] widget.
  const BsButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = .primary,
    this.size = .md,
    this.isLoading = false,
    this.icon,
    this.iconVariant,
    this.iconColor,
    this.fullWidth = false,
    this.customBorderRadius,
    this.badge,
    this.badgePosition = .trailing,
    this.color,
    this.outline = false,
  });

  /// The text label to display on the button.
  final String label;

  /// Callback when the button is pressed. If null, the button is disabled.
  final VoidCallback? onPressed;

  /// The color variant of the button.
  final BsButtonVariant variant;

  /// The size variant of the button.
  final BsButtonSize size;

  /// Whether the button is in a loading state, showing a progress indicator.
  final bool isLoading;

  /// Optional icon to display alongside the label.
  final IconData? icon;

  /// Specific color for the icon.
  final Color? iconColor;

  /// Variant color for the icon.
  final BsVariant? iconVariant;

  /// Whether the button should take up the full width of its parent.
  final bool fullWidth;

  /// Custom border radius for the button.
  final BorderRadius? customBorderRadius;

  /// Optional badge widget to display on or next to the button.
  final Widget? badge;

  /// Position of the badge relative to the button content.
  final BsBadgePosition badgePosition;

  /// Optional custom background color for the button. Overrides [variant].
  final Color? color;

  /// Whether the button should be rendered as an outline button.
  final bool outline;

  @override
  State<BsButton> createState() => _BsButtonState();
}

class _BsButtonState extends State<BsButton> {
  bool _isPressed = false;
  bool _isHovered = false;
  bool _isFocused = false;

  bool get _isDisabled => widget.onPressed == null || widget.isLoading;

  @override
  Widget build(BuildContext context) {
    // 1. Get theme
    final bsTheme = context.bs;

    // 2. Pass theme to style resolution
    final _ButtonStyle style = _resolveStyle(
      context,
      widget.variant,
      widget.size,
      bsTheme,
    );

    final Color bgColor = _resolveBackgroundColor(style, bsTheme);
    final Color fgColor = _resolveForegroundColor(style, bsTheme);

    Widget buttonWidget = AnimatedContainer(
      duration: BsTransitions.baseDuration,
      width: widget.fullWidth ? double.infinity : null,
      padding: style.padding,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: style.borderRadius,
        border: _resolveBorder(style, bsTheme),
        boxShadow: _isFocused && !_isDisabled
            ? BsShadows.focusRing(style.backgroundColor)
            : (_isPressed && !_isDisabled
                ? BsShadows.inset
                : null),
      ),
      child: _buildContent(style, fgColor),
    );

    // Absolute Badges (corners)
    final bool isAbsoluteBadge =
        widget.badge != null &&
        (widget.badgePosition == .topLeft ||
            widget.badgePosition == .topRight ||
            widget.badgePosition == .bottomLeft ||
            widget.badgePosition == .bottomRight);

    if (isAbsoluteBadge) {
      double? top, bottom, left, right;
      Offset offset = Offset.zero;

      switch (widget.badgePosition) {
        case .topLeft:
          top = 0;
          left = 0;
          offset = const Offset(-0.5, -0.5);
          break;
        case .topRight:
          top = 0;
          right = 0;
          offset = const Offset(0.5, -0.5);
          break;
        case .bottomLeft:
          bottom = 0;
          left = 0;
          offset = const Offset(-0.5, 0.5);
          break;
        case .bottomRight:
          bottom = 0;
          right = 0;
          offset = const Offset(0.5, 0.5);
          break;
        default:
          break;
      }

      buttonWidget = Stack(
        clipBehavior: Clip.none,
        children: [
          buttonWidget,
          Positioned(
            top: top,
            bottom: bottom,
            left: left,
            right: right,
            child: FractionalTranslation(
              translation: offset,
              child: widget.badge!,
            ),
          ),
        ],
      );
    }

    return Semantics(
      button: true,
      enabled: !_isDisabled,
      label: widget.label,
      child: FocusableActionDetector(
        mouseCursor: _isDisabled
            ? SystemMouseCursors.forbidden
            : SystemMouseCursors.click,
        onShowFocusHighlight: (v) => setState(() => _isFocused = v),
        onShowHoverHighlight: (v) {
          if (!_isDisabled) setState(() => _isHovered = v);
        },
        actions: {
          ActivateIntent: CallbackAction<Intent>(
            onInvoke: (_) {
              if (!_isDisabled) {
                widget.onPressed?.call();
              }
              return null;
            },
          ),
        },
        child: GestureDetector(
          onTapDown: _isDisabled
              ? null
              : (_) => setState(() => _isPressed = true),
          onTapUp: _isDisabled
              ? null
              : (_) {
                  setState(() => _isPressed = false);
                  widget.onPressed?.call();
                },
          onTapCancel: () => setState(() => _isPressed = false),
          child: buttonWidget,
        ),
      ),
    );
  }

  // ─── Color Logic ─────────────────────────────────────────────────────────────

  Color _resolveBackgroundColor(_ButtonStyle style, BsThemeData bsTheme) {
    if (_isDisabled) {
      return bsTheme.bodyBgSecondary; // Dynamic disabled background
    }

    if (widget.variant == .link) {
      return Colors.transparent;
    }

    final bool isOutline = widget.color == null && widget.outline && widget.variant != .link;

    if (_isPressed) {
      return isOutline
          ? style.foregroundColor.withValues(alpha: 0.85)
          : _darken(style.backgroundColor, 0.15); // Dynamic active state
    }

    if (_isHovered) {
      return isOutline
          ? style.foregroundColor.withValues(alpha: 0.15)
          : _darken(style.backgroundColor, 0.08); // Dynamic hover state
    }

    return style.backgroundColor;
  }

  Color _resolveForegroundColor(_ButtonStyle style, BsThemeData bsTheme) {
    if (_isDisabled) {
      return bsTheme.bodyTextTertiary; // Dynamic disabled text
    }

    final bool isOutline = widget.color == null && widget.outline && widget.variant != .link;
    if (_isPressed && isOutline) {
      return Colors.white;
    }
    return style.foregroundColor;
  }

  Border? _resolveBorder(_ButtonStyle style, BsThemeData bsTheme) {
    if (style.border == null) return null;

    final Color borderColor = _isDisabled
        ? bsTheme.bodyBgSecondary
        : _isPressed
        ? _darken(style.border!, 0.1)
        : style.border!;

    return Border.all(color: borderColor, width: 1.0);
  }

  Color _darken(Color color, double amount) {
    final hsl = HSLColor.fromColor(color);
    return hsl
        .withLightness((hsl.lightness - amount).clamp(0.0, 1.0))
        .toColor();
  }

  // ─── Content Builder ────────────────────────────────────────────────────────

  Widget _buildContent(_ButtonStyle style, Color textColor) {
    final bool isLink = widget.variant == .link;
    final bool showUnderline =
        isLink && (_isHovered || _isPressed) && !_isDisabled;

    final TextStyle finalTextStyle = style.textStyle.copyWith(
      color: textColor,
      decoration: showUnderline
          ? TextDecoration.underline
          : TextDecoration.none,
      decorationColor: textColor,
    );

    final List<Widget> content = [];

    final bool isLeadingBadge =
        widget.badge != null && widget.badgePosition == .leading;
    final bool isTrailingBadge =
        widget.badge != null &&
        widget.badgePosition == .trailing;

    if (widget.isLoading) {
      content.add(
        const BsSpinner.border(size: .sm),
      );
      if (widget.label.isNotEmpty) {
        content.add(const SizedBox(width: 8));
      }
    } else {
      if (isLeadingBadge) {
        content.add(widget.badge!);
        content.add(const SizedBox(width: 8));
      }

      if (widget.icon != null) {
        // 1. We define a specific color ONLY for the icon.
        // The default fallback is the normal button text color.
        Color resolvedIconColor = textColor;

        if (widget.iconVariant != null && widget.iconColor != null) {
          // If both are specified, you can decide which priority wins.
          debugPrint(
            'Warning: Both iconVariant and iconColor are set. iconVariant will take precedence.',
          );
        }
        // 2. Check priorities (Variant beats Color beats Fallback)
        if (widget.iconVariant != null) {
          resolvedIconColor = _resolveVariantColor(
            widget.iconVariant!,
            context.bs,
          );
        } else if (widget.iconColor != null) {
          resolvedIconColor = widget.iconColor!;
        }

        // 3. Use the new variable for the icon
        content.add(
          Icon(
            widget.icon,
            size: style.textStyle.fontSize,
            color: resolvedIconColor, // <--- Use exclusive icon color here
          ),
        );
        content.add(const SizedBox(width: 6));
      }
    }

    content.add(Text(widget.label, style: finalTextStyle));

    if (isTrailingBadge && !widget.isLoading) {
      content.add(const SizedBox(width: 8));
      content.add(widget.badge!);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: content,
    );
  }

  Color _resolveVariantColor(BsVariant variant, BsThemeData bs) {
    return switch (variant) {
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

  // ─── Style Resolution ───────────────────────────────────────────────────────

  _ButtonStyle _resolveStyle(
    BuildContext context,
    BsButtonVariant variant,
    BsButtonSize size,
    BsThemeData bs,
  ) {
    final groupContext = BsInputGroupChildContext.of(context);
    final BsButtonSize effectiveSize = groupContext != null ? 
      (groupContext.size == .sm ? .sm : 
       (groupContext.size == .lg ? .lg : .md))
      : size;

    final EdgeInsets padding = switch (effectiveSize) {
      .sm => BsSpacing.btnPaddingSm,
      .md => BsSpacing.btnPaddingMd,
      .lg => BsSpacing.btnPaddingLg,
    };
    final TextStyle textStyle = switch (effectiveSize) {
      .sm => BsTypography.btnSm,
      .md => BsTypography.btnMd,
      .lg => BsTypography.btnLg,
    };
    
    final double baseRadius = effectiveSize == .sm ? 4.0 : (effectiveSize == .lg ? 8.0 : 6.0);
    final Radius r = Radius.circular(baseRadius);

    BorderRadius? groupBorderRadius;
    if (groupContext != null) {
      if (groupContext.isFirst && groupContext.isLast) {
        groupBorderRadius = BorderRadius.all(r);
      } else if (groupContext.isFirst) {
        groupBorderRadius = BorderRadius.horizontal(left: r);
      } else if (groupContext.isLast) {
        groupBorderRadius = BorderRadius.horizontal(right: r);
      } else {
        groupBorderRadius = BorderRadius.zero;
      }
    }

    final BorderRadius borderRadius =
        groupBorderRadius ?? widget.customBorderRadius ?? BorderRadius.all(r);

    if (widget.color != null) {
      return _ButtonStyle(
        backgroundColor: widget.color!,
        foregroundColor: widget.color!.computeLuminance() > 0.5 ? Colors.black : Colors.white,
        border: widget.color!,
        padding: padding,
        textStyle: textStyle,
        borderRadius: borderRadius,
      );
    }

    final _ButtonStyle baseStyle = switch (variant) {
      .primary => _ButtonStyle(
        backgroundColor: bs.primary,
        foregroundColor: BsColors.onPrimary,
        border: bs.primary,
        padding: padding,
        textStyle: textStyle,
        borderRadius: borderRadius,
      ),
      .secondary => _ButtonStyle(
        backgroundColor: bs.secondary,
        foregroundColor: BsColors.onSecondary,
        border: bs.secondary,
        padding: padding,
        textStyle: textStyle,
        borderRadius: borderRadius,
      ),
      .success => _ButtonStyle(
        backgroundColor: bs.success,
        foregroundColor: BsColors.onSuccess,
        border: bs.success,
        padding: padding,
        textStyle: textStyle,
        borderRadius: borderRadius,
      ),
      .danger => _ButtonStyle(
        backgroundColor: bs.danger,
        foregroundColor: BsColors.onDanger,
        border: bs.danger,
        padding: padding,
        textStyle: textStyle,
        borderRadius: borderRadius,
      ),
      .warning => _ButtonStyle(
        backgroundColor: bs.warning,
        foregroundColor: BsColors.onWarning,
        border: bs.warning,
        padding: padding,
        textStyle: textStyle,
        borderRadius: borderRadius,
      ),
      .info => _ButtonStyle(
        backgroundColor: bs.info,
        foregroundColor: BsColors.onInfo,
        border: bs.info,
        padding: padding,
        textStyle: textStyle,
        borderRadius: borderRadius,
      ),
      .light => _ButtonStyle(
        backgroundColor: bs.light,
        foregroundColor: bs.onLight,
        border: bs.light,
        padding: padding,
        textStyle: textStyle,
        borderRadius: borderRadius,
      ),
      .dark => _ButtonStyle(
        backgroundColor: bs.dark,
        foregroundColor: bs.onDark,
        border: bs.dark,
        padding: padding,
        textStyle: textStyle,
        borderRadius: borderRadius,
      ),

      // Link remains the same
      .link => _ButtonStyle(
        backgroundColor: Colors.transparent,
        foregroundColor: bs.linkColor,
        padding: padding,
        textStyle: textStyle,
        borderRadius: borderRadius,
      ),
    };

    if (widget.outline && variant != .link && widget.color == null) {
      final Color outlineColor = switch (variant) {
        .dark => bs.bodyText,
        _ => baseStyle.backgroundColor,
      };

      return _ButtonStyle(
        backgroundColor: Colors.transparent,
        foregroundColor: outlineColor,
        border: outlineColor,
        padding: padding,
        textStyle: textStyle,
        borderRadius: borderRadius,
      );
    }

    return baseStyle;
  }
}

class _ButtonStyle {
  const _ButtonStyle({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.padding,
    required this.textStyle,
    required this.borderRadius,
    this.border,
  });
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? border;
  final EdgeInsets padding;
  final TextStyle textStyle;
  final BorderRadius borderRadius;
}

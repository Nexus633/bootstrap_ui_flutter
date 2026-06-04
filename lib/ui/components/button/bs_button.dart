import 'package:flutter/material.dart';
import '../../tokens/bootstrap_theme.dart';
import '../../tokens/colors.dart';
import '../../tokens/spacing.dart';
import '../../tokens/typography.dart';
import '../../tokens/enums.dart'; // WICHTIG: Dein Theme-Import

// ─── Enums ────────────────────────────────────────────────────────────────────

// (Enums moved to tokens/enums.dart)

// ─── Widget ───────────────────────────────────────────────────────────────────

class AppButton extends StatefulWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = BsButtonVariant.primary,
    this.size = BsButtonSize.md,
    this.isLoading = false,
    this.icon,
    this.iconVariant,
    this.iconColor,
    this.fullWidth = false,
    this.customBorderRadius,
    this.badge,
    this.badgePosition = BsBadgePosition.trailing,
  });

  final String label;
  final VoidCallback? onPressed;
  final BsButtonVariant variant;
  final BsButtonSize size;
  final bool isLoading;
  final IconData? icon;
  final Color? iconColor;
  final BsIconVariant? iconVariant;
  final bool fullWidth;
  final BorderRadius? customBorderRadius;
  final Widget? badge;
  final BsBadgePosition badgePosition;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _isPressed = false;
  bool _isHovered = false;

  bool get _isDisabled => widget.onPressed == null || widget.isLoading;

  @override
  Widget build(BuildContext context) {
    // 1. Theme abgreifen
    final bsTheme = context.bs;

    // 2. Theme in die Auflösung der Styles weitergeben
    final _ButtonStyle style = _resolveStyle(
      widget.variant,
      widget.size,
      bsTheme,
    );

    final Color bgColor = _resolveBackgroundColor(style, bsTheme);
    final Color fgColor = _resolveForegroundColor(style, bsTheme);

    Widget buttonWidget = AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      width: widget.fullWidth ? double.infinity : null,
      padding: style.padding,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: style.borderRadius,
        border: _resolveBorder(style, bsTheme),
        boxShadow: _isPressed && !_isDisabled
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 0,
                  spreadRadius: 0,
                  offset: const Offset(0, 2),
                  blurStyle: BlurStyle.inner,
                ),
              ]
            : null,
      ),
      child: _buildContent(style, fgColor),
    );

    // Absolute Badges (Ecken)
    final bool isAbsoluteBadge =
        widget.badge != null &&
        (widget.badgePosition == BsBadgePosition.topLeft ||
            widget.badgePosition == BsBadgePosition.topRight ||
            widget.badgePosition == BsBadgePosition.bottomLeft ||
            widget.badgePosition == BsBadgePosition.bottomRight);

    if (isAbsoluteBadge) {
      double? top, bottom, left, right;
      Offset offset = Offset.zero;

      switch (widget.badgePosition) {
        case BsBadgePosition.topLeft:
          top = 0;
          left = 0;
          offset = const Offset(-0.5, -0.5);
          break;
        case BsBadgePosition.topRight:
          top = 0;
          right = 0;
          offset = const Offset(0.5, -0.5);
          break;
        case BsBadgePosition.bottomLeft:
          bottom = 0;
          left = 0;
          offset = const Offset(-0.5, 0.5);
          break;
        case BsBadgePosition.bottomRight:
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

    return MouseRegion(
      cursor: _isDisabled
          ? SystemMouseCursors.forbidden
          : SystemMouseCursors.click,
      onEnter: (_) {
        if (!_isDisabled) setState(() => _isHovered = true);
      },
      onExit: (_) => setState(() => _isHovered = false),
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
    );
  }

  // ─── Farb-Logik ─────────────────────────────────────────────────────────────

  Color _resolveBackgroundColor(_ButtonStyle style, BsThemeData bsTheme) {
    if (_isDisabled) {
      return bsTheme.bodyBgSecondary; // Dynamischer Disabled-Background
    }

    if (widget.variant == BsButtonVariant.link) {
      return Colors.transparent;
    }

    final bool isOutline = widget.variant.name.startsWith('outline');

    if (_isPressed) {
      return isOutline
          ? style.foregroundColor.withValues(alpha: 0.85)
          : _darken(style.backgroundColor, 0.15); // Dynamischer Active-State
    }

    if (_isHovered) {
      return isOutline
          ? style.foregroundColor.withValues(alpha: 0.15)
          : _darken(style.backgroundColor, 0.08); // Dynamischer Hover-State
    }

    return style.backgroundColor;
  }

  Color _resolveForegroundColor(_ButtonStyle style, BsThemeData bsTheme) {
    if (_isDisabled) {
      return bsTheme.bodyTextTertiary; // Dynamischer Disabled-Text
    }

    final bool isOutline = widget.variant.name.startsWith('outline');
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
    final bool isLink = widget.variant == BsButtonVariant.link;
    final bool showUnderline =
        isLink && (_isHovered || _isPressed) && !_isDisabled;

    final TextStyle finalTextStyle = style.textStyle.copyWith(
      color: textColor,
      decoration: showUnderline
          ? TextDecoration.underline
          : TextDecoration.none,
      decorationColor: textColor,
    );

    List<Widget> content = [];

    final bool isLeadingBadge =
        widget.badge != null && widget.badgePosition == BsBadgePosition.leading;
    final bool isTrailingBadge =
        widget.badge != null &&
        widget.badgePosition == BsBadgePosition.trailing;

    if (widget.isLoading) {
      content.add(
        SizedBox(
          width: style.textStyle.fontSize! * 0.9,
          height: style.textStyle.fontSize! * 0.9,
          child: CircularProgressIndicator(strokeWidth: 2.0, color: textColor),
        ),
      );
      content.add(const SizedBox(width: 8));
    } else {
      if (isLeadingBadge) {
        content.add(widget.badge!);
        content.add(const SizedBox(width: 8));
      }

      if (widget.icon != null) {
        // 1. Wir definieren eine eigene Farbe NUR für das Icon.
        // Der Standard-Fallback ist die normale Textfarbe des Buttons.
        Color resolvedIconColor = textColor;

        if (widget.iconVariant != null && widget.iconColor != null) {
          // Wenn beide angegeben sind, könntest du hier entscheiden, welche Priorität hat. Zum Beispiel:
          debugPrint(
            'Warning: Both iconVariant and iconColor are set. iconVariant will take precedence.',
          );
        }
        // 2. Wir prüfen die Prioritäten (Variant schlägt Color schlägt Fallback)
        if (widget.iconVariant != null) {
          // Angenommen, du hast dir eine Hilfsmethode dafür geschrieben
          resolvedIconColor = _resolveVariantColor(
            widget.iconVariant!,
            context.bs,
          );
        } else if (widget.iconColor != null) {
          resolvedIconColor = widget.iconColor!;
        }

        // 3. Wir nutzen die neue Variable für das Icon
        content.add(
          Icon(
            widget.icon,
            size: style.textStyle.fontSize,
            color:
                resolvedIconColor, // <--- Hier die exklusive Icon-Farbe nutzen
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

  Color _resolveVariantColor(BsIconVariant variant, BsThemeData bs) {
    return switch (variant) {
      BsIconVariant.primary => bs.primary,
      BsIconVariant.secondary => bs.secondary,
      BsIconVariant.success => bs.success,
      BsIconVariant.danger => bs.danger,
      BsIconVariant.warning => bs.warning,
      BsIconVariant.info => bs.info,
      BsIconVariant.light => BsColors.light,
      BsIconVariant.dark => BsColors.dark,
    };
  }

  // ─── Style Resolution ───────────────────────────────────────────────────────

  _ButtonStyle _resolveStyle(
    BsButtonVariant variant,
    BsButtonSize size,
    BsThemeData bs,
  ) {
    final EdgeInsets padding = switch (size) {
      BsButtonSize.sm => BsSpacing.btnPaddingSm,
      BsButtonSize.md => BsSpacing.btnPaddingMd,
      BsButtonSize.lg => BsSpacing.btnPaddingLg,
    };
    final TextStyle textStyle = switch (size) {
      BsButtonSize.sm => BsTypography.btnSm,
      BsButtonSize.md => BsTypography.btnMd,
      BsButtonSize.lg => BsTypography.btnLg,
    };
    final BorderRadius borderRadius =
        widget.customBorderRadius ??
        switch (size) {
          BsButtonSize.sm => BsRadius.sm,
          BsButtonSize.md => BsRadius.md,
          BsButtonSize.lg => BsRadius.lg,
        };

    return switch (variant) {
      BsButtonVariant.primary => _ButtonStyle(
        backgroundColor: bs.primary,
        foregroundColor: BsColors.onPrimary,
        border: bs.primary,
        padding: padding,
        textStyle: textStyle,
        borderRadius: borderRadius,
      ),
      BsButtonVariant.secondary => _ButtonStyle(
        backgroundColor: bs.secondary,
        foregroundColor: BsColors.onSecondary,
        border: bs.secondary,
        padding: padding,
        textStyle: textStyle,
        borderRadius: borderRadius,
      ),
      BsButtonVariant.success => _ButtonStyle(
        backgroundColor: bs.success,
        foregroundColor: BsColors.onSuccess,
        border: bs.success,
        padding: padding,
        textStyle: textStyle,
        borderRadius: borderRadius,
      ),
      BsButtonVariant.danger => _ButtonStyle(
        backgroundColor: bs.danger,
        foregroundColor: BsColors.onDanger,
        border: bs.danger,
        padding: padding,
        textStyle: textStyle,
        borderRadius: borderRadius,
      ),
      BsButtonVariant.warning => _ButtonStyle(
        backgroundColor: bs.warning,
        foregroundColor: BsColors.onWarning,
        border: bs.warning,
        padding: padding,
        textStyle: textStyle,
        borderRadius: borderRadius,
      ),
      BsButtonVariant.info => _ButtonStyle(
        backgroundColor: bs.info,
        foregroundColor: BsColors.onInfo,
        border: bs.info,
        padding: padding,
        textStyle: textStyle,
        borderRadius: borderRadius,
      ),
      BsButtonVariant.light => _ButtonStyle(
        backgroundColor: BsColors.light, // HART codiert, nicht bs.light
        foregroundColor: BsColors.onLight, // Garantiert dunkle Schrift
        border: BsColors.light,
        padding: padding,
        textStyle: textStyle,
        borderRadius: borderRadius,
      ),
      BsButtonVariant.dark => _ButtonStyle(
        backgroundColor: BsColors.dark, // HART codiert, nicht bs.dark
        foregroundColor: BsColors.onDark, // Garantiert weiße Schrift
        border: BsColors.dark,
        padding: padding,
        textStyle: textStyle,
        borderRadius: borderRadius,
      ),
      BsButtonVariant.outlinePrimary => _ButtonStyle(
        backgroundColor: Colors.transparent,
        foregroundColor: bs.primary,
        border: bs.primary,
        padding: padding,
        textStyle: textStyle,
        borderRadius: borderRadius,
      ),
      BsButtonVariant.outlineSecondary => _ButtonStyle(
        backgroundColor: Colors.transparent,
        foregroundColor: bs.secondary,
        border: bs.secondary,
        padding: padding,
        textStyle: textStyle,
        borderRadius: borderRadius,
      ),
      BsButtonVariant.outlineSuccess => _ButtonStyle(
        backgroundColor: Colors.transparent,
        foregroundColor: bs.success,
        border: bs.success,
        padding: padding,
        textStyle: textStyle,
        borderRadius: borderRadius,
      ),
      BsButtonVariant.outlineDanger => _ButtonStyle(
        backgroundColor: Colors.transparent,
        foregroundColor: bs.danger,
        border: bs.danger,
        padding: padding,
        textStyle: textStyle,
        borderRadius: borderRadius,
      ),
      BsButtonVariant.outlineWarning => _ButtonStyle(
        backgroundColor: Colors.transparent,
        foregroundColor: bs.warning,
        border: bs.warning,
        padding: padding,
        textStyle: textStyle,
        borderRadius: borderRadius,
      ),
      BsButtonVariant.outlineInfo => _ButtonStyle(
        backgroundColor: Colors.transparent,
        foregroundColor: bs.info,
        border: bs.info,
        padding: padding,
        textStyle: textStyle,
        borderRadius: borderRadius,
      ),
      BsButtonVariant.outlineDark => _ButtonStyle(
        backgroundColor: Colors.transparent,
        // bs.bodyText ist schwarz im Light Mode und hellgrau im Dark Mode!
        // Perfekt, damit der Button auf dunklen Hintergründen sichtbar wird.
        foregroundColor: bs.bodyText,
        border: bs.bodyText,
        padding: padding,
        textStyle: textStyle,
        borderRadius: borderRadius,
      ),

      // Link bleibt gleich
      BsButtonVariant.link => _ButtonStyle(
        backgroundColor: Colors.transparent,
        foregroundColor: bs.linkColor,
        padding: padding,
        textStyle: textStyle,
        borderRadius: borderRadius,
      ),
    };
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

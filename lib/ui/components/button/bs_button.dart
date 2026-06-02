import 'package:flutter/material.dart';
import '../../tokens/colors.dart';
import '../../tokens/spacing.dart';
import '../../tokens/typography.dart';

// ─── Enums ────────────────────────────────────────────────────────────────────

enum BsButtonVariant {
  primary,
  secondary,
  success,
  danger,
  warning,
  info,
  light,
  dark,
  outlinePrimary,
  outlineSecondary,
  outlineSuccess,
  outlineDanger,
  outlineWarning,
  outlineInfo,
  outlineDark,
  link,
}

enum BsButtonSize { sm, md, lg }

enum BsBadgePosition {
  leading, // Vor dem Text
  trailing, // Hinter dem Text (Standard)
  topLeft, // Absolut: Oben Links
  topRight, // Absolut: Oben Rechts
  bottomLeft, // Absolut: Unten Links
  bottomRight, // Absolut: Unten Rechts
}

// ─── Widget ───────────────────────────────────────────────────────────────────

/// Bootstrap-kompatibler Button mit :hover, :active und disabled States.
///
/// Warum StatefulWidget?
/// Wir müssen _isPressed tracken um die aktive Farbe zu zeigen.
/// StatelessWidget hat keinen internen State → kein pressed-Feedback möglich.
class AppButton extends StatefulWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = BsButtonVariant.primary,
    this.size = BsButtonSize.md,
    this.isLoading = false,
    this.icon,
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
    final _ButtonStyle style = _resolveStyle(widget.variant, widget.size);

    final Color bgColor = _resolveBackgroundColor(style);
    final Color fgColor = _isDisabled
        ? BsColors.disabledText
        : _resolveForegroundColor(style);

    // 1. Wir bauen den eigentlichen Button (AnimatedContainer)
    Widget buttonWidget = AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      width: widget.fullWidth ? double.infinity : null,
      padding: style.padding,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: style.borderRadius,
        border: _resolveBorder(style),
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

    // 2. NEU: Absolute Badges (Ecken) auf den Button legen (Bootstrap "translate-middle")
    final bool isAbsoluteBadge =
        widget.badge != null &&
        (widget.badgePosition == BsBadgePosition.topLeft ||
            widget.badgePosition == BsBadgePosition.topRight ||
            widget.badgePosition == BsBadgePosition.bottomLeft ||
            widget.badgePosition == BsBadgePosition.bottomRight);

    if (isAbsoluteBadge) {
      double? top, bottom, left, right;
      Offset offset = Offset.zero;

      // FractionalTranslation(0.5) verschiebt das Element um exakt 50% seiner eigenen Breite/Höhe.
      // Das ist der 1:1 Ersatz für Bootstraps CSS "translate-middle"
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
        clipBehavior: Clip
            .none, // Wichtig: Erlaubt das Zeichnen über den Button-Rand hinaus!
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

    // 3. Den Interaktions-Wrapper um das fertige Widget legen
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
        child:
            buttonWidget, // Hier nutzen wir unser (evtl. mit Stack gewrapptes) Widget
      ),
    );
  }

  // ─── Farb-Logik ─────────────────────────────────────────────────────────────

  Color _resolveBackgroundColor(_ButtonStyle style) {
    if (_isDisabled) return BsColors.disabledBg;

    if (widget.variant == BsButtonVariant.link) {
      return Colors.transparent;
    }

    final bool isOutline = widget.variant.name.startsWith('outline');

    if (_isPressed) {
      // :active — Outline wird ausgefüllt, Solid wird noch dunkler
      return isOutline
          ? style.hoverColor!.withValues(alpha: 0.85) // Outline: füllt sich
          : _darken(style.hoverColor ?? style.backgroundColor, 0.1);
    }

    if (_isHovered) {
      return isOutline
          ? style.hoverColor!.withValues(alpha: 0.15) // Outline: leicht gefüllt
          : style.hoverColor ?? style.backgroundColor;
    }

    return style.backgroundColor;
  }

  Color _resolveForegroundColor(_ButtonStyle style) {
    final bool isOutline = widget.variant.name.startsWith('outline');

    if (_isPressed && isOutline) {
      // Outline im :active → Text wird weiß (wie Bootstrap)
      return Colors.white;
    }
    return style.foregroundColor;
  }

  Border? _resolveBorder(_ButtonStyle style) {
    if (style.border == null) return null;

    final Color borderColor = _isDisabled
        ? BsColors.disabledText
        : _isPressed
        ? _darken(style.border!, 0.1)
        : style.border!;

    return Border.all(color: borderColor, width: 1.0);
  }

  /// Dimmt eine Farbe um [amount] (0.0–1.0).
  /// Bootstrap's active State ist ~10% dunkler als hover.
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

    // NEU: Inline Leading Badge
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
        content.add(
          Icon(widget.icon, size: style.textStyle.fontSize, color: textColor),
        );
        content.add(const SizedBox(width: 6));
      }
    }

    content.add(Text(widget.label, style: finalTextStyle));

    // NEU: Inline Trailing Badge (deine vorherige Variante)
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

  // ─── Style Resolution ───────────────────────────────────────────────────────

  _ButtonStyle _resolveStyle(BsButtonVariant variant, BsButtonSize size) {
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
        backgroundColor: BsColors.primary,
        foregroundColor: BsColors.onPrimary,
        hoverColor: BsColors.primaryHover,
        padding: padding,
        textStyle: textStyle,
        borderRadius: borderRadius,
      ),
      BsButtonVariant.secondary => _ButtonStyle(
        backgroundColor: BsColors.secondary,
        foregroundColor: BsColors.onSecondary,
        hoverColor: BsColors.secondaryHover,
        padding: padding,
        textStyle: textStyle,
        borderRadius: borderRadius,
      ),
      BsButtonVariant.success => _ButtonStyle(
        backgroundColor: BsColors.success,
        foregroundColor: BsColors.onSuccess,
        hoverColor: BsColors.successHover,
        padding: padding,
        textStyle: textStyle,
        borderRadius: borderRadius,
      ),
      BsButtonVariant.danger => _ButtonStyle(
        backgroundColor: BsColors.danger,
        foregroundColor: BsColors.onDanger,
        hoverColor: BsColors.dangerHover,
        padding: padding,
        textStyle: textStyle,
        borderRadius: borderRadius,
      ),
      BsButtonVariant.warning => _ButtonStyle(
        backgroundColor: BsColors.warning,
        foregroundColor: BsColors.onWarning,
        hoverColor: BsColors.warningHover,
        padding: padding,
        textStyle: textStyle,
        borderRadius: borderRadius,
      ),
      BsButtonVariant.info => _ButtonStyle(
        backgroundColor: BsColors.info,
        foregroundColor: BsColors.onInfo,
        hoverColor: BsColors.infoHover,
        padding: padding,
        textStyle: textStyle,
        borderRadius: borderRadius,
      ),
      BsButtonVariant.light => _ButtonStyle(
        backgroundColor: BsColors.light,
        foregroundColor: BsColors.onLight,
        hoverColor: BsColors.lightHover,
        padding: padding,
        textStyle: textStyle,
        borderRadius: borderRadius,
        border: BsColors.border,
      ),
      BsButtonVariant.dark => _ButtonStyle(
        backgroundColor: BsColors.dark,
        foregroundColor: BsColors.onDark,
        hoverColor: BsColors.darkHover,
        padding: padding,
        textStyle: textStyle,
        borderRadius: borderRadius,
      ),
      BsButtonVariant.outlinePrimary => _ButtonStyle(
        backgroundColor: Colors.transparent,
        foregroundColor: BsColors.primary,
        hoverColor: BsColors.primary,
        border: BsColors.primary,
        padding: padding,
        textStyle: textStyle,
        borderRadius: borderRadius,
      ),
      BsButtonVariant.outlineSecondary => _ButtonStyle(
        backgroundColor: Colors.transparent,
        foregroundColor: BsColors.secondary,
        hoverColor: BsColors.secondary,
        border: BsColors.secondary,
        padding: padding,
        textStyle: textStyle,
        borderRadius: borderRadius,
      ),
      BsButtonVariant.outlineSuccess => _ButtonStyle(
        backgroundColor: Colors.transparent,
        foregroundColor: BsColors.success,
        hoverColor: BsColors.success,
        border: BsColors.success,
        padding: padding,
        textStyle: textStyle,
        borderRadius: borderRadius,
      ),
      BsButtonVariant.outlineDanger => _ButtonStyle(
        backgroundColor: Colors.transparent,
        foregroundColor: BsColors.danger,
        hoverColor: BsColors.danger,
        border: BsColors.danger,
        padding: padding,
        textStyle: textStyle,
        borderRadius: borderRadius,
      ),
      BsButtonVariant.outlineWarning => _ButtonStyle(
        backgroundColor: Colors.transparent,
        foregroundColor: BsColors.warning,
        hoverColor: BsColors.warning,
        border: BsColors.warning,
        padding: padding,
        textStyle: textStyle,
        borderRadius: borderRadius,
      ),
      BsButtonVariant.outlineInfo => _ButtonStyle(
        backgroundColor: Colors.transparent,
        foregroundColor: BsColors.info,
        hoverColor: BsColors.info,
        border: BsColors.info,
        padding: padding,
        textStyle: textStyle,
        borderRadius: borderRadius,
      ),
      BsButtonVariant.outlineDark => _ButtonStyle(
        backgroundColor: Colors.transparent,
        foregroundColor: BsColors.dark,
        hoverColor: BsColors.dark,
        border: BsColors.dark,
        padding: padding,
        textStyle: textStyle,
        borderRadius: borderRadius,
      ),
      BsButtonVariant.link => _ButtonStyle(
        backgroundColor: Colors.transparent,
        foregroundColor: BsColors.primary, // Link-Farbe ist meist Primary
        hoverColor: Colors.transparent,
        padding: padding,
        textStyle: textStyle,
        borderRadius: borderRadius,
      ),
    };
  }
}

// ─── Internes Styling-Modell ──────────────────────────────────────────────────

class _ButtonStyle {
  const _ButtonStyle({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.hoverColor,
    required this.padding,
    required this.textStyle,
    required this.borderRadius,
    this.border,
  });

  final Color backgroundColor;
  final Color foregroundColor;
  final Color? hoverColor;
  final Color? border;
  final EdgeInsets padding;
  final TextStyle textStyle;
  final BorderRadius borderRadius;
}

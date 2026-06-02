import 'package:flutter/material.dart';
import '../../tokens/colors.dart';

enum BsBadgeVariant {
  primary,
  secondary,
  success,
  danger,
  warning,
  info,
  light,
  dark,
}

class BsBadge extends StatelessWidget {
  const BsBadge({
    super.key,
    required this.label,
    this.variant = BsBadgeVariant.primary,
    this.isPill = false,
  });

  /// Der Text, der im Badge angezeigt wird.
  final String label;

  /// Die Farbe des Badges.
  final BsBadgeVariant variant;

  /// Wenn true, wird das Badge wie eine Pille (komplett rund) geformt.
  /// Entspricht Bootstrap's .rounded-pill
  final bool isPill;

  @override
  Widget build(BuildContext context) {
    final _BadgeStyle style = _resolveStyle(variant);

    // Pill-Badges haben bei Bootstrap oft ein minimal breiteres horizontales Padding
    final EdgeInsets padding = isPill
        ? const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0)
        : const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0);

    final BorderRadius radius = isPill
        ? BorderRadius.circular(50.0) // .rounded-pill
        : BorderRadius.circular(
            4.0,
          ); // Standard Radius (an deine Tokens anpassen)

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: style.backgroundColor,
        borderRadius: radius,
        // Optional: Ein ganz leichter Rand für das Light-Badge, damit es sich vom weißen Hintergrund abhebt
        border: variant == BsBadgeVariant.light
            ? Border.all(color: BsColors.border, width: 1.0)
            : null,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: style.textColor,
          fontSize:
              12.0, // Badges sind typischerweise ca. 0.75em der Basisgröße
          fontWeight:
              FontWeight.w700, // Bootstrap Badges sind standardmäßig bold
          height:
              1.0, // Verhindert zusätzliches vertikales Spacing durch Line-Height
        ),
      ),
    );
  }

  // ─── Farb-Logik (Greift auf deine Tokens zurück) ───────────────────────────

  _BadgeStyle _resolveStyle(BsBadgeVariant variant) {
    return switch (variant) {
      BsBadgeVariant.primary => const _BadgeStyle(
        backgroundColor: BsColors.primary,
        textColor: BsColors.onPrimary,
      ),
      BsBadgeVariant.secondary => const _BadgeStyle(
        backgroundColor: BsColors.secondary,
        textColor: BsColors.onSecondary,
      ),
      BsBadgeVariant.success => const _BadgeStyle(
        backgroundColor: BsColors.success,
        textColor: BsColors.onSuccess,
      ),
      BsBadgeVariant.danger => const _BadgeStyle(
        backgroundColor: BsColors.danger,
        textColor: BsColors.onDanger,
      ),
      BsBadgeVariant.warning => const _BadgeStyle(
        backgroundColor: BsColors.warning,
        textColor: BsColors.onWarning,
      ),
      BsBadgeVariant.info => const _BadgeStyle(
        backgroundColor: BsColors.info,
        textColor: BsColors.onInfo,
      ),
      BsBadgeVariant.light => const _BadgeStyle(
        backgroundColor: BsColors.light,
        textColor: BsColors.onLight,
      ),
      BsBadgeVariant.dark => const _BadgeStyle(
        backgroundColor: BsColors.dark,
        textColor: BsColors.onDark,
      ),
    };
  }
}

// ─── Internes Styling-Modell ──────────────────────────────────────────────────
class _BadgeStyle {
  const _BadgeStyle({required this.backgroundColor, required this.textColor});
  final Color backgroundColor;
  final Color textColor;
}

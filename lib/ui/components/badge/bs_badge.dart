import 'package:flutter/material.dart';
import '../../tokens/bootstrap_theme.dart';
import '../../tokens/colors.dart';
import '../../tokens/enums.dart';
import '../../utilities/spacing_extension.dart';

/// A Bootstrap-style badge component.
///
/// Badges are small count and labeling components.
class BsBadge extends StatelessWidget {
  /// Creates a [BsBadge] widget.
  const BsBadge({
    super.key,
    required this.label,
    this.variant = .primary,
    this.isPill = false,
  });

  /// The text label to display inside the badge.
  final String label;

  /// The color variant of the badge.
  final BsVariant variant;

  /// Whether the badge should have a pill-like shape (fully rounded).
  final bool isPill;

  @override
  Widget build(BuildContext context) {
    // 1. Get theme
    final bsTheme = context.bs;

    // 2. Pass the theme to the color logic
    final _BadgeStyle style = _resolveStyle(variant, bsTheme);

    final BorderRadius radius =
        isPill ? BorderRadius.circular(50.0) : BorderRadius.circular(4.0);

    return Container(
      decoration: BoxDecoration(
        color: style.backgroundColor,
        borderRadius: radius,
        // Optional: A light border for the light badge
        border:
            variant == .light
                ? Border.all(color: bsTheme.border, width: 1.0)
                : null,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: style.textColor,
          fontSize: 12.0,
          fontWeight: FontWeight.w700,
          height: 1.0,
        ),
      ).px(isPill ? 10 : 6).py(4),
    );
  }

  // ─── Color Logic ───────────────────────────────────────────────────────────

  _BadgeStyle _resolveStyle(BsVariant variant, BsThemeData bs) {
    return switch (variant) {
      .primary => _BadgeStyle(
        backgroundColor: bs.primary, // Now accesses the Dark/Light Mode value!
        textColor: BsColors.onPrimary,
      ),
      .secondary => _BadgeStyle(
        backgroundColor: bs.secondary,
        textColor: BsColors.onSecondary,
      ),
      .success => _BadgeStyle(
        backgroundColor: bs.success,
        textColor: BsColors.onSuccess,
      ),
      .danger => _BadgeStyle(
        backgroundColor: bs.danger,
        textColor: BsColors.onDanger,
      ),
      .warning => _BadgeStyle(
        backgroundColor: bs.warning,
        textColor: BsColors.onWarning,
      ),
      .info => _BadgeStyle(
        backgroundColor: bs.info,
        textColor: BsColors.onInfo,
      ),
      .light => _BadgeStyle(
        backgroundColor: bs.light,
        textColor: bs.onLight,
      ),
      .dark => _BadgeStyle(
        backgroundColor: bs.dark,
        textColor: bs.onDark,
      ),
    };
  }
}

class _BadgeStyle {
  const _BadgeStyle({required this.backgroundColor, required this.textColor});
  final Color backgroundColor;
  final Color textColor;
}

import 'package:flutter/material.dart';
import '../../tokens/breakpoints.dart';
import '../../tokens/spacing.dart';
import '../../tokens/enums.dart';

// ─── BsContainer ─────────────────────────────────────────────────────────────

/// Bootstrap's .container / .container-fluid in Flutter.
///
/// In Bootstrap zentriert .container den Inhalt horizontal und hat
/// automatische seitliche Padding (--bs-gutter-x: 1.5rem = 24px je Seite).
///
/// Verwendung:
/// ```dart
/// BsContainer(
///   child: BsRow(...),
/// )
///
/// BsContainer.fluid(
///   child: BsRow(...),
/// )
/// ```
class BsContainer extends StatelessWidget {
  const BsContainer({
    super.key,
    required this.child,
    this.type = BsContainerType.fixed,
    this.padding,
  });

  /// Shortcut für .container-fluid
  const BsContainer.fluid({super.key, required this.child, this.padding})
    : type = BsContainerType.fluid;

  final Widget child;
  final BsContainerType type;

  /// Überschreibt das Standard-Padding (default: 24px horizontal = 1.5rem).
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    // LayoutBuilder gibt uns die verfügbare Breite — das ist unser "Viewport".
    return LayoutBuilder(
      builder: (context, constraints) {
        final double availableWidth = constraints.maxWidth;

        // Berechne die max-width je nach Container-Typ und verfügbarer Breite.
        // "fluid" hat keine max-width → double.infinity
        final double maxWidth = _resolveMaxWidth(availableWidth);

        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Padding(
              // Bootstrap: --bs-gutter-x = 1.5rem = 24px (je Seite → 12px)
              // d.h. 12px links + 12px rechts = 24px Gesamtpadding
              padding:
                  padding ??
                  const EdgeInsets.symmetric(horizontal: BsSpacing.s3 * 0.75),
              child: child,
            ),
          ),
        );
      },
    );
  }

  /// Berechnet die maximale Breite analog zu Bootstrap's Container-Logik.
  double _resolveMaxWidth(double availableWidth) {
    switch (type) {
      // .container-fluid → immer volle Breite
      case BsContainerType.fluid:
        return double.infinity;

      // .container → Stufen je nach Viewport-Breite
      case BsContainerType.fixed:
        if (availableWidth >= BsBreakpoints.xxl) {
          return BsBreakpoints.containerXxl;
        }
        if (availableWidth >= BsBreakpoints.xl) {
          return BsBreakpoints.containerXl;
        }
        if (availableWidth >= BsBreakpoints.lg) {
          return BsBreakpoints.containerLg;
        }
        if (availableWidth >= BsBreakpoints.md) {
          return BsBreakpoints.containerMd;
        }
        if (availableWidth >= BsBreakpoints.sm) {
          return BsBreakpoints.containerSm;
        }
        return double.infinity; // xs → fluid

      // .container-sm: fluid bis sm, dann fixed
      case BsContainerType.sm:
        if (availableWidth >= BsBreakpoints.sm) {
          return BsBreakpoints.containerSm;
        }
        return double.infinity;

      case BsContainerType.md:
        if (availableWidth >= BsBreakpoints.md) {
          return BsBreakpoints.containerMd;
        }
        return double.infinity;

      case BsContainerType.lg:
        if (availableWidth >= BsBreakpoints.lg) {
          return BsBreakpoints.containerLg;
        }
        return double.infinity;

      case BsContainerType.xl:
        if (availableWidth >= BsBreakpoints.xl) {
          return BsBreakpoints.containerXl;
        }
        return double.infinity;

      case BsContainerType.xxl:
        if (availableWidth >= BsBreakpoints.xxl) {
          return BsBreakpoints.containerXxl;
        }
        return double.infinity;
    }
  }
}

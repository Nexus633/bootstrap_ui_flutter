import 'package:flutter/material.dart';
import '../../tokens/breakpoints.dart';
import '../../tokens/enums.dart';
import '../../utilities/alignment_extension.dart';
import '../../utilities/spacing_extension.dart';

// ─── BsContainer ─────────────────────────────────────────────────────────────

/// Bootstrap's .container / .container-fluid in Flutter.
///
/// In Bootstrap, .container centers content horizontally and has
/// automatic horizontal padding (--bs-gutter-x: 1.5rem = 24px each side).
class BsContainer extends StatelessWidget {
  /// Creates a [BsContainer] widget.
  const BsContainer({
    super.key,
    required this.child,
    this.type = BsContainerType.fixed,
    this.padding,
  });

  /// Shortcut for .container-fluid.
  /// Creates a container that is always 100% wide.
  const BsContainer.fluid({super.key, required this.child, this.padding})
    : type = BsContainerType.fluid;

  /// The widget to display inside the container.
  final Widget child;

  /// The type of container (fixed, fluid, or responsive breakpoint-specific).
  final BsContainerType type;

  /// Overrides the default padding (default: 24px horizontal = 1.5rem).
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    // LayoutBuilder gives us the available width — this is our "viewport".
    return LayoutBuilder(
      builder: (context, constraints) {
        final double availableWidth = constraints.maxWidth;

        // Calculate the max-width depending on the container type and available width.
        // "fluid" has no max-width → double.infinity
        final double maxWidth = _resolveMaxWidth(availableWidth);

        return ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child:
              padding != null
                  ? child.padding(padding!)
                  : child.px(12),
        ).center();
      },
    );
  }

  /// Calculates the maximum width analogous to Bootstrap's container logic.
  double _resolveMaxWidth(double availableWidth) {
    switch (type) {
      // .container-fluid → always full width
      case BsContainerType.fluid:
        return double.infinity;

      // .container → levels depending on the viewport width
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

      // .container-sm: fluid until sm, then fixed
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

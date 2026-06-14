import 'package:flutter/material.dart';
import '../../tokens/breakpoints.dart';
import '../../tokens/enums.dart';
import '../../tokens/spacing.dart';

// ─── BsOffsetConfig ──────────────────────────────────────────────────────────

/// Defines how many columns to offset a column by — per breakpoint.
///
/// Follows a mobile-first approach where configurations inherit from smaller breakpoints.
class BsOffsetConfig {
  /// Creates a [BsOffsetConfig] with optional offsets for each breakpoint.
  const BsOffsetConfig({
    this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
    this.xxl,
  });

  /// Shortcut: applies the same column offset across all breakpoints.
  const BsOffsetConfig.all(int offset)
      : xs = offset,
        sm = offset,
        md = offset,
        lg = offset,
        xl = offset,
        xxl = offset;

  /// Offset span for extra small screens (< 576px).
  final int? xs;

  /// Offset span for small screens (>= 576px).
  final int? sm;

  /// Offset span for medium screens (>= 768px).
  final int? md;

  /// Offset span for large screens (>= 992px).
  final int? lg;

  /// Offset span for extra large screens (>= 1200px).
  final int? xl;

  /// Offset span for extra extra large screens (>= 1400px).
  final int? xxl;

  /// Resolves the active offset for a given layout width.
  ///
  /// Uses a mobile-first approach where larger matching breakpoints take precedence.
  int resolveFor(double width) {
    int result = xs ?? 0;
    if (width >= BsBreakpoints.sm && sm != null) result = sm!;
    if (width >= BsBreakpoints.md && md != null) result = md!;
    if (width >= BsBreakpoints.lg && lg != null) result = lg!;
    if (width >= BsBreakpoints.xl && xl != null) result = xl!;
    if (width >= BsBreakpoints.xxl && xxl != null) result = xxl!;
    return result;
  }
}

// ─── BsColConfig ──────────────────────────────────────────────────────────────

/// Defines how many of the 12 columns a column occupies — per breakpoint.
///
/// If null for a breakpoint, it inherits from the next smaller configured breakpoint
/// (mobile-first behavior). If all are null, it resolves to auto-width.
class BsColConfig {
  /// Creates a [BsColConfig] with optional spans for each breakpoint.
  const BsColConfig({
    this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
    this.xxl,
  });

  /// Shortcut: applies the same column span across all breakpoints.
  const BsColConfig.all(int span)
      : xs = span,
        sm = span,
        md = span,
        lg = span,
        xl = span,
        xxl = span;

  /// Column span for extra small screens (< 576px).
  final int? xs;

  /// Column span for small screens (>= 576px).
  final int? sm;

  /// Column span for medium screens (>= 768px).
  final int? md;

  /// Column span for large screens (>= 992px).
  final int? lg;

  /// Column span for extra large screens (>= 1200px).
  final int? xl;

  /// Column span for extra extra large screens (>= 1400px).
  final int? xxl;

  /// Resolves the active column span for a given layout width.
  ///
  /// Uses a mobile-first approach where larger matching breakpoints take precedence.
  /// Returns null if no explicit span is configured (indicates auto-width).
  int? resolveFor(double width) {
    int? result = xs;
    if (width >= BsBreakpoints.sm && sm != null) result = sm;
    if (width >= BsBreakpoints.md && md != null) result = md;
    if (width >= BsBreakpoints.lg && lg != null) result = lg;
    if (width >= BsBreakpoints.xl && xl != null) result = xl;
    if (width >= BsBreakpoints.xxl && xxl != null) result = xxl;
    return result;
  }
}

// ─── BsCol ────────────────────────────────────────────────────────────────────

/// A column in the Bootstrap 12-column grid.
///
/// MUST always be placed as a direct child of a [BsRow].
class BsCol extends StatelessWidget {
  /// Creates a [BsCol] widget.
  const BsCol({
    super.key,
    required this.child,
    this.config = const BsColConfig(),
    this.offset = const BsOffsetConfig(),
    this.alignSelf = .auto,
  });

  /// The content of the column.
  final Widget child;

  /// Responsive column span configuration.
  final BsColConfig config;

  /// Responsive offset configuration.
  final BsOffsetConfig offset;

  /// Self-alignment override for this specific column.
  final BsColAlignSelf alignSelf;

  @override
  Widget build(BuildContext context) {
    // BsCol is parsed by BsRow and wrapped dynamically.
    return child;
  }
}

// ─── BsRow ────────────────────────────────────────────────────────────────────

/// Bootstrap's .row layout in Flutter — the heart of the 12-column grid.
///
/// Manages responsive wrapping, columns alignment, and gutters.
class BsRow extends StatelessWidget {
  /// Creates a [BsRow] widget with the given [children].
  const BsRow({
    super.key,
    required this.children,
    this.gutterX = BsSpacing.s3,
    this.gutterY = BsSpacing.s3,
    this.justify = .start,
    this.alignItems = .stretch,
  });

  /// The columns of this row. Must be a list of [BsCol] widgets.
  final List<BsCol> children;

  /// Horizontal space between columns. Defaults to [BsSpacing.s3] (16px).
  final double gutterX;

  /// Vertical space between wrapped rows. Defaults to [BsSpacing.s3] (16px).
  final double gutterY;

  /// Horizontal alignment of columns within the row. Defaults to [BsRowJustify.start].
  final BsRowJustify justify;

  /// Vertical alignment of columns within the row. Defaults to [BsRowAlignItems.start].
  final BsRowAlignItems alignItems;

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) return const SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        final double rowWidth = constraints.maxWidth;
        final bool hasBoundedHeight = constraints.hasBoundedHeight;

        // Step 1: Group columns into physical rows according to 12-column spans and offsets.
        final List<List<BsCol>> physicalRows = _buildRows(rowWidth);

        // Step 2: Render each physical row with spacing.
        // If the parent has bounded height and we only have 1 row, force it to fill the height
        // so that vertical alignment (alignItems, alignSelf) works correctly.
        if (hasBoundedHeight && physicalRows.length == 1) {
          return SizedBox(
            height: constraints.maxHeight,
            child: _buildSingleRow(physicalRows.first, rowWidth, forceMaxHeight: true),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int i = 0; i < physicalRows.length; i++) ...[
              if (i > 0) SizedBox(height: gutterY),
              _buildSingleRow(physicalRows[i], rowWidth, forceMaxHeight: false),
            ],
          ],
        );
      },
    );
  }

  // ─── Row Partitioning ────────────────────────────────────────────────

  List<List<BsCol>> _buildRows(double width) {
    final List<List<BsCol>> rows = [];
    List<BsCol> currentRow = [];
    int currentSpan = 0;

    for (final col in children) {
      final int span = col.config.resolveFor(width) ?? _autoSpan(children.length);
      final int offset = col.offset.resolveFor(width);

      // Wrap to next line if the current item (span + offset) exceeds remaining space.
      if (currentSpan + span + offset > 12 && currentRow.isNotEmpty) {
        rows.add(currentRow);
        currentRow = [];
        currentSpan = 0;
      }

      currentRow.add(col);
      currentSpan += span + offset;
    }

    if (currentRow.isNotEmpty) rows.add(currentRow);
    return rows;
  }

  int _autoSpan(int totalChildren) => (12 / totalChildren).round();

  // ─── Single Row Renderer ─────────────────────────────────────────────

  Widget _buildSingleRow(List<BsCol> cols, double width, {required bool forceMaxHeight}) {
    final List<Widget> lineWidgets = [];
    final bool useFixedGutters = justify == .start ||
        justify == .center ||
        justify == .end;

    for (int i = 0; i < cols.length; i++) {
      final col = cols[i];
      final int? explicitSpan = col.config.resolveFor(width);
      final int offset = col.offset.resolveFor(width);

      // 1. Handle Offset Spacer
      if (offset > 0) {
        if (lineWidgets.isNotEmpty && useFixedGutters) {
          lineWidgets.add(SizedBox(width: gutterX));
        }
        final double offsetW = (offset / 12) * (width + gutterX);
        lineWidgets.add(SizedBox(width: offsetW));
      } else {
        if (lineWidgets.isNotEmpty && useFixedGutters) {
          lineWidgets.add(SizedBox(width: gutterX));
        }
      }

      // Determine effective vertical alignment for this column
      final BsColAlignSelf effectiveAlign = col.alignSelf == .auto
          ? _mapRowAlignToColAlign(alignItems)
          : col.alignSelf;

      Widget colChild = col.child;
      colChild = _wrapWithAlignSelf(colChild, effectiveAlign);

      // 3. Render Column with width
      if (explicitSpan != null) {
        final double colW = (explicitSpan / 12) * (width + gutterX) - gutterX;
        lineWidgets.add(
          SizedBox(
            width: colW.clamp(0.0, double.infinity),
            child: colChild,
          ),
        );
      } else {
        // Auto Column
        lineWidgets.add(
          Expanded(
            child: colChild,
          ),
        );
      }
    }

    final rowWidget = Row(
      mainAxisAlignment: _mapJustify(justify),
      crossAxisAlignment: CrossAxisAlignment.stretch, // Always stretch columns vertically to equal height
      children: lineWidgets,
    );

    if (forceMaxHeight) {
      return rowWidget;
    }

    return IntrinsicHeight(child: rowWidget);
  }

  MainAxisAlignment _mapJustify(BsRowJustify justify) {
    switch (justify) {
      case .start:
        return MainAxisAlignment.start;
      case .center:
        return MainAxisAlignment.center;
      case .end:
        return MainAxisAlignment.end;
      case .between:
        return MainAxisAlignment.spaceBetween;
      case .around:
        return MainAxisAlignment.spaceAround;
    }
  }

  BsColAlignSelf _mapRowAlignToColAlign(BsRowAlignItems align) {
    switch (align) {
      case .start:
        return .start;
      case .center:
        return .center;
      case .end:
        return .end;
      case .stretch:
        return .stretch;
    }
  }

  Widget _wrapWithAlignSelf(Widget child, BsColAlignSelf alignSelf) {
    switch (alignSelf) {
      case .auto:
      case .stretch:
        return child;
      case .start:
        return Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: double.infinity,
            child: child,
          ),
        );
      case .center:
        return Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: double.infinity,
            child: child,
          ),
        );
      case .end:
        return Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: double.infinity,
            child: child,
          ),
        );
    }
  }
}

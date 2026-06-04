import 'package:flutter/material.dart';
import '../../tokens/breakpoints.dart';
import '../../tokens/spacing.dart';

// ─── BsCol Configuration ──────────────────────────────────────────────────────

/// Defines how many of the 12 columns a column occupies — per breakpoint.
/// null = inherits from the smaller breakpoint (Bootstrap behavior: mobile first).
class BsColConfig {
  /// Creates a [BsColConfig] with optional spans for each breakpoint.
  const BsColConfig({
    this.xs, // < 576px  (Standard / mobile)
    this.sm, // >= 576px
    this.md, // >= 768px
    this.lg, // >= 992px
    this.xl, // >= 1200px
    this.xxl, // >= 1400px
  });

  /// Shortcut: same column span on all breakpoints.
  const BsColConfig.all(int span)
    : xs = span,
      sm = span,
      md = span,
      lg = span,
      xl = span,
      xxl = span;

  /// Span for extra small screens (< 576px).
  final int? xs;

  /// Span for small screens (>= 576px).
  final int? sm;

  /// Span for medium screens (>= 768px).
  final int? md;

  /// Span for large screens (>= 992px).
  final int? lg;

  /// Span for extra large screens (>= 1200px).
  final int? xl;

  /// Span for extra extra large screens (>= 1400px).
  final int? xxl;

  /// Returns the active column count for a given width.
  /// Mobile-first: takes the largest matching breakpoint.
  /// Returns null if no configuration is set → "auto" (evenly distributed).
  int? resolveFor(double width) {
    int? result = xs; // Base value (mobile first)
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
/// MUST always be used inside a [BsRow].
class BsCol extends StatelessWidget {
  /// Creates a [BsCol] widget.
  const BsCol({
    super.key,
    required this.child,
    this.config = const BsColConfig(),
  });

  /// The content of the column.
  final Widget child;

  /// Responsive column configuration.
  final BsColConfig config;

  @override
  Widget build(BuildContext context) {
    // BsCol does not render itself directly —
    // BsRow reads the config and wraps in Expanded/SizedBox.
    // Nevertheless, we need a build() since BsCol is a Widget.
    return child;
  }
}

// ─── BsRow ────────────────────────────────────────────────────────────────────

/// Bootstrap's .row in Flutter — the heart of the 12-column grid.
class BsRow extends StatelessWidget {
  /// Creates a [BsRow] widget with the given [children].
  BsRow({
    super.key,
    required this.children,
    this.gutterX = BsSpacing.s3, // Bootstrap g-* default
    this.gutterY = BsSpacing.s3,
  }) : assert(children.isNotEmpty, 'BsRow requires at least one child widget.');

  /// Only [BsCol] widgets are allowed.
  final List<BsCol> children;

  /// Horizontal distance between columns (Bootstrap: gutter-x).
  final double gutterX;

  /// Vertical distance between rows (Bootstrap: gutter-y).
  final double gutterY;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double rowWidth = constraints.maxWidth;

        // ── Step 1: Divide columns into rows ───────────────────────────
        // Bootstrap breaks automatically when col-sum > 12.
        // We replicate the same logic.
        final List<List<BsCol>> rows = _buildRows(rowWidth);

        // ── Step 2: Render rows ─────────────────────────────────────────
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (int rowIndex = 0; rowIndex < rows.length; rowIndex++) ...[
              if (rowIndex > 0) SizedBox(height: gutterY),
              _buildSingleRow(rows[rowIndex], rowWidth),
            ],
          ],
        );
      },
    );
  }

  // ─── Row Division ────────────────────────────────────────────────────

  /// Divides the children into rows — exactly like Bootstrap's flexbox wrapping.
  List<List<BsCol>> _buildRows(double width) {
    final List<List<BsCol>> rows = [];
    List<BsCol> currentRow = [];
    int currentSpan = 0;

    for (final col in children) {
      final int span =
          col.config.resolveFor(width) ?? _autoSpan(children.length);

      // Would this column exceed 12? → new row.
      if (currentSpan + span > 12 && currentRow.isNotEmpty) {
        rows.add(currentRow);
        currentRow = [];
        currentSpan = 0;
      }

      currentRow.add(col);
      currentSpan += span;
    }

    if (currentRow.isNotEmpty) rows.add(currentRow);
    return rows;
  }

  /// Fallback if no config is set: distribute evenly.
  /// Like Bootstrap's .col (without number).
  int _autoSpan(int totalChildren) => (12 / totalChildren).round();

  // ─── Render Single Row ───────────────────────────────────────────────

  Widget _buildSingleRow(List<BsCol> cols, double width) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < cols.length; i++) ...[
          if (i > 0) SizedBox(width: gutterX),
          // Expanded with flex = column count → proportional width
          Expanded(
            flex: cols[i].config.resolveFor(width) ?? _autoSpan(cols.length),
            child: cols[i].child,
          ),
        ],
      ],
    );
  }
}

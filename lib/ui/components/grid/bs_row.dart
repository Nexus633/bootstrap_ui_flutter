import 'package:flutter/material.dart';
import '../../tokens/breakpoints.dart';
import '../../tokens/spacing.dart';

// ─── BsCol Konfiguration ──────────────────────────────────────────────────────

/// Definiert wie viele der 12 Spalten eine Kolonne belegt — pro Breakpoint.
/// null = erbt vom kleineren Breakpoint (Bootstrap-Verhalten: mobile first).
///
/// Beispiel Bootstrap:  class="col-12 col-md-6 col-lg-4"
/// Beispiel Flutter:
/// ```dart
/// BsColConfig(xs: 12, md: 6, lg: 4)
/// ```
class BsColConfig {
  const BsColConfig({
    this.xs, // < 576px  (Standard / mobile)
    this.sm, // >= 576px
    this.md, // >= 768px
    this.lg, // >= 992px
    this.xl, // >= 1200px
    this.xxl, // >= 1400px
  });

  /// Shortcut: gleiche Spaltenanzahl auf allen Breakpoints.
  const BsColConfig.all(int span)
    : xs = span,
      sm = span,
      md = span,
      lg = span,
      xl = span,
      xxl = span;

  final int? xs;
  final int? sm;
  final int? md;
  final int? lg;
  final int? xl;
  final int? xxl;

  /// Gibt die aktive Spaltenanzahl für eine gegebene Breite zurück.
  /// Mobile-first: nimmt den größten passenden Breakpoint.
  /// Gibt null zurück wenn keine Konfiguration gesetzt → "auto" (gleichmäßig verteilt).
  int? resolveFor(double width) {
    int? result = xs; // Basiswert (mobile first)
    if (width >= BsBreakpoints.sm && sm != null) result = sm;
    if (width >= BsBreakpoints.md && md != null) result = md;
    if (width >= BsBreakpoints.lg && lg != null) result = lg;
    if (width >= BsBreakpoints.xl && xl != null) result = xl;
    if (width >= BsBreakpoints.xxl && xxl != null) result = xxl;
    return result;
  }
}

// ─── BsCol ────────────────────────────────────────────────────────────────────

/// Eine Spalte im Bootstrap 12-Spalten-Grid.
///
/// Wird IMMER innerhalb eines BsRow verwendet.
/// Der BsRow liest die [config] aus und berechnet die Breite.
///
/// Verwendung:
/// ```dart
/// BsCol(
///   config: BsColConfig(xs: 12, md: 6, lg: 4),
///   child: Text('Inhalt'),
/// )
/// ```
class BsCol extends StatelessWidget {
  const BsCol({
    super.key,
    required this.child,
    this.config = const BsColConfig(),
  });

  final Widget child;

  /// Responsive Spalten-Konfiguration.
  final BsColConfig config;

  @override
  Widget build(BuildContext context) {
    // BsCol rendert sich selbst nicht direkt —
    // BsRow liest die config und wrапpt in Expanded/SizedBox.
    // Trotzdem brauchen wir ein build() da BsCol ein Widget ist.
    return child;
  }
}

// ─── BsRow ────────────────────────────────────────────────────────────────────

/// Bootstrap's .row in Flutter — das Herzstück des 12-Spalten-Grids.
///
/// BsRow:
/// 1. Misst die verfügbare Breite mit LayoutBuilder
/// 2. Liest die BsColConfig jedes Kindes aus
/// 3. Berechnet flex-Werte (col-Span = flex) oder feste Breiten
/// 4. Bricht in neue Zeilen um wenn Spalten-Summe > 12 (wie Bootstrap)
///
/// Verwendung:
/// ```dart
/// BsRow(
///   gutterX: BsSpacing.s3,   // g-3
///   gutterY: BsSpacing.s3,
///   children: [
///     BsCol(config: BsColConfig(xs: 12, md: 6), child: CardA()),
///     BsCol(config: BsColConfig(xs: 12, md: 6), child: CardB()),
///   ],
/// )
/// ```
class BsRow extends StatelessWidget {
  const BsRow({
    super.key,
    required this.children,
    this.gutterX = BsSpacing.s3, // Bootstrap g-* default
    this.gutterY = BsSpacing.s3,
  }) : assert(children.length > 0, 'BsRow requires at least one child widget.');

  /// Nur BsCol-Widgets erlaubt.
  final List<BsCol> children;

  /// Horizontaler Abstand zwischen Spalten (Bootstrap: gutter-x).
  /// Bootstrap g-3 = 1rem = 16px → je Seite 8px.
  final double gutterX;

  /// Vertikaler Abstand zwischen Zeilen (Bootstrap: gutter-y).
  final double gutterY;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double rowWidth = constraints.maxWidth;

        // ── Schritt 1: Spalten in Zeilen aufteilen ───────────────────────────
        // Bootstrap bricht automatisch um wenn col-Summe > 12.
        // Wir bauen die gleiche Logik nach.
        final List<List<BsCol>> rows = _buildRows(rowWidth);

        // ── Schritt 2: Zeilen rendern ─────────────────────────────────────────
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

  // ─── Zeilen-Aufteilung ────────────────────────────────────────────────────

  /// Teilt die Kinder in Zeilen auf — genau wie Bootstrap's Flexbox-Wrapping.
  List<List<BsCol>> _buildRows(double width) {
    final List<List<BsCol>> rows = [];
    List<BsCol> currentRow = [];
    int currentSpan = 0;

    for (final col in children) {
      final int span =
          col.config.resolveFor(width) ?? _autoSpan(children.length);

      // Würde diese Spalte über 12 hinausgehen? → neue Zeile.
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

  /// Fallback wenn keine config gesetzt: gleichmäßig verteilen.
  /// Wie Bootstrap's .col (ohne Zahl).
  int _autoSpan(int totalChildren) => (12 / totalChildren).round();

  // ─── Einzelne Zeile rendern ───────────────────────────────────────────────

  Widget _buildSingleRow(List<BsCol> cols, double width) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < cols.length; i++) ...[
          if (i > 0) SizedBox(width: gutterX),
          // Expanded mit flex = Spaltenanzahl → proportionale Breite
          Expanded(
            flex: cols[i].config.resolveFor(width) ?? _autoSpan(cols.length),
            child: cols[i].child,
          ),
        ],
      ],
    );
  }
}

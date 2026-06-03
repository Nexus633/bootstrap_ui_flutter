import 'package:bs_flutter_ui/ui/bs_ui.dart';
import 'package:flutter/material.dart';

/// Zeigt das BsContainer + BsRow + BsCol Grid-System.
/// Resize das Fenster um Responsive-Verhalten zu sehen.
class GridShowcase extends StatelessWidget {
  const GridShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    final bs = context.bs;
    return Scaffold(
      backgroundColor: bs.bodyBg,
      appBar: AppBar(
        backgroundColor: bs.bodyBg,
        title: Text('Grid System', style: TextStyle(color: bs.bodyText)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: BsSpacing.s4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── col (auto, gleichmäßig) ─────────────────────────────────────
            _SectionHeader(
              'col (auto)',
              'Alle gleich breit — wie Bootstrap\'s .col',
            ),
            BsContainer(
              child: BsRow(
                children: [
                  BsCol(child: _ColBox('col')),
                  BsCol(child: _ColBox('col')),
                  BsCol(child: _ColBox('col')),
                ],
              ),
            ),

            _divider(context),

            // ── col-6 col-6 ────────────────────────────────────────────────
            _SectionHeader('col-6 / col-6', '12 Spalten geteilt durch 2'),
            BsContainer(
              child: BsRow(
                children: [
                  BsCol(config: BsColConfig.all(6), child: _ColBox('col-6')),
                  BsCol(config: BsColConfig.all(6), child: _ColBox('col-6')),
                ],
              ),
            ),

            _divider(context),

            // ── col-4 col-8 ────────────────────────────────────────────────
            _SectionHeader('col-4 / col-8', 'Sidebar + Hauptbereich'),
            BsContainer(
              child: BsRow(
                children: [
                  BsCol(
                    config: BsColConfig.all(4),
                    child: _ColBox('col-4\nSidebar'),
                  ),
                  BsCol(
                    config: BsColConfig.all(8),
                    child: _ColBox('col-8\nInhalt'),
                  ),
                ],
              ),
            ),

            _divider(context),

            // ── Responsive: col-12 col-md-6 col-lg-4 ───────────────────────
            _SectionHeader(
              'col-12 col-md-6 col-lg-4',
              'Mobile: 1 Spalte → Tablet: 2 → Desktop: 3',
            ),
            BsContainer(
              child: BsRow(
                gutterY: BsSpacing.s2,
                children: List.generate(
                  6,
                  (i) => BsCol(
                    config: const BsColConfig(xs: 12, md: 6, lg: 4),
                    child: _ColBox('col-12\ncol-md-6\ncol-lg-4'),
                  ),
                ),
              ),
            ),

            _divider(context),

            // ── Automatischer Umbruch > 12 ──────────────────────────────────
            _SectionHeader(
              'Automatischer Umbruch',
              'col-8 + col-6 → zweite Zeile weil 8+6 > 12',
            ),
            BsContainer(
              child: BsRow(
                children: [
                  BsCol(config: BsColConfig.all(8), child: _ColBox('col-8')),
                  BsCol(
                    config: BsColConfig.all(6),
                    child: _ColBox('col-6\n→ neue Zeile'),
                  ),
                ],
              ),
            ),

            _divider(context),

            // ── Container Fluid ─────────────────────────────────────────────
            _SectionHeader(
              'container-fluid',
              'Immer volle Breite — kein max-width',
            ),
            BsContainer.fluid(
              child: BsRow(
                children: [
                  BsCol(
                    config: BsColConfig.all(3),
                    child: _ColBox('col-3', fluid: true),
                  ),
                  BsCol(
                    config: BsColConfig.all(3),
                    child: _ColBox('col-3', fluid: true),
                  ),
                  BsCol(
                    config: BsColConfig.all(3),
                    child: _ColBox('col-3', fluid: true),
                  ),
                  BsCol(
                    config: BsColConfig.all(3),
                    child: _ColBox('col-3', fluid: true),
                  ),
                ],
              ),
            ),

            _divider(context),

            // ── Gutter Varianten ────────────────────────────────────────────
            _SectionHeader(
              'Gutter (g-*)',
              'g-1 = 4px, g-3 = 16px (default), g-5 = 48px',
            ),
            BsContainer(
              child: Column(
                children: [
                  Text('g-1 (4px)', style: _labelStyle(context)),
                  const SizedBox(height: BsSpacing.s1),
                  BsRow(
                    gutterX: BsSpacing.s1,
                    gutterY: BsSpacing.s1,
                    children: [
                      BsCol(
                        config: BsColConfig.all(4),
                        child: _ColBox('col-4'),
                      ),
                      BsCol(
                        config: BsColConfig.all(4),
                        child: _ColBox('col-4'),
                      ),
                      BsCol(
                        config: BsColConfig.all(4),
                        child: _ColBox('col-4'),
                      ),
                    ],
                  ),
                  const SizedBox(height: BsSpacing.s3),
                  Text('g-3 / default (16px)', style: _labelStyle(context)),
                  const SizedBox(height: BsSpacing.s1),
                  BsRow(
                    // gutterX: BsSpacing.s3,
                    // gutterY: BsSpacing.s3,
                    children: [
                      BsCol(
                        config: BsColConfig.all(4),
                        child: _ColBox('col-4'),
                      ),
                      BsCol(
                        config: BsColConfig.all(4),
                        child: _ColBox('col-4'),
                      ),
                      BsCol(
                        config: BsColConfig.all(4),
                        child: _ColBox('col-4'),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: BsSpacing.s5),
          ],
        ),
      ),
    );
  }

  Widget _divider(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(vertical: BsSpacing.s4),
    child: Divider(color: context.bs.border),
  );

  TextStyle _labelStyle(BuildContext context) => BsTypography.body.copyWith(
    fontSize: BsTypography.fontSizeSm,
    color: context.bs.bodyTextSecondary,
  );
}

// ─── Section Header ───────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title, this.description);
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        BsSpacing.s3,
        0,
        BsSpacing.s3,
        BsSpacing.s2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: BsTypography.body.copyWith(
              fontSize: BsTypography.h5,
              fontWeight: BsTypography.weightBold,
            ),
          ),
          Text(
            description,
            style: BsTypography.body.copyWith(
              fontSize: BsTypography.fontSizeSm,
              color: context.bs.bodyTextSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Demo Box ─────────────────────────────────────────────────────────────────

/// Visualisiert eine Spalte — wie Bootstrap's blaue Demo-Boxes in der Doku.
class _ColBox extends StatelessWidget {
  const _ColBox(this.label, {this.fluid = false});
  final String label;
  final bool fluid;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: BsSpacing.s2,
        horizontal: BsSpacing.s1,
      ),
      decoration: BoxDecoration(
        color: fluid
            ? BsColors.success.withValues(alpha: 0.15)
            : BsColors.primary.withValues(alpha: 0.15),
        border: Border.all(
          color: fluid ? BsColors.success : BsColors.primary,
          width: 1,
        ),
        borderRadius: BsRadius.md,
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: BsTypography.body.copyWith(
          fontSize: BsTypography.fontSizeSm,
          color: fluid ? BsColors.success : BsColors.primary,
          fontWeight: BsTypography.weightMedium,
        ),
      ),
    );
  }
}

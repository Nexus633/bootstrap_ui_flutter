import 'package:flutter/material.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

class GridShowcase extends StatelessWidget {
  const GridShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.bs;

    return SingleChildScrollView(
      child: BsContainer.fluid(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card with beautiful Gradient
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [theme.primary, theme.info],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: theme.primary.withValues(alpha: 0.25),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Grid System',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ).pb2(),
                  Text(
                    'Use our powerful mobile-first flexbox grid to build layouts of all shapes and sizes thanks to a twelve-column system, six default responsive tiers, and Sass variables.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: 0.9),
                      height: 1.4,
                    ),
                  ),
                ],
              ).p4(),
            ).mb(32),

            // 1. Equal Width Columns
            _Section(
              title: 'Equal-Width Columns (col)',
              description: 'Columns share the available width equally, automatically wrapping if necessary.',
              child: BsRow(
                children: [
                  BsCol(child: const _ColBox('col-auto')),
                  BsCol(child: const _ColBox('col-auto')),
                  BsCol(child: const _ColBox('col-auto')),
                ],
              ),
            ),

            // 2. Fixed Width / 12 Column
            _Section(
              title: 'Explicit Widths (col-6 / col-4 / col-8)',
              description: 'Assign explicit column spans from 1 to 12. Columns will wrap if total span exceeds 12.',
              child: Column(
                children: [
                  BsRow(
                    children: [
                      BsCol(config: BsColConfig.all(6), child: const _ColBox('col-6')),
                      BsCol(config: BsColConfig.all(6), child: const _ColBox('col-6')),
                    ],
                  ).pb3(),
                  BsRow(
                    children: [
                      BsCol(config: BsColConfig.all(4), child: const _ColBox('col-4')),
                      BsCol(config: BsColConfig.all(8), child: const _ColBox('col-8')),
                    ],
                  ),
                ],
              ),
            ),

            // 3. Responsive Tiers
            _Section(
              title: 'Responsive Layout (col-12 col-md-6 col-lg-4)',
              description: 'Resize the app window to watch columns scale and wrap reactively (Mobile: 12 → Tablet: 6 → Desktop: 4).',
              child: BsRow(
                gutterY: BsSpacing.s2,
                children: List.generate(
                  6,
                  (i) => BsCol(
                    config: const BsColConfig(xs: 12, md: 6, lg: 4),
                    child: _ColBox('Card #${i + 1}\n(xs: 12, md: 6, lg: 4)'),
                  ),
                ),
              ),
            ),

            // 4. Offsets
            _Section(
              title: 'Offsets',
              description: 'Move columns to the right using offset configuration spans.',
              child: Column(
                children: [
                  BsRow(
                    children: const [
                      BsCol(
                        config: BsColConfig.all(4),
                        child: _ColBox('col-4'),
                      ),
                      BsCol(
                        config: BsColConfig.all(4),
                        offset: BsOffsetConfig.all(4),
                        child: _ColBox('col-4 offset-4'),
                      ),
                    ],
                  ).pb3(),
                  BsRow(
                    children: const [
                      BsCol(
                        config: BsColConfig.all(3),
                        offset: BsOffsetConfig.all(3),
                        child: _ColBox('col-3 offset-3'),
                      ),
                      BsCol(
                        config: BsColConfig.all(3),
                        offset: BsOffsetConfig.all(3),
                        child: _ColBox('col-3 offset-3'),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 5. Alignment
            _Section(
              title: 'Alignment & Justify',
              description: 'Support for vertical alignment (align-items, align-self) and horizontal alignment (justify-content).',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('justify: center (Horizontal):').fwBold().fs6().pb2(),
                  const BsRow(
                    justify: BsRowJustify.center,
                    children: [
                      BsCol(config: BsColConfig.all(4), child: _ColBox('col-4')),
                      BsCol(config: BsColConfig.all(4), child: _ColBox('col-4')),
                    ],
                  ).pb4(),

                  const Text('alignItems: center (Vertical):').fwBold().fs6().pb2(),
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: theme.border),
                      borderRadius: BorderRadius.circular(8),
                      color: theme.bodyBgSecondary,
                    ),
                    child: const BsRow(
                      alignItems: BsRowAlignItems.center,
                      children: [
                        BsCol(config: BsColConfig.all(4), child: _ColBox('col-4', highlighted: true)),
                        BsCol(config: BsColConfig.all(4), child: _ColBox('col-4', highlighted: true)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, this.description, required this.child});

  final String title;
  final String? description;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, letterSpacing: -0.5),
        ).pb(4),
        if (description != null) Text(description!).pb(16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: context.bs.bodyBg,
            border: Border.all(color: context.bs.border),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: child,
        ).pb(32),
      ],
    );
  }
}

class _ColBox extends StatelessWidget {
  const _ColBox(this.label, {this.highlighted = false});
  final String label;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final theme = context.bs;
    final primaryColor = highlighted ? theme.success : theme.primary;

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: primaryColor.withValues(alpha: 0.1),
        border: Border.all(
          color: primaryColor,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            color: primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

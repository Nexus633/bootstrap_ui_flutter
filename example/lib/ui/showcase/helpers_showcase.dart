import 'package:flutter/material.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

class HelpersShowcase extends StatelessWidget {
  const HelpersShowcase({super.key});

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
                    'Helpers',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ).pb2(),
                  Text(
                    'Bootstrap-inspired helper classes and widgets. Includes Stacks (vstack, hhstack), Text Truncation, Ratio blocks, and styled icon links.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: 0.9),
                      height: 1.4,
                    ),
                  ),
                ],
              ).p4(),
            ).mb(32),

            // 1. Stacks
            _Section(
              title: 'Stacks (Vertical & Horizontal)',
              description: 'Stacks provide a streamlined layout system for arranging items with unified spacing gaps.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Vertical Stack (vstack) with gap:').fwBold().fs6().pb2(),
                  BsVStack(
                    gap: 12,
                    children: [
                      Container(
                        height: 40,
                        color: theme.bodyBgSecondary,
                        child: const Center(child: Text('Stack Item 1')),
                      ),
                      Container(
                        height: 40,
                        color: theme.bodyBgSecondary,
                        child: const Center(child: Text('Stack Item 2')),
                      ),
                    ],
                  ).pb4(),

                  const Text('Horizontal Stack (hstack) with gap:').fwBold().fs6().pb2(),
                  BsHStack(
                    gap: 16,
                    children: [
                      Container(
                        width: 80,
                        height: 40,
                        color: theme.bodyBgSecondary,
                        child: const Center(child: Text('Col 1')),
                      ),
                      Container(
                        width: 80,
                        height: 40,
                        color: theme.bodyBgSecondary,
                        child: const Center(child: Text('Col 2')),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 2. Text Truncate
            _Section(
              title: 'Text Truncate',
              description: 'Easily truncate long text with an ellipsis (...) overflow indicator.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 240,
                    child: const Text(
                      'This is a very long text that will be truncated because we are using the .truncate() extension method on the Text widget.',
                    ).truncate(),
                  ),
                ],
              ),
            ),

            // 3. Vertical Rule
            _Section(
              title: 'Vertical Rule',
              description: 'Use the vertical rule helper (vr) to separate horizontal content blocks.',
              child: IntrinsicHeight(
                child: BsHStack(
                  gap: 16,
                  children: const [
                    Expanded(child: Text('Left side content block')),
                    BsVerticalRule(),
                    Expanded(child: Text('Right side content block')),
                  ],
                ),
              ),
            ),

            // 4. Ratio
            _Section(
              title: 'Aspect Ratios',
              description: 'Enforce specific aspect ratio dimensions for items like images or maps.',
              child: BsRow(
                gutterX: BsSpacing.s3,
                gutterY: BsSpacing.s3,
                children: [
                  BsCol(
                    config: const BsColConfig(md: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('16:9 Ratio:').fwBold().fs6().pb2(),
                        BsRatio(
                          type: BsRatioType.ratio16x9,
                          child: Container(
                            color: theme.bodyBgSecondary,
                            child: const Center(
                              child: BsIcon(BsIcons.image, size: 48, color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  BsCol(
                    config: const BsColConfig(md: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('1:1 Square Ratio:').fwBold().fs6().pb2(),
                        BsRatio(
                          type: BsRatioType.ratio1x1,
                          child: Container(
                            color: theme.bodyBgSecondary,
                            child: const Center(
                              child: BsIcon(BsIcons.image, size: 48, color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 5. Links
            _Section(
              title: 'Colored & Icon Links',
              description: 'Styled hyper-links with active presets and inline icons.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 20,
                    runSpacing: 12,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      BsLink(
                        label: const Text('Primary Link'),
                        onPressed: () {},
                      ),
                      BsLink(
                        label: const Text('Danger Link'),
                        color: theme.danger,
                        onPressed: () {},
                      ),
                      BsLink(
                        label: const Text('No Underline Link'),
                        underline: false,
                        onPressed: () {},
                      ),
                      BsIconLink(
                        label: const Text('Icon link after'),
                        icon: const BsIcon(BsIcons.arrowRight, size: 16),
                        onPressed: () {},
                      ),
                      BsIconLink(
                        label: const Text('Icon link before'),
                        icon: const BsIcon(BsIcons.download, size: 16),
                        iconAfter: false,
                        onPressed: () {},
                      ),
                    ],
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

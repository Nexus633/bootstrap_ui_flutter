import 'package:flutter/material.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

class UtilitiesShowcase extends StatelessWidget {
  const UtilitiesShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BsContainer.fluid(
        child: BsVStack(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Utilities',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ).pb(16),
            const Text(
              'Utility classes for common layout, spacing, and styling tasks.',
            ).pb(24),

            // Spacing
            _Section(
              title: 'Spacing',
              description:
                  'Padding (p*) and Margin (m*) utilities with levels 1-5.',
              child: BsVStack(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Padding levels:').pb(8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Container(
                        color: Colors.blue[100],
                        child: const Text(
                          'p1',
                          style: TextStyle(color: Colors.black),
                        ),
                      ).p1(),
                      Container(
                        color: Colors.blue[100],
                        child: const Text(
                          'p2',
                          style: TextStyle(color: Colors.black),
                        ),
                      ).p2(),
                      Container(
                        color: Colors.blue[100],
                        child: const Text(
                          'p3',
                          style: TextStyle(color: Colors.black),
                        ),
                      ).p3(),
                      Container(
                        color: Colors.blue[100],
                        child: const Text(
                          'p4',
                          style: TextStyle(color: Colors.black),
                        ),
                      ).p4(),
                      Container(
                        color: Colors.blue[100],
                        child: const Text(
                          'p5',
                          style: TextStyle(color: Colors.black),
                        ),
                      ).p5(),
                    ],
                  ).mb(16),
                  const Text('Margin levels (visualized with borders):').pb(8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red),
                        ),
                        child: const Text('m1'),
                      ).m1(),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red),
                        ),
                        child: const Text('m2'),
                      ).m2(),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red),
                        ),
                        child: const Text('m3'),
                      ).m3(),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red),
                        ),
                        child: const Text('m4'),
                      ).m4(),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red),
                        ),
                        child: const Text('m5'),
                      ).m5(),
                    ],
                  ),
                ],
              ),
            ),

            // Sizing
            _Section(
              title: 'Sizing',
              description: 'Width and height utilities (w-*, h-*, mw-*, mh-*).',
              child: BsVStack(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Width 50% vs 100% of parent:').pb(8),
                  Container(
                    width: double.infinity,
                    color: Colors.grey[200],
                    child: Stack(
                      children: [
                        Container(
                          color: Colors.green[200],
                          child: const Center(
                            child: Text(
                              'w50',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ).w50(),
                      ],
                    ),
                  ).h(100).pb(16),
                  const Text('Height 50px fixed:').pb(8),
                  Container(
                    color: Colors.orange[200],
                    child: const Center(
                      child: Text(
                        'h(50)',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ).h(50),
                ],
              ),
            ),

            // Alignment
            _Section(
              title: 'Alignment',
              description: 'Positioning and alignment utilities.',
              child: BsVStack(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Center:').pb(8),
                  Container(
                    height: 60,
                    width: double.infinity,
                    color: Colors.grey[200],
                    child: const Text(
                      'Centered Text',
                      style: TextStyle(color: Colors.black),
                    ).center(),
                  ).pb(16),
                  const Text('Align Start/End:').pb(8),
                  BsRow(
                    children: [
                      BsCol(
                        config: const BsColConfig.all(6),
                        child: const Text('Start').alignStart(),
                      ),
                      BsCol(
                        config: const BsColConfig.all(6),
                        child: const Text('End').alignEnd(),
                      ),
                    ],
                  ),
                  const Text(
                    'Vertical Align (Inline in RichText):',
                  ).pt(16).pb(8),
                  Text.rich(
                    TextSpan(
                      style: TextStyle(
                        color: context.bs.bodyText,
                        fontSize: 16,
                      ),
                      children: [
                        const TextSpan(text: 'baseline: '),
                        Container(
                          width: 12,
                          height: 12,
                          color: Colors.blue,
                        ).alignBaseline(),
                        const TextSpan(text: ' | top: '),
                        Container(
                          width: 12,
                          height: 12,
                          color: Colors.green,
                        ).alignTopInline(),
                        const TextSpan(text: ' | middle: '),
                        Container(
                          width: 12,
                          height: 12,
                          color: Colors.red,
                        ).alignMiddle(),
                        const TextSpan(text: ' | bottom: '),
                        Container(
                          width: 12,
                          height: 12,
                          color: Colors.orange,
                        ).alignBottomInline(),
                        const TextSpan(text: ' | text-top: '),
                        Container(
                          width: 12,
                          height: 12,
                          color: Colors.purple,
                        ).alignTextTop(),
                        const TextSpan(text: ' | text-bottom: '),
                        Container(
                          width: 12,
                          height: 12,
                          color: Colors.teal,
                        ).alignTextBottom(),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Display
            _Section(
              title: 'Display',
              description: 'Visibility utilities.',
              child: BsVStack(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'The following text is hidden using .dNone():',
                  ).pb(8),
                  const Text('You cannot see me!').dNone(),
                  const Text(
                    '(There is a hidden text widget between these lines)',
                  ).pt(4),
                ],
              ),
            ),

            // Text Utilities
            _Section(
              title: 'Text Utilities',
              description:
                  'Font size, font weight, style, line height, alignment, and decoration utilities.',
              child: BsVStack(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Font Sizes (fs-1 to fs-6):').pb(8),
                  BsVStack(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Font Size 1 (40px)').fs1().pb(4),
                      const Text('Font Size 2 (32px)').fs2().pb(4),
                      const Text('Font Size 3 (28px)').fs3().pb(4),
                      const Text('Font Size 4 (24px)').fs4().pb(4),
                      const Text('Font Size 5 (20px)').fs5().pb(4),
                      const Text('Font Size 6 (16px)').fs6().pb(16),
                    ],
                  ),
                  const Text('Font Weights:').pb(8),
                  Wrap(
                    spacing: 16,
                    runSpacing: 8,
                    children: [
                      const Text('Light (300)').fwLight(),
                      const Text('Normal (400)').fwNormal(),
                      const Text('Medium (500)').fwMedium(),
                      const Text('Semibold (600)').fwSemibold(),
                      const Text('Bold (700)').fwBold(),
                      const Text('Bolder (800)').fwBolder(),
                    ],
                  ).pb(16),
                  const Text('Font Styles & Decorations:').pb(8),
                  Wrap(
                    spacing: 16,
                    runSpacing: 8,
                    children: [
                      const Text('Italic text').fstItalic(),
                      const Text('Underlined text').textDecorationUnderline(),
                      const Text(
                        'Line-through text',
                      ).textDecorationLineThrough(),
                    ],
                  ).pb(16),
                  const Text('Line Heights:').pb(8),
                  BsVStack(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'lh-1: Tight line height (1.0). Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                      ).lh1().pb(8),
                      const Text(
                        'lh-sm: Small line height (1.25). Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                      ).lhSm().pb(8),
                      const Text(
                        'lh-base: Base line height (1.5). Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                      ).lhBase().pb(8),
                      const Text(
                        'lh-lg: Large line height (2.0). Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                      ).lhLg().pb(16),
                    ],
                  ),
                  const Text('Text Alignment:').pb(8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: context.bs.bodyBg,
                      border: Border.all(color: context.bs.border),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: BsVStack(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text('Text Start').textStart().pb(4),
                        const Text('Text Center').textCenter().pb(4),
                        const Text('Text End').textEnd(),
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
    return BsVStack(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ).pb(8),
        if (description != null) Text(description!).pb(16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: context.bs.border),
            borderRadius: BorderRadius.circular(8),
          ),
          child: child,
        ).pb(32),
      ],
    );
  }
}

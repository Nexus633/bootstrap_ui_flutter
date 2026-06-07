import 'package:flutter/material.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

class HelpersShowcase extends StatelessWidget {
  const HelpersShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BsContainer.fluid(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Helpers',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ).pb(16),
            const Text(
              'Bootstrap-inspired helper classes and widgets to speed up development and maintain consistency.',
            ).pb(24),

            // Stacks
            _Section(
              title: 'Stacks (Vertical & Horizontal)',
              description:
                  'Stacks provide a streamlined way to lay out components with a consistent gap.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Vertical Stack (vstack) with gap:').pb(8),
                  BsVStack(
                    gap: 16,
                    children: [
                      Container(
                        height: 40,
                        color: Colors.blue[100],
                        child: const Center(child: Text('Item 1')),
                      ),
                      Container(
                        height: 40,
                        color: Colors.blue[200],
                        child: const Center(child: Text('Item 2')),
                      ),
                      Container(
                        height: 40,
                        color: Colors.blue[300],
                        child: const Center(child: Text('Item 3')),
                      ),
                    ],
                  ).pb(24),

                  const Text('Horizontal Stack (hstack) with gap:').pb(8),
                  BsHStack(
                    gap: 16,
                    children: [
                      Container(
                        width: 80,
                        height: 40,
                        color: Colors.green[100],
                        child: const Center(child: Text('1')),
                      ),
                      Container(
                        width: 80,
                        height: 40,
                        color: Colors.green[200],
                        child: const Center(child: Text('2')),
                      ),
                      Container(
                        width: 80,
                        height: 40,
                        color: Colors.green[300],
                        child: const Center(child: Text('3')),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Text Truncate
            _Section(
              title: 'Text Truncate',
              description: 'Easily truncate long text with an ellipsis. Requires a constrained width.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 200,
                    child: const Text(
                      'This is a very long text that will be truncated because we are using the .truncate() extension method on the Text widget.',
                    ).truncate(),
                  ),
                ],
              ),
            ),

            // Vertical Rule
            _Section(
              title: 'Vertical Rule',
              description:
                  'Use the vertical rule helper to create vertical dividers.',
              child: IntrinsicHeight(
                child: BsHStack(
                  gap: 16,
                  children: [
                    const Text('Left side'),
                    const BsVerticalRule(),
                    const Text('Right side'),
                  ],
                ),
              ),
            ),

            // Ratio
            _Section(
              title: 'Ratio',
              description: 'Manage aspect ratios of content.',
              child: BsRow(
                children: [
                  BsCol(
                    config: const BsColConfig(md: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('16:9 Ratio:').pb(8),
                        BsRatio(
                          type: BsRatioType.ratio16x9,
                          child: Container(
                            color: Colors.grey[300],
                            child: const Center(
                              child: Icon(Icons.image, size: 48),
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
                        const Text('1:1 Ratio:').pb(8),
                        BsRatio(
                          type: BsRatioType.ratio1x1,
                          child: Container(
                            color: Colors.grey[300],
                            child: const Center(
                              child: Icon(Icons.image, size: 48),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Links
            _Section(
              title: 'Colored Links & Icon Links',
              description: 'Semantic colored links and links with icons.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BsHStack(
                    gap: 16,
                    children: [
                      BsLink(
                        label: const Text('Primary Link'),
                        onPressed: () {},
                      ),
                      BsLink(
                        label: const Text('Danger Link'),
                        color: context.bs.danger,
                        onPressed: () {},
                      ),
                      BsLink(
                        label: const Text('No underline'),
                        underline: false,
                        onPressed: () {},
                      ),
                    ],
                  ).pb(16),
                  BsHStack(
                    gap: 16,
                    children: [
                      BsIconLink(
                        label: const Text('Icon link after'),
                        icon: const Icon(Icons.arrow_forward, size: 16),
                        onPressed: () {},
                      ),
                      BsIconLink(
                        label: const Text('Icon link before'),
                        icon: const Icon(Icons.download, size: 16),
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

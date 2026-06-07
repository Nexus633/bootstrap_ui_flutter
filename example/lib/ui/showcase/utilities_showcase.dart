import 'package:flutter/material.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

class UtilitiesShowcase extends StatelessWidget {
  const UtilitiesShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BsContainer.fluid(
        child: Column(
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
              child: Column(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Width 50% vs 100% of parent:').pb(8),
                  Container(
                    width: double.infinity,
                    height: 100,
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
                  ).pb(16),
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
              child: Column(
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
                  Row(
                    children: [
                      const Text('Start').alignStart().expanded(),
                      const Text('End').alignEnd().expanded(),
                    ],
                  ),
                ],
              ),
            ),

            // Display
            _Section(
              title: 'Display',
              description: 'Visibility utilities.',
              child: Column(
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

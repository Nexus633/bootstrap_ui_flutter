import 'package:flutter/material.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

class HeadingShowcase extends StatelessWidget {
  const HeadingShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BsContainer.fluid(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Headings',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ).pb(16),
            const Text(
              'All HTML headings, <h1> through <h6>, are available. BsHeading is designed to match Bootstrap\'s default typography hierarchy, line height, font weights, and spacing.',
            ).pb(24),

            // Standard Headings
            _Section(
              title: 'Bootstrap Headings',
              description:
                  'Standard headings from h1 to h6. By default, headings include a bottom margin of 0.5rem (8px).',
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BsHeading('h1. Bootstrap heading', level: BsHeadingLevel.h1),
                  BsHeading('h2. Bootstrap heading', level: BsHeadingLevel.h2),
                  BsHeading('h3. Bootstrap heading', level: BsHeadingLevel.h3),
                  BsHeading('h4. Bootstrap heading', level: BsHeadingLevel.h4),
                  BsHeading('h5. Bootstrap heading', level: BsHeadingLevel.h5),
                  BsHeading('h6. Bootstrap heading', level: BsHeadingLevel.h6),
                ],
              ),
            ),

            // Customization Options
            _Section(
              title: 'Customization',
              description:
                  'Modify headings with alignment, colors, or remove the default bottom margin.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BsHeading(
                    'Centered Heading',
                    level: BsHeadingLevel.h2,
                    textAlign: TextAlign.center,
                  ),
                  const Divider().py2(),
                  BsHeading(
                    'Danger Colored Heading',
                    level: BsHeadingLevel.h3,
                    color: context.bs.danger,
                  ),
                  const Divider().py2(),
                  Row(
                    children: [
                      const BsHeading(
                        'No Bottom Margin',
                        level: BsHeadingLevel.h4,
                        removeMargin: true,
                        color: Colors.blue,
                      ).pe3(),
                      Text(
                        '(Aligned horizontally because margin is removed)',
                        style: TextStyle(color: context.bs.bodyTextSecondary),
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

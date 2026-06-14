import 'package:flutter/material.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

class TypographyShowcase extends StatelessWidget {
  const TypographyShowcase({super.key});

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
                    'Typography',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ).pb2(),
                  Text(
                    'Documentation and examples for Bootstrap typography, including headings, blockquotes, inline code, and more.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: 0.9),
                      height: 1.4,
                    ),
                  ),
                ],
              ).p4(),
            ).mb(32),

            // 1. Standard Headings
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

            // 2. Customization Options
            _Section(
              title: 'Heading Customization',
              description:
                  'Modify headings with alignment, colors, or remove the default bottom margin.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BsHeading(
                    'Centered Heading',
                    level: BsHeadingLevel.h2,
                    textAlign: TextAlign.center,
                  ),
                  const Divider().py3(),
                  BsHeading(
                    'Danger Colored Heading',
                    level: BsHeadingLevel.h3,
                    color: theme.danger,
                  ),
                  const Divider().py3(),
                  Row(
                    children: [
                      const BsHeading(
                        'No Bottom Margin',
                        level: BsHeadingLevel.h4,
                        removeMargin: true,
                        color: Colors.blue,
                      ).pe3(),
                      Expanded(
                        child: Text(
                          '(Aligned horizontally because margin is removed)',
                          style: TextStyle(color: theme.bodyTextSecondary),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 3. Blockquote
            _Section(
              title: 'Blockquotes',
              description:
                  'For quoting blocks of content from another source within your document. Use BsBlockquote to quote content and add a footer citation.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BsBlockquote(
                    child: Text(
                      'A well-known quote, contained in a blockquote element.',
                    ),
                  ).pb3(),
                  const BsBlockquote(
                    footer: Text('Someone famous in Source Title'),
                    child: Text(
                      'A well-known quote, contained in a blockquote element.',
                    ),
                  ),
                ],
              ),
            ),

            // 4. Inline Code
            _Section(
              title: 'Inline Code',
              description: 'Wrap inline snippets of code with BsCode.',
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Text('For example, '),
                  const BsCode('<section>'),
                  const Text(' should be wrapped as inline.'),
                ],
              ),
            ),

            // 5. User Input (KBD)
            _Section(
              title: 'User Input',
              description:
                  'Use BsKbd to indicate input that is typically entered via keyboard.',
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Text('To switch directories, type '),
                  const BsKbd('cd'),
                  const Text(' followed by the name of the directory.'),
                  const SizedBox(width: 8),
                  const Text('To edit settings, press '),
                  const BsKbd('ctrl + ,'),
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
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
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

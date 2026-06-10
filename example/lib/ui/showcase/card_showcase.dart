import 'package:flutter/material.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

class CardShowcase extends StatelessWidget {
  const CardShowcase({super.key});

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
                    'Cards',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ).pb2(),
                  Text(
                    'A flexible and extensible content container. Supports header, footer, background variants, border colors, images, and multiple layout alignment orientations.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: 0.9),
                      height: 1.4,
                    ),
                  ),
                ],
              ).p4(),
            ).mb(32),

            // 1. Basic Card
            _Section(
              title: 'Basic Card',
              description: 'A simple card with title, subtitle, content body, and action button.',
              child: BsRow(
                children: [
                  BsCol(
                    config: const BsColConfig(xs: 12, md: 6, lg: 4),
                    child: BsCard(
                      body: BsCardBody(
                        children: [
                          const BsCardTitle('Card Title'),
                          const BsCardSubtitle('Card Subtitle'),
                          Text(
                            'Some quick example text to build on the card title and make up the bulk of the card\'s content.',
                            style: TextStyle(color: theme.bodyTextSecondary),
                          ).pb3(),
                          BsButton(
                            label: 'Go somewhere',
                            variant: BsButtonVariant.primary,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 2. Header and Footer
            _Section(
              title: 'Header and Footer',
              description: 'Add header or footer sections to divide card information flow.',
              child: BsRow(
                children: [
                  BsCol(
                    config: const BsColConfig(xs: 12, md: 8, lg: 6),
                    child: BsCard(
                      header: const BsCardHeader(
                        child: Text('Featured News', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      body: BsCardBody(
                        children: [
                          const BsCardTitle('Special Title Treatment'),
                          Text(
                            'With supporting text below as a natural lead-in to additional content.',
                            style: TextStyle(color: theme.bodyTextSecondary),
                          ).pb3(),
                          BsButton(
                            label: 'Read Article',
                            variant: BsButtonVariant.primary,
                            onPressed: () {},
                          ),
                        ],
                      ),
                      footer: const BsCardFooter(
                        child: Text('Updated 2 hours ago'),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 3. Image top / bottom
            _Section(
              title: 'Top & Bottom Images',
              description: 'Card images automatically clip and align with boundaries and border radiuses.',
              child: BsRow(
                gutterX: BsSpacing.s3,
                gutterY: BsSpacing.s3,
                children: [
                  BsCol(
                    config: const BsColConfig(xs: 12, md: 6, lg: 4),
                    child: BsCard(
                      image: Image.network(
                        'https://picsum.photos/id/25/400/250',
                        fit: BoxFit.cover,
                      ),
                      imagePosition: BsCardImagePosition.top,
                      body: const BsCardBody(
                        children: [
                          BsCardTitle('Top Image Card'),
                          Text('The image is positioned at the top of the card.'),
                        ],
                      ),
                    ),
                  ),
                  BsCol(
                    config: const BsColConfig(xs: 12, md: 6, lg: 4),
                    child: BsCard(
                      image: Image.network(
                        'https://picsum.photos/id/26/400/250',
                        fit: BoxFit.cover,
                      ),
                      imagePosition: BsCardImagePosition.bottom,
                      body: const BsCardBody(
                        children: [
                          BsCardTitle('Bottom Image Card'),
                          Text('The image is positioned at the bottom of the card.'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 4. Horizontal Card
            _Section(
              title: 'Horizontal Layout',
              description: 'Position images next to card body contents (left or right).',
              child: BsRow(
                children: [
                  BsCol(
                    config: const BsColConfig(xs: 12, lg: 8),
                    child: SizedBox(
                      height: 180,
                      child: BsCard(
                        image: Image.network(
                          'https://picsum.photos/id/35/300/400',
                          fit: BoxFit.cover,
                        ),
                        imagePosition: BsCardImagePosition.left,
                        imageFlex: 4,
                        contentFlex: 8,
                        body: const BsCardBody(
                          children: [
                            BsCardTitle('Horizontal Card'),
                            Text(
                              'This is a wider card with supporting text below as a natural lead-in to additional content.',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 5. Image Overlay
            _Section(
              title: 'Image Overlays',
              description: 'Place overlay content directly on top of background images.',
              child: BsRow(
                children: [
                  BsCol(
                    config: const BsColConfig(xs: 12, md: 8, lg: 6),
                    child: SizedBox(
                      height: 250,
                      child: BsCard(
                        image: Image.network(
                          'https://picsum.photos/id/45/600/400',
                          fit: BoxFit.cover,
                          color: Colors.black.withValues(alpha: 0.45),
                          colorBlendMode: BlendMode.darken,
                        ),
                        imagePosition: BsCardImagePosition.overlay,
                        body: const BsCardBody(
                          children: [
                            Spacer(),
                            BsCardTitle('Card Title Overlay', color: Colors.white),
                            Text(
                              'This is a wider card with supporting text below as a natural lead-in.',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 6. Color Variants
            _Section(
              title: 'Color & Border Variants',
              description: 'Style cards using accent theme backgrounds and custom borders.',
              child: BsRow(
                gutterX: BsSpacing.s3,
                gutterY: BsSpacing.s3,
                children: const [
                  BsCol(
                    config: BsColConfig(xs: 12, md: 4),
                    child: BsCard(
                      variant: BsVariant.primary,
                      body: BsCardBody(
                        children: [
                          BsCardTitle('Primary Card'),
                          Text('Colored background card with automatic text color contrast.'),
                        ],
                      ),
                    ),
                  ),
                  BsCol(
                    config: BsColConfig(xs: 12, md: 4),
                    child: BsCard(
                      variant: BsVariant.dark,
                      body: BsCardBody(
                        children: [
                          BsCardTitle('Dark Card'),
                          Text('Colored background card with dark theme colors.'),
                        ],
                      ),
                    ),
                  ),
                  BsCol(
                    config: BsColConfig(xs: 12, md: 4),
                    child: BsCard(
                      borderVariant: BsVariant.danger,
                      body: BsCardBody(
                        children: [
                          BsCardTitle('Danger Border Card'),
                          Text('A card with normal background but danger colored border.'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 7. Card Groups
            _Section(
              title: 'Card Groups',
              description: 'Attached list of cards forming a single, unified container layout.',
              child: const BsCardGroup(
                children: [
                  BsCard(
                    body: BsCardBody(
                      children: [
                        BsCardTitle('Card 1'),
                        Text('This is a wider card with supporting text below.'),
                      ],
                    ),
                  ),
                  BsCard(
                    body: BsCardBody(
                      children: [
                        BsCardTitle('Card 2'),
                        Text('This card has supporting text below as a lead-in.'),
                      ],
                    ),
                  ),
                  BsCard(
                    body: BsCardBody(
                      children: [
                        BsCardTitle('Card 3'),
                        Text('This is a wider card with supporting text below.'),
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

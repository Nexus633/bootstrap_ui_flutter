import 'package:flutter/material.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

class CardShowcase extends StatelessWidget {
  const CardShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BsContainer.fluid(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Cards',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ).pb(16),
            const Text(
              'Bootstrap’s cards provide a flexible and extensible content container with multiple layout, image, header, footer, and color variant options.',
            ).pb(24),

            // 1. Basic Card inside a Row/Col
            _Section(
              title: 'Basic Card',
              description: 'A simple card with title, subtitle, content, and an action button, laid out inside a grid.',
              child: BsRow(
                children: [
                  BsCol(
                    config: const BsColConfig(xs: 12, md: 6, lg: 4),
                    child: BsCard(
                      body: BsCardBody(
                        children: [
                          const BsCardTitle('Card Title'),
                          const BsCardSubtitle('Card Subtitle'),
                          const Text(
                            'Some quick example text to build on the card title and make up the bulk of the card\'s content.',
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
              description: 'Cards with optional header and footer styled with theme contrast.',
              child: BsRow(
                children: [
                  BsCol(
                    config: const BsColConfig(xs: 12, md: 8, lg: 6),
                    child: BsCard(
                      header: const BsCardHeader(
                        child: Text(
                          'Featured',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      body: BsCardBody(
                        children: [
                          const BsCardTitle('Special title treatment'),
                          const Text(
                            'With supporting text below as a natural lead-in to additional content.',
                          ).pb3(),
                          BsButton(
                            label: 'Go somewhere',
                            variant: BsButtonVariant.primary,
                            onPressed: () {},
                          ),
                        ],
                      ),
                      footer: const BsCardFooter(
                        child: Text('2 days ago'),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 3. Image top / bottom
            _Section(
              title: 'Images (Top and Bottom)',
              description: 'Images automatically adapt and clip to the card\'s border radius.',
              child: BsRow(
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
              description: 'A card layout where the image is on the left or right, stretching to match height.',
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
              description: 'Overlay text and content on top of a background image.',
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
                          color: Colors.black.withValues(alpha: 0.4),
                          colorBlendMode: BlendMode.darken,
                        ),
                        imagePosition: BsCardImagePosition.overlay,
                        body: const BsCardBody(
                          children: [
                            Spacer(),
                            BsCardTitle(
                              'Card title overlay',
                              color: Colors.white,
                            ),
                            Text(
                              'This is a wider card with supporting text below as a natural lead-in to additional content.',
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
              description: 'Use background variants for colored cards, or border variants for highlighted borders.',
              child: BsRow(
                children: [
                  // Primary Variant
                  BsCol(
                    config: const BsColConfig(xs: 12, md: 4),
                    child: const BsCard(
                      variant: BsCardVariant.primary,
                      body: BsCardBody(
                        children: [
                          BsCardTitle('Primary Card'),
                          Text('Colored background card with automatic text color contrast.'),
                        ],
                      ),
                    ),
                  ),
                  // Dark Variant
                  BsCol(
                    config: const BsColConfig(xs: 12, md: 4),
                    child: const BsCard(
                      variant: BsCardVariant.dark,
                      body: BsCardBody(
                        children: [
                          BsCardTitle('Dark Card'),
                          Text('Colored background card with dark theme colors.'),
                        ],
                      ),
                    ),
                  ),
                  // Danger Border Variant
                  BsCol(
                    config: const BsColConfig(xs: 12, md: 4),
                    child: const BsCard(
                      borderVariant: BsCardVariant.danger,
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
              description: 'Use card groups to render cards as a single, attached element with equal width and height columns.',
              child: const BsCardGroup(
                children: [
                  BsCard(
                    body: BsCardBody(
                      children: [
                        BsCardTitle('Card 1'),
                        Text(
                          'This is a wider card with supporting text below as a natural lead-in to additional content.',
                        ),
                      ],
                    ),
                  ),
                  BsCard(
                    body: BsCardBody(
                      children: [
                        BsCardTitle('Card 2'),
                        Text(
                          'This card has supporting text below as a natural lead-in to additional content.',
                        ),
                      ],
                    ),
                  ),
                  BsCard(
                    body: BsCardBody(
                      children: [
                        BsCardTitle('Card 3'),
                        Text(
                          'This is a wider card with supporting text below as a natural lead-in to additional content.',
                        ),
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
  const _Section({
    required this.title,
    this.description,
    required this.child,
  });

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
        if (description != null)
          Text(description!).pb(16),
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

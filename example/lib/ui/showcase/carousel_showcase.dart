import 'package:flutter/material.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

class CarouselShowcase extends StatelessWidget {
  const CarouselShowcase({super.key});

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
                    'Carousel',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ).pb2(),
                  Text(
                    'A slideshow component for cycling through elements—like a carousel of images or slides of custom content—complete with controls, indicators, and captions.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: 0.9),
                      height: 1.4,
                    ),
                  ),
                ],
              ).p4(),
            ).mb(32),

            // 1. Basic Carousel (Slides Only)
            _Section(
              title: 'Slides Only',
              description: 'A basic carousel containing only slides that cycles automatically.',
              child: BsRow(
                children: [
                  BsCol(
                    config: const BsColConfig(xs: 12, lg: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: BsCarousel(
                        controls: false,
                        indicators: false,
                        items: [
                          BsCarouselItem(
                            child: Image.network(
                              'https://picsum.photos/id/10/800/400',
                              fit: BoxFit.cover,
                            ),
                          ),
                          BsCarouselItem(
                            child: Image.network(
                              'https://picsum.photos/id/20/800/400',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 2. With Controls & Indicators
            _Section(
              title: 'Controls & Indicators',
              description: 'Navigate through slides using side arrows or bottom dash indicators.',
              child: BsRow(
                children: [
                  BsCol(
                    config: const BsColConfig(xs: 12, lg: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: BsCarousel(
                        controls: true,
                        indicators: true,
                        items: [
                          BsCarouselItem(
                            child: Image.network(
                              'https://picsum.photos/id/37/800/400',
                              fit: BoxFit.cover,
                            ),
                          ),
                          BsCarouselItem(
                            child: Image.network(
                              'https://picsum.photos/id/48/800/400',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 3. With Captions
            _Section(
              title: 'With Captions',
              description: 'Add title and description overlays to your slides.',
              child: BsRow(
                children: [
                  BsCol(
                    config: const BsColConfig(xs: 12, lg: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: BsCarousel(
                        controls: true,
                        indicators: true,
                        items: [
                          BsCarouselItem(
                            caption: const BsCarouselCaption(
                              title: Text('First Slide Title'),
                              description: Text('Some representative placeholder content for the first slide.'),
                            ),
                            child: Image.network(
                              'https://picsum.photos/id/85/800/400',
                              fit: BoxFit.cover,
                              color: Colors.black.withValues(alpha: 0.35),
                              colorBlendMode: BlendMode.darken,
                            ),
                          ),
                          BsCarouselItem(
                            caption: const BsCarouselCaption(
                              title: Text('Second Slide Title'),
                              description: Text('Some representative placeholder content for the second slide.'),
                            ),
                            child: Image.network(
                              'https://picsum.photos/id/96/800/400',
                              fit: BoxFit.cover,
                              color: Colors.black.withValues(alpha: 0.35),
                              colorBlendMode: BlendMode.darken,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 4. Fade Transition
            _Section(
              title: 'Fade Transition',
              description: 'Use cross-fading animations instead of sliding horizontally.',
              child: BsRow(
                children: [
                  BsCol(
                    config: const BsColConfig(xs: 12, lg: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: BsCarousel(
                        controls: true,
                        indicators: true,
                        fade: true,
                        items: [
                          BsCarouselItem(
                            caption: const BsCarouselCaption(
                              title: Text('Fade Slide 1'),
                            ),
                            child: Image.network(
                              'https://picsum.photos/id/119/800/400',
                              fit: BoxFit.cover,
                              color: Colors.black.withValues(alpha: 0.3),
                              colorBlendMode: BlendMode.darken,
                            ),
                          ),
                          BsCarouselItem(
                            caption: const BsCarouselCaption(
                              title: Text('Fade Slide 2'),
                            ),
                            child: Image.network(
                              'https://picsum.photos/id/122/800/400',
                              fit: BoxFit.cover,
                              color: Colors.black.withValues(alpha: 0.3),
                              colorBlendMode: BlendMode.darken,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 5. Dark Variant
            _Section(
              title: 'Dark Variant',
              description: 'Use dark controls and indicators for light-colored background slides.',
              child: BsRow(
                children: [
                  BsCol(
                    config: const BsColConfig(xs: 12, lg: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: theme.border),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: BsCarousel(
                          controls: true,
                          indicators: true,
                          dark: true,
                          items: [
                            BsCarouselItem(
                              caption: const BsCarouselCaption(
                                title: Text('Dark Style Slide 1'),
                                description: Text('Text and arrows are dark gray for high contrast on light backgrounds.'),
                              ),
                              child: Container(
                                color: const Color(0xFFF8F9FA),
                                alignment: Alignment.center,
                                child: const BsIcon(
                                  BsIcons.emojiSmile,
                                  size: 64,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            BsCarouselItem(
                              caption: const BsCarouselCaption(
                                title: Text('Dark Style Slide 2'),
                                description: Text('Text and arrows adapt automatically to light backgrounds.'),
                              ),
                              child: Container(
                                color: const Color(0xFFE9ECEF),
                                alignment: Alignment.center,
                                child: const BsIcon(
                                  BsIcons.heartFill,
                                  size: 64,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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

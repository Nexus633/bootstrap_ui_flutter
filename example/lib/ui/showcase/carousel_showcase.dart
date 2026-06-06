import 'package:flutter/material.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

class CarouselShowcase extends StatelessWidget {
  const CarouselShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BsContainer.fluid(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Carousel',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ).pb(16),
            const Text(
              'A slideshow component for cycling through elements—like a carousel of images or slides of custom content—complete with controls, indicators, captions, and touch support.',
            ).pb(24),

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
                          BsCarouselItem(
                            child: Image.network(
                              'https://picsum.photos/id/29/800/400',
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
              title: 'With Controls and Indicators',
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
                          BsCarouselItem(
                            child: Image.network(
                              'https://picsum.photos/id/54/800/400',
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
                              title: Text('Fade slide 1'),
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
                              title: Text('Fade slide 2'),
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

            // 5. Individual Slide Intervals
            _Section(
              title: 'Individual Intervals',
              description: 'Demonstration of slides having different custom autoplay durations (e.g. 2s for slide 1, 6s for slide 2).',
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
                            interval: const Duration(seconds: 2),
                            caption: const BsCarouselCaption(
                              title: Text('Short Slide (2 seconds)'),
                            ),
                            child: Image.network(
                              'https://picsum.photos/id/141/800/400',
                              fit: BoxFit.cover,
                              color: Colors.black.withValues(alpha: 0.3),
                              colorBlendMode: BlendMode.darken,
                            ),
                          ),
                          BsCarouselItem(
                            interval: const Duration(seconds: 6),
                            caption: const BsCarouselCaption(
                              title: Text('Long Slide (6 seconds)'),
                            ),
                            child: Image.network(
                              'https://picsum.photos/id/145/800/400',
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

            // 6. Dark Variant
            _Section(
              title: 'Dark Variant',
              description: 'Use dark controls, indicators, and text colors (.carousel-dark) for light background slides.',
              child: BsRow(
                children: [
                  BsCol(
                    config: const BsColConfig(xs: 12, lg: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: context.bs.border),
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
                                child: const Icon(
                                  Icons.insert_emoticon_rounded,
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
                                child: const Icon(
                                  Icons.favorite_rounded,
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

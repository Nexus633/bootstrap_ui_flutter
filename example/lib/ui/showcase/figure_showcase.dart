import 'package:flutter/material.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

class FigureShowcase extends StatelessWidget {
  const FigureShowcase({super.key});

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
                    'Figures',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ).pb2(),
                  Text(
                    'Use figures to wrap images and text captions in a single element. Supports alignment, sizing, and thumbnail borders.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: 0.9),
                      height: 1.4,
                    ),
                  ),
                ],
              ).p4(),
            ).mb(32),

            // 1. Basic Figure
            _Section(
              title: 'Basic Figure',
              description: 'A standard figure containing an image and a bottom-aligned caption.',
              child: const Center(
                child: BsFigure(
                  image: BsImage(
                    image: NetworkImage('https://picsum.photos/id/101/400/300'),
                    rounded: true,
                  ),
                  caption: Text('A caption for the above landscape image.'),
                ),
              ),
            ),

            // 2. Caption Alignment
            _Section(
              title: 'Caption Alignment',
              description: 'Position figure captions horizontally using the alignment options.',
              child: BsRow(
                gutterX: BsSpacing.s3,
                gutterY: BsSpacing.s3,
                children: const [
                  BsCol(
                    config: BsColConfig(xs: 12, md: 6),
                    child: BsFigure(
                      image: BsImage(
                        image: NetworkImage('https://picsum.photos/id/102/300/200'),
                        rounded: true,
                        fluid: true,
                      ),
                      caption: Text('Centered caption'),
                      captionAlignment: Alignment.center,
                    ),
                  ),
                  BsCol(
                    config: BsColConfig(xs: 12, md: 6),
                    child: BsFigure(
                      image: BsImage(
                        image: NetworkImage('https://picsum.photos/id/103/300/200'),
                        rounded: true,
                        fluid: true,
                      ),
                      caption: Text('Right-aligned caption'),
                      captionAlignment: Alignment.centerRight,
                    ),
                  ),
                ],
              ),
            ),

            // 3. Figure with Thumbnail
            _Section(
              title: 'Figure with Thumbnail',
              description: 'Wrap images in thumbnail style borders before applying captions.',
              child: const Center(
                child: BsFigure(
                  image: BsImage(
                    image: NetworkImage('https://picsum.photos/id/104/250/250'),
                    thumbnail: true,
                  ),
                  caption: Text('An image wrapped in thumbnail borders.'),
                ),
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

import 'package:flutter/material.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

class ImageShowcase extends StatelessWidget {
  const ImageShowcase({super.key});

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
                    'Images',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ).pb2(),
                  Text(
                    'Documentation and examples for opting into styling images, making them responsive (so they never grow larger than their parent), and adding lightweight styles to them.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: 0.9),
                      height: 1.4,
                    ),
                  ),
                ],
              ).p4(),
            ).mb(32),

            // 1. Responsive Images
            _Section(
              title: 'Responsive Images',
              description: 'Images in Bootstrap are made responsive with the fluid flag. It applies max-width: 100% and height: auto to scale nicely inside parent containers.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BsImage.network(
                    'https://picsum.photos/id/10/800/400',
                    fluid: true,
                    semanticLabel: 'Responsive image',
                  ),
                ],
              ),
            ),

            // 2. Image Thumbnails
            _Section(
              title: 'Image Thumbnails',
              description: 'In addition to border-radius utilities, you can use the thumbnail flag to give an image a rounded 1px border appearance.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BsImage.network(
                    'https://picsum.photos/id/20/200/200',
                    thumbnail: true,
                    semanticLabel: 'Thumbnail image',
                  ),
                ],
              ),
            ),

            // 3. Rounding Corners
            _Section(
              title: 'Rounding Corners',
              description: 'Apply roundness utilities like normal borders or circular boundaries to images.',
              child: Row(
                children: [
                  Column(
                    children: [
                      BsImage.network(
                        'https://picsum.photos/id/30/150/150',
                        rounded: true,
                        semanticLabel: 'Rounded corners',
                      ).pb2(),
                      Text('.rounded', style: TextStyle(color: theme.bodyTextSecondary, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(width: BsSpacing.s4),
                  Column(
                    children: [
                      BsImage.network(
                        'https://picsum.photos/id/40/150/150',
                        circle: true,
                        semanticLabel: 'Circle image',
                      ).pb2(),
                      Text('.rounded-circle', style: TextStyle(color: theme.bodyTextSecondary, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),

            // 4. Aligning Images
            _Section(
              title: 'Aligning Images',
              description: 'Align images with float properties or centering utilities.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Float Start (Left)', style: const TextStyle(fontWeight: FontWeight.bold)).pb2(),
                  BsImage.network(
                    'https://picsum.photos/id/50/120/120',
                    rounded: true,
                    alignment: Alignment.centerLeft,
                    semanticLabel: 'Aligned left',
                  ).pb4(),

                  Text('Float End (Right)', style: const TextStyle(fontWeight: FontWeight.bold)).pb2(),
                  BsImage.network(
                    'https://picsum.photos/id/60/120/120',
                    rounded: true,
                    alignment: Alignment.centerRight,
                    semanticLabel: 'Aligned right',
                  ).pb4(),

                  Text('Centered (mx-auto)', style: const TextStyle(fontWeight: FontWeight.bold)).pb2(),
                  BsImage.network(
                    'https://picsum.photos/id/70/120/120',
                    rounded: true,
                    alignment: Alignment.center,
                    semanticLabel: 'Aligned center',
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

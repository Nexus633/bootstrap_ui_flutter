import 'package:flutter/material.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

class ImageShowcase extends StatelessWidget {
  const ImageShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Images', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: BsSpacing.s3),

          _sectionTitle('Responsive images'),
          _description(
            'Images in Bootstrap are made responsive with .img-fluid. max-width: 100%; and height: auto; are applied to the image so that it scales with the parent element.',
          ),
          BsImage.network(
            'https://picsum.photos/id/10/800/400',
            fluid: true,
            semanticLabel: 'Responsive image',
          ),
          const SizedBox(height: BsSpacing.s4),

          _sectionTitle('Image thumbnails'),
          _description(
            'In addition to our border-radius utilities, you can use .img-thumbnail to give an image a rounded 1px border appearance.',
          ),
          BsImage.network(
            'https://picsum.photos/id/20/200/200',
            thumbnail: true,
            semanticLabel: 'Thumbnail image',
          ),
          const SizedBox(height: BsSpacing.s4),

          _sectionTitle('Rounding corners'),
          Row(
            children: [
              Column(
                children: [
                  BsImage.network(
                    'https://picsum.photos/id/30/150/150',
                    rounded: true,
                    semanticLabel: 'Rounded corners',
                  ),
                  const Text('.rounded'),
                ],
              ),
              const SizedBox(width: BsSpacing.s3),
              Column(
                children: [
                  BsImage.network(
                    'https://picsum.photos/id/40/150/150',
                    circle: true,
                    semanticLabel: 'Circle image',
                  ),
                  const Text('.rounded-circle'),
                ],
              ),
            ],
          ),
          const SizedBox(height: BsSpacing.s4),

          _sectionTitle('Aligning images'),
          _description(
            'Align images with the helper float classes or text alignment classes. block-level images can be centered using the .mx-auto margin utility class.',
          ),
          const Text('Float Start (Left)'),
          BsImage.network(
            'https://picsum.photos/id/50/100/100',
            rounded: true,
            alignment: Alignment.centerLeft,
            semanticLabel: 'Aligned left',
          ),
          const SizedBox(height: BsSpacing.s2),
          const Text('Float End (Right)'),
          BsImage.network(
            'https://picsum.photos/id/60/100/100',
            rounded: true,
            alignment: Alignment.centerRight,
            semanticLabel: 'Aligned right',
          ),
          const SizedBox(height: BsSpacing.s2),
          const Text('Centered (mx-auto)'),
          BsImage.network(
            'https://picsum.photos/id/70/100/100',
            rounded: true,
            alignment: Alignment.center,
            semanticLabel: 'Aligned center',
          ),
        ],
      ).p3(),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: BsSpacing.s2),
      child: Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }

  Widget _description(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: BsSpacing.s3),
      child: Text(text, style: const TextStyle(color: Colors.grey)),
    );
  }
}

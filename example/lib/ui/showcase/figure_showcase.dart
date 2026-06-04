import 'package:flutter/material.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

class FigureShowcase extends StatelessWidget {
  const FigureShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(BsSpacing.s3),
      child: BsContainer.fluid(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Figures', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: BsSpacing.s3),
            
            _description('Anytime you need to display a piece of content—like an image with an optional caption, consider using a <figure>.'),
            
            _sectionTitle('Basic Figure'),
            _description('Figures are shrink-wrapped to their content by default (inline-block behavior).'),
            const Center(
              child: BsFigure(
                image: BsImage(
                  image: NetworkImage('https://picsum.photos/id/101/400/300'),
                  rounded: true,
                ),
                caption: Text('A caption for the above image.'),
              ),
            ),
            const SizedBox(height: BsSpacing.s4),

            _sectionTitle('Caption Alignment'),
            _description('Use captionAlignment to position the caption relative to the image.'),
            
            BsRow(
              children: [
                BsCol(
                  config: const BsColConfig(xs: 12, md: 6),
                  child: const BsFigure(
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
                  config: const BsColConfig(xs: 12, md: 6),
                  child: const BsFigure(
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
            
            const SizedBox(height: BsSpacing.s4),

            _sectionTitle('Figure with Thumbnail'),
            _description('Combining Figures with the thumbnail styling from BsImage.'),
            const BsFigure(
              image: BsImage(
                image: NetworkImage('https://picsum.photos/id/104/250/250'),
                thumbnail: true,
              ),
              caption: Text('An image with .img-thumbnail'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: BsSpacing.s2, top: BsSpacing.s3),
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

import 'package:flutter/material.dart';
import '../../tokens/spacing.dart';
import '../../tokens/typography.dart';
import '../../tokens/bootstrap_theme.dart';
import '../../utilities/alignment_extension.dart';

/// A Bootstrap-style figure component for displaying images with captions.
///
/// [BsFigure] implements the Bootstrap 5 Figure component, which wraps an image
/// and an optional caption with appropriate styling and spacing.
///
/// The figure provides a baseline margin, and the image within it has a small 
/// bottom margin to separate it from the caption. The caption is styled with
/// a smaller font size and a muted color by default.
///
/// Example:
/// ```dart
/// BsFigure(
///   image: BsImage.asset('assets/image.png', fluid: true, rounded: true),
///   caption: Text('A caption for the image.'),
/// )
/// ```
///
/// See also:
/// * [BsImage], which is typically used as the image in a figure.
/// * <https://getbootstrap.com/docs/5.3/content/figures/>
class BsFigure extends StatelessWidget {
  /// Creates a Bootstrap figure.
  const BsFigure({
    super.key,
    required this.image,
    this.caption,
    this.captionAlignment,
    this.margin = const EdgeInsets.only(bottom: BsSpacing.s3),
    this.imageMargin = const EdgeInsets.only(bottom: BsSpacing.s2),
  });

  /// The image to display in the figure.
  ///
  /// Usually a [BsImage] or another image widget.
  final Widget image;

  /// An optional caption to display below the image.
  ///
  /// Typically a [Text] widget. It will be styled with [BsTypography.fontSizeSm]
  /// and [BsColors.secondary] automatically.
  final Widget? caption;

  /// How to align the caption horizontally.
  ///
  /// If null, it defaults to the start of the figure.
  final AlignmentGeometry? captionAlignment;

  /// The outer margin of the figure.
  ///
  /// Defaults to `EdgeInsets.only(bottom: BsSpacing.s3)` (1rem) as per Bootstrap.
  final EdgeInsetsGeometry margin;

  /// The margin between the image and the caption.
  ///
  /// Defaults to `EdgeInsets.only(bottom: BsSpacing.s2)` (0.5rem).
  final EdgeInsetsGeometry imageMargin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: imageMargin,
              child: image,
            ),
            if (caption != null) _buildCaption(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCaption(BuildContext context) {
    final theme = context.bs;
    
    Widget captionWidget = DefaultTextStyle.merge(
      style: TextStyle(
        fontSize: BsTypography.fontSizeSm,
        color: theme.bodyTextSecondary,
        height: BsTypography.lineHeightBase,
      ),
      child: caption!,
    );

    if (captionAlignment != null) {
      captionWidget = captionWidget.align(captionAlignment!);
    }

    return captionWidget;
  }
}

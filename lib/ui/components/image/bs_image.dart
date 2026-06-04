import 'package:flutter/material.dart';
import '../../tokens/spacing.dart';
import '../../tokens/bootstrap_theme.dart';

/// A Bootstrap-style image component.
///
/// [BsImage] provides common image styling options from Bootstrap 5,
/// including responsive behavior, thumbnails, rounded corners, and alignment.
class BsImage extends StatelessWidget {
  /// Creates a Bootstrap image.
  const BsImage({
    super.key,
    required this.image,
    this.fluid = false,
    this.thumbnail = false,
    this.rounded = false,
    this.circle = false,
    this.alignment,
    this.width,
    this.height,
    this.fit,
    this.semanticLabel,
  });

  /// The image to display.
  final ImageProvider image;

  /// Whether the image should be responsive.
  ///
  /// If true, the image will scale with its parent's width (max-width: 100%).
  final bool fluid;

  /// Whether the image should be rendered as a thumbnail.
  ///
  /// Adds a 1px border, some padding, and rounded corners.
  final bool thumbnail;

  /// Whether the image should have rounded corners.
  ///
  /// Ignored if [circle] or [thumbnail] is true.
  final bool rounded;

  /// Whether the image should be rendered as a circle.
  final bool circle;

  /// How to align the image within its parent.
  final AlignmentGeometry? alignment;

  /// Optional fixed width.
  final double? width;

  /// Optional fixed height.
  final double? height;

  /// How the image should be inscribed into the box.
  final BoxFit? fit;

  /// A semantic description of the image.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    Widget current = Image(
      image: image,
      width: width,
      height: height,
      fit: fit ?? (fluid ? BoxFit.contain : null),
      semanticLabel: semanticLabel,
    );

    // Apply fluid constraints if enabled
    if (fluid) {
      current = ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: double.infinity),
        child: current,
      );
    }

    // Apply Thumbnail styling
    if (thumbnail) {
      final theme = context.bs;
      current = Container(
        padding: const EdgeInsets.all(BsSpacing.s1),
        decoration: BoxDecoration(
          color: theme.bodyBg,
          border: Border.all(color: theme.border, width: 1.0),
          borderRadius: BsRadius.md,
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(5.0)), // Slightly less than md (6.0) to fit inside padding
          child: current,
        ),
      );
    } else if (circle) {
      current = ClipOval(child: current);
    } else if (rounded) {
      current = ClipRRect(
        borderRadius: BsRadius.md,
        child: current,
      );
    }

    // Apply Alignment
    if (alignment != null) {
      current = Align(
        alignment: alignment!,
        child: current,
      );
    }

    return current;
  }

  /// Creates a [BsImage] from a network URL.
  factory BsImage.network(
    String src, {
    Key? key,
    bool fluid = false,
    bool thumbnail = false,
    bool rounded = false,
    bool circle = false,
    AlignmentGeometry? alignment,
    double? width,
    double? height,
    BoxFit? fit,
    String? semanticLabel,
  }) {
    return BsImage(
      key: key,
      image: NetworkImage(src),
      fluid: fluid,
      thumbnail: thumbnail,
      rounded: rounded,
      circle: circle,
      alignment: alignment,
      width: width,
      height: height,
      fit: fit,
      semanticLabel: semanticLabel,
    );
  }

  /// Creates a [BsImage] from an asset.
  factory BsImage.asset(
    String name, {
    Key? key,
    bool fluid = false,
    bool thumbnail = false,
    bool rounded = false,
    bool circle = false,
    AlignmentGeometry? alignment,
    double? width,
    double? height,
    BoxFit? fit,
    String? semanticLabel,
    AssetBundle? bundle,
    String? package,
  }) {
    return BsImage(
      key: key,
      image: AssetImage(name, bundle: bundle, package: package),
      fluid: fluid,
      thumbnail: thumbnail,
      rounded: rounded,
      circle: circle,
      alignment: alignment,
      width: width,
      height: height,
      fit: fit,
      semanticLabel: semanticLabel,
    );
  }
}

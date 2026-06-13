import 'package:flutter/material.dart';
import '../../tokens/bootstrap_theme.dart';
import '../../tokens/colors.dart';
import '../../tokens/enums.dart';
import '../../tokens/typography.dart';
import '../../tokens/spacing.dart';
import '../../utilities/spacing_extension.dart';

/// A Bootstrap-style card component.
///
/// Cards are flexible and extensible content containers with options for headers
/// and footers, variants, images, and multiple layout options (vertical, horizontal, overlay).
class BsCard extends StatelessWidget {
  /// Creates a [BsCard].
  ///
  /// You can build cards using either direct convenience parameters ([header], [body], [footer], [image])
  /// or customize it completely by providing the [children] parameter.
  const BsCard({
    super.key,
    this.header,
    this.body,
    this.footer,
    this.children,
    this.image,
    this.imagePosition = .top,
    this.imageFlex = 4,
    this.contentFlex = 8,
    this.variant,
    this.borderVariant,
    this.color,
    this.borderColor,
    this.borderRadius,
    this.width,
    this.height,
  });

  /// The header widget of the card.
  ///
  /// Typically a [BsCardHeader] containing titles, actions, or links.
  final Widget? header;

  /// The main content of the card.
  ///
  /// Typically a [BsCardBody] or generic widget containing card contents.
  final Widget? body;

  /// The footer widget of the card.
  ///
  /// Typically a [BsCardFooter] containing actions, buttons, or secondary info.
  final Widget? footer;

  /// A list of widgets to stack inside the card vertically.
  ///
  /// If provided, this overrides the default [header], [body], [footer] layout list.
  final List<Widget>? children;

  /// An optional image widget to include in the card layout.
  final Widget? image;

  /// The position of the [image] relative to the card contents.
  ///
  /// Defaults to [BsCardImagePosition.top]. Can be top, bottom, left, right, or overlay.
  final BsCardImagePosition imagePosition;

  /// The flex ratio of the image in a horizontal card layout (left or right).
  ///
  /// Defaults to 4 (representing `.col-md-4` in Bootstrap).
  final int imageFlex;

  /// The flex ratio of the content in a horizontal card layout (left or right).
  ///
  /// Defaults to 8 (representing `.col-md-8` in Bootstrap).
  final int contentFlex;

  /// The background and text color variant.
  ///
  /// Maps to Bootstrap's `.text-bg-*` classes. Overrides default card styling.
  final BsVariant? variant;

  /// The border color variant.
  ///
  /// Maps to Bootstrap's `.border-*` classes. Only affects the card border.
  final BsVariant? borderVariant;

  /// A custom background color for the card.
  ///
  /// Overrides the theme background and [variant] colors.
  final Color? color;

  /// A custom border color for the card.
  ///
  /// Overrides the theme border and [borderVariant] colors.
  final Color? borderColor;

  /// A custom border radius for the card.
  ///
  /// Defaults to [BsRadius.md] (6px).
  final BorderRadius? borderRadius;

  /// Custom width constraint.
  final double? width;

  /// Custom height constraint.
  final double? height;

  /// Creates a copy of this card with the given parameters overridden.
  BsCard copyWith({
    Widget? header,
    Widget? body,
    Widget? footer,
    List<Widget>? children,
    Widget? image,
    BsCardImagePosition? imagePosition,
    int? imageFlex,
    int? contentFlex,
    BsVariant? variant,
    BsVariant? borderVariant,
    Color? color,
    Color? borderColor,
    BorderRadius? borderRadius,
    double? width,
    double? height,
  }) {
    return BsCard(
      key: key,
      header: header ?? this.header,
      body: body ?? this.body,
      footer: footer ?? this.footer,
      image: image ?? this.image,
      imagePosition: imagePosition ?? this.imagePosition,
      imageFlex: imageFlex ?? this.imageFlex,
      contentFlex: contentFlex ?? this.contentFlex,
      variant: variant ?? this.variant,
      borderVariant: borderVariant ?? this.borderVariant,
      color: color ?? this.color,
      borderColor: borderColor ?? this.borderColor,
      borderRadius: borderRadius ?? this.borderRadius,
      width: width ?? this.width,
      height: height ?? this.height,
      children: children ?? this.children,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bsTheme = context.bs;

    // ─── 1. Border Radius ────────────────────────────────────────────────────
    final resolvedBorderRadius = borderRadius ?? BsRadius.md;

    // ─── 2. Border Color ─────────────────────────────────────────────────────
    Color resolvedBorderColor = borderColor ?? bsTheme.borderTranslucent;
    if (borderVariant != null && borderColor == null) {
      resolvedBorderColor = switch (borderVariant!) {
        .primary => bsTheme.primary,
        .secondary => bsTheme.secondary,
        .success => bsTheme.success,
        .danger => bsTheme.danger,
        .warning => bsTheme.warning,
        .info => bsTheme.info,
        .light => bsTheme.light,
        .dark => bsTheme.dark,
      };
    }

    // ─── 3. Background & Text Colors ─────────────────────────────────────────
    Color resolvedBgColor;
    Color? resolvedTextColor;

    if (variant != null && color == null) {
      resolvedBgColor = switch (variant!) {
        .primary => bsTheme.primary,
        .secondary => bsTheme.secondary,
        .success => bsTheme.success,
        .danger => bsTheme.danger,
        .warning => bsTheme.warning,
        .info => bsTheme.info,
        .light => bsTheme.light,
        .dark => bsTheme.dark,
      };

      resolvedTextColor = switch (variant!) {
        .primary => BsColors.onPrimary,
        .secondary => BsColors.onSecondary,
        .success => BsColors.onSuccess,
        .danger => BsColors.onDanger,
        .warning => BsColors.onWarning,
        .info => BsColors.onInfo,
        .light => bsTheme.onLight,
        .dark => bsTheme.onDark,
      };
    } else {
      resolvedBgColor = color ?? bsTheme.bodyBg;
      resolvedTextColor = color != null ? null : bsTheme.bodyText;
    }

    // ─── 4. Build Inner Contents ─────────────────────────────────────────────
    Widget content;
    if (children != null) {
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: children!,
      );
    } else {
      final List<Widget> items = [];

      if (image != null && imagePosition == .top) {
        items.add(image!);
      }
      if (header != null) {
        items.add(header!);
      }
      if (body != null) {
        items.add(body!);
      }
      if (footer != null) {
        items.add(footer!);
      }
      if (image != null && imagePosition == .bottom) {
        items.add(image!);
      }

      content = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: items,
      );
    }

    // ─── 5. Layout Modes (Overlay vs Horizontal vs Vertical) ──────────────────
    if (image != null) {
      if (imagePosition == .overlay) {
        Widget overlayContent = content;
        if (children == null) {
          final List<Widget> items = [];
          if (header != null) items.add(header!);
          if (body != null) {
            items.add(Expanded(child: body!));
          }
          if (footer != null) items.add(footer!);

          overlayContent = Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: items,
          );
        }

        content = Stack(
          alignment: Alignment.topLeft,
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: resolvedBorderRadius,
                child: image!,
              ),
            ),
            Positioned.fill(child: overlayContent),
          ],
        );
      } else if (imagePosition == .top) {
        // Special top image clipping
        content = Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: resolvedBorderRadius.topLeft,
                topRight: resolvedBorderRadius.topRight,
              ),
              child: image!,
            ),
            if (children != null)
              ...children!
            else ...[
              ?header,
              ?body,
              ?footer,
            ],
          ],
        );
      } else if (imagePosition == .bottom) {
        // Special bottom image clipping
        content = Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (children != null)
              ...children!
            else ...[
              ?header,
              ?body,
              ?footer,
            ],
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: resolvedBorderRadius.bottomLeft,
                bottomRight: resolvedBorderRadius.bottomRight,
              ),
              child: image!,
            ),
          ],
        );
      } else if (imagePosition == .left ||
          imagePosition == .right) {
        final List<Widget> rowChildren = [];

        final imageWidget = Expanded(
          flex: imageFlex,
          child: ClipRRect(
            borderRadius: imagePosition == .left
                ? BorderRadius.only(
                    topLeft: resolvedBorderRadius.topLeft,
                    bottomLeft: resolvedBorderRadius.bottomLeft,
                  )
                : BorderRadius.only(
                    topRight: resolvedBorderRadius.topRight,
                    bottomRight: resolvedBorderRadius.bottomRight,
                  ),
            child: image!,
          ),
        );

        final contentWidget = Expanded(flex: contentFlex, child: content);

        if (imagePosition == .left) {
          rowChildren.addAll([imageWidget, contentWidget]);
        } else {
          rowChildren.addAll([contentWidget, imageWidget]);
        }

        content = Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: rowChildren,
        );
      }
    }

    // ─── 6. Build final Card Container ────────────────────────────────────────
    Widget cardChild = ClipRRect(
      borderRadius: resolvedBorderRadius,
      child: content,
    );

    // If text color needs to be overridden for variants, wrap in DefaultTextStyle
    if (resolvedTextColor != null) {
      final defaultStyle = DefaultTextStyle.of(
        context,
      ).style.copyWith(color: resolvedTextColor);
      cardChild = DefaultTextStyle(style: defaultStyle, child: cardChild);
    }

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: resolvedBgColor,
        borderRadius: resolvedBorderRadius,
        border: Border.all(color: resolvedBorderColor, width: 1.0),
      ),
      child: cardChild,
    );
  }
}

/// A Bootstrap-style card header widget.
class BsCardHeader extends StatelessWidget {
  /// Creates a [BsCardHeader].
  const BsCardHeader({
    super.key,
    required this.child,
    this.padding,
    this.backgroundColor,
    this.borderColor,
  });

  /// The header contents.
  final Widget child;

  /// Custom padding for the header.
  ///
  /// Defaults to `vertical: BsSpacing.s2` (8px) and `horizontal: BsSpacing.s3` (16px).
  final EdgeInsetsGeometry? padding;

  /// Custom background color for the header.
  ///
  /// Defaults to a translucent theme overlay: `theme.bodyText.withOpacity(0.03)`.
  final Color? backgroundColor;

  /// Custom border color.
  ///
  /// Defaults to [BsThemeData.borderTranslucent].
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final theme = context.bs;
    final resolvedBg =
        backgroundColor ?? theme.bodyText.withValues(alpha: 0.03);
    final resolvedBorder = borderColor ?? theme.borderTranslucent;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: resolvedBg,
        border: Border(bottom: BorderSide(color: resolvedBorder, width: 1.0)),
      ),
      padding:
          padding ??
          const EdgeInsets.symmetric(
            vertical: BsSpacing.s2,
            horizontal: BsSpacing.s3,
          ),
      child: child,
    );
  }
}

/// A Bootstrap-style card footer widget.
class BsCardFooter extends StatelessWidget {
  /// Creates a [BsCardFooter].
  const BsCardFooter({
    super.key,
    required this.child,
    this.padding,
    this.backgroundColor,
    this.borderColor,
  });

  /// The footer contents.
  final Widget child;

  /// Custom padding for the footer.
  ///
  /// Defaults to `vertical: BsSpacing.s2` (8px) and `horizontal: BsSpacing.s3` (16px).
  final EdgeInsetsGeometry? padding;

  /// Custom background color for the footer.
  ///
  /// Defaults to a translucent theme overlay: `theme.bodyText.withOpacity(0.03)`.
  final Color? backgroundColor;

  /// Custom border color.
  ///
  /// Defaults to [BsThemeData.borderTranslucent].
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final theme = context.bs;
    final resolvedBg =
        backgroundColor ?? theme.bodyText.withValues(alpha: 0.03);
    final resolvedBorder = borderColor ?? theme.borderTranslucent;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: resolvedBg,
        border: Border(top: BorderSide(color: resolvedBorder, width: 1.0)),
      ),
      padding:
          padding ??
          const EdgeInsets.symmetric(
            vertical: BsSpacing.s2,
            horizontal: BsSpacing.s3,
          ),
      child: child,
    );
  }
}

/// A Bootstrap-style card body widget.
///
/// Adds default card spacing and layout behaviors. Supports wrapping a single [child]
/// or a list of [children] inside a Column.
class BsCardBody extends StatelessWidget {
  /// Creates a [BsCardBody].
  const BsCardBody({super.key, this.child, this.children, this.padding})
    : assert(
        child != null || children != null,
        'Either child or children must be provided',
      );

  /// The body contents.
  final Widget? child;

  /// A list of widgets to lay out inside the body.
  ///
  /// Placed inside a Column with crossAxisAlignment set to start.
  final List<Widget>? children;

  /// Custom padding for the body contents.
  ///
  /// Defaults to `BsSpacing.s3` (16px) all around.
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (children != null) {
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: children!,
      );
    } else {
      content = child!;
    }

    return Padding(
      padding: padding ?? const EdgeInsets.all(BsSpacing.s3),
      child: content,
    );
  }
}

/// A Bootstrap-style card title widget.
class BsCardTitle extends StatelessWidget {
  /// Creates a [BsCardTitle].
  const BsCardTitle(this.text, {super.key, this.color, this.textAlign});

  /// The text content.
  final String text;

  /// Custom text color.
  ///
  /// Defaults to the card's text color or theme emphasis color.
  final Color? color;

  /// Horizonal text alignment.
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final theme = context.bs;
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: BsTypography.h5,
        fontWeight: BsTypography.weightHeadings,
        height: BsTypography.lineHeightHeadings,
        color:
            color ??
            DefaultTextStyle.of(context).style.color ??
            theme.emphasisColor,
      ),
    ).pb2(); // 0.5rem (8px) bottom margin
  }
}

/// A Bootstrap-style card subtitle widget.
class BsCardSubtitle extends StatelessWidget {
  /// Creates a [BsCardSubtitle].
  const BsCardSubtitle(this.text, {super.key, this.color, this.textAlign});

  /// The text content.
  final String text;

  /// Custom text color.
  ///
  /// Defaults to a muted version of the card's text color or theme secondary color.
  final Color? color;

  /// Horizontal text alignment.
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final theme = context.bs;
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: 14.0,
        fontWeight: BsTypography.weightNormal,
        height: BsTypography.lineHeightHeadings,
        color:
            color ??
            DefaultTextStyle.of(context).style.color?.withValues(alpha: 0.6) ??
            theme.bodyTextSecondary,
      ),
    ).pb2(); // 0.5rem (8px) bottom margin
  }
}

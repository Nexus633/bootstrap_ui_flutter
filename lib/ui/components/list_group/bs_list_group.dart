import 'package:flutter/material.dart';
import '../../tokens/bootstrap_theme.dart';
import '../../tokens/enums.dart';
import '../../tokens/spacing.dart';
import '../../utilities/spacing_extension.dart';

/// Scope shared down from [BsListGroup] to its children.
class _BsListGroupScope extends InheritedWidget {
  const _BsListGroupScope({
    required this.flush,
    required this.numbered,
    required this.horizontal,
    required this.isFirst,
    required this.isLast,
    required this.index,
    required this.borderWidth,
    required this.borderColor,
    required this.borderRadius,
    required super.child,
  });

  final bool flush;
  final bool numbered;
  final bool horizontal;
  final bool isFirst;
  final bool isLast;
  final int index;
  final double borderWidth;
  final Color? borderColor;
  final BorderRadius? borderRadius;

  static _BsListGroupScope? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_BsListGroupScope>();
  }

  @override
  bool updateShouldNotify(_BsListGroupScope oldWidget) {
    return flush != oldWidget.flush ||
        numbered != oldWidget.numbered ||
        horizontal != oldWidget.horizontal ||
        isFirst != oldWidget.isFirst ||
        isLast != oldWidget.isLast ||
        index != oldWidget.index ||
        borderWidth != oldWidget.borderWidth ||
        borderColor != oldWidget.borderColor ||
        borderRadius != oldWidget.borderRadius;
  }
}

/// A Bootstrap-style list group component (`BsListGroup`).
///
/// List groups are a flexible and powerful component for displaying a series of content.
///
/// See: <https://getbootstrap.com/docs/5.3/components/list-group/>
class BsListGroup extends StatelessWidget {
  /// Creates a [BsListGroup].
  const BsListGroup({
    super.key,
    required this.children,
    this.flush = false,
    this.numbered = false,
    this.horizontal = false,
    this.borderWidth = 1.0,
    this.borderColor,
    this.borderRadius,
  });

  /// The list group items. Usually [BsListGroupItem]s.
  final List<Widget> children;

  /// If true, removes outer borders and rounded corners to render list items edge-to-edge.
  final bool flush;

  /// If true, automatically numbers the list items.
  final bool numbered;

  /// If true, items are laid out horizontally instead of vertically.
  final bool horizontal;

  /// The width of the borders around and between list items. Defaults to `1.0`.
  final double borderWidth;

  /// Optional border color override. Defaults to the theme's border color.
  final Color? borderColor;

  /// Optional custom border radius override. Defaults to `BsRadius.md` (6px).
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) return const SizedBox.shrink();

    final List<Widget> items = [];
    for (int i = 0; i < children.length; i++) {
      final bool isFirst = i == 0;
      final bool isLast = i == children.length - 1;

      items.add(
        _BsListGroupScope(
          flush: flush,
          numbered: numbered,
          horizontal: horizontal,
          isFirst: isFirst,
          isLast: isLast,
          index: i,
          borderWidth: borderWidth,
          borderColor: borderColor,
          borderRadius: borderRadius,
          child: children[i],
        ),
      );
    }

    if (horizontal) {
      return IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: items,
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: items,
    );
  }
}

/// A Bootstrap-style list group item (`BsListGroupItem`).
///
/// Typically placed as a child of [BsListGroup].
class BsListGroupItem extends StatefulWidget {
  /// Creates a [BsListGroupItem].
  const BsListGroupItem({
    super.key,
    required this.child,
    this.onPressed,
    this.active = false,
    this.disabled = false,
    this.variant,
    this.padding,
  });

  /// The content of the item.
  final Widget child;

  /// Callback when the item is pressed. If provided, the item is interactive (hover states, click animations).
  final VoidCallback? onPressed;

  /// Whether the item is currently active (highlighted in primary theme color).
  final bool active;

  /// Whether the item is disabled (grayed out, unclickable).
  final bool disabled;

  /// Semantic color variant of the item.
  final BsVariant? variant;

  /// Optional custom padding. Defaults to 16px horizontal and 12px vertical.
  final EdgeInsetsGeometry? padding;

  @override
  State<BsListGroupItem> createState() => _BsListGroupItemState();
}

class _BsListGroupItemState extends State<BsListGroupItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = context.bs;
    final scope = _BsListGroupScope.of(context);

    final bool flush = scope?.flush ?? false;
    final bool numbered = scope?.numbered ?? false;
    final bool horizontal = scope?.horizontal ?? false;
    final bool isFirst = scope?.isFirst ?? true;
    final bool isLast = scope?.isLast ?? true;
    final int index = scope?.index ?? 0;
    final double borderWidth = scope?.borderWidth ?? 1.0;
    final BorderRadius baseRadius = scope?.borderRadius ?? BsRadius.md;

    // 1. Resolve colors based on active, disabled, and variant states
    Color backgroundColor;
    Color textColor = theme.bodyText;
    Color borderSideColor = scope?.borderColor ?? theme.border;

    if (widget.active) {
      backgroundColor = theme.primary;
      textColor = Colors.white;
      borderSideColor = theme.primary;
    } else if (widget.disabled) {
      backgroundColor = theme.bodyBgSecondary;
      textColor = theme.bodyTextSecondary;
    } else if (widget.variant != null) {
      final colors = _resolveVariantColors(widget.variant!, theme);
      backgroundColor = colors.bg;
      textColor = colors.text;
      borderSideColor = scope?.borderColor ?? colors.border;
    } else {
      backgroundColor = theme.bodyBg;
    }

    // Apply hover states if interactive (onPressed != null)
    final bool isInteractive = widget.onPressed != null && !widget.disabled;
    if (isInteractive && _isHovered) {
      if (widget.active) {
        backgroundColor = theme.primary.withValues(alpha: 0.9);
      } else if (widget.variant != null) {
        final colors = _resolveVariantColors(widget.variant!, theme);
        backgroundColor = colors.hoverBg;
      } else {
        backgroundColor = theme.bodyBgSecondary;
      }
    }

    // 2. Padding
    final EdgeInsetsGeometry itemPadding = widget.padding ??
        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0);

    // 3. Border Radius
    BorderRadius borderRadius = BorderRadius.zero;
    if (!flush) {
      if (horizontal) {
        if (isFirst && isLast) {
          borderRadius = baseRadius;
        } else if (isFirst) {
          borderRadius = BorderRadius.only(
            topLeft: baseRadius.topLeft,
            bottomLeft: baseRadius.bottomLeft,
          );
        } else if (isLast) {
          borderRadius = BorderRadius.only(
            topRight: baseRadius.topRight,
            bottomRight: baseRadius.bottomRight,
          );
        }
      } else {
        if (isFirst && isLast) {
          borderRadius = baseRadius;
        } else if (isFirst) {
          borderRadius = BorderRadius.only(
            topLeft: baseRadius.topLeft,
            topRight: baseRadius.topRight,
          );
        } else if (isLast) {
          borderRadius = BorderRadius.only(
            bottomLeft: baseRadius.bottomLeft,
            bottomRight: baseRadius.bottomRight,
          );
        }
      }
    }

    // 4. Borders (prevent double borders)
    Border border;
    if (flush) {
      border = Border(
        bottom: isLast
            ? BorderSide.none
            : BorderSide(color: borderSideColor, width: borderWidth),
      );
    } else {
      if (horizontal) {
        border = Border(
          top: BorderSide(color: borderSideColor, width: borderWidth),
          bottom: BorderSide(color: borderSideColor, width: borderWidth),
          left: isFirst
              ? BorderSide(color: borderSideColor, width: borderWidth)
              : BorderSide.none,
          right: BorderSide(color: borderSideColor, width: borderWidth),
        );
      } else {
        border = Border(
          top: isFirst
              ? BorderSide(color: borderSideColor, width: borderWidth)
              : BorderSide.none,
          bottom: BorderSide(color: borderSideColor, width: borderWidth),
          left: BorderSide(color: borderSideColor, width: borderWidth),
          right: BorderSide(color: borderSideColor, width: borderWidth),
        );
      }
    }

    // 5. Numbered List Items
    Widget content = widget.child;
    if (numbered) {
      content = Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${index + 1}.',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ).pe2(),
          Expanded(child: content),
        ],
      );
    }

    Widget itemWidget = Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
        border: border,
      ),
      child: Padding(
        padding: itemPadding,
        child: DefaultTextStyle.merge(
          style: TextStyle(color: textColor, fontSize: 16.0),
          child: content,
        ),
      ),
    );

    // 6. Interactions & Accessibility
    if (isInteractive) {
      itemWidget = MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onPressed,
          behavior: HitTestBehavior.opaque,
          child: itemWidget,
        ),
      );
    } else if (widget.disabled) {
      itemWidget = MouseRegion(
        cursor: SystemMouseCursors.forbidden,
        child: Opacity(
          opacity: 0.55,
          child: itemWidget,
        ),
      );
    }

    return horizontal ? Expanded(child: itemWidget) : itemWidget;
  }
}

/// Helper class for resolving semantic variant colors.
class _ListGroupItemColors {
  final Color bg;
  final Color text;
  final Color border;
  final Color hoverBg;

  const _ListGroupItemColors({
    required this.bg,
    required this.text,
    required this.border,
    required this.hoverBg,
  });
}

_ListGroupItemColors _resolveVariantColors(
  BsVariant variant,
  BsThemeData theme,
) {
  switch (variant) {
    case BsVariant.primary:
      final bg = theme.primaryBgSubtle;
      return _ListGroupItemColors(
        bg: bg,
        text: theme.primaryTextEmphasis,
        border: theme.primaryTextEmphasis.withValues(alpha: 0.15),
        hoverBg: Color.alphaBlend(Colors.black.withValues(alpha: 0.04), bg),
      );
    case BsVariant.secondary:
      final bg = theme.secondaryBgSubtle;
      return _ListGroupItemColors(
        bg: bg,
        text: theme.secondaryTextEmphasis,
        border: theme.secondaryTextEmphasis.withValues(alpha: 0.15),
        hoverBg: Color.alphaBlend(Colors.black.withValues(alpha: 0.04), bg),
      );
    case BsVariant.success:
      final bg = theme.successBgSubtle;
      return _ListGroupItemColors(
        bg: bg,
        text: theme.successTextEmphasis,
        border: theme.successTextEmphasis.withValues(alpha: 0.15),
        hoverBg: Color.alphaBlend(Colors.black.withValues(alpha: 0.04), bg),
      );
    case BsVariant.danger:
      final bg = theme.dangerBgSubtle;
      return _ListGroupItemColors(
        bg: bg,
        text: theme.dangerTextEmphasis,
        border: theme.dangerTextEmphasis.withValues(alpha: 0.15),
        hoverBg: Color.alphaBlend(Colors.black.withValues(alpha: 0.04), bg),
      );
    case BsVariant.warning:
      final bg = theme.warningBgSubtle;
      return _ListGroupItemColors(
        bg: bg,
        text: theme.warningTextEmphasis,
        border: theme.warningTextEmphasis.withValues(alpha: 0.15),
        hoverBg: Color.alphaBlend(Colors.black.withValues(alpha: 0.04), bg),
      );
    case BsVariant.info:
      final bg = theme.infoBgSubtle;
      return _ListGroupItemColors(
        bg: bg,
        text: theme.infoTextEmphasis,
        border: theme.infoTextEmphasis.withValues(alpha: 0.15),
        hoverBg: Color.alphaBlend(Colors.black.withValues(alpha: 0.04), bg),
      );
    case BsVariant.light:
      final bg = theme.lightBgSubtle;
      return _ListGroupItemColors(
        bg: bg,
        text: theme.lightTextEmphasis,
        border: theme.border,
        hoverBg: Color.alphaBlend(Colors.black.withValues(alpha: 0.04), bg),
      );
    case BsVariant.dark:
      final bg = theme.darkBgSubtle;
      return _ListGroupItemColors(
        bg: bg,
        text: theme.darkTextEmphasis,
        border: theme.darkTextEmphasis.withValues(alpha: 0.15),
        hoverBg: Color.alphaBlend(Colors.black.withValues(alpha: 0.04), bg),
      );
  }
}

import 'dart:math';
import 'package:flutter/material.dart';
import '../../tokens/bootstrap_theme.dart';
import '../../tokens/enums.dart';
import '../../tokens/spacing.dart';
import '../../tokens/bs_icons.dart';
import '../../tokens/typography.dart';
import '../icon/bs_icon.dart';

// ─── BsPaginationItem ─────────────────────────────────────────────────────────

/// A single item (button) in a Bootstrap-style pagination component.
///
/// Can represent a page number, an arrow navigation, or ellipsis indicators.
/// Handles hover, active, and disabled states according to Bootstrap 5.3 styles.
class BsPaginationItem extends StatefulWidget {
  /// Creates a [BsPaginationItem].
  const BsPaginationItem({
    super.key,
    required this.child,
    this.active = false,
    this.disabled = false,
    this.onPressed,
    this.activeVariant,
    this.activeColor,
    this.activeTextColor,
    this.textColor,
    this.hoverTextColor,
    this.bgColor,
    this.hoverBgColor,
    this.borderColor,
  }) : _borderRadius = null,
       _border = null;

  /// Internal constructor used by [BsPagination] to apply collapsed borders,
  /// custom border radii, and inherited color overrides.
  const BsPaginationItem._internal({
    super.key,
    required this.child,
    required this.active,
    required this.disabled,
    this.onPressed,
    this._borderRadius,
    this._border,
    this.activeVariant,
    this.activeColor,
    this.activeTextColor,
    this.textColor,
    this.hoverTextColor,
    this.bgColor,
    this.hoverBgColor,
    this.borderColor,
  });

  /// The label or icon widget to display inside the item.
  final Widget child;

  /// Whether this page item is active (corresponds to the current page).
  final bool active;

  /// Whether this page item is disabled and cannot be clicked.
  final bool disabled;

  /// Callback when the item is tapped.
  final VoidCallback? onPressed;

  /// Theme variant used for the active state background.
  final BsVariant? activeVariant;

  /// Custom color used for the active state background, overriding [activeVariant].
  final Color? activeColor;

  /// Custom color used for the text/icon in the active state.
  final Color? activeTextColor;

  /// Custom text color for the normal state.
  final Color? textColor;

  /// Custom text color for the hovered state.
  final Color? hoverTextColor;

  /// Custom background color for the normal state.
  final Color? bgColor;

  /// Custom background color for the hovered state.
  final Color? hoverBgColor;

  /// Custom border color for the item.
  final Color? borderColor;

  final BorderRadius? _borderRadius;
  final Border? _border;

  /// Creates a copy of this pagination item with overridden styling properties.
  BsPaginationItem _copyWith({BorderRadius? borderRadius, Border? border}) {
    return BsPaginationItem._internal(
      key: key,
      active: active,
      disabled: disabled,
      onPressed: onPressed,
      borderRadius: borderRadius,
      border: border,
      activeVariant: activeVariant,
      activeColor: activeColor,
      activeTextColor: activeTextColor,
      textColor: textColor,
      hoverTextColor: hoverTextColor,
      bgColor: bgColor,
      hoverBgColor: hoverBgColor,
      borderColor: borderColor,
      child: child,
    );
  }

  @override
  State<BsPaginationItem> createState() => _BsPaginationItemState();
}

class _BsPaginationItemState extends State<BsPaginationItem> {
  bool _isHovered = false;

  Color _resolveVariantColor(BsVariant variant, BsThemeData theme) {
    return switch (variant) {
      BsVariant.primary => theme.primary,
      BsVariant.secondary => theme.secondary,
      BsVariant.success => theme.success,
      BsVariant.danger => theme.danger,
      BsVariant.warning => theme.warning,
      BsVariant.info => theme.info,
      BsVariant.light => theme.light,
      BsVariant.dark => theme.dark,
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.bs;

    // Determine padding, typography and size properties from BsTypography.
    final parentPagination = context
        .findAncestorWidgetOfExactType<BsPagination>();
    final size = parentPagination?.size ?? BsSize.md;

    final EdgeInsets padding;
    final double fontSize;
    final double iconSize;
    final double minSize;

    switch (size) {
      case BsSize.sm:
        padding = const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0);
        fontSize = BsTypography.fontSizeSm;
        iconSize = BsTypography.iconSizeSm;
        minSize = 31.0;
        break;
      case BsSize.lg:
        padding = const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0);
        fontSize = BsTypography.fontSizeLg;
        iconSize = BsTypography.iconSizeLg;
        minSize = 48.0;
        break;
      case BsSize.md:
        padding = const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0);
        fontSize = BsTypography.fontSizeBase;
        iconSize = BsTypography.iconSizeBase;
        minSize = 38.0;
        break;
    }

    // Resolve colors by checking item-level values, falling back to parent container, then to theme.
    final activeVar = widget.activeVariant ?? parentPagination?.activeVariant;
    final actColor = widget.activeColor ?? parentPagination?.activeColor;
    final actTxtColor =
        widget.activeTextColor ?? parentPagination?.activeTextColor;
    final normalTxtColor = widget.textColor ?? parentPagination?.textColor;
    final hovTxtColor =
        widget.hoverTextColor ?? parentPagination?.hoverTextColor;
    final normalBgColor = widget.bgColor ?? parentPagination?.bgColor;
    final hovBgColor = widget.hoverBgColor ?? parentPagination?.hoverBgColor;
    final bordColor = widget.borderColor ?? parentPagination?.borderColor;

    Color resolvedTextColor;
    Color resolvedBgColor;
    Color resolvedBorderColor;

    if (widget.disabled) {
      resolvedTextColor =
          normalTxtColor?.withValues(alpha: 0.5) ?? theme.bodyTextSecondary;
      resolvedBgColor = normalBgColor ?? theme.bodyBg;
      resolvedBorderColor = bordColor ?? theme.border;
    } else if (widget.active) {
      resolvedBgColor =
          actColor ??
          (activeVar != null
              ? _resolveVariantColor(activeVar, theme)
              : theme.primary);
      resolvedTextColor = actTxtColor ?? Colors.white;
      resolvedBorderColor =
          actColor ??
          (activeVar != null
              ? _resolveVariantColor(activeVar, theme)
              : theme.primary);
    } else {
      resolvedTextColor = _isHovered
          ? (hovTxtColor ?? theme.linkHoverColor)
          : (normalTxtColor ?? theme.linkColor);
      resolvedBgColor = _isHovered
          ? (hovBgColor ?? theme.bodyBgSecondary)
          : (normalBgColor ?? theme.bodyBg);
      resolvedBorderColor = bordColor ?? theme.border;
    }

    final Border border =
        widget._border ?? Border.all(color: resolvedBorderColor, width: 1.0);
    final BorderRadius borderRadius = widget._borderRadius ?? BorderRadius.zero;

    Widget content = Container(
      constraints: BoxConstraints(minWidth: minSize, minHeight: minSize),
      decoration: BoxDecoration(
        color: resolvedBgColor,
        border: border,
        borderRadius: borderRadius,
      ),
      padding: padding,
      child: IconTheme.merge(
        data: IconThemeData(color: resolvedTextColor, size: iconSize),
        child: DefaultTextStyle.merge(
          style: TextStyle(
            color: resolvedTextColor,
            fontSize: fontSize,
            fontWeight: widget.active ? FontWeight.bold : FontWeight.normal,
            fontFamily: 'Segoe UI',
            height: 1.25,
          ),
          child: Center(child: widget.child),
        ),
      ),
    );

    // Apply interactivity if not active and not disabled
    if (!widget.disabled && !widget.active && widget.onPressed != null) {
      content = MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: () {
            widget.onPressed!();
            setState(() => _isHovered = false);
          },
          child: content,
        ),
      );
    }

    return content;
  }
}

// ─── BsPagination ────────────────────────────────────────────────────────────

/// A Bootstrap-style pagination component.
///
/// Renders a series of connected page items horizontally. Ensures correct
/// border collapsing and abuts buttons with rounded corners at the start and end.
///
/// See: <https://getbootstrap.com/docs/5.3/components/pagination/>
class BsPagination extends StatelessWidget {
  /// Creates a [BsPagination] with a custom list of items.
  const BsPagination({
    super.key,
    required this.items,
    this.size = BsSize.md,
    this.alignment = BsPaginationAlignment.start,
    this.activeVariant,
    this.activeColor,
    this.activeTextColor,
    this.textColor,
    this.hoverTextColor,
    this.bgColor,
    this.hoverBgColor,
    this.borderColor,
  });

  /// Creates an automatic [BsPagination] that calculates and generates page numbers
  /// and navigation buttons based on current page state.
  ///
  /// This high-level builder automatically manages rendering of page numbers,
  /// ellipsis indicators (`...`), prev/next buttons, and optional first/last buttons.
  factory BsPagination.automatic({
    Key? key,
    required int currentPage,
    required int totalPages,
    required ValueChanged<int> onPageChanged,
    int maxVisiblePages = 5,
    BsSize size = BsSize.md,
    BsPaginationAlignment alignment = BsPaginationAlignment.start,
    bool showFirstLast = true,
    bool showPrevNext = true,
    Widget? firstLabel,
    Widget? prevLabel,
    Widget? nextLabel,
    Widget? lastLabel,
    BsVariant? activeVariant,
    Color? activeColor,
    Color? activeTextColor,
    Color? textColor,
    Color? hoverTextColor,
    Color? bgColor,
    Color? hoverBgColor,
    Color? borderColor,
  }) {
    final List<BsPaginationItem> generatedItems = [];

    // Ensure page counts are valid
    final int current = max(1, currentPage);
    final int total = max(1, totalPages);

    // 1. First Page Button
    if (showFirstLast) {
      generatedItems.add(
        BsPaginationItem(
          key: const ValueKey('page_first'),
          disabled: current == 1,
          onPressed: current > 1 ? () => onPageChanged(1) : null,
          child: firstLabel ?? const BsIcon(BsIcons.chevronDoubleLeft),
        ),
      );
    }

    // 2. Previous Page Button
    if (showPrevNext) {
      generatedItems.add(
        BsPaginationItem(
          key: const ValueKey('page_prev'),
          disabled: current == 1,
          onPressed: current > 1 ? () => onPageChanged(current - 1) : null,
          child: prevLabel ?? const BsIcon(BsIcons.chevronLeft),
        ),
      );
    }

    // 3. Page Numbers calculation
    int startPage = 1;
    int endPage = total;

    if (total > maxVisiblePages) {
      final int half = (maxVisiblePages - 1) ~/ 2;
      startPage = current - half;
      endPage = current + half;

      if (startPage < 1) {
        endPage += (1 - startPage);
        startPage = 1;
      }
      if (endPage > total) {
        startPage -= (endPage - total);
        endPage = total;
      }
      startPage = max(1, startPage);
    }

    // First page always shown if startPage > 1
    if (startPage > 1) {
      generatedItems.add(
        BsPaginationItem(
          key: const ValueKey('page_1'),
          active: current == 1,
          onPressed: current == 1 ? null : () => onPageChanged(1),
          child: const Text('1'),
        ),
      );

      if (startPage > 2) {
        generatedItems.add(
          const BsPaginationItem(
            key: ValueKey('page_ellipsis_start'),
            disabled: true,
            child: Text('...'),
          ),
        );
      }
    }

    // Visible window of page buttons
    for (int p = startPage; p <= endPage; p++) {
      // Skip if page is 1 or total (already handled manually by start/end caps)
      if (p == 1 && startPage > 1) continue;
      if (p == total && endPage < total) continue;

      generatedItems.add(
        BsPaginationItem(
          key: ValueKey('page_$p'),
          active: current == p,
          onPressed: current == p ? null : () => onPageChanged(p),
          child: Text('$p'),
        ),
      );
    }

    // Last page always shown if endPage < total
    if (endPage < total) {
      if (endPage < total - 1) {
        generatedItems.add(
          const BsPaginationItem(
            key: ValueKey('page_ellipsis_end'),
            disabled: true,
            child: Text('...'),
          ),
        );
      }

      generatedItems.add(
        BsPaginationItem(
          key: ValueKey('page_$total'),
          active: current == total,
          onPressed: current == total ? null : () => onPageChanged(total),
          child: Text('$total'),
        ),
      );
    }

    // 4. Next Page Button
    if (showPrevNext) {
      generatedItems.add(
        BsPaginationItem(
          key: const ValueKey('page_next'),
          disabled: current == total,
          onPressed: current < total ? () => onPageChanged(current + 1) : null,
          child: nextLabel ?? const BsIcon(BsIcons.chevronRight),
        ),
      );
    }

    // 5. Last Page Button
    if (showFirstLast) {
      generatedItems.add(
        BsPaginationItem(
          key: const ValueKey('page_last'),
          disabled: current == total,
          onPressed: current < total ? () => onPageChanged(total) : null,
          child: lastLabel ?? const BsIcon(BsIcons.chevronDoubleRight),
        ),
      );
    }

    return BsPagination(
      key: key,
      items: generatedItems,
      size: size,
      alignment: alignment,
      activeVariant: activeVariant,
      activeColor: activeColor,
      activeTextColor: activeTextColor,
      textColor: textColor,
      hoverTextColor: hoverTextColor,
      bgColor: bgColor,
      hoverBgColor: hoverBgColor,
      borderColor: borderColor,
    );
  }

  /// The list of items to align.
  final List<BsPaginationItem> items;

  /// The size variant of the pagination buttons (sm, md, lg).
  final BsSize size;

  /// Alignment of the pagination items in the horizontal layout.
  final BsPaginationAlignment alignment;

  /// Inherited active theme variant color.
  final BsVariant? activeVariant;

  /// Inherited custom active color.
  final Color? activeColor;

  /// Inherited custom active text color.
  final Color? activeTextColor;

  /// Inherited custom text color.
  final Color? textColor;

  /// Inherited custom hover text color.
  final Color? hoverTextColor;

  /// Inherited custom background color.
  final Color? bgColor;

  /// Inherited custom hover background color.
  final Color? hoverBgColor;

  /// Inherited custom border color.
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final theme = context.bs;

    // Resolve border radius based on pagination size
    final BorderRadius radius;
    switch (size) {
      case BsSize.sm:
        radius = BsRadius.sm;
        break;
      case BsSize.lg:
        radius = BsRadius.lg;
        break;
      case BsSize.md:
        radius = BsRadius.md;
        break;
    }

    final List<Widget> styledChildren = [];
    final int count = items.length;

    for (int i = 0; i < count; i++) {
      final item = items[i];

      // Resolve the border color using hierarchy (item -> parent -> theme)
      final resolvedBorderColor =
          item.borderColor ?? borderColor ?? theme.border;

      // Collapsed borders logic:
      // The first item has left, top, right, bottom.
      // Succeeding items omit the left border to avoid double border width.
      final border = Border(
        top: BorderSide(color: resolvedBorderColor, width: 1.0),
        bottom: BorderSide(color: resolvedBorderColor, width: 1.0),
        right: BorderSide(color: resolvedBorderColor, width: 1.0),
        left: i == 0
            ? BorderSide(color: resolvedBorderColor, width: 1.0)
            : BorderSide.none,
      );

      // Border radii logic:
      // - If only 1 item: full radius on all sides
      // - First item: radius on left side
      // - Last item: radius on right side
      // - Middle items: flat corners
      final BorderRadius borderRadius;
      if (count == 1) {
        borderRadius = radius;
      } else if (i == 0) {
        borderRadius = BorderRadius.only(
          topLeft: radius.topLeft,
          bottomLeft: radius.bottomLeft,
        );
      } else if (i == count - 1) {
        borderRadius = BorderRadius.only(
          topRight: radius.topRight,
          bottomRight: radius.bottomRight,
        );
      } else {
        borderRadius = BorderRadius.zero;
      }

      styledChildren.add(
        item._copyWith(borderRadius: borderRadius, border: border),
      );
    }

    final Widget row = Row(
      mainAxisSize: MainAxisSize.min,
      children: styledChildren,
    );

    // Map the align option to standard AlignmentGeometry
    AlignmentGeometry alignGeometry;
    switch (alignment) {
      case BsPaginationAlignment.center:
        alignGeometry = Alignment.center;
        break;
      case BsPaginationAlignment.end:
        alignGeometry = Alignment.centerRight;
        break;
      case BsPaginationAlignment.start:
        alignGeometry = Alignment.centerLeft;
        break;
    }

    return Align(alignment: alignGeometry, child: row);
  }
}

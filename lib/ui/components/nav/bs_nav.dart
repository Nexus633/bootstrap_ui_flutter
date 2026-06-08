import 'package:flutter/material.dart';
import '../../tokens/bootstrap_theme.dart';
import '../../tokens/colors.dart';
import '../../tokens/enums.dart';

/// Scope shared down from [BsNav] to its children.
class _BsNavScope extends InheritedWidget {
  const _BsNavScope({
    required this.variant,
    required this.alignment,
    required this.vertical,
    required super.child,
  });

  final BsNavVariant variant;
  final BsNavAlignment alignment;
  final bool vertical;

  static _BsNavScope? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_BsNavScope>();
  }

  @override
  bool updateShouldNotify(_BsNavScope oldWidget) {
    return variant != oldWidget.variant ||
        alignment != oldWidget.alignment ||
        vertical != oldWidget.vertical;
  }
}

/// A Bootstrap-style navigation component (`BsNav`).
///
/// Navs are built with flexbox and provide a flexible foundation for navigation.
/// Supports plain links, tabs, pills, and underline styling variants.
///
/// See: <https://getbootstrap.com/docs/5.3/components/navs-tabs/>
class BsNav extends StatelessWidget {
  /// Creates a [BsNav] container.
  const BsNav({
    super.key,
    required this.children,
    this.variant = BsNavVariant.plain,
    this.alignment = BsNavAlignment.start,
    this.vertical = false,
    this.padding = EdgeInsets.zero,
  });

  /// The nav items, typically [BsNavLink]s.
  final List<Widget> children;

  /// The visual variant style of the navigation.
  final BsNavVariant variant;

  /// The alignment of items inside the nav (only applies to horizontal navs).
  final BsNavAlignment alignment;

  /// Whether the navigation items should stack vertically.
  final bool vertical;

  /// Padding around the nav container.
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final theme = context.bs;

    // Wrap children for filled/justified alignments
    final List<Widget> wrappedChildren = [];
    for (int i = 0; i < children.length; i++) {
      Widget child = children[i];
      if (!vertical &&
          (alignment == BsNavAlignment.fill ||
              alignment == BsNavAlignment.justified)) {
        child = Expanded(child: child);
      }
      wrappedChildren.add(child);
    }

    Widget content;
    if (vertical) {
      content = Padding(
        padding: variant == BsNavVariant.tabs
            ? const EdgeInsets.only(right: 12.0)
            : EdgeInsets.zero,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: wrappedChildren,
        ),
      );
    } else {
      content = Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: _resolveMainAxisAlignment(alignment),
        crossAxisAlignment: CrossAxisAlignment.center,
        children: wrappedChildren,
      );
    }

    // Apply borders for tabbed navigation containers
    if (variant == BsNavVariant.tabs) {
      if (vertical) {
        content = Stack(
          fit: StackFit.passthrough,
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              child: Container(width: 1.0, color: theme.border),
            ),
            content,
          ],
        );
      } else {
        content = Stack(
          fit: StackFit.passthrough,
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(height: 1.0, color: theme.border),
            ),
            content,
          ],
        );
      }
    }

    return _BsNavScope(
      variant: variant,
      alignment: alignment,
      vertical: vertical,
      child: Padding(padding: padding, child: content),
    );
  }

  MainAxisAlignment _resolveMainAxisAlignment(BsNavAlignment alignment) {
    switch (alignment) {
      case BsNavAlignment.start:
      case BsNavAlignment.fill:
      case BsNavAlignment.justified:
        return MainAxisAlignment.start;
      case BsNavAlignment.center:
        return MainAxisAlignment.center;
      case BsNavAlignment.end:
        return MainAxisAlignment.end;
    }
  }
}

/// An individual navigation link inside a [BsNav] (`BsNavLink`).
class BsNavLink extends StatefulWidget {
  /// Creates a [BsNavLink] widget.
  const BsNavLink({
    super.key,
    this.label,
    this.child,
    this.active = false,
    this.disabled = false,
    this.onPressed,
    this.padding,
    this.color,
    this.activeColor,
  }) : assert(
         label != null || child != null,
         'Either label or child must be provided',
       );

  /// The text label to display.
  final String? label;

  /// A custom child widget to display instead of the label.
  final Widget? child;

  /// Whether this link is currently active.
  final bool active;

  /// Whether this link is disabled.
  final bool disabled;

  /// Callback when the link is tapped.
  final VoidCallback? onPressed;

  /// Optional custom padding override.
  final EdgeInsetsGeometry? padding;

  /// Optional custom text/icon color in normal state.
  final Color? color;

  /// Optional custom text/icon color in active state.
  final Color? activeColor;

  @override
  State<BsNavLink> createState() => _BsNavLinkState();
}

class _BsNavLinkState extends State<BsNavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final scope = _BsNavScope.of(context);
    final variant = scope?.variant ?? BsNavVariant.plain;
    final vertical = scope?.vertical ?? false;

    final theme = context.bs;

    // Resolve padding
    final EdgeInsetsGeometry defaultPadding = _resolveDefaultPadding(variant);
    final EdgeInsetsGeometry padding = widget.padding ?? defaultPadding;

    // Resolve text style, colors, and background decorations
    final TextStyle textStyle = _resolveTextStyle(variant, theme);
    final Color textColor = _resolveTextColor(variant, theme);
    final BoxDecoration? decoration = _resolveDecoration(
      variant,
      vertical,
      theme,
    );

    Widget innerContent =
        widget.child ??
        Text(
          widget.label!,
          style: textStyle.copyWith(color: textColor),
          textAlign: vertical ? TextAlign.left : TextAlign.center,
        );

    if (widget.child != null) {
      innerContent = DefaultTextStyle.merge(
        style: textStyle.copyWith(color: textColor),
        textAlign: vertical ? TextAlign.left : TextAlign.center,
        child: IconTheme.merge(
          data: IconThemeData(color: textColor, size: 16.0),
          child: innerContent,
        ),
      );
    }

    Widget content = Container(
      decoration: decoration,
      padding: padding,
      child: Align(
        alignment: vertical ? Alignment.centerLeft : Alignment.center,
        widthFactor: 1.0,
        heightFactor: 1.0,
        child: innerContent,
      ),
    );

    // Apply offset and border masking for active/hovered tabs to seamlessly merge with background
    final bool isTabs = variant == BsNavVariant.tabs;
    final bool showMask = (widget.active || _isHovered) && isTabs && !vertical;

    if (showMask) {
      if (vertical) {
        content = Stack(
          fit: StackFit.passthrough,
          clipBehavior: Clip.none,
          children: [
            content,
            Positioned(
              top: 1.0,
              bottom: 1.0,
              right: -1.0,
              child: Container(width: 2.0, color: theme.bodyBg),
            ),
          ],
        );
        if (widget.active) {
          content = Transform.translate(
            offset: const Offset(1.0, 0),
            child: content,
          );
        }
      } else {
        content = Stack(
          fit: StackFit.passthrough,
          clipBehavior: Clip.none,
          children: [
            content,
            Positioned(
              left: 1.0,
              right: 1.0,
              bottom: -1.0,
              child: Container(height: 2.0, color: theme.bodyBg),
            ),
          ],
        );
        if (widget.active) {
          content = Transform.translate(
            offset: const Offset(0, 1.0),
            child: content,
          );
        }
      }
    }

    if (widget.disabled) {
      return MouseRegion(cursor: SystemMouseCursors.forbidden, child: content);
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onPressed,
        child: content,
      ),
    );
  }

  EdgeInsetsGeometry _resolveDefaultPadding(BsNavVariant variant) {
    switch (variant) {
      case BsNavVariant.plain:
      case BsNavVariant.pills:
      case BsNavVariant.tabs:
        return const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0);
      case BsNavVariant.underline:
        return const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0);
    }
  }

  TextStyle _resolveTextStyle(BsNavVariant variant, BsThemeData theme) {
    const double baseSize = 16.0;
    if (variant == BsNavVariant.underline) {
      return TextStyle(
        fontSize: baseSize,
        fontWeight: widget.active ? FontWeight.w600 : FontWeight.normal,
      );
    }
    return TextStyle(
      fontSize: baseSize,
      fontWeight: widget.active ? FontWeight.w500 : FontWeight.normal,
    );
  }

  Color _resolveTextColor(BsNavVariant variant, BsThemeData theme) {
    if (widget.disabled) {
      return theme.bodyText.withValues(alpha: 0.3);
    }

    if (widget.active) {
      if (widget.activeColor != null) {
        return widget.activeColor!;
      }
      if (widget.color != null) {
        return widget.color!;
      }
    } else {
      if (widget.color != null) {
        return _isHovered ? widget.color! : widget.color!.withValues(alpha: 0.8);
      }
    }

    switch (variant) {
      case BsNavVariant.plain:
      case BsNavVariant.tabs:
        if (widget.active) {
          return variant == BsNavVariant.tabs ? theme.bodyText : theme.primary;
        }
        return _isHovered
            ? theme.primary
            : theme.primary.withValues(alpha: 0.8);

      case BsNavVariant.pills:
        if (widget.active) {
          return BsColors.onPrimary;
        }
        return _isHovered
            ? theme.primary
            : theme.primary.withValues(alpha: 0.8);

      case BsNavVariant.underline:
        if (widget.active) {
          return theme.bodyText;
        }
        return _isHovered
            ? theme.bodyText
            : theme.bodyText.withValues(alpha: 0.55);
    }
  }

  BoxDecoration? _resolveDecoration(
    BsNavVariant variant,
    bool vertical,
    BsThemeData theme,
  ) {
    if (widget.disabled) return null;

    switch (variant) {
      case BsNavVariant.plain:
        return null;

      case BsNavVariant.tabs:
        if (widget.active) {
          if (vertical) {
            return BoxDecoration(
              color: theme.bodyBg,
              border: Border.all(color: theme.border, width: 1.0),
              borderRadius: BorderRadius.circular(4.0),
            );
          } else {
            return BoxDecoration(
              color: theme.bodyBg,
              border: Border.all(color: theme.border, width: 1.0),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4.0),
                topRight: Radius.circular(4.0),
              ),
            );
          }
        }
        if (_isHovered) {
          if (vertical) {
            return BoxDecoration(
              border: Border.all(
                color: theme.border.withValues(alpha: 0.5),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(4.0),
            );
          } else {
            return BoxDecoration(
              border: Border.all(
                color: theme.border.withValues(alpha: 0.5),
                width: 1.0,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4.0),
                topRight: Radius.circular(4.0),
              ),
            );
          }
        }
        return BoxDecoration(
          border: Border.all(color: Colors.transparent, width: 1.0),
          borderRadius: vertical ? BorderRadius.circular(4.0) : const BorderRadius.only(
            topLeft: Radius.circular(4.0),
            topRight: Radius.circular(4.0),
          ),
        );

      case BsNavVariant.pills:
        if (widget.active) {
          return BoxDecoration(
            color: theme.primary,
            borderRadius: BorderRadius.circular(6.0),
          );
        }
        if (_isHovered) {
          return BoxDecoration(
            color: theme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6.0),
          );
        }
        return null;

      case BsNavVariant.underline:
        if (widget.active) {
          return BoxDecoration(
            border: Border(
              bottom: BorderSide(color: theme.primary, width: 2.0),
            ),
          );
        }
        return const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.transparent, width: 2.0),
          ),
        );
    }
  }
}

/// A container for the tab content panes (`BsTabContent`).
///
/// Coordinates with a tab indicator to show the pane at [activeIndex].
/// Supports an optional fade animation when switching tabs.
class BsTabContent extends StatelessWidget {
  /// Creates a [BsTabContent] layout.
  const BsTabContent({
    super.key,
    required this.children,
    required this.activeIndex,
    this.fade = true,
  });

  /// The list of tab panes (typically [BsTabPane]s).
  final List<Widget> children;

  /// The index of the currently active tab.
  final int activeIndex;

  /// Whether to perform a fade transition when switching tabs. Defaults to `true`.
  final bool fade;

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) return const SizedBox.shrink();
    final index = activeIndex.clamp(0, children.length - 1);

    final child = KeyedSubtree(
      key: ValueKey<int>(index),
      child: children[index],
    );

    if (fade) {
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 150),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: child,
      );
    }

    return child;
  }
}

/// An individual content section inside a [BsTabContent] (`BsTabPane`).
class BsTabPane extends StatelessWidget {
  /// Creates a [BsTabPane] widget.
  const BsTabPane({super.key, required this.child});

  /// The content to display inside this tab pane.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

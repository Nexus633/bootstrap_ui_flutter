import 'package:flutter/material.dart';
import '../../tokens/bootstrap_theme.dart';
import '../../utilities/spacing_extension.dart';

/// A Bootstrap-style breadcrumb item.
///
/// Used within a [BsBreadcrumb] to indicate the current page's location
/// within a navigational hierarchy.
class BsBreadcrumbItem extends StatelessWidget {
  /// Creates a [BsBreadcrumbItem].
  const BsBreadcrumbItem({
    super.key,
    required this.label,
    this.onPressed,
    this.active = false,
  });

  /// The label of the breadcrumb item. Usually a [Text] widget.
  final Widget label;

  /// Callback when the item is pressed. If null, the item is not clickable.
  /// Usually null for the active item.
  final VoidCallback? onPressed;

  /// Whether this item is the currently active page.
  ///
  /// Active items are typically styled differently and are not clickable.
  final bool active;

  @override
  Widget build(BuildContext context) {
    final bsTheme = context.bs;

    final TextStyle textStyle = TextStyle(
      color: active ? bsTheme.bodyTextSecondary : bsTheme.linkColor,
      decoration: (onPressed != null && !active) ? TextDecoration.underline : TextDecoration.none,
      decorationColor: bsTheme.linkColor,
    );

    Widget content = DefaultTextStyle.merge(
      style: textStyle,
      child: label,
    );

    if (onPressed != null && !active) {
      content = MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onPressed,
          child: content,
        ),
      );
    }

    return content;
  }
}

/// A Bootstrap-style breadcrumb component.
///
/// Breadcrumbs indicate the current page's location within a navigational
/// hierarchy that automatically adds separators via CSS.
///
/// See: <https://getbootstrap.com/docs/5.3/components/breadcrumb/>
class BsBreadcrumb extends StatelessWidget {
  /// Creates a [BsBreadcrumb].
  const BsBreadcrumb({
    super.key,
    required this.items,
    this.divider,
  });

  /// The list of breadcrumb items to display.
  final List<BsBreadcrumbItem> items;

  /// The divider to display between items.
  ///
  /// Defaults to a forward slash ("/"). Can be a [String] or a [Widget].
  final dynamic divider;

  @override
  Widget build(BuildContext context) {
    final bsTheme = context.bs;

    final List<Widget> children = [];

    for (int i = 0; i < items.length; i++) {
      children.add(items[i]);

      if (i < items.length - 1) {
        children.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: _buildDivider(bsTheme),
          ),
        );
      }
    }

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: children,
    ).mb(16); // Default margin-bottom: 1rem
  }

  Widget _buildDivider(BsThemeData bsTheme) {
    final dividerColor = bsTheme.bodyTextSecondary;

    if (divider == null) {
      return Text(
        '/',
        style: TextStyle(color: dividerColor),
      );
    }

    if (divider is String) {
      return Text(
        divider as String,
        style: TextStyle(color: dividerColor),
      );
    }

    if (divider is Widget) {
      return IconTheme.merge(
        data: IconThemeData(color: dividerColor, size: 16),
        child: DefaultTextStyle.merge(
          style: TextStyle(color: dividerColor),
          child: divider as Widget,
        ),
      );
    }

    return const SizedBox.shrink();
  }
}

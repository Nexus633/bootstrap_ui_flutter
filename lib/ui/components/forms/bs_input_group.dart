import 'package:flutter/material.dart';
import '../../tokens/bootstrap_theme.dart';
import '../../tokens/enums.dart';
import '../../tokens/typography.dart';

/// Context provided to children of a [BsInputGroup] to determine their position.
/// This allows children (like inputs, selects, and buttons) to adjust their
/// border radii automatically.
class BsInputGroupChildContext extends InheritedWidget {
  /// Creates a [BsInputGroupChildContext] to share state with children.
  const BsInputGroupChildContext({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.size,
    required super.child,
  });

  /// Whether this child is the first in the input group.
  final bool isFirst;

  /// Whether this child is the last in the input group.
  final bool isLast;

  /// The size of the input group.
  final BsInputSize size;

  /// Retrieves the nearest [BsInputGroupChildContext] from the context.
  static BsInputGroupChildContext? of(BuildContext context) {

    return context
        .dependOnInheritedWidgetOfExactType<BsInputGroupChildContext>();
  }

  @override
  bool updateShouldNotify(BsInputGroupChildContext oldWidget) {
    return isFirst != oldWidget.isFirst ||
        isLast != oldWidget.isLast ||
        size != oldWidget.size;
  }
}

/// A Bootstrap-style input group component.
///
/// Implements `.input-group` from Bootstrap 5.
/// Wraps inputs, buttons, and text add-ons to display them on a single line.
class BsInputGroup extends StatelessWidget {
  /// Creates a [BsInputGroup].
  const BsInputGroup({
    super.key,
    required this.children,
    this.size = BsInputSize.md,
  });

  /// The children of the input group.
  final List<Widget> children;

  /// The size of the input group. Affects all children that listen to it.
  final BsInputSize size;

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) return const SizedBox.shrink();

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (int i = 0; i < children.length; i++) _buildItem(children[i], i),
        ],
      ),
    );
  }

  Widget _buildItem(Widget child, int index) {
    if (child is Expanded) {
      return Expanded(
        flex: child.flex,
        child: _wrapWithContextAndTransform(child.child, index),
      );
    }
    return _wrapWithContextAndTransform(child, index);
  }

  Widget _wrapWithContextAndTransform(Widget innerChild, int index) {
    Widget wrapped = innerChild;
    if (index > 0) {
      wrapped = Transform.translate(
        offset: const Offset(-1, 0),
        child: wrapped,
      );
    }
    return BsInputGroupChildContext(
      isFirst: index == 0,
      isLast: index == children.length - 1,
      size: size,
      child: wrapped,
    );
  }
}

/// A text add-on for a [BsInputGroup].
///
/// Implements `.input-group-text` from Bootstrap 5.
class BsInputGroupText extends StatelessWidget {
  /// Creates a [BsInputGroupText].
  const BsInputGroupText(this.text, {super.key});

  /// The text to display.
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = context.bs;
    final groupContext = BsInputGroupChildContext.of(context);

    final BsInputSize size = groupContext?.size ?? BsInputSize.md;
    final bool isFirst = groupContext?.isFirst ?? true;
    final bool isLast = groupContext?.isLast ?? true;

    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(
      horizontal: 12.0,
      vertical: 6.0,
    );
    double fontSize = BsTypography.fontSizeBase;
    double minHeight = 38.0; // <--- NEU

    if (size == BsInputSize.sm) {
      padding = const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0);
      fontSize = BsTypography.fontSizeSm;
      minHeight = 31.0; // <--- NEU
    } else if (size == BsInputSize.lg) {
      padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0);
      fontSize = BsTypography.fontSizeLg;
      minHeight = 48.0; // <--- NEU
    }

    final double radius = size == BsInputSize.sm
        ? 4.0
        : (size == BsInputSize.lg ? 8.0 : 6.0);
    final Radius r = Radius.circular(radius);

    BorderRadius borderRadius;
    if (isFirst && isLast) {
      borderRadius = BorderRadius.all(r);
    } else if (isFirst) {
      borderRadius = BorderRadius.horizontal(left: r);
    } else if (isLast) {
      borderRadius = BorderRadius.horizontal(right: r);
    } else {
      borderRadius = BorderRadius.zero;
    }

    return Container(
      constraints: BoxConstraints(minHeight: minHeight), // <--- NEU
      padding: padding,
      alignment:
          Alignment.center, // <--- NEU: Ersetzt das innere Center() Widget
      decoration: BoxDecoration(
        color: theme.bodyBgSecondary,
        border: Border.all(color: theme.border, width: 1.0),
        borderRadius: borderRadius,
      ),
      child: Text(
        text,
        style: TextStyle(color: theme.bodyText, fontSize: fontSize),
      ),
    );
  }
}

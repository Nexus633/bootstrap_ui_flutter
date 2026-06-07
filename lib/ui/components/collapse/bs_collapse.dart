import 'package:flutter/material.dart';

/// A Bootstrap-style collapse component (`BsCollapse`).
///
/// Toggles the visibility of a widget with a smooth height or width transition.
/// Corresponds to Bootstrap's `.collapse` and `.collapse-horizontal` functionality.
class BsCollapse extends StatefulWidget {
  /// Creates a [BsCollapse].
  const BsCollapse({
    super.key,
    required this.isExpanded,
    required this.child,
    this.horizontal = false,
    this.duration = const Duration(milliseconds: 350),
    this.curve = Curves.easeInOut,
  });

  /// Controls the visibility state of the collapsible content.
  ///
  /// If true, the content expands. If false, the content collapses.
  final bool isExpanded;

  /// The content to collapse/expand.
  final Widget child;

  /// Whether to transition horizontally (width) instead of vertically (height).
  ///
  /// Maps to Bootstrap's `.collapse-horizontal`. Defaults to `false`.
  final bool horizontal;

  /// The duration of the transition animation.
  ///
  /// Defaults to `350ms` (matching Bootstrap's transition timing).
  final Duration duration;

  /// The animation curve.
  ///
  /// Defaults to [Curves.easeInOut].
  final Curve curve;

  @override
  State<BsCollapse> createState() => _BsCollapseState();
}

class _BsCollapseState extends State<BsCollapse> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );

    if (widget.isExpanded) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(BsCollapse oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
    }
    if (oldWidget.isExpanded != widget.isExpanded) {
      if (widget.isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: _animation,
      axis: widget.horizontal ? Axis.horizontal : Axis.vertical,
      alignment: widget.horizontal ? Alignment.centerLeft : Alignment.topCenter,
      child: widget.child,
    );
  }
}

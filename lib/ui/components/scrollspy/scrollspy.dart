import 'package:flutter/widgets.dart';

import 'scrollspy_controller.dart';

/// A widget that implements the Bootstrap Scrollspy behavior.
///
/// It listens to the scrolling events of its [child] via the provided
/// [controller] and calculates which registered target is currently visible
/// in the viewport.
class BsScrollspy extends StatefulWidget {
  /// Creates a Bootstrap Scrollspy component.
  const BsScrollspy({
    super.key,
    required this.controller,
    required this.child,
    this.activationMargin = 50.0,
  });

  /// The controller that manages the active target and scrolling.
  final BsScrollspyController controller;

  /// The scrollable child, typically a [SingleChildScrollView] or [ListView].
  ///
  /// The [child] must use the `controller.scrollController` as its
  /// [ScrollController] to ensure the scrollspy works correctly.
  final Widget child;

  /// The vertical margin (in logical pixels) from the top of the container
  /// where a target is considered "active". Defaults to 50.0.
  /// This acts similarly to the `rootMargin` in Bootstrap.
  final double activationMargin;

  @override
  State<BsScrollspy> createState() => _BsScrollspyState();
}

class _BsScrollspyState extends State<BsScrollspy> {
  final GlobalKey _containerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    widget.controller.scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _onScroll();
    });
  }

  @override
  void didUpdateWidget(covariant BsScrollspy oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.scrollController.removeListener(_onScroll);
      widget.controller.scrollController.addListener(_onScroll);
    }
  }

  @override
  void dispose() {
    widget.controller.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    if (!mounted || _containerKey.currentContext == null) return;
    if (!widget.controller.scrollController.hasClients) return;

    final containerBox =
        _containerKey.currentContext!.findRenderObject() as RenderBox?;
    if (containerBox == null) return;

    final containerPosition = containerBox.localToGlobal(Offset.zero);
    final containerTop = containerPosition.dy;

    String? newActiveId;
    double maxValidY = double.negativeInfinity;

    final scrollPos = widget.controller.scrollController.position;
    final isAtBottom = scrollPos.pixels >= scrollPos.maxScrollExtent;

    if (isAtBottom && widget.controller.targets.isNotEmpty) {
      // If we are at the very bottom, activate the target that is furthest down.
      double maxBottomY = double.negativeInfinity;
      for (final entry in widget.controller.targets.entries) {
        final key = entry.value;
        if (key.currentContext == null) continue;

        final renderBox = key.currentContext!.findRenderObject() as RenderBox?;
        if (renderBox == null) continue;

        final position = renderBox.localToGlobal(Offset.zero);
        final relativeY = position.dy - containerTop;

        if (relativeY > maxBottomY) {
          maxBottomY = relativeY;
          newActiveId = entry.key;
        }
      }
    } else {
      for (final entry in widget.controller.targets.entries) {
        final key = entry.value;
        if (key.currentContext == null) continue;

        final renderBox = key.currentContext!.findRenderObject() as RenderBox?;
        if (renderBox == null) continue;

        final position = renderBox.localToGlobal(Offset.zero);
        // y-coordinate relative to the container top
        final relativeY = position.dy - containerTop;

        // Consider elements that have scrolled past the activation margin.
        // We want the element that is closest to the margin (largest valid relativeY).
        if (relativeY <= widget.activationMargin && relativeY > maxValidY) {
          maxValidY = relativeY;
          newActiveId = entry.key;
        }
      }

      // Fallback: If no element is past the threshold, use the very first element
      // visible below the margin.
      if (newActiveId == null && widget.controller.targets.isNotEmpty) {
        double minPositiveY = double.infinity;
        for (final entry in widget.controller.targets.entries) {
          final key = entry.value;
          if (key.currentContext == null) continue;

          final renderBox = key.currentContext!.findRenderObject() as RenderBox?;
          if (renderBox == null) continue;

          final position = renderBox.localToGlobal(Offset.zero);
          final relativeY = position.dy - containerTop;

          if (relativeY < minPositiveY) {
            minPositiveY = relativeY;
            newActiveId = entry.key;
          }
        }
      }
    }

    if (newActiveId != null) {
      widget.controller.setActiveTarget(newActiveId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _containerKey,
      child: widget.child,
    );
  }
}

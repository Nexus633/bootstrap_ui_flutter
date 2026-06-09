import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../tokens/bootstrap_theme.dart';
import '../../tokens/enums.dart';

// ─── BsPopoverController ──────────────────────────────────────────────────────

/// A controller to programmatically open, close, or toggle a [BsPopover].
class BsPopoverController extends ChangeNotifier {
  bool _isOpen = false;

  /// Whether the popover is currently visible.
  bool get isOpen => _isOpen;

  /// Opens the popover.
  void open() {
    if (!_isOpen) {
      _isOpen = true;
      notifyListeners();
    }
  }

  /// Closes the popover.
  void close() {
    if (_isOpen) {
      _isOpen = false;
      notifyListeners();
    }
  }

  /// Toggles the popover state.
  void toggle() {
    _isOpen = !_isOpen;
    notifyListeners();
  }
}

// ─── BsPopover ────────────────────────────────────────────────────────────────

/// A Bootstrap-style Popover overlay component.
///
/// Similar to tooltips, popovers provide a pop-up box with a title and content
/// that appears when a user clicks or hovers an element.
///
/// See: <https://getbootstrap.com/docs/5.3/components/popovers/>
class BsPopover extends StatefulWidget {
  /// Creates a [BsPopover].
  const BsPopover({
    super.key,
    required this.child,
    this.title,
    this.content,
    this.titleText,
    this.contentText,
    this.placement = BsPopoverPlacement.top,
    this.trigger = BsPopoverTrigger.click,
    this.controller,
    this.maxWidth = 276.0,
    this.disabled = false,
    this.backgroundColor,
    this.borderColor,
    this.headerBackgroundColor,
    this.headerTextColor,
    this.bodyTextColor,
    this.headerPadding,
    this.bodyPadding,
  }) : assert(
          title != null || titleText != null || content != null || contentText != null,
          'At least one of title, titleText, content, or contentText must be provided',
        );

  /// The target widget that triggers the popover overlay.
  final Widget child;

  /// An optional custom title widget. Takes priority over [titleText].
  final Widget? title;

  /// An optional custom content widget. Takes priority over [contentText].
  final Widget? content;

  /// A convenience plain text label for the title.
  final String? titleText;

  /// A convenience plain text label for the content.
  final String? contentText;

  /// The preferred placement direction of the popover.
  ///
  /// If space is constrained, the popover will automatically flip to the opposite direction.
  final BsPopoverPlacement placement;

  /// The action that triggers the popover visibility (click or hover).
  final BsPopoverTrigger trigger;

  /// An optional controller to programmatically manage the popover state.
  final BsPopoverController? controller;

  /// The maximum width of the popover card box (Bootstrap defaults to 276px).
  final double maxWidth;

  /// Whether the popover interaction is disabled.
  final bool disabled;

  /// Custom background color of the popover body container.
  ///
  /// If not specified, defaults to [Colors.white] (light mode) or [#2b3035] (dark mode).
  final Color? backgroundColor;

  /// Custom border color of the popover and its arrow.
  ///
  /// If not specified, defaults to translucent border from Bootstrap theme.
  final Color? borderColor;

  /// Custom background color of the popover header.
  ///
  /// If not specified, defaults to [#f0f0f0] (light mode) or [#212529] (dark mode).
  final Color? headerBackgroundColor;

  /// Custom text color of the popover header title.
  final Color? headerTextColor;

  /// Custom text color of the popover body content.
  final Color? bodyTextColor;

  /// Custom padding of the popover header.
  ///
  /// If not specified, defaults to `EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0)`.
  final EdgeInsets? headerPadding;

  /// Custom padding of the popover body container.
  ///
  /// If not specified, defaults to `EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0)`.
  final EdgeInsets? bodyPadding;

  @override
  State<BsPopover> createState() => _BsPopoverState();
}

class _BsPopoverState extends State<BsPopover> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  BsPopoverController? _internalController;

  BsPopoverController get _effectiveController =>
      widget.controller ?? (_internalController ??= BsPopoverController());

  @override
  void initState() {
    super.initState();
    _effectiveController.addListener(_handleControllerChange);
  }

  @override
  void didUpdateWidget(covariant BsPopover oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChange);
      _internalController?.removeListener(_handleControllerChange);

      if (widget.controller == null) {
        _internalController ??= BsPopoverController();
        _internalController!.addListener(_handleControllerChange);
      } else {
        _internalController?.dispose();
        _internalController = null;
        widget.controller!.addListener(_handleControllerChange);
      }
    }
  }

  @override
  void dispose() {
    _effectiveController.removeListener(_handleControllerChange);
    _internalController?.dispose();
    if (_isOpen) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
    super.dispose();
  }

  void _handleControllerChange() {
    if (_effectiveController.isOpen) {
      _openPopover();
    } else {
      _closePopover();
    }
  }

  void _togglePopover() {
    if (widget.disabled) return;
    _effectiveController.toggle();
  }

  void _openPopover() {
    if (widget.disabled || _isOpen) return;

    final theme = context.bs;
    final screenSize = MediaQuery.sizeOf(context);
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    // Default anchors and offsets
    Alignment targetAnchor = Alignment.topCenter;
    Alignment followerAnchor = Alignment.bottomCenter;
    Offset offset = const Offset(0, -2);

    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    BsPopoverPlacement effectivePlacement = widget.placement;

    if (renderBox != null && renderBox.hasSize) {
      final triggerSize = renderBox.size;
      final triggerOffset = renderBox.localToGlobal(Offset.zero);

      final double spaceBelow = screenHeight - (triggerOffset.dy + triggerSize.height);
      final double spaceAbove = triggerOffset.dy;
      final double spaceRight = screenWidth - (triggerOffset.dx + triggerSize.width);
      final double spaceLeft = triggerOffset.dx;

      // Flip direction if constraints are violated
      // Assume popover needs around 120px height or 200px width
      const double minHeightRequired = 120.0;
      const double minWidthRequired = 200.0;

      if (widget.placement == BsPopoverPlacement.top && spaceAbove < minHeightRequired && spaceBelow > spaceAbove) {
        effectivePlacement = BsPopoverPlacement.bottom;
      } else if (widget.placement == BsPopoverPlacement.bottom && spaceBelow < minHeightRequired && spaceAbove > spaceBelow) {
        effectivePlacement = BsPopoverPlacement.top;
      } else if (widget.placement == BsPopoverPlacement.start && spaceLeft < minWidthRequired && spaceRight > spaceLeft) {
        effectivePlacement = BsPopoverPlacement.end;
      } else if (widget.placement == BsPopoverPlacement.end && spaceRight < minWidthRequired && spaceLeft > spaceRight) {
        effectivePlacement = BsPopoverPlacement.start;
      }

      // Configure overlays anchors based on effective placement
      switch (effectivePlacement) {
        case BsPopoverPlacement.top:
          targetAnchor = Alignment.topCenter;
          followerAnchor = Alignment.bottomCenter;
          offset = const Offset(0, -2);
          break;
        case BsPopoverPlacement.bottom:
          targetAnchor = Alignment.bottomCenter;
          followerAnchor = Alignment.topCenter;
          offset = const Offset(0, 2);
          break;
        case BsPopoverPlacement.start:
          targetAnchor = Alignment.centerLeft;
          followerAnchor = Alignment.centerRight;
          offset = const Offset(-2, 0);
          break;
        case BsPopoverPlacement.end:
          targetAnchor = Alignment.centerRight;
          followerAnchor = Alignment.centerLeft;
          offset = const Offset(2, 0);
          break;
      }
    }

    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color defaultBgColor = isDark ? const Color(0xFF2B3035) : Colors.white;
    final Color defaultBorderColor = isDark ? const Color(0x2BFFFFFF) : theme.borderTranslucent;
    final Color defaultHeaderBgColor = isDark ? const Color(0xFF212529) : const Color(0xFFF0F0F0);
    final Color defaultHeaderTextColor = isDark ? const Color(0xFFDEE2E6) : theme.bodyText;
    final Color defaultBodyTextColor = isDark ? const Color(0xFFDEE2E6) : theme.bodyText;

    final Color effectiveBgColor = widget.backgroundColor ?? defaultBgColor;
    final Color effectiveBorderColor = widget.borderColor ?? defaultBorderColor;
    final Color effectiveHeaderBgColor = widget.headerBackgroundColor ?? defaultHeaderBgColor;
    final Color effectiveHeaderTextColor = widget.headerTextColor ?? defaultHeaderTextColor;
    final Color effectiveBodyTextColor = widget.bodyTextColor ?? defaultBodyTextColor;

    final EdgeInsets effectiveHeaderPadding = widget.headerPadding ?? const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0);
    final EdgeInsets effectiveBodyPadding = widget.bodyPadding ?? const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0);

    final Widget? titleWidget = widget.title ?? (widget.titleText != null ? Text(widget.titleText!) : null);
    final Widget? contentWidget = widget.content ?? (widget.contentText != null ? Text(widget.contentText!) : null);

    final bool hasHeader = titleWidget != null;
    final Color arrowColor;
    if (effectivePlacement == BsPopoverPlacement.bottom && hasHeader) {
      arrowColor = effectiveHeaderBgColor;
    } else {
      arrowColor = effectiveBgColor;
    }

    _overlayEntry = OverlayEntry(
      builder: (context) {
        // Base Popover Container
        final popoverCard = Container(
          decoration: BoxDecoration(
            color: effectiveBgColor,
            border: Border.all(color: effectiveBorderColor, width: 1.0),
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 10.0,
                offset: const Offset(0.0, 5.0),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(7.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (titleWidget != null) ...[
                  Container(
                    padding: effectiveHeaderPadding,
                    decoration: BoxDecoration(
                      color: effectiveHeaderBgColor,
                      border: Border(
                        bottom: BorderSide(color: effectiveBorderColor, width: 1.0),
                      ),
                    ),
                    child: DefaultTextStyle(
                      style: TextStyle(
                        color: effectiveHeaderTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        fontFamily: 'Segoe UI',
                      ),
                      child: titleWidget,
                    ),
                  ),
                ],
                if (contentWidget != null) ...[
                  Container(
                    padding: effectiveBodyPadding,
                    child: DefaultTextStyle(
                      style: TextStyle(
                        color: effectiveBodyTextColor,
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Segoe UI',
                        height: 1.4,
                      ),
                      child: contentWidget,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );

        // Align arrow according to placement
        final Widget popoverWithArrow;
        if (effectivePlacement == BsPopoverPlacement.top) {
          popoverWithArrow = Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              popoverCard,
              CustomPaint(
                size: const Size(12.0, 6.0),
                painter: _ArrowPainter(
                  direction: BsPopoverPlacement.top,
                  color: arrowColor,
                  borderColor: effectiveBorderColor,
                ),
              ),
            ],
          );
        } else if (effectivePlacement == BsPopoverPlacement.bottom) {
          popoverWithArrow = Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomPaint(
                size: const Size(12.0, 6.0),
                painter: _ArrowPainter(
                  direction: BsPopoverPlacement.bottom,
                  color: arrowColor,
                  borderColor: effectiveBorderColor,
                ),
              ),
              popoverCard,
            ],
          );
        } else if (effectivePlacement == BsPopoverPlacement.start) {
          popoverWithArrow = Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(child: popoverCard),
              CustomPaint(
                size: const Size(6.0, 12.0),
                painter: _ArrowPainter(
                  direction: BsPopoverPlacement.start,
                  color: arrowColor,
                  borderColor: effectiveBorderColor,
                ),
              ),
            ],
          );
        } else { // BsPopoverPlacement.end
          popoverWithArrow = Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomPaint(
                size: const Size(6.0, 12.0),
                painter: _ArrowPainter(
                  direction: BsPopoverPlacement.end,
                  color: arrowColor,
                  borderColor: effectiveBorderColor,
                ),
              ),
              Flexible(child: popoverCard),
            ],
          );
        }

        final followerWidget = CompositedTransformFollower(
          link: _layerLink,
          targetAnchor: targetAnchor,
          followerAnchor: followerAnchor,
          offset: offset,
          child: Align(
            alignment: followerAnchor,
            child: Material(
              color: Colors.transparent,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: widget.maxWidth,
                ),
                child: popoverWithArrow,
              ),
            ),
          ),
        );

        // Outside tap barrier for click triggers
        if (widget.trigger == BsPopoverTrigger.click) {
          return Stack(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTapDown: (_) => _effectiveController.close(),
                child: const SizedBox.expand(),
              ),
              followerWidget,
            ],
          );
        }

        return followerWidget;
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _isOpen = true;
    });
  }

  void _closePopover() {
    if (!_isOpen) return;
    _isOpen = false;
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.trigger == BsPopoverTrigger.hover) {
      return MouseRegion(
        cursor: widget.disabled ? SystemMouseCursors.forbidden : SystemMouseCursors.click,
        onEnter: (_) {
          if (!widget.disabled) {
            _effectiveController.open();
          }
        },
        onExit: (_) {
          _effectiveController.close();
        },
        child: CompositedTransformTarget(
          link: _layerLink,
          child: widget.child,
        ),
      );
    }

    // Default trigger is Click
    return MouseRegion(
      cursor: widget.disabled ? SystemMouseCursors.forbidden : SystemMouseCursors.click,
      child: Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: widget.disabled
            ? null
            : (event) {
                if (event.buttons == kPrimaryButton) {
                  _togglePopover();
                }
              },
        child: CompositedTransformTarget(
          link: _layerLink,
          child: widget.child,
        ),
      ),
    );
  }
}

// ─── _ArrowPainter ────────────────────────────────────────────────────────────

class _ArrowPainter extends CustomPainter {
  _ArrowPainter({
    required this.direction,
    required this.color,
    required this.borderColor,
  });

  final BsPopoverPlacement direction;
  final Color color;
  final Color borderColor;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final path = Path();
    final borderPath = Path();

    switch (direction) {
      case BsPopoverPlacement.top:
        // Triangle pointing down
        path.moveTo(0, 0);
        path.lineTo(size.width, 0);
        path.lineTo(size.width / 2, size.height);
        path.close();

        borderPath.moveTo(0, 0);
        borderPath.lineTo(size.width / 2, size.height);
        borderPath.lineTo(size.width, 0);
        break;
      case BsPopoverPlacement.bottom:
        // Triangle pointing up
        path.moveTo(0, size.height);
        path.lineTo(size.width, size.height);
        path.lineTo(size.width / 2, 0);
        path.close();

        borderPath.moveTo(0, size.height);
        borderPath.lineTo(size.width / 2, 0);
        borderPath.lineTo(size.width, size.height);
        break;
      case BsPopoverPlacement.start:
        // Triangle pointing right
        path.moveTo(0, 0);
        path.lineTo(0, size.height);
        path.lineTo(size.width, size.height / 2);
        path.close();

        borderPath.moveTo(0, 0);
        borderPath.lineTo(size.width, size.height / 2);
        borderPath.lineTo(0, size.height);
        break;
      case BsPopoverPlacement.end:
        // Triangle pointing left
        path.moveTo(size.width, 0);
        path.lineTo(size.width, size.height);
        path.lineTo(0, size.height / 2);
        path.close();

        borderPath.moveTo(size.width, 0);
        borderPath.lineTo(0, size.height / 2);
        borderPath.lineTo(size.width, size.height);
        break;
    }

    canvas.drawPath(path, paint);
    canvas.drawPath(borderPath, borderPaint);
  }

  @override
  bool shouldRepaint(covariant _ArrowPainter oldDelegate) {
    return oldDelegate.direction != direction ||
        oldDelegate.color != color ||
        oldDelegate.borderColor != borderColor;
  }
}

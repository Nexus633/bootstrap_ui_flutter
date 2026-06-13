import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import '../../tokens/bootstrap_theme.dart';
import '../../tokens/enums.dart';
import '../../tokens/z_index.dart';

/// A Bootstrap-style Tooltip component.
///
/// Documentation and examples for adding custom Bootstrap tooltips with CSS and
/// JavaScript using data attributes for routing and markup.
///
/// See: <https://getbootstrap.com/docs/5.3/components/tooltips/>
class BsTooltip extends StatefulWidget {
  /// Creates a Bootstrap tooltip.
  const BsTooltip({
    super.key,
    required this.message,
    required this.child,
    this.placement = .top,
    this.disabled = false,
    this.variant,
    this.color,
  });

  /// The text message to display in the tooltip.
  final String message;

  /// The widget that triggers the tooltip.
  final Widget child;

  /// Preferred placement of the tooltip (top, bottom, start, end).
  final BsPlacement placement;

  /// Whether the tooltip is disabled.
  final bool disabled;

  /// Optional variant for the tooltip background color.
  final BsVariant? variant;

  /// Optional custom background color for the tooltip. Overrides [variant].
  final Color? color;

  @override
  State<BsTooltip> createState() => _BsTooltipState();
}

class _BsTooltipState extends State<BsTooltip> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isHovered = false;

  @override
  void dispose() {
    _hideTooltip();
    super.dispose();
  }

  void _showTooltip() {
    if (widget.disabled || _overlayEntry != null) return;

    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.hasSize) return;

    final screenSize = MediaQuery.sizeOf(context);
    Alignment targetAnchor = Alignment.topCenter;
    Alignment followerAnchor = Alignment.bottomCenter;
    Offset offset = const Offset(0, -6);

    BsPlacement effectivePlacement = widget.placement;

    // Evaluate space to flip placement if necessary
    final triggerSize = renderBox.size;
    final triggerOffset = renderBox.localToGlobal(Offset.zero);

    final double spaceBelow = screenSize.height - (triggerOffset.dy + triggerSize.height);
    final double spaceAbove = triggerOffset.dy;
    final double spaceRight = screenSize.width - (triggerOffset.dx + triggerSize.width);
    final double spaceLeft = triggerOffset.dx;

    const double minHeightRequired = 40.0;
    const double minWidthRequired = 100.0;

    if (widget.placement == .top && spaceAbove < minHeightRequired && spaceBelow > spaceAbove) {
      effectivePlacement = .bottom;
    } else if (widget.placement == .bottom && spaceBelow < minHeightRequired && spaceAbove > spaceBelow) {
      effectivePlacement = .top;
    } else if (widget.placement == .start && spaceLeft < minWidthRequired && spaceRight > spaceLeft) {
      effectivePlacement = .end;
    } else if (widget.placement == .end && spaceRight < minWidthRequired && spaceLeft > spaceRight) {
      effectivePlacement = .start;
    }

    switch (effectivePlacement) {
      case .top:
        targetAnchor = Alignment.topCenter;
        followerAnchor = Alignment.bottomCenter;
        offset = const Offset(0, -6);
        break;
      case .bottom:
        targetAnchor = Alignment.bottomCenter;
        followerAnchor = Alignment.topCenter;
        offset = const Offset(0, 6);
        break;
      case .start:
        targetAnchor = Alignment.centerLeft;
        followerAnchor = Alignment.centerRight;
        offset = const Offset(-6, 0);
        break;
      case .end:
        targetAnchor = Alignment.centerRight;
        followerAnchor = Alignment.centerLeft;
        offset = const Offset(6, 0);
        break;
    }

    final theme = context.bs;
    Color resolveTooltipColor() {
      if (widget.color != null) return widget.color!;
      if (widget.variant != null) {
        return switch (widget.variant!) {
          .primary => theme.primary,
          .secondary => theme.secondary,
          .success => theme.success,
          .danger => theme.danger,
          .warning => theme.warning,
          .info => theme.info,
          .light => theme.light,
          .dark => theme.dark,
        };
      }
      return Colors.black; // Bootstrap default
    }

    final Color tooltipColor = resolveTooltipColor();
    final Color textColor = tooltipColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        final tooltipInner = Semantics(
          sortKey: const OrdinalSortKey(BsZIndex.tooltip * 1.0),
          child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: tooltipColor,
            borderRadius: BorderRadius.circular(4.0), // --bs-tooltip-border-radius
          ),
          child: Text(
            widget.message,
            style: TextStyle(
              color: textColor,
              fontSize: 12.0, // --bs-tooltip-font-size
              fontFamily: 'Segoe UI',
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
        ));

        Widget tooltipWithArrow;
        if (effectivePlacement == .top) {
          tooltipWithArrow = Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              tooltipInner,
              CustomPaint(
                size: const Size(8.0, 4.0),
                painter: _TooltipArrowPainter(direction: .top, color: tooltipColor),
              ),
            ],
          );
        } else if (effectivePlacement == .bottom) {
          tooltipWithArrow = Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomPaint(
                size: const Size(8.0, 4.0),
                painter: _TooltipArrowPainter(direction: .bottom, color: tooltipColor),
              ),
              tooltipInner,
            ],
          );
        } else if (effectivePlacement == .start) {
          tooltipWithArrow = Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(child: tooltipInner),
              CustomPaint(
                size: const Size(4.0, 8.0),
                painter: _TooltipArrowPainter(direction: .start, color: tooltipColor),
              ),
            ],
          );
        } else {
          tooltipWithArrow = Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomPaint(
                size: const Size(4.0, 8.0),
                painter: _TooltipArrowPainter(direction: .end, color: tooltipColor),
              ),
              Flexible(child: tooltipInner),
            ],
          );
        }

        return CompositedTransformFollower(
          link: _layerLink,
          targetAnchor: targetAnchor,
          followerAnchor: followerAnchor,
          offset: offset,
          child: Align(
            alignment: followerAnchor,
            child: Material(
              color: Colors.transparent,
              child: Opacity(
                opacity: 0.9, // --bs-tooltip-opacity
                child: tooltipWithArrow,
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideTooltip() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        if (!widget.disabled) {
          _showTooltip();
        }
      },
      onLongPressEnd: (_) {
        _hideTooltip();
      },
      child: MouseRegion(
        onEnter: (_) {
          if (!widget.disabled) {
            setState(() => _isHovered = true);
            _showTooltip();
          }
        },
        onExit: (_) {
          setState(() => _isHovered = false);
          _hideTooltip();
        },
        child: Focus(
          onFocusChange: (hasFocus) {
            if (hasFocus && !widget.disabled) {
              _showTooltip();
            } else if (!hasFocus && !_isHovered) {
              _hideTooltip();
            }
          },
          child: CompositedTransformTarget(
            link: _layerLink,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

class _TooltipArrowPainter extends CustomPainter {
  _TooltipArrowPainter({required this.direction, required this.color});

  final BsPlacement direction;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final path = Path();

    switch (direction) {
      case .top:
        path.moveTo(0, 0);
        path.lineTo(size.width, 0);
        path.lineTo(size.width / 2, size.height);
        break;
      case .bottom:
        path.moveTo(0, size.height);
        path.lineTo(size.width, size.height);
        path.lineTo(size.width / 2, 0);
        break;
      case .start:
        path.moveTo(0, 0);
        path.lineTo(0, size.height);
        path.lineTo(size.width, size.height / 2);
        break;
      case .end:
        path.moveTo(size.width, 0);
        path.lineTo(size.width, size.height);
        path.lineTo(0, size.height / 2);
        break;
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _TooltipArrowPainter oldDelegate) {
    return oldDelegate.direction != direction || oldDelegate.color != color;
  }
}

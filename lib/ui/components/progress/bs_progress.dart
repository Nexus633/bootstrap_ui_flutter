import 'package:flutter/material.dart';
import '../../tokens/bootstrap_theme.dart';
import '../../tokens/enums.dart';

// ─── BsProgressBar ────────────────────────────────────────────────────────────

/// A single progress bar segment inside a [BsProgress] container.
///
/// Progress bars show how much of a task is complete.
/// They support custom values, labels, Bootstrap color variants, striped backgrounds,
/// and animated motion.
///
/// See: <https://getbootstrap.com/docs/5.3/components/progress/>
class BsProgressBar extends StatefulWidget {
  /// Creates a [BsProgressBar].
  const BsProgressBar({
    super.key,
    required this.value,
    this.label,
    this.variant = .primary,
    this.striped = false,
    this.animated = false,
    this.color,
    this.textColor,
  }) : assert(
          value >= 0.0 && value <= 100.0,
          'Value must be between 0.0 and 100.0',
        );

  /// The percentage value of the progress bar (from 0.0 to 100.0).
  final double value;

  /// Optional text label to display inside the progress bar segment.
  final String? label;

  /// Optional Bootstrap theme color variant. Defaults to [BsVariant.primary].
  final BsVariant? variant;

  /// Whether the progress bar should have a diagonal striped background pattern.
  final bool striped;

  /// Whether the diagonal stripes should animate/scroll.
  ///
  /// Setting this to true implicitly activates [striped].
  final bool animated;

  /// Custom fill color of the progress bar. Takes precedence over [variant].
  final Color? color;

  /// Custom text color of the progress bar label. Takes precedence over [variant]'s default text color.
  final Color? textColor;

  @override
  State<BsProgressBar> createState() => _BsProgressBarState();
}

class _BsProgressBarState extends State<BsProgressBar> with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  @override
  void didUpdateWidget(covariant BsProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animated != oldWidget.animated) {
      _initAnimation();
    }
  }

  void _initAnimation() {
    if (widget.animated) {
      _controller ??= AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1000),
      );
      _controller!.repeat();
    } else {
      _controller?.stop();
      _controller?.dispose();
      _controller = null;
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Color _getVariantColor(BuildContext context, BsVariant variant) {
    final theme = context.bs;
    switch (variant) {
      case .primary:
        return theme.primary;
      case .secondary:
        return theme.secondary;
      case .success:
        return theme.success;
      case .danger:
        return theme.danger;
      case .warning:
        return theme.warning;
      case .info:
        return theme.info;
      case .light:
        return theme.light;
      case .dark:
        return theme.dark;
    }
  }

  Color _getVariantTextColor(BuildContext context, BsVariant variant) {
    switch (variant) {
      case .light:
      case .warning:
        return const Color(0xFF212529); // Dark text for light/warning backgrounds
      default:
        return Colors.white; // White text for darker backgrounds
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.bs;
    final Color effectiveBarColor = widget.color ??
        (widget.variant != null ? _getVariantColor(context, widget.variant!) : theme.primary);
    final Color effectiveTextColor = widget.textColor ??
        (widget.variant != null ? _getVariantTextColor(context, widget.variant!) : Colors.white);

    Widget content = Container(
      color: effectiveBarColor,
      alignment: Alignment.center,
      child: widget.label != null
          ? Text(
              widget.label!,
              style: TextStyle(
                color: effectiveTextColor,
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Segoe UI',
                height: 1.0,
              ),
              textAlign: TextAlign.center,
              strutStyle: const StrutStyle(
                fontSize: 11.0,
                height: 1.0,
                forceStrutHeight: true,
              ),
              overflow: TextOverflow.ellipsis,
            )
          : const SizedBox.expand(),
    );

    if (widget.striped || widget.animated) {
      if (widget.animated && _controller != null) {
        content = AnimatedBuilder(
          animation: _controller!,
          builder: (context, child) {
            return CustomPaint(
              foregroundPainter: _StripedBarPainter(
                animationValue: _controller!.value,
                stripeColor: Colors.white.withValues(alpha: 0.15),
              ),
              child: child,
            );
          },
          child: content,
        );
      } else {
        content = CustomPaint(
          foregroundPainter: _StripedBarPainter(
            animationValue: 0.0,
            stripeColor: Colors.white.withValues(alpha: 0.15),
          ),
          child: content,
        );
      }
    }

    return content;
  }
}

// ─── BsProgress ───────────────────────────────────────────────────────────────

/// A Bootstrap-style Progress Container.
///
/// Progress components are built with two HTML elements, some CSS widths, and a few attributes.
/// We use [BsProgress] as the outer wrapper and [BsProgressBar] inside it.
///
/// See: <https://getbootstrap.com/docs/5.3/components/progress/>
class BsProgress extends StatelessWidget {
  /// Creates a stacked progress container with multiple [BsProgressBar] segments.
  const BsProgress({
    super.key,
    required this.bars,
    this.height = 16.0,
    this.backgroundColor,
    this.borderRadius,
  });

  /// Convenience constructor to create a [BsProgress] with a single progress segment.
  factory BsProgress.single({
    Key? key,
    required double value,
    String? label,
    BsVariant? variant = .primary,
    bool striped = false,
    bool animated = false,
    double height = 16.0,
    Color? backgroundColor,
    Color? barColor,
    Color? textColor,
    BorderRadius? borderRadius,
  }) {
    return BsProgress(
      key: key,
      height: height,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      bars: [
        BsProgressBar(
          value: value,
          label: label,
          variant: variant,
          striped: striped,
          animated: animated,
          color: barColor,
          textColor: textColor,
        ),
      ],
    );
  }

  /// List of progress segments to display. Supports stacked layouts.
  final List<BsProgressBar> bars;

  /// Custom height of the progress container (Bootstrap defaults to 16px).
  final double height;

  /// Custom background color of the progress container tracks (defaults to light gray or dark gray).
  final Color? backgroundColor;

  /// Custom border radius of the progress track (defaults to 6px).
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color effectiveBgColor =
        backgroundColor ?? (isDark ? const Color(0xFF2B3035) : const Color(0xFFE9ECEF));
    final BorderRadius effectiveRadius = borderRadius ?? BorderRadius.circular(6.0);

    // Calculate sum of bar values to determine if spacer is needed at the end
    double totalValue = 0.0;
    for (final bar in bars) {
      totalValue += bar.value;
    }
    totalValue = totalValue.clamp(0.0, 100.0);

    final List<Widget> children = [];
    for (final bar in bars) {
      if (bar.value > 0.0) {
        children.add(
          Expanded(
            flex: (bar.value * 1000).toInt(),
            child: bar,
          ),
        );
      }
    }

    if (totalValue < 100.0) {
      children.add(
        Expanded(
          flex: ((100.0 - totalValue) * 1000).toInt(),
          child: const SizedBox.shrink(),
        ),
      );
    }

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: effectiveBgColor,
        borderRadius: effectiveRadius,
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}

// ─── _StripedBarPainter ───────────────────────────────────────────────────────

class _StripedBarPainter extends CustomPainter {
  _StripedBarPainter({
    required this.animationValue,
    required this.stripeColor,
  });

  final double animationValue;
  final Color stripeColor;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = stripeColor
      ..style = PaintingStyle.fill;

    final double stripeWidth = size.height;
    final double step = stripeWidth * 2;

    // Shift stripes dynamically based on animation value
    final double offset = animationValue * step;

    canvas.save();
    canvas.clipRect(Offset.zero & size);

    // Draw diagonal bars at a 45-degree angle
    for (double x = -stripeWidth - step; x < size.width + step; x += step) {
      final path = Path()
        ..moveTo(x + offset, 0)
        ..lineTo(x + offset + stripeWidth, 0)
        ..lineTo(x + offset + stripeWidth - size.height, size.height)
        ..lineTo(x + offset - size.height, size.height)
        ..close();

      canvas.drawPath(path, paint);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _StripedBarPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.stripeColor != stripeColor;
  }
}

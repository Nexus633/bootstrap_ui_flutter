import 'package:flutter/material.dart';
import '../../tokens/bootstrap_theme.dart';
import '../../tokens/enums.dart';
import '../../utilities/bs_localizations.dart';

/// A Bootstrap-style Spinner component.
///
/// Use spinners to indicate the loading state of a component or page.
class BsSpinner extends StatelessWidget {
  /// Creates a Bootstrap spinner.
  const BsSpinner({
    super.key,
    this.type = .border,
    this.variant,
    this.color,
    this.size = .md,
    this.animationDuration = const Duration(milliseconds: 750),
    this.semanticsLabel,
  });

  /// Creates a 'border' spinner.
  const BsSpinner.border({
    super.key,
    this.variant,
    this.color,
    this.size = .md,
    this.animationDuration = const Duration(milliseconds: 750),
    this.semanticsLabel,
  }) : type = .border;

  /// Creates a 'grow' spinner.
  const BsSpinner.grow({
    super.key,
    this.variant,
    this.color,
    this.size = .md,
    this.animationDuration = const Duration(milliseconds: 750),
    this.semanticsLabel,
  }) : type = .grow;

  /// The type of spinner to display (border or grow).
  final BsSpinnerType type;

  /// Semantic color variant from the Bootstrap theme.
  final BsVariant? variant;

  /// Custom color. If provided, it overrides [variant].
  /// If neither is provided, the current text color is used.
  final Color? color;

  /// The size of the spinner.
  final BsSpinnerSize size;

  /// Duration for a complete animation cycle. Defaults to 750ms.
  final Duration animationDuration;

  /// Optional custom semantics label for screen readers.
  ///
  /// Defaults to automatic detection via [BsLocalizations.spinner].
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    Color effectiveColor = color ?? Colors.transparent;

    if (color == null) {
      if (variant != null) {
        final bsTheme = context.bs;
        switch (variant!) {
          case .primary:
            effectiveColor = bsTheme.primary;
            break;
          case .secondary:
            effectiveColor = bsTheme.secondary;
            break;
          case .success:
            effectiveColor = bsTheme.success;
            break;
          case .danger:
            effectiveColor = bsTheme.danger;
            break;
          case .warning:
            effectiveColor = bsTheme.warning;
            break;
          case .info:
            effectiveColor = bsTheme.info;
            break;
          case .light:
            effectiveColor = bsTheme.light;
            break;
          case .dark:
            effectiveColor = bsTheme.dark;
            break;
        }
      } else {
        effectiveColor =
            DefaultTextStyle.of(context).style.color ?? context.bs.bodyText;
      }
    }

    final double width = size == .sm ? 16.0 : 32.0;
    final double height = size == .sm ? 16.0 : 32.0;

    final Widget spinnerWidget = type == .grow
        ? SizedBox(
            width: width,
            height: height,
            child: _BsSpinnerGrow(
              color: effectiveColor,
              duration: animationDuration,
            ),
          )
        : SizedBox(
            width: width,
            height: height,
            child: _BsSpinnerBorder(
              color: effectiveColor,
              borderWidth: size == .sm ? 3.2 : 4.0,
              duration: animationDuration,
            ),
          );

    final String label = semanticsLabel ?? (BsLocalizations.of(context)?.spinner ?? 'Loading...');

    return Semantics(
      label: label,
      liveRegion: true,
      child: spinnerWidget,
    );
  }
}

// ─── Border Spinner Implementation ─────────────────────────────────────────────

class _BsSpinnerBorder extends StatefulWidget {
  const _BsSpinnerBorder({
    required this.color,
    required this.borderWidth,
    required this.duration,
  });

  final Color color;
  final double borderWidth;
  final Duration duration;

  @override
  State<_BsSpinnerBorder> createState() => _BsSpinnerBorderState();
}

class _BsSpinnerBorderState extends State<_BsSpinnerBorder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  @override
  void didUpdateWidget(_BsSpinnerBorder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size.infinite,
          painter: _BorderSpinnerPainter(
            color: widget.color,
            borderWidth: widget.borderWidth,
            progress: _controller.value,
          ),
        );
      },
    );
  }
}

class _BorderSpinnerPainter extends CustomPainter {
  _BorderSpinnerPainter({
    required this.color,
    required this.borderWidth,
    required this.progress,
  });

  final Color color;
  final double borderWidth;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    // The gap in the border spinner is exactly one quarter of the circle (right side)
    // In CSS: border-right-color: transparent;
    // We start drawing at 45 deg and sweep for 270 deg.
    // 45 degrees = pi/4
    // 270 degrees = 3*pi/2
    final double rotation = progress * 2 * 3.141592653589793238;
    final double startAngle = (3.141592653589793238 / 4) + rotation;
    const double sweepAngle = 3 * 3.141592653589793238 / 2;

    final Rect rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: size.width - borderWidth,
      height: size.height - borderWidth,
    );

    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant _BorderSpinnerPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.borderWidth != borderWidth ||
        oldDelegate.progress != progress;
  }
}

// ─── Grow Spinner Implementation ───────────────────────────────────────────────

class _BsSpinnerGrow extends StatefulWidget {
  const _BsSpinnerGrow({required this.color, required this.duration});

  final Color color;
  final Duration duration;

  @override
  State<_BsSpinnerGrow> createState() => _BsSpinnerGrowState();
}

class _BsSpinnerGrowState extends State<_BsSpinnerGrow>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  @override
  void didUpdateWidget(_BsSpinnerGrow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final double t = _controller.value;

        // CSS Keyframes:
        // 0% { transform: scale(0); opacity: 0; } (opacity 0 from base class)
        // 50% { opacity: 1; transform: none; }
        // 100% { opacity: 0; transform: none; } (implicit)

        double scale = 1.0;
        double opacity = 0.0;

        if (t <= 0.5) {
          // 0 to 50%
          final double normalized = t / 0.5; // 0.0 to 1.0
          scale = normalized;
          opacity = normalized;
        } else {
          // 50% to 100%
          final double normalized = (t - 0.5) / 0.5; // 0.0 to 1.0
          scale = 1.0;
          opacity = 1.0 - normalized;
        }

        return Transform.scale(
          scale: scale,
          child: Opacity(
            opacity: opacity.clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                color: widget.color,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      },
    );
  }
}

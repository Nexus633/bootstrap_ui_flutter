import 'package:flutter/material.dart';
import '../../tokens/bootstrap_theme.dart';
import '../../tokens/enums.dart';

// ─── BsPlaceholderAnimation ──────────────────────────────────────────────────

/// Animation types for [BsPlaceholder] elements.
enum BsPlaceholderAnimation {
  /// No animation.
  none,

  /// Glow (pulse opacity) animation.
  glow,

  /// Wave (shimmer gradient) animation.
  wave,
}

// ─── BsPlaceholderScope ──────────────────────────────────────────────────────

/// InheritedWidget to propagate animation controller and type down the placeholder tree.
class _BsPlaceholderScope extends InheritedWidget {
  const _BsPlaceholderScope({
    required this.animation,
    required this.controllerValue,
    required super.child,
  });

  final BsPlaceholderAnimation animation;
  final double controllerValue;

  static _BsPlaceholderScope? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_BsPlaceholderScope>();
  }

  @override
  bool updateShouldNotify(_BsPlaceholderScope oldWidget) {
    return animation != oldWidget.animation ||
        controllerValue != oldWidget.controllerValue;
  }
}

// ─── BsPlaceholderContainer ──────────────────────────────────────────────────

/// A container that animates nested [BsPlaceholder] widgets.
///
/// In Bootstrap, placeholder components support animation:
/// - `BsPlaceholderAnimation.glow` (pulse opacity)
/// - `BsPlaceholderAnimation.wave` (linear-gradient shimmer)
///
/// Simply wrap your layout of [BsPlaceholder]s with a [BsPlaceholderContainer].
class BsPlaceholderContainer extends StatefulWidget {
  /// Creates a [BsPlaceholderContainer].
  const BsPlaceholderContainer({
    super.key,
    required this.child,
    this.animation = BsPlaceholderAnimation.glow,
    this.duration = const Duration(milliseconds: 2000),
  });

  /// The child subtree that contains [BsPlaceholder] widgets.
  final Widget child;

  /// The animation type to apply (`glow` or `wave`).
  final BsPlaceholderAnimation animation;

  /// The duration of a full animation cycle.
  final Duration duration;

  @override
  State<BsPlaceholderContainer> createState() => _BsPlaceholderContainerState();
}

class _BsPlaceholderContainerState extends State<BsPlaceholderContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _setupAnimation();
  }

  @override
  void didUpdateWidget(covariant BsPlaceholderContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.animation != widget.animation ||
        oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
      _setupAnimation();
    }
  }

  void _setupAnimation() {
    _controller.stop();
    if (widget.animation == BsPlaceholderAnimation.glow) {
      // Opacity cycles from 0.4 to 1.0 and back
      _controller.repeat(reverse: true);
    } else if (widget.animation == BsPlaceholderAnimation.wave) {
      // Shimmer slides from left to right repeatedly
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
    if (widget.animation == BsPlaceholderAnimation.none) {
      return widget.child;
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return _BsPlaceholderScope(
          animation: widget.animation,
          controllerValue: _controller.value,
          child: child!,
        );
      },
      child: widget.child,
    );
  }
}

// ─── BsPlaceholder ────────────────────────────────────────────────────────────

/// A Bootstrap-style loading placeholder (skeleton) component.
///
/// Use placeholders to build loading states for your components.
/// Can be styled with custom widths, heights, colors, and animations.
///
/// See: <https://getbootstrap.com/docs/5.3/components/placeholders/>
class BsPlaceholder extends StatelessWidget {
  /// Creates a [BsPlaceholder].
  const BsPlaceholder({
    super.key,
    this.width,
    this.widthFactor,
    this.colSpan,
    this.height,
    this.size = BsSize.md,
    this.variant,
    this.color,
    this.borderRadius,
  }) : assert(
          (width == null ? 0 : 1) +
                  (widthFactor == null ? 0 : 1) +
                  (colSpan == null ? 0 : 1) <=
              1,
          'Specify only one of: width, widthFactor, or colSpan',
        );

  /// A fixed width for the placeholder.
  final double? width;

  /// A fractional width relative to the parent (0.0 to 1.0).
  /// Equivalent to Bootstrap's `.w-50` or `.w-75`.
  final double? widthFactor;

  /// Width represented as number of columns in a 12-column grid (1 to 12).
  /// Equivalent to Bootstrap's `.col-6`, `.col-8`, etc.
  final int? colSpan;

  /// A custom height. If null, height is determined by the [size] property.
  final double? height;

  /// Size variant matching Bootstrap's `.placeholder-lg`, `.placeholder-sm`.
  final BsSize size;

  /// Color variant matching Bootstrap's semantic theme colors.
  final BsVariant? variant;

  /// Custom background color, overrides [variant].
  final Color? color;

  /// Custom border radius. Defaults to 4px matching Bootstrap's `.placeholder`.
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = context.bs;

    // Resolve height based on size
    final double resolvedHeight;
    if (height != null) {
      resolvedHeight = height!;
    } else {
      switch (size) {
        case BsSize.sm:
          resolvedHeight = 11.0; // matches .placeholder-sm (.8em ≈ 12px)
          break;
        case BsSize.lg:
          resolvedHeight = 18.0; // matches .placeholder-lg (1.2em ≈ 18px)
          break;
        case BsSize.md:
          resolvedHeight = 14.0; // matches .placeholder (1em ≈ 15px)
          break;
      }
    }

    // Resolve base color
    Color baseColor;
    if (color != null) {
      baseColor = color!;
    } else if (variant != null) {
      baseColor = _resolveVariantColor(variant!, theme);
    } else {
      // Default placeholder background: text color with 17.5% opacity (0.175) or a soft grey
      baseColor = theme.bodyText.withValues(alpha: 0.175);
    }

    final BorderRadius resolvedRadius = borderRadius ?? BorderRadius.circular(4.0);

    // Resolve width sizing constraints
    Widget sizingBox;
    if (width != null) {
      sizingBox = SizedBox(
        width: width,
        height: resolvedHeight,
      );
    } else if (widthFactor != null) {
      sizingBox = FractionallySizedBox(
        widthFactor: widthFactor,
        child: SizedBox(height: resolvedHeight),
      );
    } else if (colSpan != null) {
      final double factor = (colSpan!.clamp(1, 12)) / 12.0;
      sizingBox = FractionallySizedBox(
        widthFactor: factor,
        child: SizedBox(height: resolvedHeight),
      );
    } else {
      sizingBox = SizedBox(
        width: double.infinity,
        height: resolvedHeight,
      );
    }

    final scope = _BsPlaceholderScope.of(context);
    final animation = scope?.animation ?? BsPlaceholderAnimation.none;
    final controllerValue = scope?.controllerValue ?? 0.0;

    Widget content;
    if (animation == BsPlaceholderAnimation.glow) {
      // Pulse animation: opacity transitions smoothly from 0.4 to 1.0
      final double opacity = 0.4 + (0.6 * controllerValue);
      content = Opacity(
        opacity: opacity,
        child: Container(
          decoration: BoxDecoration(
            color: baseColor,
            borderRadius: resolvedRadius,
          ),
        ),
      );
    } else if (animation == BsPlaceholderAnimation.wave) {
      // Wave animation: slides linear gradient over the base background
      content = Container(
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: resolvedRadius,
        ),
        child: ClipRRect(
          borderRadius: resolvedRadius,
          child: CustomPaint(
            painter: _WavePainter(animationValue: controllerValue),
            child: const SizedBox.expand(),
          ),
        ),
      );
    } else {
      content = Container(
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: resolvedRadius,
        ),
      );
    }

    return Stack(
      children: [
        sizingBox,
        Positioned.fill(
          child: content,
        ),
      ],
    );
  }

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
}

// ─── _WavePainter ────────────────────────────────────────────────────────────

class _WavePainter extends CustomPainter {
  _WavePainter({required this.animationValue});

  final double animationValue;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // Sliding gradient: moves from left to right across the element width
    // Linear gradient with transparent - white - transparent
    final double gradientWidth = size.width * 1.5;
    final double left = -gradientWidth + ((size.width + gradientWidth) * animationValue);
    final double right = left + gradientWidth;

    paint.shader = LinearGradient(
      colors: [
        Colors.white.withValues(alpha: 0.0),
        Colors.white.withValues(alpha: 0.35),
        Colors.white.withValues(alpha: 0.0),
      ],
      stops: const [0.0, 0.5, 1.0],
      tileMode: TileMode.clamp,
    ).createShader(Rect.fromLTRB(left, 0, right, size.height));

    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant _WavePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}

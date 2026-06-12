import 'dart:async';
import 'package:flutter/material.dart';
import '../../tokens/spacing.dart';
import '../../tokens/transitions.dart';

/// An InheritedWidget to share carousel-specific state down to captions or other children.
class _BsCarouselScope extends InheritedWidget {
  const _BsCarouselScope({
    required this.dark,
    required super.child,
  });

  final bool dark;

  static _BsCarouselScope? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_BsCarouselScope>();
  }

  @override
  bool updateShouldNotify(_BsCarouselScope oldWidget) {
    return dark != oldWidget.dark;
  }
}

/// A Bootstrap-style carousel slide item.
class BsCarouselItem extends StatelessWidget {
  /// Creates a [BsCarouselItem].
  const BsCarouselItem({
    super.key,
    required this.child,
    this.interval,
    this.caption,
  });

  /// The main widget of the slide (usually an image).
  final Widget child;

  /// Custom autoplay interval for this specific slide.
  ///
  /// If provided, overrides the carousel's default interval.
  final Duration? interval;

  /// Optional caption overlay for this slide.
  final BsCarouselCaption? caption;

  @override
  Widget build(BuildContext context) {
    if (caption != null) {
      return Stack(
        fit: StackFit.expand,
        children: [
          child,
          caption!,
        ],
      );
    }
    return child;
  }
}

/// A Bootstrap-style caption overlay for a carousel slide.
class BsCarouselCaption extends StatelessWidget {
  /// Creates a [BsCarouselCaption].
  const BsCarouselCaption({
    super.key,
    this.title,
    this.description,
    this.color,
    this.alignment = Alignment.bottomCenter,
  });

  /// Optional title widget (typically heading styled).
  final Widget? title;

  /// Optional description widget.
  final Widget? description;

  /// Custom text color.
  ///
  /// If not specified, inherits the carousel's theme-based text color (white or dark).
  final Color? color;

  /// Alignment of the caption within the slide.
  ///
  /// Defaults to [Alignment.bottomCenter].
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    final scope = _BsCarouselScope.of(context);
    final isDark = scope?.dark ?? false;

    // Bootstrap dark variant uses dark gray text (#212529), standard uses white.
    final resolvedColor = color ?? (isDark ? const Color(0xFF212529) : Colors.white);

    final TextStyle defaultStyle = TextStyle(
      color: resolvedColor,
      fontSize: 16.0,
      height: 1.5,
    );

    return Align(
      alignment: alignment,
      child: DefaultTextStyle(
        style: defaultStyle,
        textAlign: TextAlign.center,
        child: Container(
          // Bootstrap standard caption container layout (bottom: 1.25rem, padding-bottom: 1.25rem)
          padding: const EdgeInsets.only(
            left: BsSpacing.s4,
            right: BsSpacing.s4,
            top: BsSpacing.s4,
            bottom: BsSpacing.s5,
          ),
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (title != null) ...[
                DefaultTextStyle(
                  style: defaultStyle.copyWith(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                  child: title!,
                ),
                const SizedBox(height: 8.0),
              ],
              if (description != null) ...[
                DefaultTextStyle(
                  style: defaultStyle.copyWith(
                    color: resolvedColor.withValues(alpha: 0.8),
                    fontSize: 16.0,
                  ),
                  child: description!,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// A Bootstrap-style carousel component for cycling through elements.
///
/// Carousels support controls, indicators, captions, autoplay cycling with
/// custom per-slide intervals, light/dark themes, and touch swipe gestures.
class BsCarousel extends StatefulWidget {
  /// Creates a [BsCarousel].
  const BsCarousel({
    super.key,
    required this.items,
    this.autoplay = true,
    this.defaultInterval = const Duration(seconds: 5),
    this.controls = true,
    this.indicators = true,
    this.fade = false,
    this.pauseOnHover = true,
    this.touch = true,
    this.dark = false,
    this.height,
    this.aspectRatio,
    this.initialIndex = 0,
    this.onSlideChanged,
  });

  /// The list of slides to display.
  final List<BsCarouselItem> items;

  /// Whether the carousel should cycle automatically.
  ///
  /// Defaults to `true`.
  final bool autoplay;

  /// Default duration between slides when cycling.
  ///
  /// Defaults to 5 seconds (5000ms).
  final Duration defaultInterval;

  /// Whether to show the previous and next control arrows.
  ///
  /// Defaults to `true`.
  final bool controls;

  /// Whether to show slide indicator bars at the bottom.
  ///
  /// Defaults to `true`.
  final bool indicators;

  /// Whether to use a cross-fade transition instead of a horizontal slide transition.
  ///
  /// Defaults to `false`.
  final bool fade;

  /// Whether to pause autoplay when the user hovers over the carousel.
  ///
  /// Defaults to `true`.
  final bool pauseOnHover;

  /// Whether to enable swipe gestures to navigate slides.
  ///
  /// Defaults to `true`.
  final bool touch;

  /// Whether to apply the dark variant styling (`.carousel-dark`).
  ///
  /// Adjusts control, indicator, and caption text colors for light backgrounds.
  /// Defaults to `false`.
  final bool dark;

  /// A fixed height for the carousel.
  ///
  /// If both [height] and [aspectRatio] are null, defaults to a height of `300.0`.
  final double? height;

  /// An aspect ratio to constrain the carousel size dynamically.
  ///
  /// If provided, wraps the carousel in an [AspectRatio] widget.
  final double? aspectRatio;

  /// The index of the slide to display initially.
  ///
  /// Defaults to `0`.
  final int initialIndex;

  /// Callback triggered when the active slide changes.
  final ValueChanged<int>? onSlideChanged;

  @override
  State<BsCarousel> createState() => _BsCarouselState();
}

class _BsCarouselState extends State<BsCarousel> {
  late int _currentIndex;
  late PageController _pageController;
  Timer? _autoplayTimer;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex.clamp(0, widget.items.length - 1);
    _pageController = PageController(initialPage: _currentIndex);
    _resetAutoplay();
  }

  @override
  void didUpdateWidget(BsCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.autoplay != widget.autoplay ||
        oldWidget.defaultInterval != widget.defaultInterval ||
        oldWidget.items != widget.items) {
      _resetAutoplay();
    }
  }

  @override
  void dispose() {
    _stopAutoplay();
    _pageController.dispose();
    super.dispose();
  }

  void _resetAutoplay() {
    _stopAutoplay();
    if (widget.autoplay && widget.items.length > 1) {
      _startAutoplay();
    }
  }

  void _startAutoplay() {
    _stopAutoplay();
    if (!widget.autoplay || (widget.pauseOnHover && _isHovering)) return;

    final currentItem = widget.items[_currentIndex];
    final interval = currentItem.interval ?? widget.defaultInterval;

    _autoplayTimer = Timer(interval, () {
      _navigateNext();
    });
  }

  void _stopAutoplay() {
    _autoplayTimer?.cancel();
    _autoplayTimer = null;
  }

  void _navigateNext() {
    final nextIndex = (_currentIndex + 1) % widget.items.length;
    _goToSlide(nextIndex);
  }

  void _navigatePrev() {
    final prevIndex = (_currentIndex - 1 + widget.items.length) % widget.items.length;
    _goToSlide(prevIndex);
  }

  void _goToSlide(int index) {
    if (index == _currentIndex) return;

    setState(() {
      _currentIndex = index;
    });

    if (!widget.fade) {
      // In a normal PageView, animate smoothly
      _pageController.animateToPage(
        index,
        duration: BsTransitions.carouselDuration,
        curve: Curves.easeInOut,
      );
    }

    widget.onSlideChanged?.call(_currentIndex);
    _resetAutoplay();
  }

  void _onPageChanged(int index) {
    if (index == _currentIndex) return;
    setState(() {
      _currentIndex = index;
    });
    widget.onSlideChanged?.call(_currentIndex);
    _resetAutoplay();
  }

  @override
  Widget build(BuildContext context) {
    assert(widget.items.isNotEmpty, 'The carousel must have at least one item');
    // Determine control and indicator colors based on the theme & dark variant
    final Color controlsColor = widget.dark ? const Color(0xFF212529) : Colors.white;

    final Widget carouselBody = MouseRegion(
      onEnter: (_) {
        setState(() => _isHovering = true);
        if (widget.pauseOnHover) _stopAutoplay();
      },
      onExit: (_) {
        setState(() => _isHovering = false);
        if (widget.autoplay) _startAutoplay();
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          // ─── 1. Active Slides ──────────────────────────────────────────────
          _buildSlidesContent(),

          // ─── 2. Indicators (Dashes) ────────────────────────────────────────
          if (widget.indicators && widget.items.length > 1)
            _buildIndicators(controlsColor),

          // ─── 3. Controls (Prev / Next Buttons) ─────────────────────────────
          if (widget.controls && widget.items.length > 1) ...[
            _buildControlDirection(isNext: false, color: controlsColor),
            _buildControlDirection(isNext: true, color: controlsColor),
          ],
        ],
      ),
    );

    // Apply layout boundaries to prevent unconstrained height crashes
    Widget layoutWrapper;
    if (widget.aspectRatio != null) {
      layoutWrapper = AspectRatio(
        aspectRatio: widget.aspectRatio!,
        child: carouselBody,
      );
    } else {
      layoutWrapper = SizedBox(
        height: widget.height ?? 300.0,
        child: carouselBody,
      );
    }

    return _BsCarouselScope(
      dark: widget.dark,
      child: layoutWrapper,
    );
  }

  Widget _buildSlidesContent() {
    if (widget.fade) {
      // Fade Transition Mode
      final Widget currentSlide = AnimatedSwitcher(
        duration: BsTransitions.carouselDuration,
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        transitionBuilder: (child, animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: KeyedSubtree(
          key: ValueKey<int>(_currentIndex),
          child: widget.items[_currentIndex],
        ),
      );

      if (widget.touch) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity! < 0) {
              _navigateNext();
            } else if (details.primaryVelocity! > 0) {
              _navigatePrev();
            }
          },
          child: currentSlide,
        );
      }
      return currentSlide;
    } else {
      // Horizontal Slide Transition Mode (PageView)
      return PageView.builder(
        controller: _pageController,
        itemCount: widget.items.length,
        physics: widget.touch
            ? const ClampingScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        onPageChanged: _onPageChanged,
        itemBuilder: (context, index) {
          return widget.items[index];
        },
      );
    }
  }

  Widget _buildIndicators(Color baseColor) {
    return Positioned(
      bottom: 15,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(widget.items.length, (index) {
          final isActive = index == _currentIndex;
          return GestureDetector(
            onTap: () => _goToSlide(index),
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              child: AnimatedContainer(
                duration: BsTransitions.modalDuration,
                curve: Curves.easeInOut,
                // Premium micro-animation: width stretches when active (similar to modern web sliders)
                width: isActive ? 30.0 : 16.0,
                height: 3.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1.5),
                  color: baseColor.withValues(alpha: isActive ? 1.0 : 0.4),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildControlDirection({required bool isNext, required Color color}) {
    return Positioned(
      top: 0,
      bottom: 0,
      left: isNext ? null : 0,
      right: isNext ? 0 : null,
      child: _CarouselControlButton(
        icon: isNext ? Icons.chevron_right_rounded : Icons.chevron_left_rounded,
        onTap: isNext ? _navigateNext : _navigatePrev,
        color: color,
        isNext: isNext,
      ),
    );
  }
}

/// An internal interactive helper widget to draw the hoverable side buttons.
class _CarouselControlButton extends StatefulWidget {
  const _CarouselControlButton({
    required this.icon,
    required this.onTap,
    required this.color,
    required this.isNext,
  });

  final IconData icon;
  final VoidCallback onTap;
  final Color color;
  final bool isNext;

  @override
  State<_CarouselControlButton> createState() => _CarouselControlButtonState();
}

class _CarouselControlButtonState extends State<_CarouselControlButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // Bootstrap: side buttons stretch full-height and are 15% width of the carousel
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: BsTransitions.baseDuration,
          width: 60,
          height: double.infinity,
          // Premium: subtle hover background gradient
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: widget.isNext ? Alignment.centerLeft : Alignment.centerRight,
              end: widget.isNext ? Alignment.centerRight : Alignment.centerLeft,
              colors: [
                Colors.transparent,
                Colors.black.withValues(alpha: _isHovered ? 0.08 : 0.0),
              ],
            ),
          ),
          alignment: Alignment.center,
          child: AnimatedScale(
            scale: _isHovered ? 1.15 : 1.0,
            duration: BsTransitions.fadeDuration,
            child: AnimatedOpacity(
              opacity: _isHovered ? 0.9 : 0.5,
              duration: BsTransitions.fadeDuration,
              child: Icon(
                widget.icon,
                color: widget.color,
                size: 38,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

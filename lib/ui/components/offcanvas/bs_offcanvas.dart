import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../tokens/bootstrap_theme.dart';
import '../../tokens/colors.dart';
import '../../tokens/enums.dart';
import '../button/bs_close_button.dart';

/// A Bootstrap-style offcanvas panel (`BsOffcanvas`).
///
/// Offcanvas is a sidebar component that can be toggled to slide in from
/// any edge of the viewport (left, right, top, or bottom).
///
/// See: <https://getbootstrap.com/docs/5.3/components/offcanvas/>
class BsOffcanvas extends StatelessWidget {
  /// Creates a [BsOffcanvas] layout.
  const BsOffcanvas({
    super.key,
    this.header,
    required this.body,
    this.placement = BsOffcanvasPlacement.start,
    this.width,
    this.height,
    this.decoration,
    this.variant,
    this.color,
  });

  /// The header of the offcanvas. Typically a [BsOffcanvasHeader].
  final BsOffcanvasHeader? header;

  /// The main body content. Typically a [BsOffcanvasBody].
  final Widget body;

  /// The placement edge of the offcanvas. Defaults to [BsOffcanvasPlacement.start].
  final BsOffcanvasPlacement placement;

  /// The width of the offcanvas panel (only applicable for [BsOffcanvasPlacement.start] and [BsOffcanvasPlacement.end]).
  /// Defaults to 400.0 (clamped to viewport width).
  final double? width;

  /// The height of the offcanvas panel (only applicable for [BsOffcanvasPlacement.top] and [BsOffcanvasPlacement.bottom]).
  /// Defaults to 300.0 (clamped to viewport height).
  final double? height;

  /// Optional decoration override. If null, the default Bootstrap design is applied.
  final BoxDecoration? decoration;

  /// The background and text color variant.
  ///
  /// Maps to Bootstrap's `.text-bg-*` classes. Overrides default offcanvas styling.
  final BsVariant? variant;

  /// A custom background color for the offcanvas.
  ///
  /// Overrides the theme background and [variant] colors.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = context.bs;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // Define standard sizes
    final double defaultWidth = width ?? 400.0;
    final double resolvedWidth = defaultWidth > screenWidth ? screenWidth : defaultWidth;

    final double defaultHeight = height ?? 300.0;
    final double resolvedHeight = defaultHeight > screenHeight ? screenHeight : defaultHeight;

    // Resolve background and text colors
    Color resolvedBgColor;
    Color? resolvedTextColor;

    if (variant != null && color == null) {
      resolvedBgColor = switch (variant!) {
        BsVariant.primary => theme.primary,
        BsVariant.secondary => theme.secondary,
        BsVariant.success => theme.success,
        BsVariant.danger => theme.danger,
        BsVariant.warning => theme.warning,
        BsVariant.info => theme.info,
        BsVariant.light => theme.light,
        BsVariant.dark => theme.dark,
      };

      resolvedTextColor = switch (variant!) {
        BsVariant.primary => BsColors.onPrimary,
        BsVariant.secondary => BsColors.onSecondary,
        BsVariant.success => BsColors.onSuccess,
        BsVariant.danger => BsColors.onDanger,
        BsVariant.warning => BsColors.onWarning,
        BsVariant.info => BsColors.onInfo,
        BsVariant.light => theme.onLight,
        BsVariant.dark => theme.onDark,
      };
    } else {
      resolvedBgColor = color ?? theme.bodyBg;
      resolvedTextColor = color != null ? null : theme.bodyText;
    }

    final Color resolvedBorderColor = variant != null && color == null
        ? (resolvedTextColor?.withValues(alpha: 0.15) ?? theme.border)
        : theme.border;

    // Default decoration
    final Border defaultBorder;
    switch (placement) {
      case BsOffcanvasPlacement.start:
        defaultBorder = Border(right: BorderSide(color: resolvedBorderColor, width: 1.0));
        break;
      case BsOffcanvasPlacement.end:
        defaultBorder = Border(left: BorderSide(color: resolvedBorderColor, width: 1.0));
        break;
      case BsOffcanvasPlacement.top:
        defaultBorder = Border(bottom: BorderSide(color: resolvedBorderColor, width: 1.0));
        break;
      case BsOffcanvasPlacement.bottom:
        defaultBorder = Border(top: BorderSide(color: resolvedBorderColor, width: 1.0));
        break;
    }

    final panelDecoration = decoration ??
        BoxDecoration(
          color: resolvedBgColor,
          border: defaultBorder,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        );

    final panelContent = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ?header,
        body,
      ],
    );

    Widget finalPanel = panelContent;
    if (resolvedTextColor != null) {
      final defaultStyle = DefaultTextStyle.of(context).style.copyWith(color: resolvedTextColor);
      finalPanel = DefaultTextStyle(style: defaultStyle, child: finalPanel);
    }

    // Apply dimensions based on placement
    if (placement == BsOffcanvasPlacement.start || placement == BsOffcanvasPlacement.end) {
      return Container(
        width: resolvedWidth,
        height: double.infinity,
        decoration: panelDecoration,
        child: finalPanel,
      );
    } else {
      return Container(
        width: double.infinity,
        height: resolvedHeight,
        decoration: panelDecoration,
        child: finalPanel,
      );
    }
  }
}

/// A Bootstrap-style offcanvas header (`BsOffcanvasHeader`).
class BsOffcanvasHeader extends StatelessWidget {
  /// Creates a [BsOffcanvasHeader] container.
  const BsOffcanvasHeader({
    super.key,
    required this.child,
    this.showCloseButton = true,
    this.onClosePressed,
    this.padding = const EdgeInsets.all(16),
  });

  /// The title content. Typically a [Text] widget.
  final Widget child;

  /// Whether to display the [BsCloseButton] on the right. Defaults to `true`.
  final bool showCloseButton;

  /// Action callback when the close button is pressed.
  /// If null, default is dismissing the offcanvas with [Navigator.pop].
  final VoidCallback? onClosePressed;

  /// Header padding. Defaults to 16px.
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final theme = context.bs;
    final parentColor = DefaultTextStyle.of(context).style.color;
    final bool isLightText = parentColor != null &&
        ThemeData.estimateBrightnessForColor(parentColor) == Brightness.light;

    return Container(
      padding: padding,
      child: Row(
        children: [
          Expanded(
            child: DefaultTextStyle.merge(
              style: TextStyle(
                fontSize: 20.0, // h5 size
                fontWeight: FontWeight.bold,
                color: parentColor ?? theme.bodyText,
              ),
              child: child,
            ),
          ),
          if (showCloseButton)
            BsCloseButton(
              white: isLightText,
              onPressed: onClosePressed ?? () => Navigator.of(context).pop(),
            ),
        ],
      ),
    );
  }
}

/// A Bootstrap-style offcanvas body (`BsOffcanvasBody`).
class BsOffcanvasBody extends StatelessWidget {
  /// Creates a [BsOffcanvasBody] container.
  const BsOffcanvasBody({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.scrollable = true,
  });

  /// Body content.
  final Widget child;

  /// Body padding. Defaults to 16px.
  final EdgeInsetsGeometry padding;

  /// Whether the body should be scrollable. Defaults to `true`.
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    final theme = context.bs;
    final parentColor = DefaultTextStyle.of(context).style.color;

    Widget content = Padding(
      padding: padding,
      child: DefaultTextStyle.merge(
        style: TextStyle(
          fontSize: 16.0,
          color: parentColor ?? theme.bodyText,
        ),
        child: child,
      ),
    );

    if (scrollable) {
      content = SingleChildScrollView(
        child: content,
      );
    }

    return Expanded(
      child: content,
    );
  }
}

/// Helper stateful widget that wraps the offcanvas content to manage the backdrop
/// and trigger a pulse/shake animation when a static backdrop is tapped.
class _BsOffcanvasBackdropWrapper extends StatefulWidget {
  const _BsOffcanvasBackdropWrapper({
    required this.child,
    required this.animation,
    required this.backdrop,
    required this.showBackdrop,
    required this.alignment,
    required this.keyboard,
  });

  final Widget child;
  final Animation<double> animation;
  final BsBackdrop backdrop;
  final bool showBackdrop;
  final Alignment alignment;
  final bool keyboard;

  @override
  State<_BsOffcanvasBackdropWrapper> createState() =>
      _BsOffcanvasBackdropWrapperState();
}

class _BsOffcanvasBackdropWrapperState
    extends State<_BsOffcanvasBackdropWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _pulseAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.0,
          end: 1.02,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.02,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 50,
      ),
    ]).animate(_pulseController);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _triggerPulse() {
    _pulseController.forward(from: 0.0);
  }

  void _handleBackdropTap() {
    if (widget.backdrop == BsBackdrop.enabled) {
      Navigator.of(context).pop();
    } else if (widget.backdrop == BsBackdrop.static) {
      _triggerPulse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.escape) {
          if (widget.keyboard) {
            Navigator.of(context).pop();
            return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      },
      child: Stack(
        children: [
          // Backdrop Overlay
          if (widget.showBackdrop)
            AnimatedBuilder(
              animation: widget.animation,
              builder: (context, child) {
                return GestureDetector(
                  onTap: _handleBackdropTap,
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    color: Colors.black.withValues(
                      alpha: 0.5 * widget.animation.value,
                    ),
                  ),
                );
              },
            )
          else if (widget.backdrop != BsBackdrop.disabled)
            GestureDetector(
              onTap: _handleBackdropTap,
              behavior: HitTestBehavior.translucent,
            ),

          // Offcanvas container alignment
          Align(
            alignment: widget.alignment,
            child: SafeArea(
              child: GestureDetector(
                onTap:
                    () {}, // Prevent taps on content from bubbling to backdrop
                child: ScaleTransition(
                  scale: _pulseAnimation,
                  child: widget.child,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Helper function to display a Bootstrap-style Offcanvas sidebar.
///
/// Integrates backdrop controls (closing on click, static animation)
/// and keyboard events (Escape key closes dialog).
Future<T?> showBsOffcanvas<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  BsOffcanvasPlacement placement = BsOffcanvasPlacement.start,
  BsBackdrop backdrop = BsBackdrop.enabled,
  bool keyboard = true,
}) {
  final showBackdrop = backdrop != BsBackdrop.disabled;

  final Alignment alignment;
  final Offset beginOffset;
  switch (placement) {
    case BsOffcanvasPlacement.start:
      alignment = Alignment.centerLeft;
      beginOffset = const Offset(-1.0, 0.0);
      break;
    case BsOffcanvasPlacement.end:
      alignment = Alignment.centerRight;
      beginOffset = const Offset(1.0, 0.0);
      break;
    case BsOffcanvasPlacement.top:
      alignment = Alignment.topCenter;
      beginOffset = const Offset(0.0, -1.0);
      break;
    case BsOffcanvasPlacement.bottom:
      alignment = Alignment.bottomCenter;
      beginOffset = const Offset(0.0, 1.0);
      break;
  }

  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: false,
    barrierLabel: 'Dismiss',
    barrierColor: Colors.transparent,
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return builder(context);
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final slideAnimation = Tween<Offset>(
        begin: beginOffset,
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));

      return _BsOffcanvasBackdropWrapper(
        animation: animation,
        backdrop: backdrop,
        showBackdrop: showBackdrop,
        alignment: alignment,
        keyboard: keyboard,
        child: SlideTransition(
          position: slideAnimation,
          child: Material(
            color: Colors.transparent,
            type: MaterialType.transparency,
            child: child,
          ),
        ),
      );
    },
  );
}

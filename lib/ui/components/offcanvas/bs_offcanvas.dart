import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import '../../tokens/bootstrap_theme.dart';
import '../../tokens/colors.dart';
import '../../tokens/enums.dart';
import '../../tokens/shadows.dart';
import '../../tokens/transitions.dart';
import '../../tokens/z_index.dart';
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
    this.placement = .start,
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
        .primary => theme.primary,
        .secondary => theme.secondary,
        .success => theme.success,
        .danger => theme.danger,
        .warning => theme.warning,
        .info => theme.info,
        .light => theme.light,
        .dark => theme.dark,
      };

      resolvedTextColor = switch (variant!) {
        .primary => BsColors.onPrimary,
        .secondary => BsColors.onSecondary,
        .success => BsColors.onSuccess,
        .danger => BsColors.onDanger,
        .warning => BsColors.onWarning,
        .info => BsColors.onInfo,
        .light => theme.onLight,
        .dark => theme.onDark,
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
      case .start:
        defaultBorder = Border(right: BorderSide(color: resolvedBorderColor, width: 1.0));
        break;
      case .end:
        defaultBorder = Border(left: BorderSide(color: resolvedBorderColor, width: 1.0));
        break;
      case .top:
        defaultBorder = Border(bottom: BorderSide(color: resolvedBorderColor, width: 1.0));
        break;
      case .bottom:
        defaultBorder = Border(top: BorderSide(color: resolvedBorderColor, width: 1.0));
        break;
    }

    final panelDecoration = decoration ??
        BoxDecoration(
          color: resolvedBgColor,
          border: defaultBorder,
          boxShadow: BsShadows.regular,
        );

    final panelContent = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ?header,
        Expanded(child: body),
      ],
    );

    Widget finalPanel = panelContent;
    if (resolvedTextColor != null) {
      final defaultStyle = DefaultTextStyle.of(context).style.copyWith(color: resolvedTextColor);
      finalPanel = DefaultTextStyle(style: defaultStyle, child: finalPanel);
    }

    // Apply dimensions based on placement
    if (placement == .start || placement == .end) {
      return Semantics(
        sortKey: const OrdinalSortKey(BsZIndex.offcanvas * 1.0),
        scopesRoute: true,
        namesRoute: true,
        explicitChildNodes: true,
        label: 'Offcanvas',
        child: Container(
          width: resolvedWidth,
          height: double.infinity,
          decoration: panelDecoration,
          child: finalPanel,
        ),
      );
    } else {
      return Semantics(
        sortKey: const OrdinalSortKey(BsZIndex.offcanvas * 1.0),
        scopesRoute: true,
        namesRoute: true,
        explicitChildNodes: true,
        label: 'Offcanvas',
        child: Container(
          width: double.infinity,
          height: resolvedHeight,
          decoration: panelDecoration,
          child: finalPanel,
        ),
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

    return content;
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
      duration: BsTransitions.fadeDuration,
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
    if (widget.backdrop == .enabled) {
      Navigator.of(context).pop();
    } else if (widget.backdrop == .static) {
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
          else if (widget.backdrop != .disabled)
            GestureDetector(
              onTap: _handleBackdropTap,
              behavior: HitTestBehavior.translucent,
              child: const SizedBox.expand(),
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
  BsOffcanvasPlacement placement = .start,
  BsBackdrop backdrop = .enabled,
  bool keyboard = true,
}) {
  final showBackdrop = backdrop != .disabled;

  final Alignment alignment;
  final Offset beginOffset;
  switch (placement) {
    case .start:
      alignment = Alignment.centerLeft;
      beginOffset = const Offset(-1.0, 0.0);
      break;
    case .end:
      alignment = Alignment.centerRight;
      beginOffset = const Offset(1.0, 0.0);
      break;
    case .top:
      alignment = Alignment.topCenter;
      beginOffset = const Offset(0.0, -1.0);
      break;
    case .bottom:
      alignment = Alignment.bottomCenter;
      beginOffset = const Offset(0.0, 1.0);
      break;
  }

  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: false,
    barrierLabel: 'Dismiss',
    barrierColor: Colors.transparent,
    transitionDuration: BsTransitions.modalDuration,
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

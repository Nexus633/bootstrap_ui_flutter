import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../tokens/bootstrap_theme.dart';
import '../../tokens/enums.dart';
import '../button/bs_close_button.dart';

/// A Bootstrap-style modal dialog component (`BsModal`).
///
/// Modals are streamlined, but flexible, dialog prompts.
///
/// See: <https://getbootstrap.com/docs/5.3/components/modal/>
class BsModal extends StatelessWidget {
  const BsModal({
    super.key,
    this.header,
    required this.body,
    this.footer,
    this.size = BsModalSize.md,
    this.centered = false,
    this.scrollable = false,
  });

  /// The header of the modal. Typically a [BsModalHeader].
  final BsModalHeader? header;

  /// The main body content of the modal. Typically a [BsModalBody].
  final Widget body;

  /// The footer of the modal. Typically a [BsModalFooter].
  final BsModalFooter? footer;

  /// The size variant of the modal. Defaults to [BsModalSize.md].
  final BsModalSize size;

  /// Whether the modal should be vertically centered. Defaults to `false`.
  final bool centered;

  /// Whether the modal body should scroll while header/footer stay fixed. Defaults to `false`.
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    final theme = context.bs;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double borderRadiusVal = size == BsModalSize.fullscreen
        ? 0.0
        : (size == BsModalSize.sm ? 4.8 : 8.0);

    final dialogDecoration = BoxDecoration(
      color: theme.bodyBg,
      borderRadius: BorderRadius.circular(borderRadiusVal),
      border: Border.all(color: theme.border, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.15),
          blurRadius: 16,
          offset: const Offset(0, 8),
        ),
      ],
    );

    final double modalWidth = _resolveWidth(context, screenWidth);

    if (size == BsModalSize.fullscreen) {
      return Container(
        width: screenWidth,
        height: screenHeight,
        decoration: dialogDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ?header,
            Expanded(
              child: scrollable ? SingleChildScrollView(child: body) : body,
            ),
            ?footer,
          ],
        ),
      );
    }

    if (scrollable) {
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: modalWidth,
          maxHeight: screenHeight - 60,
        ),
        child: Container(
          decoration: dialogDecoration,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ?header,
              Flexible(
                child: SingleChildScrollView(
                  child: body,
                ),
              ),
              ?footer,
            ],
          ),
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(
          top: centered ? 0.0 : 30.0,
          bottom: centered ? 0.0 : 30.0,
        ),
        width: modalWidth,
        decoration: dialogDecoration,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ?header,
            body,
            ?footer,
          ],
        ),
      );
    }
  }

  double _resolveWidth(BuildContext context, double screenWidth) {
    double maxWidth;
    switch (size) {
      case BsModalSize.sm:
        maxWidth = 300.0;
        break;
      case BsModalSize.md:
        maxWidth = 500.0;
        break;
      case BsModalSize.lg:
        maxWidth = 800.0;
        break;
      case BsModalSize.xl:
        maxWidth = 1140.0;
        break;
      case BsModalSize.fullscreen:
        maxWidth = screenWidth;
        break;
    }

    if (screenWidth < 576.0) {
      return screenWidth - 20.0; // 10px margin on each side on mobile
    } else {
      return screenWidth < maxWidth ? screenWidth - 40.0 : maxWidth;
    }
  }
}

/// A Bootstrap-style modal header (`BsModalHeader`).
class BsModalHeader extends StatelessWidget {
  const BsModalHeader({
    super.key,
    required this.child,
    this.showCloseButton = true,
    this.onClosePressed,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
  });

  /// The title content. Typically a [Text] widget.
  final Widget child;

  /// Whether to display the [BsCloseButton] on the right. Defaults to `true`.
  final bool showCloseButton;

  /// Action callback when the close button is pressed.
  /// If null, default is dismissing the modal with [Navigator.pop].
  final VoidCallback? onClosePressed;

  /// Header padding. Defaults to 20px horizontal and 16px vertical.
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final theme = context.bs;
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: theme.border, width: 1.0),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: DefaultTextStyle.merge(
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: theme.bodyText,
              ),
              child: child,
            ),
          ),
          if (showCloseButton)
            BsCloseButton(
              onPressed: onClosePressed ?? () => Navigator.of(context).pop(),
            ),
        ],
      ),
    );
  }
}

/// A Bootstrap-style modal body (`BsModalBody`).
class BsModalBody extends StatelessWidget {
  const BsModalBody({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
  });

  /// Body content.
  final Widget child;

  /// Body padding. Defaults to 20px on all sides.
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final theme = context.bs;
    return Padding(
      padding: padding,
      child: DefaultTextStyle.merge(
        style: TextStyle(
          fontSize: 16.0,
          color: theme.bodyText,
        ),
        child: child,
      ),
    );
  }
}

/// A Bootstrap-style modal footer (`BsModalFooter`).
class BsModalFooter extends StatelessWidget {
  const BsModalFooter({
    super.key,
    required this.children,
    this.padding = const EdgeInsets.all(16),
    this.alignment = MainAxisAlignment.end,
  });

  /// Action buttons in the footer.
  final List<Widget> children;

  /// Footer padding. Defaults to 16px.
  final EdgeInsetsGeometry padding;

  /// Alignment of the footer buttons. Defaults to [MainAxisAlignment.end].
  final MainAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    final theme = context.bs;

    // Apply Bootstrap default button spacing (gap-2 = 8px)
    final List<Widget> spacedChildren = [];
    for (int i = 0; i < children.length; i++) {
      spacedChildren.add(children[i]);
      if (i < children.length - 1) {
        spacedChildren.add(const SizedBox(width: 8));
      }
    }

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: theme.border, width: 1.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: alignment,
        children: spacedChildren,
      ),
    );
  }
}

/// Helper stateful widget that wraps the dialog content to manage the modal backdrop
/// and trigger a pulse/shake animation when a static backdrop is tapped.
class _BsModalBackdropWrapper extends StatefulWidget {
  const _BsModalBackdropWrapper({
    required this.child,
    required this.animation,
    required this.backdrop,
    required this.showBackdrop,
    required this.alignment,
    required this.keyboard,
  });

  final Widget child;
  final Animation<double> animation;
  final BsModalBackdrop backdrop;
  final bool showBackdrop;
  final Alignment alignment;
  final bool keyboard;

  @override
  State<_BsModalBackdropWrapper> createState() => _BsModalBackdropWrapperState();
}

class _BsModalBackdropWrapperState extends State<_BsModalBackdropWrapper> with SingleTickerProviderStateMixin {
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
        tween: Tween<double>(begin: 1.0, end: 1.025).chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.025, end: 1.0).chain(CurveTween(curve: Curves.easeIn)),
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
    if (widget.backdrop == BsModalBackdrop.enabled) {
      Navigator.of(context).pop();
    } else if (widget.backdrop == BsModalBackdrop.static) {
      _triggerPulse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.escape) {
          if (widget.keyboard) {
            Navigator.of(context).pop();
            return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      },
      child: Stack(
        children: [
          // Backdrop Overlay (renders behind the scrolling area)
          if (widget.showBackdrop)
            AnimatedBuilder(
              animation: widget.animation,
              builder: (context, child) {
                return Container(
                  color: Colors.black.withValues(alpha: 0.5 * widget.animation.value),
                );
              },
            ),
          // Scrollable layout container
          Positioned.fill(
            child: GestureDetector(
              onTap: _handleBackdropTap,
              behavior: HitTestBehavior.opaque,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  // Ensure container is at least full height of screen so backdrop click works everywhere
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: Align(
                    alignment: widget.alignment,
                    child: SafeArea(
                      child: GestureDetector(
                        onTap: () {}, // Prevent taps on modal content from bubbling up to backdrop
                        child: ScaleTransition(
                          scale: _pulseAnimation,
                          child: widget.child,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Helper function to display a Bootstrap-style Modal dialog.
///
/// Integrates backdrop controls (closing on click, static animation)
/// and keyboard events (Escape key closes dialog).
Future<T?> showBsModal<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  BsModalBackdrop backdrop = BsModalBackdrop.enabled,
  bool keyboard = true,
  bool centered = false,
}) {
  final showBackdrop = backdrop != BsModalBackdrop.disabled;
  final alignment = centered ? Alignment.center : Alignment.topCenter;

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
        begin: const Offset(0, -0.05),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      ));

      return _BsModalBackdropWrapper(
        animation: animation,
        backdrop: backdrop,
        showBackdrop: showBackdrop,
        alignment: alignment,
        keyboard: keyboard,
        child: FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: slideAnimation,
            child: Material(
              color: Colors.transparent,
              type: MaterialType.transparency,
              child: child,
            ),
          ),
        ),
      );
    },
  );
}

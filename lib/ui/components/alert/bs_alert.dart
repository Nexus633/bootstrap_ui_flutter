import 'dart:async';
import 'package:flutter/material.dart';
import '../../tokens/bootstrap_theme.dart';
import '../../tokens/enums.dart';
import '../../utilities/size_extension.dart';
import '../../utilities/spacing_extension.dart';

/// A Bootstrap-style alert component.
///
/// Alerts are used to provide contextual feedback messages for typical user actions
/// with the handful of available and flexible alert messages.
class BsAlert extends StatefulWidget {
  /// Creates a [BsAlert] widget.
  const BsAlert({
    super.key,
    required this.child,
    this.variant = BsAlertVariant.primary,
    this.icon,
    this.iconColor,
    this.iconVariant,
    this.dismissible = false,
    this.onClose,
    this.animation = BsAlertAnimation.fade,
    this.animationInDuration = const Duration(milliseconds: 200),
    this.animationOutDuration = const Duration(milliseconds: 200),
    this.autoCloseDuration,
  });

  /// The text or content of the alert.
  final Widget child;

  /// The color variant of the alert.
  final BsAlertVariant variant;

  /// An optional icon to the left of the text.
  final IconData? icon;

  /// Specific color for the icon. If null, uses the variant's text color.
  final Color? iconColor;

  /// Variant color for the icon.
  final BsIconVariant? iconVariant;

  /// Shows an "X" (close icon) on the right side.
  final bool dismissible;

  /// Called when the close icon is clicked.
  final VoidCallback? onClose;

  /// The type of animation when showing and hiding.
  final BsAlertAnimation animation;

  /// The duration of the animation when showing.
  /// Default is 200ms (Bootstrap standard).
  final Duration animationInDuration;

  /// The duration of the animation when hiding.
  /// Default is 200ms (Bootstrap standard).
  final Duration animationOutDuration;

  /// If set, the alert closes automatically after this duration.
  final Duration? autoCloseDuration;

  @override
  State<BsAlert> createState() => _BsAlertState();
}

class _BsAlertState extends State<BsAlert> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _curvedAnimation;
  late Animation<Offset> _slideAnimation;
  Timer? _autoCloseTimer;

  @override
  void initState() {
    super.initState();

    // Bootstrap fades are fast (approx. 150-200ms in CSS)
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationInDuration,
      reverseDuration: widget.animationOutDuration,
    );

    _curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _updateSlideAnimation();

    if (widget.animation == BsAlertAnimation.none) {
      _controller.value = 1.0;
    } else {
      _controller.forward();
    }

    if (widget.autoCloseDuration != null) {
      _autoCloseTimer = Timer(widget.autoCloseDuration!, () {
        if (mounted) _handleClose();
      });
    }
  }

  void _updateSlideAnimation() {
    _slideAnimation = Tween<Offset>(
      begin: _getBeginOffset(),
      end: Offset.zero,
    ).animate(_curvedAnimation);
  }

  Offset _getBeginOffset() {
    return switch (widget.animation) {
      BsAlertAnimation.slideTop => const Offset(0, -1),
      BsAlertAnimation.slideBottom => const Offset(0, 1),
      BsAlertAnimation.slideLeft => const Offset(-1, 0),
      BsAlertAnimation.slideRight => const Offset(1, 0),
      _ => Offset.zero,
    };
  }

  @override
  void didUpdateWidget(BsAlert oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.animation != widget.animation) {
      _updateSlideAnimation();
    }
  }

  @override
  void dispose() {
    _autoCloseTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _handleClose() {
    if (widget.animation == BsAlertAnimation.none) {
      _controller.value = 0.0; // Hide immediately
      widget.onClose?.call();
    } else {
      _controller.reverse().then((_) {
        widget.onClose?.call();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _AlertColors colors = _resolveColors(widget.variant);

    Widget content = Container(
      decoration: BoxDecoration(
        color: colors.backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: colors.borderColor, width: 1.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.icon != null) ...[
            Icon(
              widget.icon,
              color: _resolveIconColor(colors.iconColor),
              size: 24,
            ),
            const SizedBox(width: 12),
          ],
          DefaultTextStyle(
            style: TextStyle(color: colors.textColor, fontSize: 16),
            child: widget.child,
          ).expanded(),
          if (widget.dismissible) ...[
            const SizedBox(width: 12),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: _handleClose,
                borderRadius: BorderRadius.circular(4.0),
                child: Icon(
                  Icons.close,
                  color: colors.textColor.withValues(alpha: 0.5),
                  size: 20,
                ).p(2),
              ),
            ),
          ],
        ],
      ).p3(),
    ).w100().pb3();

    Widget animatedContent = content;

    // Fade Transition (becomes a jump-cut when 'none' is selected)
    animatedContent = FadeTransition(
      opacity: _curvedAnimation,
      child: animatedContent,
    );

    // Slide Transition (only if a slide animation was selected)
    if (widget.animation != BsAlertAnimation.fade &&
        widget.animation != BsAlertAnimation.none) {
      animatedContent = SlideTransition(
        position: _slideAnimation,
        child: animatedContent,
      );
    }

    // Size Transition for the "collapsing" of the layout
    return SizeTransition(
      sizeFactor: _curvedAnimation,
      alignment: Alignment.topCenter,
      child: animatedContent,
    );
  }

  Color _resolveIconColor(Color fallback) {
    if (widget.iconVariant != null) {
      final bs = context.bs;
      return switch (widget.iconVariant!) {
        BsIconVariant.primary => bs.primary,
        BsIconVariant.secondary => bs.secondary,
        BsIconVariant.success => bs.success,
        BsIconVariant.danger => bs.danger,
        BsIconVariant.warning => bs.warning,
        BsIconVariant.info => bs.info,
        BsIconVariant.light => const Color(0xFFF8F9FA),
        BsIconVariant.dark => const Color(0xFF212529),
      };
    }
    return widget.iconColor ?? fallback;
  }

  _AlertColors _resolveColors(BsAlertVariant variant) {
    final bs = context.bs;

    final Color textColor = switch (variant) {
      BsAlertVariant.primary => bs.primaryTextEmphasis,
      BsAlertVariant.secondary => bs.secondaryTextEmphasis,
      BsAlertVariant.success => bs.successTextEmphasis,
      BsAlertVariant.danger => bs.dangerTextEmphasis,
      BsAlertVariant.warning => bs.warningTextEmphasis,
      BsAlertVariant.info => bs.infoTextEmphasis,
      BsAlertVariant.light => bs.lightTextEmphasis,
      BsAlertVariant.dark => bs.darkTextEmphasis,
    };

    final Color bgColor = switch (variant) {
      BsAlertVariant.primary => bs.primaryBgSubtle,
      BsAlertVariant.secondary => bs.secondaryBgSubtle,
      BsAlertVariant.success => bs.successBgSubtle,
      BsAlertVariant.danger => bs.dangerBgSubtle,
      BsAlertVariant.warning => bs.warningBgSubtle,
      BsAlertVariant.info => bs.infoBgSubtle,
      BsAlertVariant.light => bs.lightBgSubtle,
      BsAlertVariant.dark => bs.darkBgSubtle,
    };

    final Color borderColor = switch (variant) {
      BsAlertVariant.primary => bs.primaryBorderSubtle,
      BsAlertVariant.secondary => bs.secondaryBorderSubtle,
      BsAlertVariant.success => bs.successBorderSubtle,
      BsAlertVariant.danger => bs.dangerBorderSubtle,
      BsAlertVariant.warning => bs.warningBorderSubtle,
      BsAlertVariant.info => bs.infoBorderSubtle,
      BsAlertVariant.light => bs.lightBorderSubtle,
      BsAlertVariant.dark => bs.darkBorderSubtle,
    };

    return _AlertColors(
      backgroundColor: bgColor,
      borderColor: borderColor,
      textColor: textColor,
      iconColor: textColor,
    );
  }
}

class _AlertColors {
  const _AlertColors({
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
    required this.iconColor,
  });
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final Color iconColor;
}

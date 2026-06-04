import 'dart:async';
import 'package:flutter/material.dart';
import '../../tokens/bootstrap_theme.dart';
import '../../tokens/enums.dart';

class BsAlert extends StatefulWidget {
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

  /// Der Text oder Inhalt des Alerts.
  final Widget child;
  final BsAlertVariant variant;

  /// Ein optionales Icon links neben dem Text.
  final IconData? icon;

  final Color? iconColor;

  final BsIconVariant? iconVariant;

  /// Zeigt ein "X" (Schließen-Icon) auf der rechten Seite.
  final bool dismissible;

  /// Wird aufgerufen, wenn das Schließen-Icon geklickt wird.
  final VoidCallback? onClose;

  /// Die Art der Animation beim Ein- und Ausblenden.
  final BsAlertAnimation animation;

  /// Die Dauer der Animation beim Einblenden.
  /// Standardmäßig 200ms (Bootstrap-Standard).
  final Duration animationInDuration;

  /// Die Dauer der Animation beim Ausblenden.
  /// Standardmäßig 200ms (Bootstrap-Standard).
  final Duration animationOutDuration;

  /// Wenn gesetzt, schließt sich der Alert nach dieser Dauer automatisch.
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

    // Bootstrap-Fades sind schnell (ca. 150-200ms in CSS)
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
      _controller.value = 0.0; // Sofort ausblenden
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

    Widget content = Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
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
            Expanded(
              child: DefaultTextStyle(
                style: TextStyle(color: colors.textColor, fontSize: 16),
                child: widget.child,
              ),
            ),
            if (widget.dismissible) ...[
              const SizedBox(width: 12),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _handleClose,
                  borderRadius: BorderRadius.circular(4.0),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Icon(
                      Icons.close,
                      color: colors.textColor.withValues(alpha: 0.5),
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );

    Widget animatedContent = content;

    // Fade Transition (wird bei 'none' zum Jump-Cut)
    animatedContent = FadeTransition(
      opacity: _curvedAnimation,
      child: animatedContent,
    );

    // Slide Transition (nur wenn eine Slide-Animation gewählt wurde)
    if (widget.animation != BsAlertAnimation.fade &&
        widget.animation != BsAlertAnimation.none) {
      animatedContent = SlideTransition(
        position: _slideAnimation,
        child: animatedContent,
      );
    }

    // Size Transition für das "Zusammenschieben" des Layouts
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

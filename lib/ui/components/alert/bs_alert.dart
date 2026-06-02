import 'package:flutter/material.dart';
import '../../tokens/colors.dart';

enum BsAlertVariant {
  primary,
  secondary,
  success,
  danger,
  warning,
  info,
  light,
  dark,
}

class BsAlert extends StatefulWidget {
  const BsAlert({
    super.key,
    required this.child,
    this.variant = BsAlertVariant.primary,
    this.icon,
    this.dismissible = false,
    this.onClose,
  });

  /// Der Text oder Inhalt des Alerts.
  final Widget child;
  final BsAlertVariant variant;

  /// Ein optionales Icon links neben dem Text.
  final IconData? icon;

  /// Zeigt ein "X" (Schließen-Icon) auf der rechten Seite.
  final bool dismissible;

  /// Wird aufgerufen, wenn das Schließen-Icon geklickt wird.
  final VoidCallback? onClose;

  @override
  State<BsAlert> createState() => _BsAlertState();
}

class _BsAlertState extends State<BsAlert> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();

    // Bootstrap-Fades sind schnell (ca. 150-200ms in CSS)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _sizeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // Initial komplett sichtbar
    _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleClose() {
    // 1. Spiele die Animation rückwärts ab (Ausblenden + Schrumpfen)
    _controller.reverse().then((_) {
      // 2. Erst wenn die Animation fertig ist, Callback feuern
      widget.onClose?.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    final _AlertColors colors = _resolveColors(widget.variant);

    return SizeTransition(
      sizeFactor: _sizeAnimation,
      alignment: Alignment.topCenter, // Klappt nach oben zusammen
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Padding(
          // Abstand nach unten in die Animation gepackt, damit er weich verschwindet
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
            decoration: BoxDecoration(
              color: colors.backgroundColor,
              borderRadius: BorderRadius.circular(
                8.0,
              ), // Anpassen an dein Token
              border: Border.all(color: colors.borderColor, width: 1.0),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.icon != null) ...[
                  Icon(widget.icon, color: colors.iconColor, size: 24),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: DefaultTextStyle(
                    style: TextStyle(
                      color: colors.textColor,
                      fontSize: 16, // Anpassen an dein Token
                    ),
                    child: widget.child,
                  ),
                ),
                if (widget.dismissible) ...[
                  const SizedBox(width: 12),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: _handleClose, // Triggert die Exit-Animation
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
        ),
      ),
    );
  }

  // ─── Farb-Logik (Simulation der Bootstrap CSS-Variablen) ───────────────────

  _AlertColors _resolveColors(BsAlertVariant variant) {
    final Color baseColor = switch (variant) {
      BsAlertVariant.primary => BsColors.primary,
      BsAlertVariant.secondary => BsColors.secondary,
      BsAlertVariant.success => BsColors.success,
      BsAlertVariant.danger => BsColors.danger,
      BsAlertVariant.warning => BsColors.warning,
      BsAlertVariant.info => BsColors.info,
      BsAlertVariant.light => BsColors.light,
      BsAlertVariant.dark => BsColors.dark,
    };

    final Color textColor = switch (variant) {
      BsAlertVariant.warning => BsColors.body,
      BsAlertVariant.info => BsColors.body,
      BsAlertVariant.light => BsColors.body,
      BsAlertVariant.dark => BsColors.onDark,
      _ => _darken(baseColor, 0.3),
    };

    final Color bgColor = variant == BsAlertVariant.dark
        ? BsColors.dark
        : baseColor.withValues(alpha: 0.15);

    final Color borderColor = variant == BsAlertVariant.dark
        ? BsColors.dark
        : baseColor.withValues(alpha: 0.3);

    return _AlertColors(
      backgroundColor: bgColor,
      borderColor: borderColor,
      textColor: textColor,
      iconColor: variant == BsAlertVariant.dark ? Colors.white : baseColor,
    );
  }

  Color _darken(Color color, double amount) {
    final hsl = HSLColor.fromColor(color);
    return hsl
        .withLightness((hsl.lightness - amount).clamp(0.0, 1.0))
        .toColor();
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

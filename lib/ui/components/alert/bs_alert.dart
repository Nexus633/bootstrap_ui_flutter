import 'package:bs_flutter_ui/ui/bs_ui.dart';
import 'package:flutter/material.dart';

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
      iconColor: textColor, // Bootstrap nutzt dieselbe Farbe für Icons im Alert
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

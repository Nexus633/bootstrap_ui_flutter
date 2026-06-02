import 'package:flutter/material.dart';

/// Bootstrap 5 Farben — direkt aus den CSS-Variablen übernommen.
/// Quelle: https://getbootstrap.com/docs/5.3/customize/color/
abstract class BsColors {
  // ─── Brand Colors ────────────────────────────────────────────────────────
  static const Color primary = Color(0xFF0d6efd); // --bs-primary
  static const Color secondary = Color(0xFF6c757d); // --bs-secondary
  static const Color success = Color(0xFF198754); // --bs-success
  static const Color danger = Color(0xFFdc3545); // --bs-danger
  static const Color warning = Color(0xFFffc107); // --bs-warning
  static const Color info = Color(0xFF0dcaf0); // --bs-info
  static const Color light = Color(0xFFf8f9fa); // --bs-light
  static const Color dark = Color(0xFF212529); // --bs-dark

  // ─── Text on Brand Colors ─────────────────────────────────────────────────
  // Bootstrap berechnet diese automatisch — wir definieren sie fix.
  static const Color onPrimary = Colors.white;
  static const Color onSecondary = Colors.white;
  static const Color onSuccess = Colors.white;
  static const Color onDanger = Colors.white;
  static const Color onWarning = Color(
    0xFF212529,
  ); // dunkel, weil Gelb hell ist
  static const Color onInfo = Color(0xFF212529); // dunkel, weil Cyan hell ist
  static const Color onLight = Color(0xFF212529);
  static const Color onDark = Colors.white;

  // ─── Neutral / Body ──────────────────────────────────────────────────────
  static const Color body = Color(0xFF212529); // --bs-body-color
  static const Color bodyBg = Color(0xFFffffff); // --bs-body-bg
  static const Color mutedText = Color(0xFF6c757d); // text-muted
  static const Color border = Color(0xFFdee2e6); // --bs-border-color
  static const Color borderLight = Color(0xFFe9ecef);
  static const Color disabledBg = Color(0xFFe9ecef);
  static const Color disabledText = Color(0xFF6c757d);

  // ─── Hover-Varianten (Bootstrap dimmt ~20%) ───────────────────────────────
  static const Color primaryHover = Color(0xFF0b5ed7);
  static const Color secondaryHover = Color(0xFF5c636a);
  static const Color successHover = Color(0xFF157347);
  static const Color dangerHover = Color(0xFFb02a37);
  static const Color warningHover = Color(0xFFffca2c);
  static const Color infoHover = Color(0xFF31d2f2);
  static const Color lightHover = Color(0xFFf9fafb);
  static const Color darkHover = Color(0xFF1c1f23);
}

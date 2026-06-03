import 'package:flutter/material.dart';

/// Bootstrap 5.3 Farbpalette — exakte Werte aus _variables.scss.
///
/// Alle Tint/Shade-Werte werden via mix() berechnet (identisch zu
/// Bootstraps tint-color() / shade-color() Sass-Funktionen).
abstract class BsColors {
  // ─── Semantische Theme-Farben ────────────────────────────────────────────
  // Quelle: $theme-colors in _variables.scss
  static const Color primary = Color(0xFF0D6EFD); // $blue
  static const Color secondary = Color(0xFF6C757D); // $gray-600
  static const Color success = Color(0xFF198754); // $green
  static const Color danger = Color(0xFFDC3545); // $red
  static const Color warning = Color(0xFFFFC107); // $yellow
  static const Color info = Color(0xFF0DCAF0); // $cyan
  static const Color light = Color(0xFFF8F9FA); // $gray-100
  static const Color dark = Color(0xFF212529); // $gray-900

  // ─── Text auf semantischen Farben ────────────────────────────────────────
  // Bootstrap berechnet diese per color-contrast() — hier als feste Werte.
  static const Color onPrimary = Colors.white;
  static const Color onSecondary = Colors.white;
  static const Color onSuccess = Colors.white;
  static const Color onDanger = Colors.white;
  static const Color onWarning = Color(0xFF212529); // dunkel auf Gelb
  static const Color onInfo = Color(0xFF212529); // dunkel auf Cyan
  static const Color onLight = Color(0xFF212529);
  static const Color onDark = Colors.white;

  // ─── Body / Struktur ─────────────────────────────────────────────────────
  static const Color bodyBg = Color(0xFFFFFFFF); // --bs-body-bg
  static const Color border = Color(
    0xFFDEE2E6,
  ); // --bs-border-color ($gray-300)
  static const Color disabledBg = Color(0xFFE9ECEF); // $gray-200
  static const Color disabledText = Color(0xFF6C757D); // $gray-600

  // ─── Hover-Varianten ─────────────────────────────────────────────────────
  // Bootstrap shade-color($color, 20%)
  static const Color primaryHover = Color(0xFF0A58CA); // blue-600
  static const Color secondaryHover = Color(0xFF565E64); // gray-700 shade-20
  static const Color successHover = Color(0xFF146C43); // green-600
  static const Color dangerHover = Color(0xFFB02A37); // red-600
  static const Color warningHover = Color(0xFFCC9A06); // yellow-600
  static const Color infoHover = Color(0xFF0AA2C0); // cyan-600
  static const Color lightHover = Color(
    0xFFE9ECEF,
  ); // gray-200 (tint-20 of gray-100)
  static const Color darkHover = Color(0xFF1A1E21); // gray-900 shade-20

  // ─── Farbpaletten (100–900) ───────────────────────────────────────────────
  // Berechnet via: tint-color($base, x%) = mix(white, $base, x%)
  //                shade-color($base, x%) = mix(black, $base, x%)

  static const MaterialColor blue = MaterialColor(0xFF0D6EFD, {
    100: Color(0xFFCFE2FF),
    200: Color(0xFF9EC5FE),
    300: Color(0xFF6EA8FE),
    400: Color(0xFF3D8BFD),
    500: Color(0xFF0D6EFD),
    600: Color(0xFF0A58CA),
    700: Color(0xFF084298),
    800: Color(0xFF052C65),
    900: Color(0xFF031633),
  });

  static const MaterialColor indigo = MaterialColor(0xFF6610F2, {
    100: Color(0xFFE0CFFC),
    200: Color(0xFFC29FFA),
    300: Color(0xFFA370F7),
    400: Color(0xFF8540F5),
    500: Color(0xFF6610F2),
    600: Color(0xFF520DC2),
    700: Color(0xFF3D0A91),
    800: Color(0xFF290661),
    900: Color(0xFF140330),
  });

  static const MaterialColor purple = MaterialColor(0xFF6F42C1, {
    100: Color(0xFFE2D9F3),
    200: Color(0xFFC5B3E6),
    300: Color(0xFFA98EDA),
    400: Color(0xFF8C68CD),
    500: Color(0xFF6F42C1),
    600: Color(0xFF59359A),
    700: Color(0xFF432874),
    800: Color(0xFF2C1A4D),
    900: Color(0xFF160D27),
  });

  static const MaterialColor pink = MaterialColor(0xFFD63384, {
    100: Color(0xFFF7D6E6),
    200: Color(0xFFEFADCE),
    300: Color(0xFFE685B5),
    400: Color(0xFFDE5C9D),
    500: Color(0xFFD63384),
    600: Color(0xFFAB296A),
    700: Color(0xFF801F4F),
    800: Color(0xFF561435),
    900: Color(0xFF2B0A1A),
  });

  static const MaterialColor red = MaterialColor(0xFFDC3545, {
    100: Color(0xFFF8D7DA),
    200: Color(0xFFF1AEB5),
    300: Color(0xFFEA868F),
    400: Color(0xFFE35D6A),
    500: Color(0xFFDC3545),
    600: Color(0xFFB02A37),
    700: Color(0xFF842029),
    800: Color(0xFF58151C),
    900: Color(0xFF2C0B0E),
  });

  static const MaterialColor orange = MaterialColor(0xFFFD7E14, {
    100: Color(0xFFFFE5D0),
    200: Color(0xFFFECBA1),
    300: Color(0xFFFEB272),
    400: Color(0xFFFD9843),
    500: Color(0xFFFD7E14),
    600: Color(0xFFCA6510),
    700: Color(0xFF984C0C),
    800: Color(0xFF653208),
    900: Color(0xFF331904),
  });

  static const MaterialColor yellow = MaterialColor(0xFFFFC107, {
    100: Color(0xFFFFF3CD),
    200: Color(0xFFFFE69C),
    300: Color(0xFFFFDA6A),
    400: Color(0xFFFFCD39),
    500: Color(0xFFFFC107),
    600: Color(0xFFCC9A06),
    700: Color(0xFF997404),
    800: Color(0xFF664D03),
    900: Color(0xFF332701),
  });

  static const MaterialColor green = MaterialColor(0xFF198754, {
    100: Color(0xFFD1E7DD),
    200: Color(0xFFA3CFBB),
    300: Color(0xFF75B798),
    400: Color(0xFF479F76),
    500: Color(0xFF198754),
    600: Color(0xFF146C43),
    700: Color(0xFF0F5132),
    800: Color(0xFF0A3622),
    900: Color(0xFF051B11),
  });

  static const MaterialColor teal = MaterialColor(0xFF20C997, {
    100: Color(0xFFD2F4EA),
    200: Color(0xFFA6E9D5),
    300: Color(0xFF79DFC1),
    400: Color(0xFF4DD4AC),
    500: Color(0xFF20C997),
    600: Color(0xFF1AA179),
    700: Color(0xFF13795B),
    800: Color(0xFF0D503C),
    900: Color(0xFF06281E),
  });

  static const MaterialColor cyan = MaterialColor(0xFF0DCAF0, {
    100: Color(0xFFCFF4FC),
    200: Color(0xFF9EEAF9),
    300: Color(0xFF6EDFF6),
    400: Color(0xFF3DD5F3),
    500: Color(0xFF0DCAF0),
    600: Color(0xFF0AA2C0),
    700: Color(0xFF087990),
    800: Color(0xFF055160),
    900: Color(0xFF032830),
  });

  static const MaterialColor gray = MaterialColor(0xFFADB5BD, {
    100: Color(0xFFF8F9FA),
    200: Color(0xFFE9ECEF),
    300: Color(0xFFDEE2E6),
    400: Color(0xFFCED4DA),
    500: Color(0xFFADB5BD),
    600: Color(0xFF6C757D),
    700: Color(0xFF495057),
    800: Color(0xFF343A40),
    900: Color(0xFF212529),
  });
}

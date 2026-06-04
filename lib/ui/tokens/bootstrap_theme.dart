import 'package:flutter/material.dart';
import 'colors.dart';

/// Bootstrap 5.3 Theme Extension for Flutter.
///
/// All color values reference BsColors palettes — no hardcoded
/// hex values except where Bootstrap itself specifies fixed values
/// (e.g., rgba transparencies and bodyBg white/black).
class BsThemeData extends ThemeExtension<BsThemeData> {
  /// Creates a [BsThemeData] instance with the given Bootstrap-specific colors.
  const BsThemeData({
    // ── Main Semantic Colors ────────────────────────────────────────────
    required this.primary,
    required this.secondary,
    required this.success,
    required this.danger,
    required this.warning,
    required this.info,
    required this.light,
    required this.dark,

    // ── Body Text ─────────────────────────────────────────────────────────
    // --bs-body-color           → bodyText
    // --bs-secondary-color      → bodyTextSecondary   (.text-body-secondary)
    // --bs-tertiary-color       → bodyTextTertiary    (.text-body-tertiary)
    // --bs-emphasis-color       → emphasisColor       (.text-body-emphasis)
    required this.bodyText,
    required this.bodyTextSecondary,
    required this.bodyTextTertiary,
    required this.emphasisColor,

    // ── Body Backgrounds ──────────────────────────────────────────────────
    // --bs-body-bg              → bodyBg
    // --bs-secondary-bg         → bodyBgSecondary
    // --bs-tertiary-bg          → bodyBgTertiary
    required this.bodyBg,
    required this.bodyBgSecondary,
    required this.bodyBgTertiary,

    // ── Borders ───────────────────────────────────────────────────────────
    // --bs-border-color         → border
    // --bs-border-color-translucent → borderTranslucent
    required this.border,
    required this.borderTranslucent,

    // ── Links ─────────────────────────────────────────────────────────────
    required this.linkColor,
    required this.linkHoverColor,

    // ── Text Emphasis (for Alerts, Badges, etc.) ───────────────────────────
    // --bs-{color}-text-emphasis
    required this.primaryTextEmphasis,
    required this.secondaryTextEmphasis,
    required this.successTextEmphasis,
    required this.dangerTextEmphasis,
    required this.warningTextEmphasis,
    required this.infoTextEmphasis,
    required this.lightTextEmphasis,
    required this.darkTextEmphasis,

    // ── Subtle Backgrounds (for Alerts, Badges, etc.) ──────────────────────
    // --bs-{color}-bg-subtle
    required this.primaryBgSubtle,
    required this.secondaryBgSubtle,
    required this.successBgSubtle,
    required this.dangerBgSubtle,
    required this.warningBgSubtle,
    required this.infoBgSubtle,
    required this.lightBgSubtle,
    required this.darkBgSubtle,

    // ── Subtle Borders ────────────────────────────────────────────────────
    // --bs-{color}-border-subtle
    required this.primaryBorderSubtle,
    required this.secondaryBorderSubtle,
    required this.successBorderSubtle,
    required this.dangerBorderSubtle,
    required this.warningBorderSubtle,
    required this.infoBorderSubtle,
    required this.lightBorderSubtle,
    required this.darkBorderSubtle,
  });

  final Color primary;
  final Color secondary;
  final Color success;
  final Color danger;
  final Color warning;
  final Color info;
  final Color light;
  final Color dark;

  final Color bodyText;
  final Color bodyTextSecondary;
  final Color bodyTextTertiary;
  final Color emphasisColor;

  /// The main background color of the body.
  final Color bodyBg;
  final Color bodyBgSecondary;
  final Color bodyBgTertiary;

  final Color border;
  final Color borderTranslucent;

  final Color linkColor;
  final Color linkHoverColor;

  final Color primaryTextEmphasis;
  final Color secondaryTextEmphasis;
  final Color successTextEmphasis;
  final Color dangerTextEmphasis;
  final Color warningTextEmphasis;
  final Color infoTextEmphasis;
  final Color lightTextEmphasis;
  final Color darkTextEmphasis;

  final Color primaryBgSubtle;
  final Color secondaryBgSubtle;
  final Color successBgSubtle;
  final Color dangerBgSubtle;
  final Color warningBgSubtle;
  final Color infoBgSubtle;
  final Color lightBgSubtle;
  final Color darkBgSubtle;

  final Color primaryBorderSubtle;
  final Color secondaryBorderSubtle;
  final Color successBorderSubtle;
  final Color dangerBorderSubtle;
  final Color warningBorderSubtle;
  final Color infoBorderSubtle;
  final Color lightBorderSubtle;
  final Color darkBorderSubtle;

  // ─── Light Theme ─────────────────────────────────────────────────────────
  // Source: _root.scss :root / [data-bs-theme=light]
  //
  // Mapping Logic:
  //   bodyText           = gray[900]            ($body-color)
  //   bodyTextSecondary  = gray[900] @ 75%      (rgba($body-color, .75))
  //   bodyTextTertiary   = gray[900] @ 50%      (rgba($body-color, .50))
  //   emphasisColor      = black                ($black)
  //   bodyBg             = white                ($body-bg)
  //   bodyBgSecondary    = gray[200]            ($secondary-bg)
  //   bodyBgTertiary     = gray[100]            ($tertiary-bg)
  //   border             = gray[300]            ($border-color)
  //   borderTranslucent  = black @ 17.5%        (rgba(0,0,0,.175))
  //   linkColor          = blue[500]            ($primary)
  //   linkHoverColor     = blue[700]            (shade-color($primary, 20%) = blue-600)
  //
  //   *TextEmphasis  = shade-color($color, 60%) → 800 stop of the respective palette
  //   *BgSubtle      = tint-color($color, 80%)  → 100 stop
  //   *BorderSubtle  = tint-color($color, 60%)  → 200 stop
  static final BsThemeData lightTheme = BsThemeData(
    primary: BsColors.primary,
    secondary: BsColors.secondary,
    success: BsColors.success,
    danger: BsColors.danger,
    warning: BsColors.warning,
    info: BsColors.info,
    light: BsColors.light,
    dark: BsColors.dark,

    bodyText: BsColors.gray[900]!,
    bodyTextSecondary: BsColors.gray[900]!.withValues(alpha: 0.75),
    bodyTextTertiary: BsColors.gray[900]!.withValues(alpha: 0.50),
    emphasisColor: const Color(0xFF000000),

    bodyBg: BsColors.bodyBg,
    bodyBgSecondary: BsColors.gray[200]!, // $gray-200 = #e9ecef
    bodyBgTertiary: BsColors.gray[100]!, // $gray-100 = #f8f9fa

    border: BsColors.gray[300]!, // $gray-300 = #dee2e6
    borderTranslucent: const Color(0x2D000000), // rgba(0,0,0,.175)

    linkColor: BsColors.blue[500]!, // $primary = blue-500
    linkHoverColor:
        BsColors.blue[600]!, // shade-color($primary, 20%) = blue-600
    // shade-color($color, 60%) = 800 stop
    primaryTextEmphasis: BsColors.blue[800]!,
    secondaryTextEmphasis: BsColors.gray[700]!,
    successTextEmphasis: BsColors.green[800]!,
    dangerTextEmphasis: BsColors.red[800]!,
    warningTextEmphasis: BsColors.yellow[800]!,
    infoTextEmphasis: BsColors.cyan[800]!,
    lightTextEmphasis: BsColors.gray[600]!,
    darkTextEmphasis: BsColors.gray[600]!,

    // tint-color($color, 80%) = 100 stop
    primaryBgSubtle: BsColors.blue[100]!,
    secondaryBgSubtle: BsColors
        .gray[100]!, // tint-color($secondary, 80%) ≈ gray-100 range; Bootstrap uses #e2e3e5, close to gray-200
    successBgSubtle: BsColors.green[100]!,
    dangerBgSubtle: BsColors.red[100]!,
    warningBgSubtle: BsColors.yellow[100]!,
    infoBgSubtle: BsColors.cyan[100]!,
    lightBgSubtle: BsColors.gray[100]!, // tint-color($light, 80%) ≈ gray-100
    darkBgSubtle: BsColors.gray[400]!, // Bootstrap: #ced4da = gray-400
    // tint-color($color, 60%) = 200 stop
    primaryBorderSubtle: BsColors.blue[200]!,
    secondaryBorderSubtle: BsColors.gray[200]!,
    successBorderSubtle: BsColors.green[200]!,
    dangerBorderSubtle: BsColors.red[200]!,
    warningBorderSubtle: BsColors.yellow[200]!,
    infoBorderSubtle: BsColors.cyan[200]!,
    lightBorderSubtle: BsColors.gray[200]!,
    darkBorderSubtle: BsColors.gray[500]!, // Bootstrap: #adb5bd = gray-500
  );

  // ─── Dark Theme ──────────────────────────────────────────────────────────
  // Source: _variables-dark.scss / [data-bs-theme=dark]
  //
  // Mapping Logic:
  //   bodyText           = gray[300]            ($body-color-dark = $gray-300)
  //   bodyTextSecondary  = gray[300] @ 75%      (rgba($body-color-dark, .75))
  //   bodyTextTertiary   = gray[300] @ 50%
  //   emphasisColor      = white
  //   bodyBg             = gray[900]            ($body-bg-dark = $gray-900)
  //   bodyBgSecondary    = gray[800] (#343a40)  ($secondary-bg-dark)
  //   bodyBgTertiary     = #2b3035              ($tertiary-bg-dark — no exact palette stop)
  //   border             = gray[700]            ($border-color-dark = $gray-700)
  //   borderTranslucent  = white @ 15%          (rgba(255,255,255,.15))
  //   linkColor          = blue[300]            (tint-color($primary, 40%))
  //   linkHoverColor     = blue[200]            (tint-color($primary, 60%)) — Bootstrap: #8bb9fe
  //                                              Note: Bootstrap specifies #8bb9fe, which lies between
  //                                              blue-200 (#9EC5FE) and blue-300 (#6EA8FE).
  //                                              We use blue[200] as the next stop.
  //
  //   *TextEmphasis  = tint-color($color, 40%)  → 300 stop
  //   *BgSubtle      = shade-color($color, 80%) → 900 stop
  //   *BorderSubtle  = shade-color($color, 40%) → 700 stop (partially 600)
  static final BsThemeData darkTheme = BsThemeData(
    // Semantic colors remain unchanged in Dark Mode.
    // Components use *TextEmphasis/*BgSubtle tokens for dark representation.
    primary: BsColors.primary,
    secondary: BsColors.secondary,
    success: BsColors.success,
    danger: BsColors.danger,
    warning: BsColors.warning,
    info: BsColors.info,
    light: BsColors.gray[800]!,
    dark: BsColors.gray[200]!,

    bodyText: BsColors.gray[300]!,
    bodyTextSecondary: BsColors.gray[300]!.withValues(alpha: 0.75),
    bodyTextTertiary: BsColors.gray[300]!.withValues(alpha: 0.50),
    emphasisColor: const Color(0xFFFFFFFF),

    bodyBg: BsColors.gray[900]!,
    bodyBgSecondary: BsColors.gray[800]!, // #343a40 = gray-800
    bodyBgTertiary: const Color(
      0xFF2B3035,
    ), // Bootstrap fixed value — no exact palette stop

    border: BsColors.gray[700]!, // #495057 = gray-700
    borderTranslucent: const Color(0x26FFFFFF), // rgba(255,255,255,.15)

    linkColor: BsColors.blue[300]!, // tint-color($primary, 40%) = blue-300
    linkHoverColor: BsColors.blue[200]!, // next stop to #8bb9fe
    // tint-color($color, 40%) = 300 stop
    primaryTextEmphasis: BsColors.blue[300]!,
    secondaryTextEmphasis:
        BsColors.gray[400]!, // Bootstrap: #a7acb1 — between gray-400/500
    successTextEmphasis: BsColors.green[300]!,
    dangerTextEmphasis: BsColors.red[300]!,
    warningTextEmphasis: BsColors.yellow[300]!,
    infoTextEmphasis: BsColors.cyan[300]!,
    lightTextEmphasis: BsColors.gray[100]!,
    darkTextEmphasis: BsColors.gray[300]!,

    // shade-color($color, 80%) = 900 stop
    primaryBgSubtle: BsColors.blue[900]!,
    secondaryBgSubtle: BsColors.gray[900]!,
    successBgSubtle: BsColors.green[900]!,
    dangerBgSubtle: BsColors.red[900]!,
    warningBgSubtle: BsColors.yellow[900]!,
    infoBgSubtle: BsColors.cyan[900]!,
    lightBgSubtle: BsColors.gray[800]!,
    darkBgSubtle:
        BsColors.gray[900]!, // Bootstrap: #1a1d20 — shade-color(gray-800, 20%)
    // shade-color($color, 40%) = 700 stop
    primaryBorderSubtle: BsColors.blue[700]!,
    secondaryBorderSubtle: BsColors.gray[700]!,
    successBorderSubtle: BsColors.green[700]!,
    dangerBorderSubtle: BsColors.red[700]!,
    warningBorderSubtle: BsColors.yellow[700]!,
    infoBorderSubtle: BsColors.cyan[700]!,
    lightBorderSubtle: BsColors.gray[600]!,
    darkBorderSubtle: BsColors.gray[800]!,
  );

  // ─── Boilerplate ─────────────────────────────────────────────────────────

  @override
  BsThemeData copyWith({
    Color? primary,
    Color? secondary,
    Color? success,
    Color? danger,
    Color? warning,
    Color? info,
    Color? light,
    Color? dark,
    Color? bodyText,
    Color? bodyTextSecondary,
    Color? bodyTextTertiary,
    Color? emphasisColor,
    Color? bodyBg,
    Color? bodyBgSecondary,
    Color? bodyBgTertiary,
    Color? border,
    Color? borderTranslucent,
    Color? linkColor,
    Color? linkHoverColor,
    Color? primaryTextEmphasis,
    Color? secondaryTextEmphasis,
    Color? successTextEmphasis,
    Color? dangerTextEmphasis,
    Color? warningTextEmphasis,
    Color? infoTextEmphasis,
    Color? lightTextEmphasis,
    Color? darkTextEmphasis,
    Color? primaryBgSubtle,
    Color? secondaryBgSubtle,
    Color? successBgSubtle,
    Color? dangerBgSubtle,
    Color? warningBgSubtle,
    Color? infoBgSubtle,
    Color? lightBgSubtle,
    Color? darkBgSubtle,
    Color? primaryBorderSubtle,
    Color? secondaryBorderSubtle,
    Color? successBorderSubtle,
    Color? dangerBorderSubtle,
    Color? warningBorderSubtle,
    Color? infoBorderSubtle,
    Color? lightBorderSubtle,
    Color? darkBorderSubtle,
  }) {
    return BsThemeData(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      success: success ?? this.success,
      danger: danger ?? this.danger,
      warning: warning ?? this.warning,
      info: info ?? this.info,
      light: light ?? this.light,
      dark: dark ?? this.dark,
      bodyText: bodyText ?? this.bodyText,
      bodyTextSecondary: bodyTextSecondary ?? this.bodyTextSecondary,
      bodyTextTertiary: bodyTextTertiary ?? this.bodyTextTertiary,
      emphasisColor: emphasisColor ?? this.emphasisColor,
      bodyBg: bodyBg ?? this.bodyBg,
      bodyBgSecondary: bodyBgSecondary ?? this.bodyBgSecondary,
      bodyBgTertiary: bodyBgTertiary ?? this.bodyBgTertiary,
      border: border ?? this.border,
      borderTranslucent: borderTranslucent ?? this.borderTranslucent,
      linkColor: linkColor ?? this.linkColor,
      linkHoverColor: linkHoverColor ?? this.linkHoverColor,
      primaryTextEmphasis: primaryTextEmphasis ?? this.primaryTextEmphasis,
      secondaryTextEmphasis:
          secondaryTextEmphasis ?? this.secondaryTextEmphasis,
      successTextEmphasis: successTextEmphasis ?? this.successTextEmphasis,
      dangerTextEmphasis: dangerTextEmphasis ?? this.dangerTextEmphasis,
      warningTextEmphasis: warningTextEmphasis ?? this.warningTextEmphasis,
      infoTextEmphasis: infoTextEmphasis ?? this.infoTextEmphasis,
      lightTextEmphasis: lightTextEmphasis ?? this.lightTextEmphasis,
      darkTextEmphasis: darkTextEmphasis ?? this.darkTextEmphasis,
      primaryBgSubtle: primaryBgSubtle ?? this.primaryBgSubtle,
      secondaryBgSubtle: secondaryBgSubtle ?? this.secondaryBgSubtle,
      successBgSubtle: successBgSubtle ?? this.successBgSubtle,
      dangerBgSubtle: dangerBgSubtle ?? this.dangerBgSubtle,
      warningBgSubtle: warningBgSubtle ?? this.warningBgSubtle,
      infoBgSubtle: infoBgSubtle ?? this.infoBgSubtle,
      lightBgSubtle: lightBgSubtle ?? this.lightBgSubtle,
      darkBgSubtle: darkBgSubtle ?? this.darkBgSubtle,
      primaryBorderSubtle: primaryBorderSubtle ?? this.primaryBorderSubtle,
      secondaryBorderSubtle:
          secondaryBorderSubtle ?? this.secondaryBorderSubtle,
      successBorderSubtle: successBorderSubtle ?? this.successBorderSubtle,
      dangerBorderSubtle: dangerBorderSubtle ?? this.dangerBorderSubtle,
      warningBorderSubtle: warningBorderSubtle ?? this.warningBorderSubtle,
      infoBorderSubtle: infoBorderSubtle ?? this.infoBorderSubtle,
      lightBorderSubtle: lightBorderSubtle ?? this.lightBorderSubtle,
      darkBorderSubtle: darkBorderSubtle ?? this.darkBorderSubtle,
    );
  }

  @override
  BsThemeData lerp(ThemeExtension<BsThemeData>? other, double t) {
    if (other is! BsThemeData) return this;
    return BsThemeData(
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      success: Color.lerp(success, other.success, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
      light: Color.lerp(light, other.light, t)!,
      dark: Color.lerp(dark, other.dark, t)!,
      bodyText: Color.lerp(bodyText, other.bodyText, t)!,
      bodyTextSecondary: Color.lerp(
        bodyTextSecondary,
        other.bodyTextSecondary,
        t,
      )!,
      bodyTextTertiary: Color.lerp(
        bodyTextTertiary,
        other.bodyTextTertiary,
        t,
      )!,
      emphasisColor: Color.lerp(emphasisColor, other.emphasisColor, t)!,
      bodyBg: Color.lerp(bodyBg, other.bodyBg, t)!,
      bodyBgSecondary: Color.lerp(bodyBgSecondary, other.bodyBgSecondary, t)!,
      bodyBgTertiary: Color.lerp(bodyBgTertiary, other.bodyBgTertiary, t)!,
      border: Color.lerp(border, other.border, t)!,
      borderTranslucent: Color.lerp(
        borderTranslucent,
        other.borderTranslucent,
        t,
      )!,
      linkColor: Color.lerp(linkColor, other.linkColor, t)!,
      linkHoverColor: Color.lerp(linkHoverColor, other.linkHoverColor, t)!,
      primaryTextEmphasis: Color.lerp(
        primaryTextEmphasis,
        other.primaryTextEmphasis,
        t,
      )!,
      secondaryTextEmphasis: Color.lerp(
        secondaryTextEmphasis,
        other.secondaryTextEmphasis,
        t,
      )!,
      successTextEmphasis: Color.lerp(
        successTextEmphasis,
        other.successTextEmphasis,
        t,
      )!,
      dangerTextEmphasis: Color.lerp(
        dangerTextEmphasis,
        other.dangerTextEmphasis,
        t,
      )!,
      warningTextEmphasis: Color.lerp(
        warningTextEmphasis,
        other.warningTextEmphasis,
        t,
      )!,
      infoTextEmphasis: Color.lerp(
        infoTextEmphasis,
        other.infoTextEmphasis,
        t,
      )!,
      lightTextEmphasis: Color.lerp(
        lightTextEmphasis,
        other.lightTextEmphasis,
        t,
      )!,
      darkTextEmphasis: Color.lerp(
        darkTextEmphasis,
        other.darkTextEmphasis,
        t,
      )!,
      primaryBgSubtle: Color.lerp(primaryBgSubtle, other.primaryBgSubtle, t)!,
      secondaryBgSubtle: Color.lerp(
        secondaryBgSubtle,
        other.secondaryBgSubtle,
        t,
      )!,
      successBgSubtle: Color.lerp(successBgSubtle, other.successBgSubtle, t)!,
      dangerBgSubtle: Color.lerp(dangerBgSubtle, other.dangerBgSubtle, t)!,
      warningBgSubtle: Color.lerp(warningBgSubtle, other.warningBgSubtle, t)!,
      infoBgSubtle: Color.lerp(infoBgSubtle, other.infoBgSubtle, t)!,
      lightBgSubtle: Color.lerp(lightBgSubtle, other.lightBgSubtle, t)!,
      darkBgSubtle: Color.lerp(darkBgSubtle, other.darkBgSubtle, t)!,
      primaryBorderSubtle: Color.lerp(
        primaryBorderSubtle,
        other.primaryBorderSubtle,
        t,
      )!,
      secondaryBorderSubtle: Color.lerp(
        secondaryBorderSubtle,
        other.secondaryBorderSubtle,
        t,
      )!,
      successBorderSubtle: Color.lerp(
        successBorderSubtle,
        other.successBorderSubtle,
        t,
      )!,
      dangerBorderSubtle: Color.lerp(
        dangerBorderSubtle,
        other.dangerBorderSubtle,
        t,
      )!,
      warningBorderSubtle: Color.lerp(
        warningBorderSubtle,
        other.warningBorderSubtle,
        t,
      )!,
      infoBorderSubtle: Color.lerp(
        infoBorderSubtle,
        other.infoBorderSubtle,
        t,
      )!,
      lightBorderSubtle: Color.lerp(
        lightBorderSubtle,
        other.lightBorderSubtle,
        t,
      )!,
      darkBorderSubtle: Color.lerp(
        darkBorderSubtle,
        other.darkBorderSubtle,
        t,
      )!,
    );
  }
}

/// Provides access to [BsThemeData] from the [BuildContext].
extension BsThemeContext on BuildContext {
  /// Returns the [BsThemeData] defined in the current [Theme].
  BsThemeData get bs => Theme.of(this).extension<BsThemeData>()!;
}

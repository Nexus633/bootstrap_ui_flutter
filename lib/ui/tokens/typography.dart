import 'package:flutter/material.dart';

/// Bootstrap 5 Typography-System.
/// Bootstrap uses system-near fonts — in Flutter we use the standard font
/// and define sizes/weights exactly according to Bootstrap.
/// Source: https://getbootstrap.com/docs/5.3/content/typography/
abstract class BsTypography {
  // ─── Font Sizes ──────────────────────────────────────────────────────────

  /// Base font size for body text (16px, 1rem).
  static const double fontSizeBase = 16.0;

  /// Small font size, used for small buttons and components (14px, 0.875rem).
  static const double fontSizeSm = 14.0;

  /// Large font size, used for large buttons and components (20px, 1.25rem).
  static const double fontSizeLg = 20.0;

  /// Base icon size for icons (16px).
  static const double iconSizeBase = 16.0;

  /// Small icon size (14px).
  static const double iconSizeSm = 14.0;

  /// Large icon size (20px).
  static const double iconSizeLg = 20.0;

  /// Font size for h1 headings (40px, 2.5rem).
  static const double h1 = 40.0;

  /// Font size for h2 headings (32px, 2rem).
  static const double h2 = 32.0;

  /// Font size for h3 headings (28px, 1.75rem).
  static const double h3 = 28.0;

  /// Font size for h4 headings (24px, 1.5rem).
  static const double h4 = 24.0;

  /// Font size for h5 headings (20px, 1.25rem).
  static const double h5 = 20.0;

  /// Font size for h6 headings (16px, 1rem).
  static const double h6 = 16.0;

  /// Font size for display-1 (80px, 5rem).
  static const double display1 = 80.0;

  /// Font size for display-2 (72px, 4.5rem).
  static const double display2 = 72.0;

  /// Font size for display-3 (64px, 4rem).
  static const double display3 = 64.0;

  /// Font size for display-4 (56px, 3.5rem).
  static const double display4 = 56.0;

  /// Font size for display-5 (48px, 3rem).
  static const double display5 = 48.0;

  /// Font size for display-6 (40px, 2.5rem).
  static const double display6 = 40.0;

  // ─── Font Weights ─────────────────────────────────────────────────────────

  /// Font weight light (w300).
  static const FontWeight weightLight = FontWeight.w300;

  /// Font weight normal (w400).
  static const FontWeight weightNormal = FontWeight.w400;

  /// Font weight medium (w500).
  static const FontWeight weightMedium = FontWeight.w500;

  /// Font weight bold (w700).
  static const FontWeight weightBold = FontWeight.w700;

  /// Default font weight for standard headings (w500).
  static const FontWeight weightHeadings = FontWeight.w500;

  /// Font weight for display headings (w300).
  static const FontWeight weightDisplay = FontWeight.w300;

  // ─── Line Heights ─────────────────────────────────────────────────────────

  /// Default line height for body text (1.5).
  static const double lineHeightBase = 1.5;

  /// Line height for small components (1.25).
  static const double lineHeightSm = 1.25;

  /// Line height for large components (2.0).
  static const double lineHeightLg = 2.0;

  /// Line height for standard headings (1.2).
  static const double lineHeightHeadings = 1.2;

  /// Line height for display headings (1.2).
  static const double lineHeightDisplay = 1.2;

  // ─── Ready-to-use TextStyle objects ────────────────────────────────────────────

  /// Ready-to-use TextStyle for body text with base size, normal weight, and base line height.
  static const TextStyle body = TextStyle(
    fontSize: fontSizeBase,
    fontWeight: weightNormal,
    height: lineHeightBase,
  );

  /// Ready-to-use TextStyle for small buttons with small font size, normal weight, and base line height.
  static const TextStyle btnSm = TextStyle(
    fontSize: fontSizeSm,
    fontWeight: weightNormal,
    height: lineHeightBase,
  );

  /// Ready-to-use TextStyle for medium (default) buttons with base font size, normal weight, and base line height.
  static const TextStyle btnMd = TextStyle(
    fontSize: fontSizeBase,
    fontWeight: weightNormal,
    height: lineHeightBase,
  );

  /// Ready-to-use TextStyle for large buttons with large font size, normal weight, and base line height.
  static const TextStyle btnLg = TextStyle(
    fontSize: fontSizeLg,
    fontWeight: weightNormal,
    height: lineHeightBase,
  );
}

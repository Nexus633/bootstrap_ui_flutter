// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

/// Bootstrap 5 Typography-System.
/// Bootstrap uses system-near fonts — in Flutter we use the standard font
/// and define sizes/weights exactly according to Bootstrap.
/// Source: https://getbootstrap.com/docs/5.3/content/typography/
abstract class BsTypography {
  // ─── Font Sizes ──────────────────────────────────────────────────────────
  // --bs-body-font-size: 1rem = 16px
  static const double fontSizeBase = 16.0;
  // Button sm: 0.875rem = 14px
  static const double fontSizeSm = 14.0;
  // Button lg: 1.25rem = 20px
  static const double fontSizeLg = 20.0;

  // Headings
  static const double h1 = 40.0; // 2.5rem
  static const double h2 = 32.0; // 2rem
  static const double h3 = 28.0; // 1.75rem
  static const double h4 = 24.0; // 1.5rem
  static const double h5 = 20.0; // 1.25rem
  static const double h6 = 16.0; // 1rem

  // ─── Font Weights ─────────────────────────────────────────────────────────
  static const FontWeight weightLight = FontWeight.w300;
  static const FontWeight weightNormal =
      FontWeight.w400; // --bs-body-font-weight
  static const FontWeight weightMedium = FontWeight.w500;
  static const FontWeight weightBold = FontWeight.w700;
  static const FontWeight weightHeadings = FontWeight.w500; // headings

  // ─── Line Heights ─────────────────────────────────────────────────────────
  static const double lineHeightBase = 1.5; // --bs-body-line-height
  static const double lineHeightSm = 1.25; // --bs-line-height-sm
  static const double lineHeightLg = 2.0; // --bs-line-height-lg
  // --bs-heading-line-height
  static const double lineHeightHeadings = 1.2;

  // ─── Ready-to-use TextStyle objects ────────────────────────────────────────────
  static const TextStyle body = TextStyle(
    fontSize: fontSizeBase,
    fontWeight: weightNormal,
    height: lineHeightBase,
  );

  static const TextStyle btnSm = TextStyle(
    fontSize: fontSizeSm,
    fontWeight: weightNormal,
    height: lineHeightBase,
  );

  static const TextStyle btnMd = TextStyle(
    fontSize: fontSizeBase,
    fontWeight: weightNormal,
    height: lineHeightBase,
  );

  static const TextStyle btnLg = TextStyle(
    fontSize: fontSizeLg,
    fontWeight: weightNormal,
    height: lineHeightBase,
  );
}

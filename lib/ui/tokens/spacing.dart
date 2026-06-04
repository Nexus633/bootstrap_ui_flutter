import 'package:flutter/material.dart';

/// Bootstrap 5 Spacing-System.
/// Bootstrap uses a base of 1rem = 16px and multiplies by 0.25 steps.
/// Source: https://getbootstrap.com/docs/5.3/utilities/spacing/
abstract class BsSpacing {
  // Base: 1rem = 16px
  static const double base = 16.0;

  // $spacer * 0.25 → 4px
  static const double s1 = 4.0;
  // $spacer * 0.5  → 8px
  static const double s2 = 8.0;
  // $spacer * 1    → 16px
  static const double s3 = 16.0;
  // $spacer * 1.5  → 24px
  static const double s4 = 24.0;
  // $spacer * 3    → 48px
  static const double s5 = 48.0;

  // ─── Button-specific Padding ─────────────────────────────────────────
  // Bootstrap defines button padding separately from general spacers.
  // sm: 0.25rem 0.5rem → 4 / 8
  static const EdgeInsets btnPaddingSm = EdgeInsets.symmetric(
    vertical: 4.0,
    horizontal: 8.0,
  );
  // md (default): 0.375rem 0.75rem → 6 / 12
  static const EdgeInsets btnPaddingMd = EdgeInsets.symmetric(
    vertical: 6.0,
    horizontal: 12.0,
  );
  // lg: 0.5rem 1rem → 8 / 16
  static const EdgeInsets btnPaddingLg = EdgeInsets.symmetric(
    vertical: 8.0,
    horizontal: 16.0,
  );
}

/// Bootstrap 5 Border-Radius values.
/// Source: https://getbootstrap.com/docs/5.3/utilities/borders/#border-radius
abstract class BsRadius {
  // --bs-border-radius-sm → 0.25rem = 4px
  static const BorderRadius sm = BorderRadius.all(Radius.circular(4.0));
  // --bs-border-radius    → 0.375rem = 6px  (Standard for Buttons)
  static const BorderRadius md = BorderRadius.all(Radius.circular(6.0));
  // --bs-border-radius-lg → 0.5rem = 8px
  static const BorderRadius lg = BorderRadius.all(Radius.circular(8.0));
  // --bs-border-radius-pill → 50rem → fully rounded
  static const BorderRadius pill = BorderRadius.all(Radius.circular(9999.0));
  // No radius
  static const BorderRadius none = BorderRadius.zero;
}

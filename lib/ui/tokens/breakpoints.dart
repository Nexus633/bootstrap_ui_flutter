// ignore_for_file: public_member_api_docs

/// Bootstrap 5 Breakpoints — exactly from the documentation.
/// Source: https://getbootstrap.com/docs/5.3/layout/breakpoints/
///
/// Bootstrap is "mobile first" — meaning you define for small
/// screens first and overwrite for larger ones.
abstract class BsBreakpoints {
  // xs: < 576px  → no prefix in Bootstrap (default)
  static const double sm = 576.0; // col-sm-*
  static const double md = 768.0; // col-md-*
  static const double lg = 992.0; // col-lg-*
  static const double xl = 1200.0; // col-xl-*
  static const double xxl = 1400.0; // col-xxl-*

  // ─── Container Max-Widths ──────────────────────────────────────────────────
  // Bootstrap's .container has a maximum width depending on the viewport.
  // Source: https://getbootstrap.com/docs/5.3/layout/containers/
  static const double containerSm = 540.0;
  static const double containerMd = 720.0;
  static const double containerLg = 960.0;
  static const double containerXl = 1140.0;
  static const double containerXxl = 1320.0;
}

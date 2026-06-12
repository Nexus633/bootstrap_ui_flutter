import 'package:flutter/material.dart';

/// Bootstrap 5 Transition and Animation Tokens.
/// Source: Bootstrap _variables.scss
abstract class BsTransitions {
  // ─── Durations ─────────────────────────────────────────────────────────────

  /// Base transition duration (e.g. colors, shadows, borders)
  /// Default: 200ms
  static const Duration baseDuration = Duration(milliseconds: 200);

  /// Fade transition duration (e.g. tooltips, popovers, simple opacity changes)
  /// Default: 150ms
  static const Duration fadeDuration = Duration(milliseconds: 150);

  /// Collapse transition duration (e.g. accordions, collapse, nav toggles)
  /// Default: 350ms
  static const Duration collapseDuration = Duration(milliseconds: 350);

  /// Modal / Offcanvas transition duration
  /// Default: 300ms
  static const Duration modalDuration = Duration(milliseconds: 300);

  /// Carousel slide transition duration
  /// Default: 600ms
  static const Duration carouselDuration = Duration(milliseconds: 600);

  /// Toast slide/fade transition duration
  /// Default: 300ms
  static const Duration toastDuration = Duration(milliseconds: 300);

  /// Placeholder shimmering animation duration
  /// Default: 2000ms
  static const Duration placeholderDuration = Duration(milliseconds: 2000);

  /// Progress bar striping animation duration
  /// Default: 1000ms
  static const Duration progressDuration = Duration(milliseconds: 1000);

  /// Spinner rotation duration
  /// Default: 750ms
  static const Duration spinnerDuration = Duration(milliseconds: 750);

  // ─── Curves ────────────────────────────────────────────────────────────────

  /// $transition-base curve (ease-in-out)
  static const Curve baseCurve = Curves.easeInOut;

  /// $transition-fade curve (linear)
  static const Curve fadeCurve = Curves.linear;

  /// $transition-collapse curve (ease)
  static const Curve collapseCurve = Curves.ease;
}

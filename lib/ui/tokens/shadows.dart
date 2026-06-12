import 'package:flutter/material.dart';

/// Bootstrap 5 Box-Shadow values.
/// Source: https://getbootstrap.com/docs/5.3/utilities/shadows/
abstract class BsShadows {
  /// Regular shadow (shadow)
  /// $box-shadow: 0 .5rem 1rem rgba($black, .15);
  static const List<BoxShadow> regular = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.15),
      offset: Offset(0, 8),
      blurRadius: 16,
    ),
  ];

  /// Small shadow (shadow-sm)
  /// $box-shadow-sm: 0 .125rem .25rem rgba($black, .075);
  static const List<BoxShadow> sm = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.075),
      offset: Offset(0, 2),
      blurRadius: 4,
    ),
  ];

  /// Large shadow (shadow-lg)
  /// $box-shadow-lg: 0 1rem 3rem rgba($black, .175);
  static const List<BoxShadow> lg = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.175),
      offset: Offset(0, 16),
      blurRadius: 48,
    ),
  ];

  /// Inset shadow (shadow-inset)
  /// $box-shadow-inset: inset 0 1px 2px rgba($black, .075);
  static const List<BoxShadow> inset = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.075),
      offset: Offset(0, 1),
      blurRadius: 2,
      blurStyle: BlurStyle.inner,
    ),
  ];

  /// Focus Ring Shadow
  /// $focus-ring-width: .25rem (4px)
  /// $focus-ring-opacity: .25
  static List<BoxShadow> focusRing(Color color) {
    return [
      BoxShadow(
        color: color.withValues(alpha: 0.25),
        offset: Offset.zero,
        blurRadius: 0,
        spreadRadius: 4,
      ),
    ];
  }
}

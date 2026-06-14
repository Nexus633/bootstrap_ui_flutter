import 'package:flutter/material.dart';

/// Extension on [Widget] to provide Bootstrap-like display and visibility utilities.
extension BsDisplayExtension on Widget {
  // ─── Breakpoint Helper ─────────────────────────────────────────────────────

  Widget _apply(double? breakpoint, Widget Function(Widget) wrap) {
    if (breakpoint == null) return wrap(this);
    return Builder(
      builder: (context) {
        if (MediaQuery.sizeOf(context).width >= breakpoint) {
          return wrap(this);
        }
        return this;
      },
    );
  }

  /// Shows or hides the widget based on [visible].
  ///
  /// Maps to Bootstrap's display utilities (conceptually).
  Widget visible(bool visible, [double? breakpoint]) => _apply(
        breakpoint,
        (w) => Visibility(
          visible: visible,
          child: w,
        ),
      );

  /// Hides the widget and removes it from the layout if [gone] is true.
  ///
  /// Similar to `display: none` in CSS.
  Widget gone(bool gone, [double? breakpoint]) => _apply(
        breakpoint,
        (w) => Visibility(
          visible: !gone,
          maintainState: false,
          child: w,
        ),
      );

  /// Convenient alias for `gone(true)`.
  /// Maps to Bootstrap's `.d-none`. If a breakpoint is provided, it hides the widget
  /// from that breakpoint and up.
  Widget dNone([double? breakpoint]) => gone(true, breakpoint);

  /// Convenient alias for `gone(false)`.
  /// Maps to Bootstrap's `.d-block`. If a breakpoint is provided, it shows the widget
  /// from that breakpoint and up, and **hides** it on smaller screens
  /// (acting as a combination of `d-none d-{bp}-block`).
  Widget dBlock([double? breakpoint]) {
    if (breakpoint == null) return gone(false);
    return Builder(
      builder: (context) {
        return Visibility(
          visible: MediaQuery.sizeOf(context).width >= breakpoint,
          maintainState: false,
          child: this,
        );
      },
    );
  }

  /// Sets the opacity of the widget.
  ///
  /// Maps to Bootstrap's `.opacity-*` utilities.
  Widget opacity(double value, [double? breakpoint]) => _apply(
        breakpoint,
        (w) => Opacity(
          opacity: value,
          child: w,
        ),
      );
}

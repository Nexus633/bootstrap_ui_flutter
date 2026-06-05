import 'package:flutter/material.dart';

/// Extension on [Widget] to provide Bootstrap-like display and visibility utilities.
extension BsDisplayExtension on Widget {
  /// Shows or hides the widget based on [visible].
  ///
  /// Maps to Bootstrap's display utilities (conceptually).
  Widget visible(bool visible) => Visibility(
        visible: visible,
        child: this,
      );

  /// Hides the widget and removes it from the layout if [gone] is true.
  ///
  /// Similar to `display: none` in CSS.
  Widget gone(bool gone) => Visibility(
        visible: !gone,
        maintainState: false,
        child: this,
      );

  /// Convenient alias for `gone(true)`.
  /// Maps to Bootstrap's `.d-none`.
  Widget dNone() => gone(true);

  /// Sets the opacity of the widget.
  ///
  /// Maps to Bootstrap's `.opacity-*` utilities.
  Widget opacity(double value) => Opacity(
        opacity: value,
        child: this,
      );
}

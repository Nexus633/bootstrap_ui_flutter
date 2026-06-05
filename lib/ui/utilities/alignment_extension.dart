import 'package:flutter/material.dart';

/// Extension on [Widget] to provide alignment utilities.
extension BsAlignmentExtension on Widget {
  /// Aligns the widget within its parent using the given [alignment].
  Widget align(AlignmentGeometry alignment) => Align(
        alignment: alignment,
        child: this,
      );

  /// Centers the widget within its parent.
  Widget center() => Center(
        child: this,
      );

  /// Aligns the widget to the start (left) of its parent.
  Widget alignStart() => Align(
        alignment: AlignmentDirectional.centerStart,
        child: this,
      );

  /// Aligns the widget to the end (right) of its parent.
  Widget alignEnd() => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: this,
      );

  /// Aligns the widget to the top center of its parent.
  Widget alignTop() => Align(
        alignment: Alignment.topCenter,
        child: this,
      );

  /// Aligns the widget to the bottom center of its parent.
  Widget alignBottom() => Align(
        alignment: Alignment.bottomCenter,
        child: this,
      );
}

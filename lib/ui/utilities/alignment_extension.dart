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

/// Extension on [Widget] to provide inline vertical alignment utilities (Vertical Align).
///
/// These utilities return a [WidgetSpan] to align the widget inside inline text flows,
/// matching Bootstrap's `.align-*` classes for inline elements.
extension BsVerticalAlignExtension on Widget {
  /// Aligns the baseline of the element with the baseline of its parent.
  ///
  /// Matches Bootstrap's `.align-baseline` class.
  WidgetSpan alignBaseline({TextBaseline baseline = TextBaseline.alphabetic}) =>
      WidgetSpan(
        alignment: PlaceholderAlignment.baseline,
        baseline: baseline,
        child: this,
      );

  /// Aligns the top of the element with the top of the tallest element on the line.
  ///
  /// Matches Bootstrap's `.align-top` class.
  WidgetSpan alignTopInline() => WidgetSpan(
        alignment: PlaceholderAlignment.top,
        child: this,
      );

  /// Centers the element vertically within the line.
  ///
  /// Matches Bootstrap's `.align-middle` class.
  WidgetSpan alignMiddle() => WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: this,
      );

  /// Aligns the bottom of the element with the bottom of the lowest element on the line.
  ///
  /// Matches Bootstrap's `.align-bottom` class.
  WidgetSpan alignBottomInline() => WidgetSpan(
        alignment: PlaceholderAlignment.bottom,
        child: this,
      );

  /// Aligns the top of the element with the top of the parent element's font.
  ///
  /// Matches Bootstrap's `.align-text-top` class.
  WidgetSpan alignTextTop({TextBaseline baseline = TextBaseline.alphabetic}) => WidgetSpan(
        alignment: PlaceholderAlignment.aboveBaseline,
        baseline: baseline,
        child: this,
      );

  /// Aligns the bottom of the element with the bottom of the parent element's font.
  ///
  /// Matches Bootstrap's `.align-text-bottom` class.
  WidgetSpan alignTextBottom({TextBaseline baseline = TextBaseline.alphabetic}) => WidgetSpan(
        alignment: PlaceholderAlignment.belowBaseline,
        baseline: baseline,
        child: this,
      );
}

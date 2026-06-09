import 'package:flutter/material.dart';

/// Extension on [Widget] to provide sizing utilities.
extension BsSizeExtension on Widget {
  /// Sets a fixed width for the widget.
  Widget w(double width) => SizedBox(
        width: width,
        child: this,
      );

  /// Sets a fixed height for the widget.
  Widget h(double height) => SizedBox(
        height: height,
        child: this,
      );

  /// Sets both width and height to 100% (double.infinity).
  /// Maps to Bootstrap's `.w-100` and `.h-100`.
  Widget size100() => SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: this,
      );

  /// Sets the width to 100% (double.infinity).
  Widget w100() => SizedBox(
        width: double.infinity,
        child: this,
      );

  /// Sets the width to 75% of parent (FractionallySizedBox).
  Widget w75() => FractionallySizedBox(
        widthFactor: 0.75,
        child: this,
      );

  /// Sets the width to 50% of parent (FractionallySizedBox).
  Widget w50() => FractionallySizedBox(
        widthFactor: 0.5,
        child: this,
      );

  /// Sets the width to 25% of parent (FractionallySizedBox).
  Widget w25() => FractionallySizedBox(
        widthFactor: 0.25,
        child: this,
      );

  /// Sets the height to 100% (double.infinity).
  Widget h100() => SizedBox(
        height: double.infinity,
        child: this,
      );

  /// Sets the height to 75% of parent (FractionallySizedBox).
  Widget h75() => FractionallySizedBox(
        heightFactor: 0.75,
        child: this,
      );

  /// Sets the height to 50% of parent (FractionallySizedBox).
  Widget h50() => FractionallySizedBox(
        heightFactor: 0.5,
        child: this,
      );

  /// Sets the height to 25% of parent (FractionallySizedBox).
  Widget h25() => FractionallySizedBox(
        heightFactor: 0.25,
        child: this,
      );

  /// Wraps the widget in an [Expanded] widget.
  Widget expanded([int flex = 1]) => Expanded(
        flex: flex,
        child: this,
      );

  /// Sets width to 100vw (100% of viewport width).
  Widget vw100(BuildContext context) => SizedBox(
        width: MediaQuery.of(context).size.width,
        child: this,
      );

  /// Sets height to 100vh (100% of viewport height).
  Widget vh100(BuildContext context) => SizedBox(
        height: MediaQuery.of(context).size.height,
        child: this,
      );

  /// Sets width to 50vw (50% of viewport width).
  Widget vw50(BuildContext context) => SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: this,
      );

  /// Sets height to 50vh (50% of viewport height).
  Widget vh50(BuildContext context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: this,
      );

  /// Sets min-width to 100vw (100% of viewport width).
  Widget minVw100(BuildContext context) => ConstrainedBox(
        constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
        child: this,
      );

  /// Sets min-height to 100vh (100% of viewport height).
  Widget minVh100(BuildContext context) => ConstrainedBox(
        constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
        child: this,
      );

  /// Sets min-width to 50vw (50% of viewport width).
  Widget minVw50(BuildContext context) => ConstrainedBox(
        constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width * 0.5),
        child: this,
      );

  /// Sets min-height to 50vh (50% of viewport height).
  Widget minVh50(BuildContext context) => ConstrainedBox(
        constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height * 0.5),
        child: this,
      );

  /// Sets min-width to 100% of parent.
  Widget minW100() => ConstrainedBox(
        constraints: const BoxConstraints(minWidth: double.infinity),
        child: this,
      );

  /// Sets min-height to 100% of parent.
  Widget minH100() => ConstrainedBox(
        constraints: const BoxConstraints(minHeight: double.infinity),
        child: this,
      );
}

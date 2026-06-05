import 'package:flutter/material.dart';

/// Predefined aspect ratios for [BsRatio].
enum BsRatioType {
  /// 1:1 aspect ratio
  ratio1x1(1 / 1),
  /// 4:3 aspect ratio
  ratio4x3(4 / 3),
  /// 16:9 aspect ratio
  ratio16x9(16 / 9),
  /// 21:9 aspect ratio
  ratio21x9(21 / 9);

  const BsRatioType(this.value);
  /// The numerical value of the aspect ratio.
  final double value;
}

/// A Bootstrap-style ratio helper.
///
/// Use the ratio helper to manage aspect ratios of external content like
/// `<iframe>`s, `<embed>`s, `<video>`s, and `<object>`s.
///
/// See: <https://getbootstrap.com/docs/5.3/helpers/ratio/>
class BsRatio extends StatelessWidget {
  /// Creates a [BsRatio] with a predefined [type].
  const BsRatio({
    super.key,
    required this.child,
    this.type = BsRatioType.ratio1x1,
  }) : customRatio = null;

  /// Creates a [BsRatio] with a [customRatio].
  const BsRatio.custom({
    super.key,
    required this.child,
    required this.customRatio,
  }) : type = null;

  /// The widget to apply the aspect ratio to.
  final Widget child;

  /// The predefined aspect ratio type.
  final BsRatioType? type;

  /// A custom aspect ratio value (width / height).
  final double? customRatio;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: customRatio ?? type?.value ?? 1.0,
      child: child,
    );
  }
}

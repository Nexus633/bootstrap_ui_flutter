import 'package:flutter/material.dart';

import '../tokens/spacing.dart';

/// Extension on [Widget] to provide Bootstrap-like spacing utilities.
///
/// This extension allows for concise application of padding and margin to widgets,
/// mirroring Bootstrap's `p-*`, `m-*`, etc., utility classes.
///
/// Example:
/// ```dart
/// Text('Hello').p3();  // Applies standard padding level 3 (1rem/16px)
/// Text('World').mb2(); // Applies standard margin-bottom level 2 (0.5rem/8px)
/// ```
extension BsSpacingExtension on Widget {
  // ─── Padding Utilities (Dynamic Values) ──────────────────────────────────

  /// Applies uniform padding on all sides.
  Widget p(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);

  /// Applies horizontal padding (left and right).
  Widget px(double value) => Padding(
    padding: EdgeInsets.symmetric(horizontal: value),
    child: this,
  );

  /// Applies vertical padding (top and bottom).
  Widget py(double value) => Padding(
    padding: EdgeInsets.symmetric(vertical: value),
    child: this,
  );

  /// Applies padding only to the top side.
  Widget pt(double value) => Padding(
    padding: EdgeInsets.only(top: value),
    child: this,
  );

  /// Applies padding only to the bottom side.
  Widget pb(double value) => Padding(
    padding: EdgeInsets.only(bottom: value),
    child: this,
  );

  /// Applies padding only to the start (left) side.
  Widget ps(double value) => Padding(
    padding: EdgeInsets.only(left: value),
    child: this,
  );

  /// Applies padding only to the end (right) side.
  Widget pe(double value) => Padding(
    padding: EdgeInsets.only(right: value),
    child: this,
  );

  // ─── Margin Utilities (Dynamic Values) ───────────────────────────────────

  /// Applies uniform margin on all sides.
  Widget m(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);

  /// Applies horizontal margin (left and right).
  Widget mx(double value) => Padding(
    padding: EdgeInsets.symmetric(horizontal: value),
    child: this,
  );

  /// Applies vertical margin (top and bottom).
  Widget my(double value) => Padding(
    padding: EdgeInsets.symmetric(vertical: value),
    child: this,
  );

  /// Applies margin only to the top side.
  Widget mt(double value) => Padding(
    padding: EdgeInsets.only(top: value),
    child: this,
  );

  /// Applies margin only to the bottom side.
  Widget mb(double value) => Padding(
    padding: EdgeInsets.only(bottom: value),
    child: this,
  );

  /// Applies margin only to the start (left) side.
  Widget ms(double value) => Padding(
    padding: EdgeInsets.only(left: value),
    child: this,
  );

  /// Applies margin only to the end (right) side.
  Widget me(double value) => Padding(
    padding: EdgeInsets.only(right: value),
    child: this,
  );

  // ─── Uniform Padding (Standard Values) ─────────────────────────────────────

  /// Applies uniform padding of [BsSpacing.s1] on all sides.
  Widget p1() => Padding(padding: EdgeInsets.all(BsSpacing.s1), child: this);

  /// Applies uniform padding of [BsSpacing.s2] on all sides.
  Widget p2() => Padding(padding: EdgeInsets.all(BsSpacing.s2), child: this);

  /// Applies uniform padding of [BsSpacing.s3] on all sides.
  Widget p3() => Padding(padding: EdgeInsets.all(BsSpacing.s3), child: this);

  /// Applies uniform padding of [BsSpacing.s4] on all sides.
  Widget p4() => Padding(padding: EdgeInsets.all(BsSpacing.s4), child: this);

  /// Applies uniform padding of [BsSpacing.s5] on all sides.
  Widget p5() => Padding(padding: EdgeInsets.all(BsSpacing.s5), child: this);

  // ─── Uniform Margin (Standard Values) ──────────────────────────────────────

  /// Applies uniform margin of [BsSpacing.s1] on all sides.
  Widget m1() => Padding(padding: EdgeInsets.all(BsSpacing.s1), child: this);

  /// Applies uniform margin of [BsSpacing.s2] on all sides.
  Widget m2() => Padding(padding: EdgeInsets.all(BsSpacing.s2), child: this);

  /// Applies uniform margin of [BsSpacing.s3] on all sides.
  Widget m3() => Padding(padding: EdgeInsets.all(BsSpacing.s3), child: this);

  /// Applies uniform margin of [BsSpacing.s4] on all sides.
  Widget m4() => Padding(padding: EdgeInsets.all(BsSpacing.s4), child: this);

  /// Applies uniform margin of [BsSpacing.s5] on all sides.
  Widget m5() => Padding(padding: EdgeInsets.all(BsSpacing.s5), child: this);

  // ─── Horizontal Padding (Standard Values) ──────────────────────────────────

  /// Applies horizontal padding (left and right) of [BsSpacing.s1].
  Widget px1() => Padding(
    padding: EdgeInsets.symmetric(horizontal: BsSpacing.s1),
    child: this,
  );

  /// Applies horizontal padding (left and right) of [BsSpacing.s2].
  Widget px2() => Padding(
    padding: EdgeInsets.symmetric(horizontal: BsSpacing.s2),
    child: this,
  );

  /// Applies horizontal padding (left and right) of [BsSpacing.s3].
  Widget px3() => Padding(
    padding: EdgeInsets.symmetric(horizontal: BsSpacing.s3),
    child: this,
  );

  /// Applies horizontal padding (left and right) of [BsSpacing.s4].
  Widget px4() => Padding(
    padding: EdgeInsets.symmetric(horizontal: BsSpacing.s4),
    child: this,
  );

  /// Applies horizontal padding (left and right) of [BsSpacing.s5].
  Widget px5() => Padding(
    padding: EdgeInsets.symmetric(horizontal: BsSpacing.s5),
    child: this,
  );

  // ─── Horizontal Margin (Standard Values) ───────────────────────────────────

  /// Applies horizontal margin (left and right) of [BsSpacing.s1].
  Widget mx1() => Padding(
    padding: EdgeInsets.symmetric(horizontal: BsSpacing.s1),
    child: this,
  );

  /// Applies horizontal margin (left and right) of [BsSpacing.s2].
  Widget mx2() => Padding(
    padding: EdgeInsets.symmetric(horizontal: BsSpacing.s2),
    child: this,
  );

  /// Applies horizontal margin (left and right) of [BsSpacing.s3].
  Widget mx3() => Padding(
    padding: EdgeInsets.symmetric(horizontal: BsSpacing.s3),
    child: this,
  );

  /// Applies horizontal margin (left and right) of [BsSpacing.s4].
  Widget mx4() => Padding(
    padding: EdgeInsets.symmetric(horizontal: BsSpacing.s4),
    child: this,
  );

  /// Applies horizontal margin (left and right) of [BsSpacing.s5].
  Widget mx5() => Padding(
    padding: EdgeInsets.symmetric(horizontal: BsSpacing.s5),
    child: this,
  );

  // ─── Vertical Padding (Standard Values) ────────────────────────────────────

  /// Applies vertical padding (top and bottom) of [BsSpacing.s1].
  Widget py1() => Padding(
    padding: EdgeInsets.symmetric(vertical: BsSpacing.s1),
    child: this,
  );

  /// Applies vertical padding (top and bottom) of [BsSpacing.s2].
  Widget py2() => Padding(
    padding: EdgeInsets.symmetric(vertical: BsSpacing.s2),
    child: this,
  );

  /// Applies vertical padding (top and bottom) of [BsSpacing.s3].
  Widget py3() => Padding(
    padding: EdgeInsets.symmetric(vertical: BsSpacing.s3),
    child: this,
  );

  /// Applies vertical padding (top and bottom) of [BsSpacing.s4].
  Widget py4() => Padding(
    padding: EdgeInsets.symmetric(vertical: BsSpacing.s4),
    child: this,
  );

  /// Applies vertical padding (top and bottom) of [BsSpacing.s5].
  Widget py5() => Padding(
    padding: EdgeInsets.symmetric(vertical: BsSpacing.s5),
    child: this,
  );

  // ─── Vertical Margin (Standard Values) ─────────────────────────────────────

  /// Applies vertical margin (top and bottom) of [BsSpacing.s1].
  Widget my1() => Padding(
    padding: EdgeInsets.symmetric(vertical: BsSpacing.s1),
    child: this,
  );

  /// Applies vertical margin (top and bottom) of [BsSpacing.s2].
  Widget my2() => Padding(
    padding: EdgeInsets.symmetric(vertical: BsSpacing.s2),
    child: this,
  );

  /// Applies vertical margin (top and bottom) of [BsSpacing.s3].
  Widget my3() => Padding(
    padding: EdgeInsets.symmetric(vertical: BsSpacing.s3),
    child: this,
  );

  /// Applies vertical margin (top and bottom) of [BsSpacing.s4].
  Widget my4() => Padding(
    padding: EdgeInsets.symmetric(vertical: BsSpacing.s4),
    child: this,
  );

  /// Applies vertical margin (top and bottom) of [BsSpacing.s5].
  Widget my5() => Padding(
    padding: EdgeInsets.symmetric(vertical: BsSpacing.s5),
    child: this,
  );

  // ─── Top Padding (Standard Values) ─────────────────────────────────────────

  /// Applies top padding of [BsSpacing.s1].
  Widget pt1() => Padding(
    padding: EdgeInsets.only(top: BsSpacing.s1),
    child: this,
  );

  /// Applies top padding of [BsSpacing.s2].
  Widget pt2() => Padding(
    padding: EdgeInsets.only(top: BsSpacing.s2),
    child: this,
  );

  /// Applies top padding of [BsSpacing.s3].
  Widget pt3() => Padding(
    padding: EdgeInsets.only(top: BsSpacing.s3),
    child: this,
  );

  /// Applies top padding of [BsSpacing.s4].
  Widget pt4() => Padding(
    padding: EdgeInsets.only(top: BsSpacing.s4),
    child: this,
  );

  /// Applies top padding of [BsSpacing.s5].
  Widget pt5() => Padding(
    padding: EdgeInsets.only(top: BsSpacing.s5),
    child: this,
  );

  // ─── Top Margin (Standard Values) ──────────────────────────────────────────

  /// Applies top margin of [BsSpacing.s1].
  Widget mt1() => Padding(
    padding: EdgeInsets.only(top: BsSpacing.s1),
    child: this,
  );

  /// Applies top margin of [BsSpacing.s2].
  Widget mt2() => Padding(
    padding: EdgeInsets.only(top: BsSpacing.s2),
    child: this,
  );

  /// Applies top margin of [BsSpacing.s3].
  Widget mt3() => Padding(
    padding: EdgeInsets.only(top: BsSpacing.s3),
    child: this,
  );

  /// Applies top margin of [BsSpacing.s4].
  Widget mt4() => Padding(
    padding: EdgeInsets.only(top: BsSpacing.s4),
    child: this,
  );

  /// Applies top margin of [BsSpacing.s5].
  Widget mt5() => Padding(
    padding: EdgeInsets.only(top: BsSpacing.s5),
    child: this,
  );

  // ─── Bottom Padding (Standard Values) ──────────────────────────────────────

  /// Applies bottom padding of [BsSpacing.s1].
  Widget pb1() => Padding(
    padding: EdgeInsets.only(bottom: BsSpacing.s1),
    child: this,
  );

  /// Applies bottom padding of [BsSpacing.s2].
  Widget pb2() => Padding(
    padding: EdgeInsets.only(bottom: BsSpacing.s2),
    child: this,
  );

  /// Applies bottom padding of [BsSpacing.s3].
  Widget pb3() => Padding(
    padding: EdgeInsets.only(bottom: BsSpacing.s3),
    child: this,
  );

  /// Applies bottom padding of [BsSpacing.s4].
  Widget pb4() => Padding(
    padding: EdgeInsets.only(bottom: BsSpacing.s4),
    child: this,
  );

  /// Applies bottom padding of [BsSpacing.s5].
  Widget pb5() => Padding(
    padding: EdgeInsets.only(bottom: BsSpacing.s5),
    child: this,
  );

  // ─── Bottom Margin (Standard Values) ───────────────────────────────────────

  /// Applies bottom margin of [BsSpacing.s1].
  Widget mb1() => Padding(
    padding: EdgeInsets.only(bottom: BsSpacing.s1),
    child: this,
  );

  /// Applies bottom margin of [BsSpacing.s2].
  Widget mb2() => Padding(
    padding: EdgeInsets.only(bottom: BsSpacing.s2),
    child: this,
  );

  /// Applies bottom margin of [BsSpacing.s3].
  Widget mb3() => Padding(
    padding: EdgeInsets.only(bottom: BsSpacing.s3),
    child: this,
  );

  /// Applies bottom margin of [BsSpacing.s4].
  Widget mb4() => Padding(
    padding: EdgeInsets.only(bottom: BsSpacing.s4),
    child: this,
  );

  /// Applies bottom margin of [BsSpacing.s5].
  Widget mb5() => Padding(
    padding: EdgeInsets.only(bottom: BsSpacing.s5),
    child: this,
  );

  // ─── Start Padding (Standard Values) ───────────────────────────────────────

  /// Applies start (left) padding of [BsSpacing.s1].
  Widget ps1() => Padding(
    padding: EdgeInsets.only(left: BsSpacing.s1),
    child: this,
  );

  /// Applies start (left) padding of [BsSpacing.s2].
  Widget ps2() => Padding(
    padding: EdgeInsets.only(left: BsSpacing.s2),
    child: this,
  );

  /// Applies start (left) padding of [BsSpacing.s3].
  Widget ps3() => Padding(
    padding: EdgeInsets.only(left: BsSpacing.s3),
    child: this,
  );

  /// Applies start (left) padding of [BsSpacing.s4].
  Widget ps4() => Padding(
    padding: EdgeInsets.only(left: BsSpacing.s4),
    child: this,
  );

  /// Applies start (left) padding of [BsSpacing.s5].
  Widget ps5() => Padding(
    padding: EdgeInsets.only(left: BsSpacing.s5),
    child: this,
  );

  // ─── Start Margin (Standard Values) ────────────────────────────────────────

  /// Applies start (left) margin of [BsSpacing.s1].
  Widget ms1() => Padding(
    padding: EdgeInsets.only(left: BsSpacing.s1),
    child: this,
  );

  /// Applies start (left) margin of [BsSpacing.s2].
  Widget ms2() => Padding(
    padding: EdgeInsets.only(left: BsSpacing.s2),
    child: this,
  );

  /// Applies start (left) margin of [BsSpacing.s3].
  Widget ms3() => Padding(
    padding: EdgeInsets.only(left: BsSpacing.s3),
    child: this,
  );

  /// Applies start (left) margin of [BsSpacing.s4].
  Widget ms4() => Padding(
    padding: EdgeInsets.only(left: BsSpacing.s4),
    child: this,
  );

  /// Applies start (left) margin of [BsSpacing.s5].
  Widget ms5() => Padding(
    padding: EdgeInsets.only(left: BsSpacing.s5),
    child: this,
  );

  // ─── End Padding (Standard Values) ─────────────────────────────────────────

  /// Applies end (right) padding of [BsSpacing.s1].
  Widget pe1() => Padding(
    padding: EdgeInsets.only(right: BsSpacing.s1),
    child: this,
  );

  /// Applies end (right) padding of [BsSpacing.s2].
  Widget pe2() => Padding(
    padding: EdgeInsets.only(right: BsSpacing.s2),
    child: this,
  );

  /// Applies end (right) padding of [BsSpacing.s3].
  Widget pe3() => Padding(
    padding: EdgeInsets.only(right: BsSpacing.s3),
    child: this,
  );

  /// Applies end (right) padding of [BsSpacing.s4].
  Widget pe4() => Padding(
    padding: EdgeInsets.only(right: BsSpacing.s4),
    child: this,
  );

  /// Applies end (right) padding of [BsSpacing.s5].
  Widget pe5() => Padding(
    padding: EdgeInsets.only(right: BsSpacing.s5),
    child: this,
  );

  // ─── End Margin (Standard Values) ──────────────────────────────────────────

  /// Applies end (right) margin of [BsSpacing.s1].
  Widget me1() => Padding(
    padding: EdgeInsets.only(right: BsSpacing.s1),
    child: this,
  );

  /// Applies end (right) margin of [BsSpacing.s2].
  Widget me2() => Padding(
    padding: EdgeInsets.only(right: BsSpacing.s2),
    child: this,
  );

  /// Applies end (right) margin of [BsSpacing.s3].
  Widget me3() => Padding(
    padding: EdgeInsets.only(right: BsSpacing.s3),
    child: this,
  );

  /// Applies end (right) margin of [BsSpacing.s4].
  Widget me4() => Padding(
    padding: EdgeInsets.only(right: BsSpacing.s4),
    child: this,
  );

  /// Applies end (right) margin of [BsSpacing.s5].
  Widget me5() => Padding(
    padding: EdgeInsets.only(right: BsSpacing.s5),
    child: this,
  );
}

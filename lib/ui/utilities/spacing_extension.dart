import 'package:flutter/material.dart';

import '../tokens/spacing.dart';

/// Extension on [Widget] to provide Bootstrap-like spacing utilities.
extension BsSpacingExtension on Widget {
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

  /// Applies custom [EdgeInsets] as padding.
  Widget padding(EdgeInsets value) => Padding(padding: value, child: this);

  // ─── Padding Utilities (Dynamic Values) ──────────────────────────────────

  /// Applies all padding.
  Widget p(double value, [double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: EdgeInsets.all(value), child: w));

  /// Applies horizontal padding.
  Widget px(double value, [double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: EdgeInsets.symmetric(horizontal: value), child: w));

  /// Applies vertical padding.
  Widget py(double value, [double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: EdgeInsets.symmetric(vertical: value), child: w));

  /// Applies top padding.
  Widget pt(double value, [double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: EdgeInsets.only(top: value), child: w));

  /// Applies bottom padding.
  Widget pb(double value, [double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: EdgeInsets.only(bottom: value), child: w));

  /// Applies left padding.
  Widget ps(double value, [double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: EdgeInsets.only(left: value), child: w));

  /// Applies right padding.
  Widget pe(double value, [double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: EdgeInsets.only(right: value), child: w));
  // ─── Margin Utilities (Dynamic Values) ──────────────────────────────────

  /// Applies all margin.
  Widget m(double value, [double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: EdgeInsets.all(value), child: w));

  /// Applies horizontal margin.
  Widget mx(double value, [double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: EdgeInsets.symmetric(horizontal: value), child: w));

  /// Applies vertical margin.
  Widget my(double value, [double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: EdgeInsets.symmetric(vertical: value), child: w));

  /// Applies top margin.
  Widget mt(double value, [double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: EdgeInsets.only(top: value), child: w));

  /// Applies bottom margin.
  Widget mb(double value, [double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: EdgeInsets.only(bottom: value), child: w));

  /// Applies left margin.
  Widget ms(double value, [double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: EdgeInsets.only(left: value), child: w));

  /// Applies right margin.
  Widget me(double value, [double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: EdgeInsets.only(right: value), child: w));

  // ─── Padding All (Standard Values) ──────────────────────────────────

  /// Applies all padding of [BsSpacing.s1].
  Widget p1([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.all(BsSpacing.s1), child: w));

  /// Applies all padding of [BsSpacing.s2].
  Widget p2([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.all(BsSpacing.s2), child: w));

  /// Applies all padding of [BsSpacing.s3].
  Widget p3([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.all(BsSpacing.s3), child: w));

  /// Applies all padding of [BsSpacing.s4].
  Widget p4([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.all(BsSpacing.s4), child: w));

  /// Applies all padding of [BsSpacing.s5].
  Widget p5([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.all(BsSpacing.s5), child: w));

  // ─── Padding Horizontal (Standard Values) ──────────────────────────────────

  /// Applies horizontal padding of [BsSpacing.s1].
  Widget px1([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.symmetric(horizontal: BsSpacing.s1), child: w));

  /// Applies horizontal padding of [BsSpacing.s2].
  Widget px2([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.symmetric(horizontal: BsSpacing.s2), child: w));

  /// Applies horizontal padding of [BsSpacing.s3].
  Widget px3([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.symmetric(horizontal: BsSpacing.s3), child: w));

  /// Applies horizontal padding of [BsSpacing.s4].
  Widget px4([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.symmetric(horizontal: BsSpacing.s4), child: w));

  /// Applies horizontal padding of [BsSpacing.s5].
  Widget px5([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.symmetric(horizontal: BsSpacing.s5), child: w));

  // ─── Padding Vertical (Standard Values) ──────────────────────────────────

  /// Applies vertical padding of [BsSpacing.s1].
  Widget py1([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.symmetric(vertical: BsSpacing.s1), child: w));

  /// Applies vertical padding of [BsSpacing.s2].
  Widget py2([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.symmetric(vertical: BsSpacing.s2), child: w));

  /// Applies vertical padding of [BsSpacing.s3].
  Widget py3([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.symmetric(vertical: BsSpacing.s3), child: w));

  /// Applies vertical padding of [BsSpacing.s4].
  Widget py4([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.symmetric(vertical: BsSpacing.s4), child: w));

  /// Applies vertical padding of [BsSpacing.s5].
  Widget py5([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.symmetric(vertical: BsSpacing.s5), child: w));

  // ─── Padding Top (Standard Values) ──────────────────────────────────

  /// Applies top padding of [BsSpacing.s1].
  Widget pt1([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(top: BsSpacing.s1), child: w));

  /// Applies top padding of [BsSpacing.s2].
  Widget pt2([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(top: BsSpacing.s2), child: w));

  /// Applies top padding of [BsSpacing.s3].
  Widget pt3([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(top: BsSpacing.s3), child: w));

  /// Applies top padding of [BsSpacing.s4].
  Widget pt4([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(top: BsSpacing.s4), child: w));

  /// Applies top padding of [BsSpacing.s5].
  Widget pt5([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(top: BsSpacing.s5), child: w));

  // ─── Padding Bottom (Standard Values) ──────────────────────────────────

  /// Applies bottom padding of [BsSpacing.s1].
  Widget pb1([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(bottom: BsSpacing.s1), child: w));

  /// Applies bottom padding of [BsSpacing.s2].
  Widget pb2([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(bottom: BsSpacing.s2), child: w));

  /// Applies bottom padding of [BsSpacing.s3].
  Widget pb3([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(bottom: BsSpacing.s3), child: w));

  /// Applies bottom padding of [BsSpacing.s4].
  Widget pb4([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(bottom: BsSpacing.s4), child: w));

  /// Applies bottom padding of [BsSpacing.s5].
  Widget pb5([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(bottom: BsSpacing.s5), child: w));

  // ─── Padding Left (Standard Values) ──────────────────────────────────

  /// Applies left padding of [BsSpacing.s1].
  Widget ps1([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(left: BsSpacing.s1), child: w));

  /// Applies left padding of [BsSpacing.s2].
  Widget ps2([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(left: BsSpacing.s2), child: w));

  /// Applies left padding of [BsSpacing.s3].
  Widget ps3([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(left: BsSpacing.s3), child: w));

  /// Applies left padding of [BsSpacing.s4].
  Widget ps4([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(left: BsSpacing.s4), child: w));

  /// Applies left padding of [BsSpacing.s5].
  Widget ps5([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(left: BsSpacing.s5), child: w));

  // ─── Padding Right (Standard Values) ──────────────────────────────────

  /// Applies right padding of [BsSpacing.s1].
  Widget pe1([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(right: BsSpacing.s1), child: w));

  /// Applies right padding of [BsSpacing.s2].
  Widget pe2([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(right: BsSpacing.s2), child: w));

  /// Applies right padding of [BsSpacing.s3].
  Widget pe3([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(right: BsSpacing.s3), child: w));

  /// Applies right padding of [BsSpacing.s4].
  Widget pe4([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(right: BsSpacing.s4), child: w));

  /// Applies right padding of [BsSpacing.s5].
  Widget pe5([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(right: BsSpacing.s5), child: w));

  // ─── Margin All (Standard Values) ──────────────────────────────────

  /// Applies all margin of [BsSpacing.s1].
  Widget m1([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.all(BsSpacing.s1), child: w));

  /// Applies all margin of [BsSpacing.s2].
  Widget m2([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.all(BsSpacing.s2), child: w));

  /// Applies all margin of [BsSpacing.s3].
  Widget m3([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.all(BsSpacing.s3), child: w));

  /// Applies all margin of [BsSpacing.s4].
  Widget m4([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.all(BsSpacing.s4), child: w));

  /// Applies all margin of [BsSpacing.s5].
  Widget m5([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.all(BsSpacing.s5), child: w));

  // ─── Margin Horizontal (Standard Values) ──────────────────────────────────

  /// Applies horizontal margin of [BsSpacing.s1].
  Widget mx1([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.symmetric(horizontal: BsSpacing.s1), child: w));

  /// Applies horizontal margin of [BsSpacing.s2].
  Widget mx2([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.symmetric(horizontal: BsSpacing.s2), child: w));

  /// Applies horizontal margin of [BsSpacing.s3].
  Widget mx3([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.symmetric(horizontal: BsSpacing.s3), child: w));

  /// Applies horizontal margin of [BsSpacing.s4].
  Widget mx4([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.symmetric(horizontal: BsSpacing.s4), child: w));

  /// Applies horizontal margin of [BsSpacing.s5].
  Widget mx5([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.symmetric(horizontal: BsSpacing.s5), child: w));

  // ─── Margin Vertical (Standard Values) ──────────────────────────────────

  /// Applies vertical margin of [BsSpacing.s1].
  Widget my1([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.symmetric(vertical: BsSpacing.s1), child: w));

  /// Applies vertical margin of [BsSpacing.s2].
  Widget my2([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.symmetric(vertical: BsSpacing.s2), child: w));

  /// Applies vertical margin of [BsSpacing.s3].
  Widget my3([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.symmetric(vertical: BsSpacing.s3), child: w));

  /// Applies vertical margin of [BsSpacing.s4].
  Widget my4([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.symmetric(vertical: BsSpacing.s4), child: w));

  /// Applies vertical margin of [BsSpacing.s5].
  Widget my5([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.symmetric(vertical: BsSpacing.s5), child: w));

  // ─── Margin Top (Standard Values) ──────────────────────────────────

  /// Applies top margin of [BsSpacing.s1].
  Widget mt1([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(top: BsSpacing.s1), child: w));

  /// Applies top margin of [BsSpacing.s2].
  Widget mt2([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(top: BsSpacing.s2), child: w));

  /// Applies top margin of [BsSpacing.s3].
  Widget mt3([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(top: BsSpacing.s3), child: w));

  /// Applies top margin of [BsSpacing.s4].
  Widget mt4([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(top: BsSpacing.s4), child: w));

  /// Applies top margin of [BsSpacing.s5].
  Widget mt5([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(top: BsSpacing.s5), child: w));

  // ─── Margin Bottom (Standard Values) ──────────────────────────────────

  /// Applies bottom margin of [BsSpacing.s1].
  Widget mb1([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(bottom: BsSpacing.s1), child: w));

  /// Applies bottom margin of [BsSpacing.s2].
  Widget mb2([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(bottom: BsSpacing.s2), child: w));

  /// Applies bottom margin of [BsSpacing.s3].
  Widget mb3([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(bottom: BsSpacing.s3), child: w));

  /// Applies bottom margin of [BsSpacing.s4].
  Widget mb4([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(bottom: BsSpacing.s4), child: w));

  /// Applies bottom margin of [BsSpacing.s5].
  Widget mb5([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(bottom: BsSpacing.s5), child: w));

  // ─── Margin Left (Standard Values) ──────────────────────────────────

  /// Applies left margin of [BsSpacing.s1].
  Widget ms1([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(left: BsSpacing.s1), child: w));

  /// Applies left margin of [BsSpacing.s2].
  Widget ms2([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(left: BsSpacing.s2), child: w));

  /// Applies left margin of [BsSpacing.s3].
  Widget ms3([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(left: BsSpacing.s3), child: w));

  /// Applies left margin of [BsSpacing.s4].
  Widget ms4([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(left: BsSpacing.s4), child: w));

  /// Applies left margin of [BsSpacing.s5].
  Widget ms5([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(left: BsSpacing.s5), child: w));

  // ─── Margin Right (Standard Values) ──────────────────────────────────

  /// Applies right margin of [BsSpacing.s1].
  Widget me1([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(right: BsSpacing.s1), child: w));

  /// Applies right margin of [BsSpacing.s2].
  Widget me2([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(right: BsSpacing.s2), child: w));

  /// Applies right margin of [BsSpacing.s3].
  Widget me3([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(right: BsSpacing.s3), child: w));

  /// Applies right margin of [BsSpacing.s4].
  Widget me4([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(right: BsSpacing.s4), child: w));

  /// Applies right margin of [BsSpacing.s5].
  Widget me5([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(right: BsSpacing.s5), child: w));

  // ─── Padding Level 0 (Standard Values) ──────────────────────────────────

  /// Applies zero all padding.
  Widget p0([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.all(0.0), child: w));

  /// Applies zero horizontal padding.
  Widget px0([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.symmetric(horizontal: 0.0), child: w));

  /// Applies zero vertical padding.
  Widget py0([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.symmetric(vertical: 0.0), child: w));

  /// Applies zero top padding.
  Widget pt0([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(top: 0.0), child: w));

  /// Applies zero bottom padding.
  Widget pb0([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(bottom: 0.0), child: w));

  /// Applies zero left padding.
  Widget ps0([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(left: 0.0), child: w));

  /// Applies zero right padding.
  Widget pe0([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(right: 0.0), child: w));

  // ─── Margin Level 0 (Standard Values) ──────────────────────────────────

  /// Applies zero all margin.
  Widget m0([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.all(0.0), child: w));

  /// Applies zero horizontal margin.
  Widget mx0([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.symmetric(horizontal: 0.0), child: w));

  /// Applies zero vertical margin.
  Widget my0([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.symmetric(vertical: 0.0), child: w));

  /// Applies zero top margin.
  Widget mt0([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(top: 0.0), child: w));

  /// Applies zero bottom margin.
  Widget mb0([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(bottom: 0.0), child: w));

  /// Applies zero left margin.
  Widget ms0([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(left: 0.0), child: w));

  /// Applies zero right margin.
  Widget me0([double? breakpoint]) =>
      _apply(breakpoint, (w) => Padding(padding: const EdgeInsets.only(right: 0.0), child: w));

  // ─── Auto Margin Utilities ──────────────────────────────────────────────────

  /// Centers the widget horizontally and vertically, matching `m-auto`.
  Widget mAuto([double? breakpoint]) => _apply(breakpoint, (w) => Center(child: w));

  /// Centers the widget horizontally within its parent, matching `mx-auto`.
  Widget mxAuto([double? breakpoint]) => _apply(breakpoint, (w) => Align(alignment: Alignment.center, child: w));

  /// Centers the widget vertically within its parent, matching `my-auto`.
  Widget myAuto([double? breakpoint]) => _apply(breakpoint, (w) => Align(alignment: Alignment.center, child: w));

  /// Aligns the widget to the end (right) of its parent, matching `ms-auto` in horizontal layout.
  Widget msAuto([double? breakpoint]) => _apply(breakpoint, (w) => Align(alignment: AlignmentDirectional.centerEnd, child: w));

  /// Aligns the widget to the start (left) of its parent, matching `me-auto` in horizontal layout.
  Widget meAuto([double? breakpoint]) => _apply(breakpoint, (w) => Align(alignment: AlignmentDirectional.centerStart, child: w));

  /// Aligns the widget to the bottom of its parent, matching `mt-auto` in vertical layout.
  Widget mtAuto([double? breakpoint]) => _apply(breakpoint, (w) => Align(alignment: Alignment.bottomCenter, child: w));

  /// Aligns the widget to the top of its parent, matching `mb-auto` in vertical layout.
  Widget mbAuto([double? breakpoint]) => _apply(breakpoint, (w) => Align(alignment: Alignment.topCenter, child: w));
}

import 'package:flutter/material.dart';
import '../tokens/bootstrap_theme.dart';
import '../tokens/enums.dart';

/// Extension on [Widget] to provide Bootstrap-like border and border-radius utilities.
extension BsBorderExtension on Widget {
  /// Adds a default border on all sides, matching `.border`.
  Widget border({Color? color, double width = 1.0}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: color ?? const Color(0xFFDEE2E6), // default Bootstrap light gray border color
          width: width,
        ),
      ),
      child: this,
    );
  }

  /// Removes all borders, matching `.border-0`.
  Widget border0() => this;

  /// Adds a border to the top side, matching `.border-top`.
  Widget borderTop({Color? color, double width = 1.0}) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: color ?? const Color(0xFFDEE2E6),
            width: width,
          ),
        ),
      ),
      child: this,
    );
  }

  /// Adds a border to the bottom side, matching `.border-bottom`.
  Widget borderBottom({Color? color, double width = 1.0}) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: color ?? const Color(0xFFDEE2E6),
            width: width,
          ),
        ),
      ),
      child: this,
    );
  }

  /// Adds a border to the start (left) side, matching `.border-start`.
  Widget borderStart({Color? color, double width = 1.0}) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: color ?? const Color(0xFFDEE2E6),
            width: width,
          ),
        ),
      ),
      child: this,
    );
  }

  /// Adds a border to the end (right) side, matching `.border-end`.
  Widget borderEnd({Color? color, double width = 1.0}) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: color ?? const Color(0xFFDEE2E6),
            width: width,
          ),
        ),
      ),
      child: this,
    );
  }

  /// Colors the border based on the theme color variant, matching `.border-*`.
  Widget borderVariant(BuildContext context, BsVariant variant, {double width = 1.0}) {
    final theme = context.bs;
    final color = switch (variant) {
      BsVariant.primary => theme.primary,
      BsVariant.secondary => theme.secondary,
      BsVariant.success => theme.success,
      BsVariant.danger => theme.danger,
      BsVariant.warning => theme.warning,
      BsVariant.info => theme.info,
      BsVariant.light => theme.light,
      BsVariant.dark => theme.dark,
    };
    return border(color: color, width: width);
  }

  /// Applies a default border-radius of 0.375rem (6px), matching `.rounded`.
  Widget rounded() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6.0),
      child: this,
    );
  }

  /// Removes all border-radius, matching `.rounded-0`.
  Widget rounded0() {
    return ClipRRect(
      borderRadius: BorderRadius.zero,
      child: this,
    );
  }

  /// Applies a small border-radius of 0.25rem (4px), matching `.rounded-1`.
  Widget rounded1() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.0),
      child: this,
    );
  }

  /// Applies a medium border-radius of 0.375rem (6px), matching `.rounded-2`.
  Widget rounded2() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6.0),
      child: this,
    );
  }

  /// Applies a large border-radius of 0.5rem (8px), matching `.rounded-3`.
  Widget rounded3() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: this,
    );
  }

  /// Applies an extra-large border-radius of 1rem (16px), matching `.rounded-4`.
  Widget rounded4() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: this,
    );
  }

  /// Applies an extra-extra-large border-radius of 2rem (32px), matching `.rounded-5`.
  Widget rounded5() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32.0),
      child: this,
    );
  }

  /// Applies a circular border-radius, matching `.rounded-circle`.
  Widget roundedCircle() {
    return ClipOval(
      child: this,
    );
  }

  /// Applies a pill-like border-radius (large value), matching `.rounded-pill`.
  Widget roundedPill() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50.0),
      child: this,
    );
  }

  /// Applies border-radius only to the top side, matching `.rounded-top`.
  Widget roundedTop({double radius = 6.0}) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(radius),
      ),
      child: this,
    );
  }

  /// Applies border-radius only to the bottom side, matching `.rounded-bottom`.
  Widget roundedBottom({double radius = 6.0}) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(radius),
      ),
      child: this,
    );
  }

  /// Applies border-radius only to the start (left) side, matching `.rounded-start`.
  Widget roundedStart({double radius = 6.0}) {
    return ClipRRect(
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(radius),
      ),
      child: this,
    );
  }

  /// Applies border-radius only to the end (right) side, matching `.rounded-end`.
  Widget roundedEnd({double radius = 6.0}) {
    return ClipRRect(
      borderRadius: BorderRadius.horizontal(
        right: Radius.circular(radius),
      ),
      child: this,
    );
  }
}

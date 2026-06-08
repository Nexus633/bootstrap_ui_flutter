import 'package:flutter/material.dart';
import '../tokens/typography.dart';

/// Extension on [Text] to provide Bootstrap-like text utilities.
extension BsTextExtension on Text {
  /// Helper to create a copy of the Text widget with a modified TextStyle.
  Text _copyWithStyle(TextStyle Function(TextStyle? existing) updateStyle) {
    if (data != null) {
      return Text(
        data!,
        key: key,
        style: updateStyle(style),
        strutStyle: strutStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        locale: locale,
        softWrap: softWrap,
        overflow: overflow,
        textScaler: textScaler,
        maxLines: maxLines,
        semanticsLabel: semanticsLabel,
        textWidthBasis: textWidthBasis,
        textHeightBehavior: textHeightBehavior,
        selectionColor: selectionColor,
      );
    } else if (textSpan != null) {
      return Text.rich(
        textSpan!,
        key: key,
        style: updateStyle(style),
        strutStyle: strutStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        locale: locale,
        softWrap: softWrap,
        overflow: overflow,
        textScaler: textScaler,
        maxLines: maxLines,
        semanticsLabel: semanticsLabel,
        textWidthBasis: textWidthBasis,
        textHeightBehavior: textHeightBehavior,
        selectionColor: selectionColor,
      );
    }
    return this;
  }

  /// Helper to create a copy of the Text widget with a modified TextAlign.
  Text _copyWithTextAlign(TextAlign align) {
    if (data != null) {
      return Text(
        data!,
        key: key,
        style: style,
        strutStyle: strutStyle,
        textAlign: align,
        textDirection: textDirection,
        locale: locale,
        softWrap: softWrap,
        overflow: overflow,
        textScaler: textScaler,
        maxLines: maxLines,
        semanticsLabel: semanticsLabel,
        textWidthBasis: textWidthBasis,
        textHeightBehavior: textHeightBehavior,
        selectionColor: selectionColor,
      );
    } else if (textSpan != null) {
      return Text.rich(
        textSpan!,
        key: key,
        style: style,
        strutStyle: strutStyle,
        textAlign: align,
        textDirection: textDirection,
        locale: locale,
        softWrap: softWrap,
        overflow: overflow,
        textScaler: textScaler,
        maxLines: maxLines,
        semanticsLabel: semanticsLabel,
        textWidthBasis: textWidthBasis,
        textHeightBehavior: textHeightBehavior,
        selectionColor: selectionColor,
      );
    }
    return this;
  }

  /// Truncates the text with an ellipsis if it exceeds one line.
  ///
  /// This mirrors Bootstrap's `.text-truncate` class.
  ///
  /// Example:
  /// ```dart
  /// Text('Very long text...').truncate()
  /// ```
  Text truncate() {
    if (data != null) {
      return Text(
        data!,
        key: key,
        style: style,
        strutStyle: strutStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        locale: locale,
        softWrap: false,
        overflow: TextOverflow.ellipsis,
        textScaler: textScaler,
        maxLines: 1,
        semanticsLabel: semanticsLabel,
        textWidthBasis: textWidthBasis,
        textHeightBehavior: textHeightBehavior,
        selectionColor: selectionColor,
      );
    } else if (textSpan != null) {
      return Text.rich(
        textSpan!,
        key: key,
        style: style,
        strutStyle: strutStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        locale: locale,
        softWrap: false,
        overflow: TextOverflow.ellipsis,
        textScaler: textScaler,
        maxLines: 1,
        semanticsLabel: semanticsLabel,
        textWidthBasis: textWidthBasis,
        textHeightBehavior: textHeightBehavior,
        selectionColor: selectionColor,
      );
    }
    return this;
  }

  /// Sets the font size to fs-1 (40px, equivalent to h1).
  Text fs1() => _copyWithStyle((s) => (s ?? const TextStyle()).copyWith(fontSize: BsTypography.h1));

  /// Sets the font size to fs-2 (32px, equivalent to h2).
  Text fs2() => _copyWithStyle((s) => (s ?? const TextStyle()).copyWith(fontSize: BsTypography.h2));

  /// Sets the font size to fs-3 (28px, equivalent to h3).
  Text fs3() => _copyWithStyle((s) => (s ?? const TextStyle()).copyWith(fontSize: BsTypography.h3));

  /// Sets the font size to fs-4 (24px, equivalent to h4).
  Text fs4() => _copyWithStyle((s) => (s ?? const TextStyle()).copyWith(fontSize: BsTypography.h4));

  /// Sets the font size to fs-5 (20px, equivalent to h5).
  Text fs5() => _copyWithStyle((s) => (s ?? const TextStyle()).copyWith(fontSize: BsTypography.h5));

  /// Sets the font size to fs-6 (16px, equivalent to h6).
  Text fs6() => _copyWithStyle((s) => (s ?? const TextStyle()).copyWith(fontSize: BsTypography.h6));

  /// Sets the font weight to bold (w700, equivalent to fw-bold).
  Text fwBold() => _copyWithStyle((s) => (s ?? const TextStyle()).copyWith(fontWeight: BsTypography.weightBold));

  /// Sets the font weight to bolder (w800, equivalent to fw-bolder).
  Text fwBolder() => _copyWithStyle((s) => (s ?? const TextStyle()).copyWith(fontWeight: FontWeight.w800));

  /// Sets the font weight to semibold (w600, equivalent to fw-semibold).
  Text fwSemibold() => _copyWithStyle((s) => (s ?? const TextStyle()).copyWith(fontWeight: FontWeight.w600));

  /// Sets the font weight to medium (w500, equivalent to fw-medium).
  Text fwMedium() => _copyWithStyle((s) => (s ?? const TextStyle()).copyWith(fontWeight: BsTypography.weightMedium));

  /// Sets the font weight to normal (w400, equivalent to fw-normal).
  Text fwNormal() => _copyWithStyle((s) => (s ?? const TextStyle()).copyWith(fontWeight: BsTypography.weightNormal));

  /// Sets the font weight to light (w300, equivalent to fw-light).
  Text fwLight() => _copyWithStyle((s) => (s ?? const TextStyle()).copyWith(fontWeight: BsTypography.weightLight));

  /// Sets the font weight to lighter (w200, equivalent to fw-lighter).
  Text fwLighter() => _copyWithStyle((s) => (s ?? const TextStyle()).copyWith(fontWeight: FontWeight.w200));

  /// Sets the font style to italic (equivalent to fst-italic).
  Text fstItalic() => _copyWithStyle((s) => (s ?? const TextStyle()).copyWith(fontStyle: FontStyle.italic));

  /// Sets the font style to normal (equivalent to fst-normal).
  Text fstNormal() => _copyWithStyle((s) => (s ?? const TextStyle()).copyWith(fontStyle: FontStyle.normal));

  /// Sets the line height to 1.0 (equivalent to lh-1).
  Text lh1() => _copyWithStyle((s) => (s ?? const TextStyle()).copyWith(height: 1.0));

  /// Sets the line height to small (1.25, equivalent to lh-sm).
  Text lhSm() => _copyWithStyle((s) => (s ?? const TextStyle()).copyWith(height: BsTypography.lineHeightSm));

  /// Sets the line height to base (1.5, equivalent to lh-base).
  Text lhBase() => _copyWithStyle((s) => (s ?? const TextStyle()).copyWith(height: BsTypography.lineHeightBase));

  /// Sets the line height to large (2.0, equivalent to lh-lg).
  Text lhLg() => _copyWithStyle((s) => (s ?? const TextStyle()).copyWith(height: BsTypography.lineHeightLg));

  /// Aligns the text to the start (left, equivalent to text-start).
  Text textStart() => _copyWithTextAlign(TextAlign.start);

  /// Aligns the text to the center (equivalent to text-center).
  Text textCenter() => _copyWithTextAlign(TextAlign.center);

  /// Aligns the text to the end (right, equivalent to text-end).
  Text textEnd() => _copyWithTextAlign(TextAlign.end);

  /// Applies underline decoration (equivalent to text-decoration-underline).
  Text textDecorationUnderline() => _copyWithStyle((s) => (s ?? const TextStyle()).copyWith(decoration: TextDecoration.underline));

  /// Applies line-through decoration (equivalent to text-decoration-line-through).
  Text textDecorationLineThrough() => _copyWithStyle((s) => (s ?? const TextStyle()).copyWith(decoration: TextDecoration.lineThrough));

  /// Removes text decoration (equivalent to text-decoration-none).
  Text textDecorationNone() => _copyWithStyle((s) => (s ?? const TextStyle()).copyWith(decoration: TextDecoration.none));
}

import 'package:flutter/material.dart';

/// Extension on [Text] to provide Bootstrap-like text utilities.
extension BsTextExtension on Text {
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
}

import 'package:flutter/material.dart';
import '../../tokens/bootstrap_theme.dart';
import '../../tokens/enums.dart';
import '../../tokens/typography.dart';
import '../../utilities/spacing_extension.dart';

/// A Bootstrap-style radio button component.
///
/// Implements `.form-check` with type radio from Bootstrap 5.
class BsRadio<T> extends StatefulWidget {
  /// Creates a [BsRadio] selection control.
  const BsRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.label,
    this.inline = false,
    this.reverse = false,
    this.disabled = false,
    this.validationState,
  });

  /// The value represented by this radio button.
  final T value;

  /// The currently selected value for this group of radio buttons.
  final T? groupValue;

  /// Called when the user selects this radio button.
  final ValueChanged<T?>? onChanged;

  /// The label widget to display next to the radio button.
  final Widget? label;

  /// If true, applies inline styling, allowing multiple checks/radios on the same line.
  final bool inline;

  /// If true, places the input on the opposite side of the label.
  final bool reverse;

  /// Whether the input is disabled.
  final bool disabled;

  /// Explicit validation state.
  final BsValidationState? validationState;

  @override
  State<BsRadio<T>> createState() => _BsRadioState<T>();
}

class _BsRadioState<T> extends State<BsRadio<T>> {
  bool _isFocused = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChanged);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChanged);
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChanged() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _select() {
    if (widget.disabled || widget.onChanged == null) return;
    if (widget.value != widget.groupValue) {
      widget.onChanged!(widget.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.bs;
    final bool isChecked = widget.value == widget.groupValue;

    // Resolve Validation State colors
    final bool isInvalid = widget.validationState == BsValidationState.invalid;
    final bool isValid = widget.validationState == BsValidationState.valid;

    Color borderColor = theme.border;
    Color focusRingColor = theme.primary.withValues(alpha: 0.25);
    Color focusBorderColor = theme.primary.withValues(alpha: 0.5);
    Color activeBgColor = theme.primary;
    Color activeBorderColor = theme.primary;

    if (isInvalid) {
      borderColor = theme.danger;
      focusBorderColor = theme.danger;
      focusRingColor = theme.danger.withValues(alpha: 0.25);
      activeBgColor = theme.danger;
      activeBorderColor = theme.danger;
    } else if (isValid) {
      borderColor = theme.success;
      focusBorderColor = theme.success;
      focusRingColor = theme.success.withValues(alpha: 0.25);
      activeBgColor = theme.success;
      activeBorderColor = theme.success;
    }

    Color bgColor = theme.bodyBg;
    if (isChecked) {
      bgColor = activeBgColor;
      borderColor = activeBorderColor;
    }

    if (widget.disabled) {
      bgColor = isChecked
          ? theme.primary.withValues(alpha: 0.5)
          : theme.bodyBgSecondary;
      borderColor = theme.border.withValues(alpha: 0.5);
    }

    // Input Visual
    final Widget inputVisual = AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: 16.0,
      height: 16.0,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: _isFocused ? focusBorderColor : borderColor,
          width: 1.0,
        ),
        boxShadow: (_isFocused && !widget.disabled)
            ? [
                BoxShadow(
                  color: focusRingColor,
                  blurRadius: 0,
                  spreadRadius: 4.0,
                ),
              ]
            : null,
      ),
      child: isChecked
          ? Center(
              child: Container(
                width: 6.0,
                height: 6.0,
                decoration: BoxDecoration(
                  color: widget.disabled ? Colors.white.withValues(alpha: 0.8) : Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            )
          : null,
    );

    // Keyboard navigation
    final Widget inputWidget = Focus(
      focusNode: _focusNode,
      onKeyEvent: (node, event) {
        if (event.logicalKey.keyLabel == 'Enter' ||
            event.logicalKey.keyLabel == ' ') {
          _select();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: inputVisual,
    );

    // Label
    Widget? labelWidget;
    if (widget.label != null) {
      labelWidget = DefaultTextStyle(
        style: TextStyle(
          color: widget.disabled ? theme.bodyTextSecondary : theme.bodyText,
          fontSize: BsTypography.fontSizeBase,
        ),
        child: widget.label!,
      );
    }

    // Assembly
    final List<Widget> rowChildren = [];
    if (widget.reverse) {
      if (labelWidget != null) {
        rowChildren.add(widget.inline ? labelWidget : Expanded(child: labelWidget));
        rowChildren.add(const SizedBox(width: 8.0));
      }
      rowChildren.add(inputWidget);
    } else {
      rowChildren.add(inputWidget);
      if (labelWidget != null) {
        rowChildren.add(const SizedBox(width: 8.0));
        rowChildren.add(widget.inline ? labelWidget : Expanded(child: labelWidget));
      }
    }

    Widget content = MouseRegion(
      cursor: widget.disabled
          ? SystemMouseCursors.forbidden
          : SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _select,
        behavior: HitTestBehavior.opaque,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: rowChildren,
        ).py(4),
      ),
    );

    if (widget.inline) {
      content = Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: content,
      );
    }

    return content;
  }
}

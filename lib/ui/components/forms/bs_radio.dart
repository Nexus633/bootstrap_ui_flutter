import 'package:flutter/material.dart';
import '../../tokens/bootstrap_theme.dart';
import '../../tokens/enums.dart';
import '../../tokens/shadows.dart';
import '../../tokens/transitions.dart';
import '../../tokens/typography.dart';
import '../../utilities/spacing_extension.dart';
import 'bs_validated_form.dart';

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
    
    final bool wasValidated = BsValidatedForm.of(context);

    // Resolve Validation State colors
    BsValidationState currentState =
        widget.validationState ?? BsValidationState.none;
    if (widget.validationState == null) {
      if (wasValidated) {
        currentState = BsValidationState.valid;
      }
    }

    final bool isInvalid = currentState == BsValidationState.invalid;
    final bool isValid = currentState == BsValidationState.valid;

    Color borderColor = theme.border;
    Color focusBorderColor = theme.primary.withValues(alpha: 0.5);
    Color activeBgColor = theme.primary;
    Color activeBorderColor = theme.primary;

    if (isInvalid) {
      borderColor = theme.danger;
      focusBorderColor = theme.danger;
      activeBgColor = theme.danger;
      activeBorderColor = theme.danger;
    } else if (isValid) {
      borderColor = theme.success;
      focusBorderColor = theme.success;
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
      duration: BsTransitions.baseDuration,
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
            ? BsShadows.focusRing(isInvalid ? theme.danger : (isValid ? theme.success : theme.primary))
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

    // No custom focus wrapper needed, handled by FocusableActionDetector
    final Widget inputWidget = inputVisual;

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

    Widget content = Semantics(
      checked: isChecked,
      inMutuallyExclusiveGroup: true,
      enabled: !widget.disabled,
      child: FocusableActionDetector(
        focusNode: _focusNode,
        mouseCursor: widget.disabled ? SystemMouseCursors.forbidden : SystemMouseCursors.click,
        onShowFocusHighlight: (v) => setState(() => _isFocused = v),
        actions: {
          ActivateIntent: CallbackAction<Intent>(
            onInvoke: (_) {
              _select();
              return null;
            },
          ),
        },
        child: GestureDetector(
          onTap: _select,
          behavior: HitTestBehavior.opaque,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: rowChildren,
          ).py(4),
        ),
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

import 'package:flutter/material.dart';
import '../../tokens/bootstrap_theme.dart';
import '../../tokens/enums.dart';
import '../../tokens/typography.dart';
import '../../utilities/spacing_extension.dart';
import 'bs_feedback.dart';

/// A Bootstrap-style checkbox and switch component.
///
/// Implements `.form-check` and `.form-switch` from Bootstrap 5.
/// Integrates natively with Flutter's [Form] system via [FormField].
class BsCheckbox extends FormField<bool> {
  /// Creates a [BsCheckbox].
  BsCheckbox({
    super.key,
    this.label,
    bool initialValue = false,
    this.isSwitch = false,
    this.inline = false,
    this.reverse = false,
    this.disabled = false,
    this.onChanged,
    this.validationState,
    super.validator,
    super.onSaved,
    super.autovalidateMode,
  }) : super(
         initialValue: initialValue,
         builder: (FormFieldState<bool> field) {
           final _BsCheckboxState state = field as _BsCheckboxState;
           return state._buildField();
         },
       );

  /// The label widget to display next to the checkbox/switch.
  final Widget? label;

  /// If true, renders a toggle switch (`.form-switch`) instead of a checkbox.
  final bool isSwitch;

  /// If true, applies inline styling (`.form-check-inline`), allowing multiple checks on the same line.
  final bool inline;

  /// If true, places the input on the opposite side of the label (`.form-check-reverse`).
  final bool reverse;

  /// Whether the input is disabled.
  final bool disabled;

  /// Called when the user toggles the checkbox/switch.
  final ValueChanged<bool?>? onChanged;

  /// Explicit validation state. Overrides standard `FormField` validation if provided.
  final BsValidationState? validationState;

  @override
  FormFieldState<bool> createState() => _BsCheckboxState();
}

class _BsCheckboxState extends FormFieldState<bool> {
  bool _isFocused = false;
  final FocusNode _focusNode = FocusNode();

  @override
  BsCheckbox get widget => super.widget as BsCheckbox;

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

  void _toggle() {
    if (widget.disabled) return;
    final newValue = !(value ?? false);
    didChange(newValue);
    if (widget.onChanged != null) widget.onChanged!(newValue);
  }

  Widget _buildField() {
    final theme = context.bs;
    final bool isChecked = value ?? false;

    // Resolve Validation State
    BsValidationState currentState =
        widget.validationState ?? BsValidationState.none;
    if (widget.validationState == null && hasError) {
      currentState = BsValidationState.invalid;
    }

    final bool isInvalid = currentState == BsValidationState.invalid;
    final bool isValid = currentState == BsValidationState.valid;

    // Resolve Colors
    Color borderColor = theme.border; // equivalent to .form-check-input border
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

    // ─── Input Visual (Checkbox or Switch) ──────────────────────────────────
    Widget inputVisual;

    if (widget.isSwitch) {
      // Switch rendering
      inputVisual = AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 32.0, // 2em
        height: 16.0, // 1em
        decoration: BoxDecoration(
          color: isChecked
              ? activeBgColor
              : (theme
                    .bodyBgSecondary), // Unchecked switch usually has a gray bg, not pure white
          borderRadius: BorderRadius.circular(16.0), // Pill shape
          border: Border.all(
            color: _isFocused
                ? focusBorderColor
                : (isChecked ? activeBorderColor : theme.border),
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
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeInOut,
          alignment: isChecked ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.all(2.0),
            width: 10.0,
            height: 10.0,
            decoration: BoxDecoration(
              color: isChecked ? Colors.white : theme.bodyTextSecondary,
              shape: BoxShape.circle,
            ),
          ),
        ),
      );
    } else {
      // Checkbox rendering
      inputVisual = AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 16.0, // 1em
        height: 16.0, // 1em
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(4.0), // .25em
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
            ? const Center(
                child: Icon(Icons.check, size: 14.0, color: Colors.white),
              )
            : null,
      );
    }

    // Wrap input with focus node detector for keyboard navigation
    Widget inputWidget = Focus(
      focusNode: _focusNode,
      onKeyEvent: (node, event) {
        if (event.logicalKey.keyLabel == 'Enter' ||
            event.logicalKey.keyLabel == ' ') {
          _toggle();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: inputVisual,
    );

    // ─── Label ─────────────────────────────────────────────────────────────
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

    // ─── Assembly ──────────────────────────────────────────────────────────
    List<Widget> rowChildren = [];
    if (widget.reverse) {
      if (labelWidget != null) {
        rowChildren.add(widget.inline ? labelWidget : Expanded(child: labelWidget));
        rowChildren.add(
          const SizedBox(width: 8.0),
        ); // .5rem margin-left for reverse
      }
      rowChildren.add(inputWidget);
    } else {
      rowChildren.add(inputWidget);
      if (labelWidget != null) {
        rowChildren.add(
          const SizedBox(width: 8.0),
        ); // .5rem margin-right for normal
        rowChildren.add(widget.inline ? labelWidget : Expanded(child: labelWidget));
      }
    }

    Widget content = MouseRegion(
      cursor: widget.disabled
          ? SystemMouseCursors.forbidden
          : SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _toggle,
        behavior: HitTestBehavior.opaque,
        child: Row(
          mainAxisSize: MainAxisSize.min, // shrink-wrap if inline
          crossAxisAlignment: CrossAxisAlignment.start,
          children: rowChildren,
        ).py(4), // Give it a slight vertical padding for touch target
      ),
    );

    // Wrap in inline styling if needed
    if (widget.inline) {
      content.pe3();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        content,
        if (hasError)
          BsFormFeedback(
            state: BsValidationState.invalid,
            message: errorText!,
          ).pt(4),
      ],
    );
  }
}

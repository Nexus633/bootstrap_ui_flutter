import 'package:flutter/material.dart';
import '../../tokens/bootstrap_theme.dart';
import '../../tokens/enums.dart';
import '../../tokens/typography.dart';
import '../../utilities/spacing_extension.dart';
import 'bs_feedback.dart';

import 'bs_input_group.dart';

/// A Bootstrap-style text input component.
///
/// Implements `.form-control` from Bootstrap 5.
/// Integrates natively with Flutter's [Form] system via [FormField].
class BsInput extends FormField<String> {
  /// Creates a [BsInput].
  BsInput({
    super.key,
    this.controller,
    String? initialValue,
    this.size = BsInputSize.md,
    this.disabled = false,
    this.readonly = false,
    this.plainText = false,
    this.placeholder,
    this.keyboardType,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines,
    this.focusNode,
    this.onChanged,
    this.onFieldSubmitted,
    this.validationState,
    this.customBorderRadius,
    super.validator,
    super.onSaved,
    super.autovalidateMode,
  }) : super(
         initialValue: controller != null
             ? controller.text
             : (initialValue ?? ''),
         builder: (FormFieldState<String> field) {
           final _BsInputState state = field as _BsInputState;
           return state._buildField();
         },
       );

  /// Controls the text being edited.
  final TextEditingController? controller;

  /// The size of the input.
  final BsInputSize size;

  /// Whether the input is disabled (grayed out, unclickable).
  final bool disabled;

  /// Whether the input is readonly (cannot be modified, but can be focused/selected).
  final bool readonly;

  /// Whether to render the input as plain text (`.form-control-plaintext`).
  final bool plainText;

  /// The hint text to display when the input is empty.
  final String? placeholder;

  /// The type of keyboard to use for editing the text.
  final TextInputType? keyboardType;

  /// Whether to hide the text being edited (e.g., for passwords).
  final bool obscureText;

  /// The maximum number of lines to show at one time, wrapping if necessary.
  final int? maxLines;

  /// The minimum number of lines to occupy when the content spans fewer lines.
  final int? minLines;

  /// Defines the keyboard focus for this widget.
  final FocusNode? focusNode;

  /// Called when the user initiates a change to the TextField's value: when they have inserted or deleted text.
  final ValueChanged<String>? onChanged;

  /// Called when the user indicates that they are done editing the text in the field.
  final ValueChanged<String>? onFieldSubmitted;

  /// Explicit validation state. Overrides standard `FormField` validation if provided.
  final BsValidationState? validationState;

  /// Custom border radius. Useful when composing inside an input group.
  final BorderRadius? customBorderRadius;

  @override
  FormFieldState<String> createState() => _BsInputState();
}

class _BsInputState extends FormFieldState<String> {
  TextEditingController? _controller;
  FocusNode? _focusNode;
  bool _isFocused = false;

  TextEditingController get _effectiveController =>
      widget.controller ?? _controller!;

  FocusNode get _effectiveFocusNode => widget.focusNode ?? _focusNode!;

  @override
  BsInput get widget => super.widget as BsInput;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = TextEditingController(text: widget.initialValue);
    } else {
      widget.controller!.addListener(_handleControllerChanged);
    }

    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode!.addListener(_handleFocusChanged);
  }

  @override
  void didUpdateWidget(BsInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null) {
        _controller = TextEditingController.fromValue(
          oldWidget.controller!.value,
        );
      }
      if (widget.controller != null) {
        setValue(widget.controller!.text);
        if (oldWidget.controller == null) {
          _controller = null;
        }
      }
    }

    if (widget.focusNode != oldWidget.focusNode) {
      oldWidget.focusNode?.removeListener(_handleFocusChanged);
      widget.focusNode?.addListener(_handleFocusChanged);
      if (oldWidget.focusNode != null && widget.focusNode == null) {
        _focusNode = FocusNode();
        _focusNode!.addListener(_handleFocusChanged);
      }
      if (widget.focusNode != null && oldWidget.focusNode == null) {
        _focusNode!.removeListener(_handleFocusChanged);
        _focusNode!.dispose();
        _focusNode = null;
      }
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    _controller?.dispose();
    widget.focusNode?.removeListener(_handleFocusChanged);
    _focusNode?.dispose();
    super.dispose();
  }

  @override
  void didChange(String? value) {
    super.didChange(value);
    if (_effectiveController.text != value) {
      _effectiveController.text = value ?? '';
    }
  }

  @override
  void reset() {
    super.reset();
    setState(() {
      _effectiveController.text = widget.initialValue ?? '';
    });
  }

  void _handleControllerChanged() {
    if (_effectiveController.text != value) {
      didChange(_effectiveController.text);
    }
  }

  void _handleFocusChanged() {
    setState(() {
      _isFocused = _effectiveFocusNode.hasFocus;
    });
  }

  // ─── Builder Logic ──────────────────────────────────────────────────────────

  Widget _buildField() {
    final theme = context.bs;

    // Resolve Validation State
    BsValidationState currentState =
        widget.validationState ?? BsValidationState.none;
    if (widget.validationState == null && hasError) {
      currentState = BsValidationState.invalid;
    }

    final bool isInvalid = currentState == BsValidationState.invalid;
    final bool isValid = currentState == BsValidationState.valid;

    // Resolve Colors based on state
    Color borderColor = theme.border;
    Color focusRingColor = theme.primary.withValues(alpha: 0.25);
    Color focusBorderColor = theme.primary.withValues(alpha: 0.5);

    if (isInvalid) {
      borderColor = theme.danger;
      focusBorderColor = theme.danger;
      focusRingColor = theme.danger.withValues(alpha: 0.25);
    } else if (isValid) {
      borderColor = theme.success;
      focusBorderColor = theme.success;
      focusRingColor = theme.success.withValues(alpha: 0.25);
    }

    Color bgColor = theme.bodyBg;
    if (widget.disabled) {
      bgColor = theme.bodyBgSecondary;
    } else if (widget.plainText) {
      bgColor = Colors.transparent;
      borderColor = Colors.transparent;
    }

    final groupContext = BsInputGroupChildContext.of(context);
    final BsInputSize effectiveSize = groupContext?.size ?? widget.size;
    final bool isFirst = groupContext?.isFirst ?? true;
    final bool isLast = groupContext?.isLast ?? true;

    // Resolve Padding based on Size
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(
      horizontal: 12.0,
      vertical: 6.0,
    ); // md (.375rem .75rem)
    double fontSize = BsTypography.fontSizeBase; // 1rem
    double minHeight = 38.0;

    if (effectiveSize == BsInputSize.sm) {
      padding = const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0);
      fontSize = BsTypography.fontSizeSm;
      minHeight = 31.0; // <--- NEU: Bootstrap sm height
    } else if (effectiveSize == BsInputSize.lg) {
      padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0);
      fontSize = BsTypography.fontSizeLg;
      minHeight = 48.0; // <--- NEU: Bootstrap lg height
    }

    if (widget.plainText) {
      padding = EdgeInsets.only(
        top: padding.vertical / 2,
        bottom: padding.vertical / 2,
      );
    }

    final double baseRadius = effectiveSize == BsInputSize.sm
        ? 4.0
        : (effectiveSize == BsInputSize.lg ? 8.0 : 6.0);
    final Radius r = Radius.circular(baseRadius);

    BorderRadius? groupBorderRadius;
    if (groupContext != null) {
      if (isFirst && isLast) {
        groupBorderRadius = BorderRadius.all(r);
      } else if (isFirst) {
        groupBorderRadius = BorderRadius.horizontal(left: r);
      } else if (isLast) {
        groupBorderRadius = BorderRadius.horizontal(right: r);
      } else {
        groupBorderRadius = BorderRadius.zero;
      }
    }

    final BorderRadius borderRadius =
        groupBorderRadius ?? widget.customBorderRadius ?? BorderRadius.all(r);

    final InputDecoration decoration = InputDecoration(
      isDense: true,
      contentPadding: padding,
      hintText: widget.placeholder,
      hintStyle: TextStyle(color: theme.bodyTextSecondary, fontSize: fontSize),
      filled: false,
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      focusedErrorBorder: InputBorder.none,
      errorStyle: const TextStyle(height: 0, fontSize: 0),
    );

    // Container for Focus Ring and Visual Bounds
    final Widget inputWidget = AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      constraints: BoxConstraints(minHeight: minHeight),
      decoration: BoxDecoration(
        color: bgColor, // Moved from InputDecoration
        borderRadius: borderRadius,
        border: widget.plainText
            ? null
            : Border.all(
                color: _isFocused ? focusBorderColor : borderColor,
                width: 1.0,
              ), // Moved from InputDecoration
        boxShadow: (_isFocused && !widget.disabled && !widget.plainText)
            ? [
                BoxShadow(
                  color: focusRingColor,
                  blurRadius: 0,
                  spreadRadius: 4.0,
                ),
              ] // Bootstrap uses 0 0 0 .25rem
            : null,
      ),

      child: TextField(
        controller: _effectiveController,
        focusNode: _effectiveFocusNode,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        enabled: !widget.disabled,
        readOnly:
            widget.readonly ||
            widget
                .plainText, // Plain text implies readonly visually in Bootstrap usage
        style: TextStyle(
          color: widget.disabled ? theme.bodyTextSecondary : theme.bodyText,
          fontSize: fontSize,
        ),
        cursorColor: theme.bodyText,
        decoration: decoration,
        onChanged: (value) {
          didChange(value);
          if (widget.onChanged != null) widget.onChanged!(value);
        },
        onSubmitted: widget.onFieldSubmitted,
        textAlignVertical: (widget.maxLines == null || widget.maxLines! > 1)
            ? TextAlignVertical.top
            : TextAlignVertical.center, // Helps center text when stretched
      ),
    );

    // If inside an InputGroup, we MUST NOT wrap the inputWidget in a Column that takes min height.
    // The InputGroup uses IntrinsicHeight + CrossAxisAlignment.stretch on its children.
    // A Column with MainAxisSize.min will NOT stretch its children vertically to fill the IntrinsicHeight.
    // So if it's in a group, we return just the inputWidget, and the feedback will have to be handled differently (e.g. grouped below the entire InputGroup).
    if (groupContext != null) {
      return inputWidget;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        inputWidget,
        if (hasError)
          BsFormFeedback(
            state: BsValidationState.invalid,
            message: errorText!,
          ).pt(4),
      ],
    );
  }
}

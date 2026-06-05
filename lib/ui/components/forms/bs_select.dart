import 'package:flutter/material.dart';
import '../../tokens/bootstrap_theme.dart';
import '../../tokens/enums.dart';
import '../../tokens/typography.dart';
import 'bs_feedback.dart';
import 'bs_input_group.dart';

/// A Bootstrap-style select (dropdown) component.
///
/// Implements `.form-select` from Bootstrap 5.
/// Integrates natively with Flutter's [Form] system via [FormField].
class BsSelect<T> extends FormField<T> {
  /// Creates a [BsSelect].
  BsSelect({
    super.key,
    required this.items,
    T? value,
    this.size = BsInputSize.md,
    this.disabled = false,
    this.placeholder,
    this.onChanged,
    this.validationState,
    this.customBorderRadius,
    super.validator,
    super.onSaved,
    super.autovalidateMode,
  }) : super(
         initialValue: value,
         builder: (FormFieldState<T> field) {
           final _BsSelectState<T> state = field as _BsSelectState<T>;
           return state._buildField();
         },
       );

  /// The list of items the user can select.
  final List<DropdownMenuItem<T>> items;

  /// The size of the select input.
  final BsInputSize size;

  /// Whether the select is disabled (grayed out, unclickable).
  final bool disabled;

  /// The hint text to display when no value is selected.
  final Widget? placeholder;

  /// Called when the user selects an item.
  final ValueChanged<T?>? onChanged;

  /// Explicit validation state. Overrides standard `FormField` validation if provided.
  final BsValidationState? validationState;

  /// Custom border radius. Useful when composing inside an input group.
  final BorderRadius? customBorderRadius;

  @override
  FormFieldState<T> createState() => _BsSelectState<T>();
}

class _BsSelectState<T> extends FormFieldState<T> {
  bool _isFocused = false;
  final FocusNode _focusNode = FocusNode();

  @override
  BsSelect<T> get widget => super.widget as BsSelect<T>;

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
    Color indicatorColor = theme.bodyText; // Default chevron color

    if (isInvalid) {
      borderColor = theme.danger;
      focusBorderColor = theme.danger;
      focusRingColor = theme.danger.withValues(alpha: 0.25);
      indicatorColor = theme.danger;
    } else if (isValid) {
      borderColor = theme.success;
      focusBorderColor = theme.success;
      focusRingColor = theme.success.withValues(alpha: 0.25);
      indicatorColor = theme.success;
    }

    Color bgColor = theme.bodyBg;
    if (widget.disabled) {
      bgColor = theme.bodyBgSecondary;
    }

    final groupContext = BsInputGroupChildContext.of(context);
    final BsInputSize effectiveSize = groupContext?.size ?? widget.size;
    final bool isFirst = groupContext?.isFirst ?? true;
    final bool isLast = groupContext?.isLast ?? true;

    // Resolve Padding based on Size
    // Select requires slightly different padding, especially on the right for the indicator
    EdgeInsetsGeometry padding = const EdgeInsets.only(
      left: 12.0,
      top: 6.0,
      bottom: 6.0,
      right: 36.0,
    );
    double fontSize = BsTypography.fontSizeBase;
    double iconSize = 24.0;
    double minHeight = 38.0;

    if (effectiveSize == BsInputSize.sm) {
      padding = const EdgeInsets.only(
        left: 8.0,
        top: 4.0,
        bottom: 4.0,
        right: 32.0,
      );
      fontSize = BsTypography.fontSizeSm;
      iconSize = 20.0;
      minHeight = 31.0; // <--- NEU
    } else if (effectiveSize == BsInputSize.lg) {
      padding = const EdgeInsets.only(
        left: 16.0,
        top: 8.0,
        bottom: 8.0,
        right: 40.0,
      );
      fontSize = BsTypography.fontSizeLg;
      iconSize = 28.0;
      minHeight = 48.0; // <--- NEU
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

    // Container for Focus Ring
    Widget selectWidget = AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      constraints: BoxConstraints(minHeight: minHeight),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: borderRadius,
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
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          isDense: true,
          value: value,
          items: widget.items,
          onChanged: widget.disabled
              ? null
              : (T? newValue) {
                  didChange(newValue);
                  if (widget.onChanged != null) widget.onChanged!(newValue);
                },
          focusNode: _focusNode,
          hint: widget.placeholder,
          style: TextStyle(
            color: widget.disabled ? theme.bodyTextSecondary : theme.bodyText,
            fontSize: fontSize,
          ),
          icon: Icon(
            Icons.expand_more,
            color: indicatorColor,
            size: iconSize,
          ), // Custom chevron
          iconSize: iconSize,
          isExpanded: true, // Make sure it takes full width of the field
          dropdownColor: theme.bodyBg, // Match dropdown background to theme
          padding: padding, // Use padding here directly
        ),
      ),
    );

    if (groupContext != null) {
      return selectWidget;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        selectWidget,
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: BsFormFeedback(
              state: BsValidationState.invalid,
              message: errorText!,
            ),
          ),
      ],
    );
  }
}

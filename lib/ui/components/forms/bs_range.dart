import 'package:flutter/material.dart';
import '../../tokens/bootstrap_theme.dart';
import '../../tokens/enums.dart';
import '../../utilities/spacing_extension.dart';
import 'bs_feedback.dart';
import 'bs_validated_form.dart';

/// A Bootstrap-style range slider component.
///
/// Implements `.form-range` from Bootstrap 5.
/// Integrates natively with Flutter's [Form] system via [FormField].
class BsRange extends FormField<double> {
  /// Creates a [BsRange].
  BsRange({
    super.key,
    double initialValue = 50.0,
    this.min = 0.0,
    this.max = 100.0,
    this.divisions,
    this.disabled = false,
    this.onChanged,
    this.validationState,
    super.validator,
    super.onSaved,
    super.autovalidateMode,
  }) : super(
          initialValue: initialValue,
          builder: (FormFieldState<double> field) {
            final _BsRangeState state = field as _BsRangeState;
            return state._buildField();
          },
        );

  /// The minimum value the user can select.
  final double min;

  /// The maximum value the user can select.
  final double max;

  /// The number of discrete divisions.
  final int? divisions;

  /// Whether the range slider is disabled.
  final bool disabled;

  /// Called when the user changes the slider's value.
  final ValueChanged<double>? onChanged;

  /// Explicit validation state. Overrides standard `FormField` validation if provided.
  final BsValidationState? validationState;

  @override
  FormFieldState<double> createState() => _BsRangeState();
}

class _BsRangeState extends FormFieldState<double> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  BsRange get widget => super.widget as BsRange;

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
    final double currentValue = value ?? widget.min;
    
    final bool wasValidated = BsValidatedForm.of(context);

    // Resolve Validation State
    BsValidationState currentState = widget.validationState ?? BsValidationState.none;
    if (widget.validationState == null) {
      if (hasError) {
        currentState = BsValidationState.invalid;
      } else if (wasValidated) {
        currentState = BsValidationState.valid;
      }
    }
    
    final bool isInvalid = currentState == BsValidationState.invalid;

    // Resolve Colors
    Color thumbColor = theme.primary;
    Color activeTrackColor = theme.primary;
    Color inactiveTrackColor = theme.border;
    Color focusRingColor = theme.primary.withValues(alpha: 0.25);

    if (isInvalid) {
      thumbColor = theme.danger;
      activeTrackColor = theme.danger;
      focusRingColor = theme.danger.withValues(alpha: 0.25);
    } else if (currentState == BsValidationState.valid) {
      thumbColor = theme.success;
      activeTrackColor = theme.success;
      focusRingColor = theme.success.withValues(alpha: 0.25);
    }

    if (widget.disabled) {
      thumbColor = theme.bodyTextSecondary;
      activeTrackColor = theme.border;
      inactiveTrackColor = theme.bodyBgSecondary;
    }

    // Bootstrap .form-range styles:
    // Track height: 0.5rem (8px)
    // Thumb size: 1rem (16px)
    // Actually, Flutter's default slider looks very different. We need to use SliderTheme.

    final Widget slider = SliderTheme(
      data: SliderThemeData(
        trackHeight: 8.0,
        activeTrackColor: activeTrackColor,
        inactiveTrackColor: inactiveTrackColor,
        thumbColor: thumbColor,
        overlayColor: _isFocused ? focusRingColor : Colors.transparent,
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 14.0), // Focus ring size
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8.0, disabledThumbRadius: 8.0),
        // Hide the default value indicator bubble to match Bootstrap, which relies on external output tags
        showValueIndicator: ShowValueIndicator.never,
      ),
      child: Focus(
        focusNode: _focusNode,
        child: Slider(
          value: currentValue.clamp(widget.min, widget.max),
          min: widget.min,
          max: widget.max,
          divisions: widget.divisions,
          onChanged: widget.disabled
              ? null
              : (newValue) {
                  didChange(newValue);
                  if (widget.onChanged != null) widget.onChanged!(newValue);
                },
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        slider,
        if (hasError)
          BsFormFeedback(state: BsValidationState.invalid, message: errorText!).pt(4),
      ],
    );
  }
}

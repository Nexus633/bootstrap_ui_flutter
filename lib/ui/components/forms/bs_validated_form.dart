import 'package:flutter/material.dart';

/// A wrapper widget that acts like Bootstrap's `.was-validated` CSS class.
///
/// By default, Flutter's [Form] only knows about invalid (error) states.
/// It does not color successfully validated fields green. 
/// Wrapping your form in [BsValidatedForm] and setting [wasValidated] to `true`
/// tells all Bootstrap input components to render their valid (green) state 
/// if they don't have an error.
class BsValidatedForm extends InheritedWidget {
  /// Creates a [BsValidatedForm].
  const BsValidatedForm({
    super.key,
    required this.wasValidated,
    required super.child,
  });

  /// Whether the form has been validated. If `true`, all child form fields
  /// that pass validation will render with a valid (green) state.
  final bool wasValidated;

  /// Retrieves the nearest [BsValidatedForm] state from the context.
  static bool of(BuildContext context) {
    final BsValidatedForm? result =
        context.dependOnInheritedWidgetOfExactType<BsValidatedForm>();
    return result?.wasValidated ?? false;
  }

  @override
  bool updateShouldNotify(BsValidatedForm oldWidget) {
    return wasValidated != oldWidget.wasValidated;
  }
}

import 'package:flutter/material.dart';
import '../../tokens/bootstrap_theme.dart';
import '../../tokens/enums.dart';
import '../../utilities/spacing_extension.dart';
import '../../utilities/size_extension.dart';

/// A Bootstrap-style form feedback component.
///
/// Displays validation messages below form controls.
/// Maps to Bootstrap's `.valid-feedback` and `.invalid-feedback`.
class BsFormFeedback extends StatelessWidget {
  /// Creates a [BsFormFeedback] widget.
  const BsFormFeedback({
    super.key,
    required this.state,
    required this.message,
    this.isTooltip = false,
  });

  /// The validation state (valid or invalid) determining the color.
  final BsValidationState state;

  /// The text message to display.
  final String message;

  /// Whether to display the feedback as a tooltip instead of inline text.
  /// Maps to `.valid-tooltip` and `.invalid-tooltip`.
  final bool isTooltip;

  @override
  Widget build(BuildContext context) {
    if (state == .none || message.isEmpty) {
      return const SizedBox.shrink();
    }

    final theme = context.bs;
    final bool isInvalid = state == .invalid;
    
    // Default Bootstrap colors for feedback
    final Color feedbackColor = isInvalid ? theme.danger : theme.success;

    if (isTooltip) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        margin: const EdgeInsets.only(top: 4.0),
        decoration: BoxDecoration(
          color: feedbackColor,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14.0, // .875em
          ),
        ),
      ).w100(); // Usually tooltips take up available space or wrap tightly, we align it via wrapper.
    }

    return Text(
      message,
      style: TextStyle(
        color: feedbackColor,
        fontSize: 14.0, // Bootstrap uses .875em for feedback
      ),
    ).pt(4.0).w100(); // margin-top: .25rem
  }
}

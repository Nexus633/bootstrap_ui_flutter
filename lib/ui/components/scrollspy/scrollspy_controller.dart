import 'package:flutter/material.dart';
import '../../tokens/transitions.dart';

/// A controller for the [BsScrollspy] component.
///
/// The controller manages the currently active target ID and handles
/// smooth scrolling to the registered target sections.
class BsScrollspyController extends ChangeNotifier {
  /// Creates a [BsScrollspyController].
  ///
  /// If [scrollController] is not provided, a new [ScrollController] is created
  /// and managed by this controller.
  BsScrollspyController({
    ScrollController? scrollController,
  })  : scrollController = scrollController ?? ScrollController(),
        _ownsScrollController = scrollController == null;

  /// The underlying [ScrollController] used by the scrollable area.
  final ScrollController scrollController;
  final bool _ownsScrollController;

  final Map<String, GlobalKey> _targets = {};

  String? _activeTargetId;

  /// Returns an unmodifiable map of registered targets and their keys.
  Map<String, GlobalKey> get targets => Map.unmodifiable(_targets);

  /// The ID of the currently active target section.
  String? get activeTargetId => _activeTargetId;

  /// Registers a target section with the given [id] and [key].
  ///
  /// The [key] must be attached to the widget representing the target section
  /// within the scrollable area.
  void registerTarget(String id, GlobalKey key) {
    _targets[id] = key;
  }

  /// Unregisters the target section with the given [id].
  void unregisterTarget(String id) {
    _targets.remove(id);
  }

  /// Updates the currently active target ID and notifies listeners if it changed.
  void setActiveTarget(String id) {
    if (_activeTargetId != id) {
      _activeTargetId = id;
      notifyListeners();
    }
  }

  /// Scrolls to the target section with the given [id].
  ///
  /// If [smooth] is true (the default), the scrolling will be animated
  /// smoothly, as defined by Bootstrap's smooth scroll behavior.
  /// If false, it jumps to the section immediately.
  Future<void> scrollToTarget(String id, {bool smooth = true}) async {
    final key = _targets[id];
    if (key == null || key.currentContext == null) return;

    final context = key.currentContext!;
    if (smooth) {
      await Scrollable.ensureVisible(
        context,
        duration: BsTransitions.modalDuration,
        curve: Curves.easeInOut,
      );
    } else {
      Scrollable.ensureVisible(
        context,
        duration: Duration.zero,
      );
    }
  }

  @override
  void dispose() {
    if (_ownsScrollController) {
      scrollController.dispose();
    }
    super.dispose();
  }
}

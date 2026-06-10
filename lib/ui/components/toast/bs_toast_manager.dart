import 'package:flutter/material.dart';
import 'dart:async';

/// Global configuration and management for Bootstrap Toasts.
class BsToastManager {
  static final BsToastManager _instance = BsToastManager._internal();
  /// Gets the singleton instance of the [BsToastManager].
  factory BsToastManager() => _instance;
  BsToastManager._internal();

  OverlayEntry? _overlayEntry;
  final Map<Alignment, _ToastQueue> _queues = {};

  /// Shows a [toast] on the screen.
  /// 
  /// The toast will automatically disappear after [duration].
  /// If [duration] is null, it stays until explicitly dismissed via [BsToastManager.dismiss] or a close button.
  static void show(
    BuildContext context, {
    required Widget toast,
    Duration? duration = const Duration(seconds: 5),
    Alignment alignment = Alignment.bottomRight,
  }) {
    _instance._show(context, toast, duration, alignment);
  }

  void _show(BuildContext context, Widget toast, Duration? duration, Alignment alignment) {
    bool needsRebuild = false;

    if (!_queues.containsKey(alignment)) {
      _queues[alignment] = _ToastQueue();
      needsRebuild = true;
    }

    if (_overlayEntry == null) {
      _overlayEntry = OverlayEntry(
        builder: (context) => _BsToastOverlay(queues: _queues),
      );
      Overlay.of(context).insert(_overlayEntry!);
    } else if (needsRebuild) {
      _overlayEntry?.markNeedsBuild();
    }

    final queue = _queues[alignment]!;
    final entry = _ToastEntry(
      id: UniqueKey(),
      widget: toast,
      alignment: alignment,
    );

    queue.toasts.insert(0, entry);
    queue.listKey.currentState?.insertItem(0, duration: const Duration(milliseconds: 300));

    if (duration != null) {
      entry.timer = Timer(duration, () {
        _removeEntry(entry);
      });
    }
  }

  void _removeEntry(_ToastEntry entry) {
    final queue = _queues[entry.alignment];
    if (queue == null) return;

    final index = queue.toasts.indexOf(entry);
    if (index != -1) {
      entry.timer?.cancel();
      final removedItem = queue.toasts.removeAt(index);
      
      queue.listKey.currentState?.removeItem(
        index,
        (context, animation) => _buildItem(removedItem, animation, entry.alignment),
        duration: const Duration(milliseconds: 300),
      );

      if (queue.toasts.isEmpty) {
        Future.delayed(const Duration(milliseconds: 300), () {
          if (queue.toasts.isEmpty) {
            _queues.remove(entry.alignment);
            _overlayEntry?.markNeedsBuild();
            if (_queues.isEmpty && _overlayEntry != null) {
              _overlayEntry?.remove();
              _overlayEntry = null;
            }
          }
        });
      }
    }
  }

  /// Manually dismiss a specific toast if you know its widget or ID.
  /// For simplicity, if you need to dismiss from inside the toast, use a callback in the toast itself
  /// that calls a generic dismiss mechanism, or manage state externally.
  static void dismissAll() {
    final entriesToDismiss = <_ToastEntry>[];
    for (final queue in _instance._queues.values) {
      entriesToDismiss.addAll(queue.toasts);
    }
    for (var i = entriesToDismiss.length - 1; i >= 0; i--) {
      _instance._removeEntry(entriesToDismiss[i]);
    }
  }

  /// Dismisses a specific toast identified by its [Key].
  static void dismiss(Key id) {
    for (final queue in _instance._queues.values) {
      for (var i = 0; i < queue.toasts.length; i++) {
        if (queue.toasts[i].id == id) {
          _instance._removeEntry(queue.toasts[i]);
          return;
        }
      }
    }
  }

  /// Dismisses the toast that contains the given [context].
  /// Returns `true` if a toast was found and dismissed, `false` otherwise.
  static bool dismissOf(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<_BsToastScope>();
    if (scope != null) {
      dismiss(scope.toastId);
      return true;
    }
    return false;
  }

  Widget _buildItem(_ToastEntry entry, Animation<double> animation, Alignment alignment) {
    // Fade and slide transition
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: animation.drive(Tween(
          begin: Offset(0.0, alignment.y > 0 ? 0.5 : -0.5),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeOut))),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: _BsToastScope(
            toastId: entry.id,
            child: entry.widget,
          ),
        ),
      ),
    );
  }
}

class _BsToastScope extends InheritedWidget {
  const _BsToastScope({
    required this.toastId,
    required super.child,
  });

  final Key toastId;

  @override
  bool updateShouldNotify(_BsToastScope oldWidget) => toastId != oldWidget.toastId;
}

class _ToastQueue {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final List<_ToastEntry> toasts = [];
}

class _ToastEntry {
  final Key id;
  final Widget widget;
  final Alignment alignment;
  Timer? timer;

  _ToastEntry({
    required this.id, 
    required this.widget,
    required this.alignment,
  });
}

class _BsToastOverlay extends StatelessWidget {
  final Map<Alignment, _ToastQueue> queues;

  const _BsToastOverlay({
    required this.queues,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: queues.entries.map((entry) {
          final alignment = entry.key;
          final queue = entry.value;

          return Align(
            alignment: alignment,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Material(
                color: Colors.transparent,
                child: ConstrainedBox(
                  // Allow Toasts to dictate width, but constrain to screen
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: AnimatedList(
                    key: queue.listKey,
                    shrinkWrap: true,
                    initialItemCount: queue.toasts.length,
                    reverse: alignment.y > 0, // if bottom aligned, new items pop from bottom
                    itemBuilder: (context, index, animation) {
                      return BsToastManager()._buildItem(queue.toasts[index], animation, alignment);
                    },
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

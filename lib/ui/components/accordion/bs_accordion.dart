import 'package:flutter/material.dart';
import '../../tokens/bootstrap_theme.dart';
import '../../tokens/shadows.dart';
import '../../tokens/transitions.dart';
import '../../utilities/size_extension.dart';
import '../../utilities/spacing_extension.dart';

// ─── Data Model ──────────────────────────────────────────────────────────────

/// Represents a single item in the accordion.
class BsAccordionItem {
  /// Creates a [BsAccordionItem] with a title and body.
  const BsAccordionItem({
    required this.title,
    required this.body,
    this.initiallyExpanded = false,
  });

  /// The text in the header.
  final String title;

  /// The content that becomes visible when expanded.
  final Widget body;

  /// Whether the item should be open initially.
  final bool initiallyExpanded;
}

// ─── Main Widget ─────────────────────────────────────────────────────────────

/// Bootstrap-compatible accordion.
///
/// It displays a list of [BsAccordionItem]s that can be expanded or collapsed.
class BsAccordion extends StatefulWidget {
  /// Creates a [BsAccordion] with the given [items].
  const BsAccordion({
    super.key,
    required this.items,
    this.alwaysOpen = false,
    this.flush = false, // Bootstrap's .accordion-flush variant
    this.activeColor,
    this.mouseCursor,
  });

  /// The list of items to display in the accordion.
  final List<BsAccordionItem> items;

  /// If true, multiple items can be open at the same time.
  /// If false (Bootstrap default), one item closes when another opens.
  final bool alwaysOpen;

  /// If true, outer borders and rounded corners are removed (good for edge-to-edge).
  final bool flush;

  /// The color of the header and icon when the item is open.
  /// Defaults to the primary token of the current theme.
  final Color? activeColor;

  /// The mouse cursor shown when hovering over the header.
  final MouseCursor? mouseCursor;

  @override
  State<BsAccordion> createState() => _BsAccordionState();
}

class _BsAccordionState extends State<BsAccordion> {
  // Stores the indexes of the currently open items.
  late Set<int> _openIndexes;

  @override
  void initState() {
    super.initState();
    _openIndexes = {};
    for (int i = 0; i < widget.items.length; i++) {
      if (widget.items[i].initiallyExpanded) {
        _openIndexes.add(i);
      }
    }
  }

  void _handleToggle(int index) {
    setState(() {
      final bool isCurrentlyOpen = _openIndexes.contains(index);

      if (widget.alwaysOpen) {
        if (isCurrentlyOpen) {
          _openIndexes.remove(index);
        } else {
          _openIndexes.add(index);
        }
      } else {
        if (isCurrentlyOpen) {
          _openIndexes.remove(index);
        } else {
          _openIndexes.clear();
          _openIndexes.add(index);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 1. Get theme
    final bsTheme = context.bs;

    final borderRadius = widget.flush
        ? BorderRadius.zero
        : BorderRadius.circular(8.0);

    // 2. Dynamic border color
    final borderSide = BorderSide(color: bsTheme.border, width: 1.0);

    // 3. Dynamic fallback color (bsTheme.primary instead of BsColors.primary)
    final resolvedActiveColor = widget.activeColor ?? bsTheme.primary;

    return Container(
      decoration: BoxDecoration(
        color: bsTheme.bodyBg, // 4. Dynamic background
        borderRadius: borderRadius,
        border: widget.flush
            ? null
            : Border.all(color: bsTheme.border, width: 1.0), // Dynamic border
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(widget.items.length, (index) {
            final isLast = index == widget.items.length - 1;

            return _BsAccordionItemWidget(
              item: widget.items[index],
              isOpen: _openIndexes.contains(index),
              onToggle: () => _handleToggle(index),
              showBottomBorder: !isLast,
              borderSide: borderSide,
              activeColor: resolvedActiveColor,
              mouseCursor: widget.mouseCursor,
            );
          }),
        ),
      ),
    );
  }
}

// ─── Internal Item Widget ─────────────────────────────────────────────────────

class _BsAccordionItemWidget extends StatefulWidget {
  const _BsAccordionItemWidget({
    required this.item,
    required this.isOpen,
    required this.onToggle,
    required this.showBottomBorder,
    required this.borderSide,
    required this.activeColor,
    required this.mouseCursor,
  });

  final BsAccordionItem item;
  final bool isOpen;
  final VoidCallback onToggle;
  final bool showBottomBorder;
  final BorderSide borderSide;
  final Color activeColor;
  final MouseCursor? mouseCursor;

  @override
  State<_BsAccordionItemWidget> createState() => _BsAccordionItemWidgetState();
}

class _BsAccordionItemWidgetState extends State<_BsAccordionItemWidget> {
  bool _isFocused = false;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bsTheme = context.bs;

    final headerBgColor = widget.isOpen
        ? widget.activeColor.withValues(alpha: 0.1)
        : (_isHovered || _isFocused ? bsTheme.bodyBgSecondary : Colors.transparent);

    final headerTextColor = widget.isOpen ? widget.activeColor : bsTheme.bodyText;

    return Container(
      decoration: BoxDecoration(
        border: widget.showBottomBorder ? Border(bottom: widget.borderSide) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ─── Header ─────────────────────────────────────────────────────────
          Semantics(
            button: true,
            expanded: widget.isOpen,
            child: FocusableActionDetector(
              mouseCursor: widget.mouseCursor ?? SystemMouseCursors.click,
              onShowHoverHighlight: (v) => setState(() => _isHovered = v),
              onShowFocusHighlight: (v) => setState(() => _isFocused = v),
              actions: {
                ActivateIntent: CallbackAction<Intent>(
                  onInvoke: (_) {
                    widget.onToggle();
                    return null;
                  },
                ),
              },
              child: GestureDetector(
                onTap: widget.onToggle,
                behavior: HitTestBehavior.opaque,
                child: AnimatedContainer(
                  duration: BsTransitions.baseDuration,
                  decoration: BoxDecoration(
                    color: headerBgColor,
                    boxShadow: _isFocused ? BsShadows.focusRing(widget.activeColor) : null,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.item.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: headerTextColor,
                        ),
                      ).expanded(),
                      AnimatedRotation(
                        turns: widget.isOpen ? -0.5 : 0.0,
                        duration: BsTransitions.baseDuration,
                        curve: Curves.easeInOut,
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: headerTextColor,
                        ),
                      ),
                    ],
                  ).px(20).py(16),
                ),
              ),
            ),
          ),

          // ─── Body (Animated) ────────────────────────────────────────────────
          AnimatedSize(
            duration: BsTransitions.baseDuration,
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: (widget.isOpen ? widget.item.body.p(20) : const SizedBox.shrink()).w100(),
          ),
        ],
      ),
    );
  }
}

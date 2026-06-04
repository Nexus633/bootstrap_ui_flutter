import 'package:flutter/material.dart';
import '../../tokens/bootstrap_theme.dart';

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

class _BsAccordionItemWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final bsTheme = context.bs;

    // Bootstrap styling for active header
    final headerBgColor = isOpen
        ? activeColor.withValues(alpha: 0.1)
        : Colors.transparent;

    // IMPORTANT: When closed, we use bodyText (for contrast)
    final headerTextColor = isOpen ? activeColor : bsTheme.bodyText;

    return Container(
      decoration: BoxDecoration(
        border: showBottomBorder ? Border(bottom: borderSide) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ─── Header ─────────────────────────────────────────────────────────
          Material(
            color: headerBgColor,
            child: InkWell(
              mouseCursor: mouseCursor,
              onTap: onToggle,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 16.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: headerTextColor,
                        ),
                      ),
                    ),
                    AnimatedRotation(
                      turns: isOpen ? -0.5 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: headerTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ─── Body (Animated) ────────────────────────────────────────────────
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: double.infinity,
              child: isOpen
                  ? Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: item
                          .body, // Text styling is usually done when passing the widget
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}

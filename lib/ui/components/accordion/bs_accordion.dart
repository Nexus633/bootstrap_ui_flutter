import 'package:flutter/material.dart';
import '../../tokens/bs_theme.dart'; // WICHTIG: Dein Theme-Import

// ─── Datenmodell ──────────────────────────────────────────────────────────────

/// Repräsentiert ein einzelnes Element im Accordion.
class BsAccordionItem {
  const BsAccordionItem({
    required this.title,
    required this.body,
    this.initiallyExpanded = false,
  });

  /// Der Text im Header
  final String title;

  /// Der Inhalt, der beim Aufklappen sichtbar wird
  final Widget body;

  /// Ob das Item von Anfang an geöffnet sein soll
  final bool initiallyExpanded;
}

// ─── Haupt-Widget ─────────────────────────────────────────────────────────────

/// Bootstrap-kompatibles Accordion.
class BsAccordion extends StatefulWidget {
  const BsAccordion({
    super.key,
    required this.items,
    this.alwaysOpen = false,
    this.flush = false, // Bootstrap's .accordion-flush Variante
    this.activeColor,
    this.mouseCursor,
  });

  final List<BsAccordionItem> items;

  /// Wenn true, können mehrere Items gleichzeitig offen sein.
  /// Wenn false (Bootstrap Default), schließt sich ein Item, wenn ein anderes öffnet.
  final bool alwaysOpen;

  /// Wenn true, werden die äußeren Rahmen und runden Ecken entfernt (gut für Edge-to-Edge).
  final bool flush;

  /// Die Farbe des Headers und Icons, wenn das Item geöffnet ist.
  /// Standardmäßig das Primary-Token des aktuellen Themes.
  final Color? activeColor;

  /// Der Mauszeiger, der angezeigt wird, wenn man über den Header fährt.
  final MouseCursor? mouseCursor;

  @override
  State<BsAccordion> createState() => _BsAccordionState();
}

class _BsAccordionState extends State<BsAccordion> {
  // Speichert die Indizes der aktuell geöffneten Items
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
    // 1. Theme abgreifen
    final bsTheme = context.bs;

    final borderRadius = widget.flush
        ? BorderRadius.zero
        : BorderRadius.circular(8.0);

    // 2. Rahmenfarbe dynamisch
    final borderSide = BorderSide(color: bsTheme.border, width: 1.0);

    // 3. Fallback-Farbe dynamisch (bsTheme.primary statt BsColors.primary)
    final resolvedActiveColor = widget.activeColor ?? bsTheme.primary;

    return Container(
      decoration: BoxDecoration(
        color: bsTheme.bodyBg, // 4. Hintergrund dynamisch
        borderRadius: borderRadius,
        border: widget.flush
            ? null
            : Border.all(color: bsTheme.border, width: 1.0), // Rahmen dynamisch
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

// ─── Internes Item-Widget ─────────────────────────────────────────────────────

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

    // Bootstrap Styling für aktiven Header
    final headerBgColor = isOpen
        ? activeColor.withValues(alpha: 0.1)
        : Colors.transparent;

    // WICHTIG: Wenn geschlossen, nutzen wir bodyText (für den Kontrast)
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

          // ─── Body (Animiert) ────────────────────────────────────────────────
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
                          .body, // Text-Styling machen wir meist beim Übergeben des Widgets (wie im Showcase gezeigt)
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}

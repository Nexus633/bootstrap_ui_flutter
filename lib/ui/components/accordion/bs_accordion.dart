import 'package:flutter/material.dart';
import '../../tokens/colors.dart';

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
  /// Standardmäßig [BsColors.primary].
  final Color? activeColor; // <--- NEU

  /// Der Mauszeiger, der angezeigt wird, wenn man über den Header fährt.
  /// Standardmäßig der normale Zeiger, da BS-Accordion-Header nicht unbedingt wie Buttons aussehen.
  final MouseCursor? mouseCursor; // <--- NEU

  @override
  State<BsAccordion> createState() => _BsAccordionState();
}

class _BsAccordionState extends State<BsAccordion> {
  // Speichert die Indizes der aktuell geöffneten Items
  late Set<int> _openIndexes;

  @override
  void initState() {
    super.initState();
    // Initialisieren basierend auf initiallyExpanded
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
        // Unabhängiges Öffnen/Schließen
        if (isCurrentlyOpen) {
          _openIndexes.remove(index);
        } else {
          _openIndexes.add(index);
        }
      } else {
        // Mutually exclusive (nur eins darf offen sein)
        if (isCurrentlyOpen) {
          _openIndexes.remove(index); // Klick auf offenes Item schließt es
        } else {
          _openIndexes.clear(); // Alle anderen schließen
          _openIndexes.add(index); // Neues öffnen
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Wenn flush true ist, gibt es keinen äußeren Border und Radius
    final borderRadius = widget.flush
        ? BorderRadius.zero
        : BorderRadius.circular(8.0); // Passe dies an deine Tokens an
    final borderSide = BorderSide(color: BsColors.border, width: 1.0);

    final resolvedActiveColor = widget.activeColor ?? BsColors.primary;

    return Container(
      decoration: BoxDecoration(
        color: BsColors.bodyBg,
        borderRadius: borderRadius,
        border: widget.flush
            ? null
            : Border.all(color: BsColors.border, width: 1.0),
      ),
      // ClipRRect sorgt dafür, dass die Kinder (Header-Hintergründe) nicht über die runden Ecken malen
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
              showBottomBorder:
                  !isLast, // Jedes Item außer dem letzten bekommt einen Rahmen unten
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

/// Kümmert sich um die Animationen (Aufklappen, Pfeil-Rotation, Farben) eines einzelnen Items.
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
    // Bootstrap Styling für aktiven Header
    final headerBgColor = isOpen
        ? activeColor.withValues(alpha: 0.1)
        : Colors.transparent;
    final headerTextColor = isOpen
        ? activeColor
        : BsColors.body; // Passe dark an dein Token an

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
                        // Nutze dein eigenes Typografie-Token, z.B. BsTypography.body
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: headerTextColor,
                        ),
                      ),
                    ),
                    // Der Pfeil, der sich dreht
                    AnimatedRotation(
                      turns: isOpen
                          ? -0.5
                          : 0.0, // Dreht sich um 180° (-0.5 bedeutet gegen den Uhrzeigersinn wie in BS)
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
            alignment: Alignment
                .topCenter, // Wichtig: Animation klappt von oben nach unten auf
            child: SizedBox(
              width: double.infinity,
              // Wenn nicht offen, ist die Höhe 0 (durch leeren SizedBox)
              child: isOpen
                  ? Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: item.body,
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}

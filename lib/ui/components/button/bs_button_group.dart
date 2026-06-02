import 'package:flutter/material.dart';

import '../../tokens/spacing.dart';
import 'bs_button.dart';
// Deine Imports für AppButton und BsRadius hier einfügen...

class BsButtonGroup extends StatelessWidget {
  const BsButtonGroup({
    super.key,
    required this.children,
    this.vertical = false,
    this.groupSize,
  });

  /// WICHTIG: Wir verlangen explizit 'AppButton', damit wir die
  /// Properties auslesen und die Buttons neu bauen können.
  final List<AppButton> children;

  /// Bootstrap's .btn-group-vertical
  final bool vertical;

  /// Alle Buttons in der Gruppe haben die gleiche Größe (sm/md/lg).
  final BsButtonSize? groupSize;

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) return const SizedBox.shrink();
    if (children.length == 1) return children.first;

    final List<Widget> groupedButtons = [];

    for (int i = 0; i < children.length; i++) {
      final button = children[i];
      final bool isFirst = i == 0;
      final bool isLast = i == children.length - 1;

      final BsButtonSize finalSize = groupSize ?? button.size;
      // 1. Spezifischen Radius für die Position in der Gruppe berechnen
      final BorderRadius groupRadius = _calculateRadius(
        finalSize,
        isFirst,
        isLast,
      );

      // 2. Wir "klonen" den Button und injizieren den neuen Radius
      Widget modifiedButton = AppButton(
        key: button.key,
        label: button.label,
        onPressed: button.onPressed,
        variant: button.variant,
        size: finalSize,
        isLoading: button.isLoading,
        icon: button.icon,
        fullWidth: button.fullWidth,
        badge: button.badge,
        badgePosition: button.badgePosition,
        customBorderRadius: groupRadius, // Hier überschreiben wir die Ecken!
      );

      // 3. CSS "margin-left: -1px" simulieren
      // Wenn wir Outline-Buttons nebeneinander legen, entstehen sonst doppelte 2px Ränder.
      // Wir schieben jeden Button (außer den ersten) optisch um 1px nach links (oder oben).
      if (i > 0) {
        modifiedButton = Transform.translate(
          offset: vertical ? const Offset(0, -1) : const Offset(-1, 0),
          child: modifiedButton,
        );
      }

      groupedButtons.add(modifiedButton);
    }

    // 4. In Row oder Column rendern
    return vertical
        ? Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: groupedButtons,
          )
        : Row(mainAxisSize: MainAxisSize.min, children: groupedButtons);
  }

  /// Berechnet, welche Ecken abgerundet bleiben dürfen
  BorderRadius _calculateRadius(BsButtonSize size, bool isFirst, bool isLast) {
    // Basis-Radius aus deinen Tokens holen
    final BorderRadius baseRadius = switch (size) {
      BsButtonSize.sm => BsRadius.sm,
      BsButtonSize.md => BsRadius.md,
      BsButtonSize.lg => BsRadius.lg,
    };

    // Wir extrahieren den reinen Radius-Wert (z.B. Radius.circular(6)) von oben links,
    // da wir ihn gleich für spezifische Seiten (links/rechts/oben/unten) neu zusammensetzen.
    final Radius r = baseRadius.topLeft;

    if (vertical) {
      if (isFirst) return BorderRadius.vertical(top: r);
      if (isLast) return BorderRadius.vertical(bottom: r);
    } else {
      if (isFirst) return BorderRadius.horizontal(left: r);
      if (isLast) return BorderRadius.horizontal(right: r);
    }

    // Mittlere Buttons (weder first noch last) sind komplett eckig
    return BorderRadius.zero;
  }
}

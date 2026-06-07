# Schließen-Schaltfläche (Close Button)

Eine universelle Schließen-Schaltfläche (`BsCloseButton`) zum Ausblenden oder Schließen von Inhalten wie Modals, Alerts, Cards und Dropdowns. Sie implementiert Bootstraps `.btn-close`-Verhalten: automatische Helligkeitsanpassung an das Theme, Opazitätsübergänge beim Hover und deaktivierte Zustände.

## Verwendung

```dart
BsCloseButton(
  onPressed: () {
    print('Schließen geklickt');
  },
)

// Deaktivierter Zustand
BsCloseButton(
  disabled: true,
)

// Invertiertes Weiß für dunkle Hintergründe
BsCloseButton(
  white: true,
)
```

## Eigenschaften

| Eigenschaft | Typ | Standard | Beschreibung |
| :--- | :--- | :--- | :--- |
| `onPressed` | `VoidCallback?` | `null` | Callback, das beim Tippen auf die Schaltfläche ausgelöst wird. Ignoriert, wenn `disabled` auf `true` steht. |
| `disabled` | `bool` | `false` | Bestimmt, ob die Schaltfläche deaktiviert ist. Wenn `true`, werden Klicks ignoriert und die Deckkraft sinkt auf `25%`. |
| `white` | `bool` | `false` | Erzwingt ein weißes Icon. Ideal für die Verwendung auf dunklen Hintergründen. |
| `color` | `Color?` | `null` | Eine benutzerdefinierte Farb-Überschreibung für das Schließen-Icon. Überschreibt Standard- und White-Farbzuordnungen. |
| `size` | `double` | `16.0` | Die Größe des Schließen-Icons. |
| `padding` | `EdgeInsetsGeometry` | `EdgeInsets.all(4.0)` | Innenabstand (Padding) um das Icon zur Vergrößerung des Klickbereichs. |

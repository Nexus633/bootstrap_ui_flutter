# Icon

Icon-Komponente zur Nachbildung und Anzeige der Bootstrap 5 Icons.

## Zweck
`BsIcon` stellt eine einfache Möglichkeit dar, Bootstrap Icons in Flutter anzuzeigen. Es unterstützt native Bootstrap-Farbvarianten, Größenanpassung und barrierefreie Beschreibungen.

## Eigenschaften

| Eigenschaft | Typ | Standard | Beschreibung |
| :--- | :--- | :--- | :--- |
| `icon` | `IconData` | *Pflicht* | Das anzuzeigende Bootstrap-Icon (z.B. aus `BsIcons`). |
| `size` | `double?` | `null` | Die Größe des Icons (falls `null`, wird die Standardgröße des übergeordneten Elements verwendet). |
| `color` | `Color?` | `null` | Eine spezifische Farbe für das Icon. Überschreibt `variant`, falls beide angegeben sind. |
| `variant` | `BsIconVariant?` | `null` | Die Bootstrap-Farbvariante für das Icon (z.B. `primary`, `danger`, `success` etc.). |
| `semanticLabel` | `String?` | `null` | Eine Barrierefreiheitsbeschreibung für Screenreader. |
| `textDirection` | `TextDirection?` | `null` | Die Textrichtung, die für das Rendering des Icons verwendet werden soll. |

## Verwendung

### Einfaches Icon
Ein einfaches Icon wird durch Übergabe einer der Konstanten aus `BsIcons` angezeigt.

```dart
BsIcon(BsIcons.alarm)
```

### Farbvarianten
Du kannst das Icon mit den typischen Bootstrap-Farbvarianten einfärben.

```dart
BsIcon(
  BsIcons.checkCircleFill,
  variant: BsIconVariant.success,
)
```

### Eigene Größe und Farbe
Größe und Farbe können frei angepasst werden. Eigene Farben überschreiben die `variant`.

```dart
BsIcon(
  BsIcons.heartFill,
  size: 32.0,
  color: Colors.pink,
)
```

## Besonderheiten
- `color` hat immer Vorrang vor `variant`.
- Die Farbvarianten werden mithilfe von `BsThemeData` aus dem Kontext aufgelöst, was bedeutet, dass sich die Farben automatisch anpassen, wenn das Theme (z.B. Dark Mode) wechselt.

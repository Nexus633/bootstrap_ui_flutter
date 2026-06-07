# Überschrift (Heading)

## Vorschau

![Vorschau](../../assets/Headings.png)


Das `BsHeading`-Widget wird verwendet, um Standard-Überschriften von `<h1>` bis `<h6>` mit Bootstrap-kompatiblen Stilen zu rendern, einschließlich des standardmäßigen unteren Abstands (Margin) und der korrekten Zeilenhöhe (Line-Height).

## Verwendung

```dart
BsHeading(
  'Beispiel Überschrift 1',
  level: BsHeadingLevel.h1,
)

BsHeading(
  'Beispiel Überschrift 6 ohne Abstand',
  level: BsHeadingLevel.h6,
  removeMargin: true,
  color: BsColors.secondary,
)
```

## Eigenschaften

| Eigenschaft | Typ | Standard | Beschreibung |
| :--- | :--- | :--- | :--- |
| `text` | `String` | **Erforderlich** | Der anzuzeigende Text der Überschrift. |
| `level` | `BsHeadingLevel` | `BsHeadingLevel.h1` | Die Überschriften-Ebene von `h1` (am größten) bis `h6` (am kleinsten). |
| `color` | `Color?` | `null` | Eigene Textfarbe. Standardmäßig die Textfarbe des Themes (`bodyText`). |
| `textAlign` | `TextAlign?` | `null` | Optionale horizontale Ausrichtung des Textes. |
| `removeMargin` | `bool` | `false` | Wenn `true`, wird der standardmäßige untere Abstand von `0.5rem` (8px) entfernt (mittels Padding-Bottom umgesetzt). |
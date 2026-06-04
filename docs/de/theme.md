# Theme & Tokens

Das Framework nutzt ein tokenbasiertes System, das eng an Bootstrap 5.3 angelehnt ist.

## Bootstrap Theme

Die `BsThemeData` Extension ermöglicht den Zugriff auf alle Bootstrap-spezifischen Farben und Styles über den BuildContext.

```dart
final bs = context.bs;
final primaryColor = bs.primary;
final bodyBg = bs.bodyBg;
```

### Light & Dark Mode

Das Framework unterstützt nativ den Light und Dark Mode. Die entsprechenden Themes sind über `BsThemeData.lightTheme` und `BsThemeData.darkTheme` verfügbar.

## Farben (BsColors)

Alle Bootstrap-Basis-Farben und Paletten (100-900) sind in `BsColors` verfügbar.

```dart
Color myColor = BsColors.blue[500]!;

// Flutter-Standard (MaterialColor)
Color myColor = BsColors.blue.shade500
```

## Spacing & Radius (BsSpacing, BsRadius)

Das Spacing-System nutzt die Standard-Bootstrap-Schritte ($spacer = 16px).

| Token | Wert | Beschreibung |
| :--- | :--- | :--- |
| `s1` | 4px | $spacer * 0.25 |
| `s2` | 8px | $spacer * 0.5 |
| `s3` | 16px | $spacer * 1 |
| `s4` | 24px | $spacer * 1.5 |
| `s5` | 48px | $spacer * 3 |

Der Border-Radius ist ebenfalls konform zu Bootstrap (`sm`, `md`, `lg`, `pill`).

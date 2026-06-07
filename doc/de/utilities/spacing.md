# Abstands-Utilities (Spacing)

## Vorschau

![Vorschau](../../assets/Utilities-1.png)


Die `BsSpacingExtension` bietet eine Reihe von prägnanten Methoden, um Padding (Innenabstand) und Margin (Außenabstand) auf jedes Flutter-Widget anzuwenden. Dabei wird die Namenskonvention der Bootstrap-Utility-Klassen übernommen.

## Features

- **Prägnante Syntax**: Verkettbare Methoden wie `.p3()`, `.mb2()`, etc.
- **Bootstrap-Konformität**: Nutzt die standardmäßigen Bootstrap-Abstandsstufen (1-5).
- **Flexibel**: Erlaubt benutzerdefinierte Werte über `.p(double)`, `.m(double)`, etc.
- **Kontextbewusst**: Berücksichtigt die Konzepte von Padding (innerhalb eines Rahmens) und Margin (außerhalb eines Rahmens) im Flutter-Widget-Baum.

## Verwendung

Anstatt ein Widget manuell in ein `Padding`-Widget zu verschachteln:

```dart
// Standard Flutter (Padding)
Padding(
  padding: EdgeInsets.all(16.0),
  child: Text('Hallo'),
)

// Mit BsSpacingExtension
Text('Hallo').p3()

// Margin (Abstand außerhalb einer Dekoration/Box)
Container(color: Colors.red, child: Text('Alarm'))
  .mb3() // Fügt Außenabstand unten außerhalb der roten Box hinzu
```

## Verfügbare Methoden

### Standard-Stufen (1-5)

Diese Methoden verwenden die vordefinierten `BsSpacing`-Tokens:

| Typ | Padding-Methoden | Margin-Methoden | Bootstrap-Äquivalent |
| :--- | :--- | :--- | :--- |
| **Gleichmäßig** | `.p1()` bis `.p5()` | `.m1()` bis `.m5()` | `p-*` / `m-*` |
| **Horizontal** | `.px1()` bis `.px5()` | `.mx1()` bis `.mx5()` | `px-*` / `mx-*` |
| **Vertikal** | `.py1()` bis `.py5()` | `.my1()` bis `.my5()` | `py-*` / `my-*` |
| **Oben (Top)** | `.pt1()` bis `.pt5()` | `.mt1()` bis `.mt5()` | `pt-*` / `mt-*` |
| **Unten (Bottom)** | `.pb1()` bis `.pb5()` | `.mb1()` bis `.mb5()` | `pb-*` / `mb-*` |
| **Anfang (Start)** | `.ps1()` bis `.ps5()` | `.ms1()` bis `.ms5()` | `ps-*` / `ms-*` |
| **Ende (End)** | `.pe1()` bis `.pe5()` | `.me1()` bis `.me5()` | `pe-*` / `me-*` |

### Benutzerdefinierte Werte

Falls ein spezifischer Pixelwert benötigt wird, der nicht durch die Standardstufen abgedeckt ist:

- Padding: `.p(val)`, `.px(val)`, `.py(val)`, `.pt(val)`, `.pb(val)`, `.ps(val)`, `.pe(val)`
- Margin: `.m(val)`, `.mx(val)`, `.my(val)`, `.mt(val)`, `.mb(val)`, `.ms(val)`, `.me(val)`

## Beispiel

```dart
Column(
  children: [
    Text('Titel').mb3(), // Außenabstand unten (Abstand zwischen Elementen)
    Row(
      children: [
        Icon(Icons.star).pe2(), // Innenabstand Ende Stufe 2
        Text('Bewertung'),
      ],
    ).px4(), // Horizontales Padding Stufe 4
  ],
).p5() // Gleichmäßiges Padding Stufe 5 für den gesamten Container
```
# Spinners

## Vorschau

![Vorschau](../../assets/Spinners.gif)

Zeigt den Ladezustand einer Komponente oder Seite mit Bootstrap-Spinnern an.

## Zweck und Einsatzgebiet

Spinner sind leichtgewichtige Ladeindikatoren. Sie können einzeln verwendet werden, um anzuzeigen, dass eine Seite oder ein Bereich geladen wird, oder innerhalb von Buttons platziert werden, um zu signalisieren, dass eine Aktion gerade verarbeitet wird.

Bootstrap bietet zwei Arten von Spinnern:
* **Border Spinner** (`BsSpinner.border()`): Ein rotierender Kreis mit einer transparenten Lücke.
* **Grow Spinner** (`BsSpinner.grow()`): Ein pulsierender Punkt, der wächst und dabei ausblendet.

## Verfügbare Eigenschaften

| Eigenschaft | Typ | Beschreibung |
| :--- | :--- | :--- |
| `type` | `BsSpinnerType` | Der visuelle Stil des Spinners (`border` oder `grow`). |
| `variant` | `BsVariant?` | Semantische Farbvariante aus dem Bootstrap-Theme (z.B. `primary`, `danger`). |
| `color` | `Color?` | Benutzerdefinierte Farbe. Überschreibt `variant`. Standardmäßig wird die aktuelle Textfarbe verwendet. |
| `size` | `BsSpinnerSize` | Die Größe des Spinners (`md` für 32x32px, `sm` für 16x16px). |
| `animationDuration` | `Duration` | Geschwindigkeit der Animation. Standard: `Duration(milliseconds: 750)`. |

## Beispiele

### Border Spinner

Verwende den Border Spinner für einen klassischen, leichten Ladeindikator.

```dart
BsSpinner.border()
```

### Grow Spinner

Wenn dir ein klassischer Spinner nicht gefällt, wechsle zum Grow Spinner. Dieser "dreht" sich technisch gesehen nicht, sondern wächst wiederholt heran.

```dart
BsSpinner.grow()
```

### Farben

Spinner nutzen standardmäßig die aktuelle Textfarbe (`currentColor`). Du kannst das Aussehen über die Farbvarianten ganz einfach ändern.

```dart
BsSpinner.border(variant: .primary)
BsSpinner.border(variant: .success)

BsSpinner.grow(variant: .danger)
BsSpinner.grow(variant: .warning)
```

### Größe

Verwende `.sm`, um einen kleineren Spinner zu erzeugen. Dies ist besonders nützlich, wenn er innerhalb einer anderen Komponente, wie z.B. einem Button, angezeigt werden soll.

```dart
BsSpinner.border(size: .sm)
BsSpinner.grow(size: .sm)
```

### Geschwindigkeit anpassen

Falls dir der Standard-Spinner zu "krass" oder schnell rotiert, kannst du die Dauer eines Animations-Zyklus über die Eigenschaft `animationDuration` bequem selbst einstellen:

```dart
// Deutlich langsamerer Spinner (1.5 Sekunden pro Umdrehung)
BsSpinner.border(
  animationDuration: Duration(milliseconds: 1500),
)
```

### Ausrichtung (Alignment)

Wie bei Bootstrap üblich, verwendet man Flexbox- oder Margin-Utilities für das Alignment. In Flutter platzierst du den Spinner einfach in Standard-Layout-Widgets wie `Center()`, `Align()` oder nutzt `Row`/`Column` (z.B. mit `mainAxisAlignment`):

```dart
// Spinner zentrieren
Align(
  alignment: Alignment.center,
  child: BsSpinner.border(),
)

// In einer Reihe rechts ausrichten
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text('Lade Daten...'),
    BsSpinner.border(),
  ],
)
```

### Buttons

Nutze Spinner innerhalb von Buttons, um zu verdeutlichen, dass eine Aktion gerade verarbeitet wird. Du kannst dafür bei `BsButton` einfach `isLoading: true` setzen!

```dart
BsButton(
  onPressed: () {},
  label: 'Wird geladen...',
  isLoading: true,
)
```

## Hinweise zur Verwendung
* Wenn weder `variant` noch `color` angegeben sind, übernimmt das `BsSpinner`-Widget automatisch die aktuelle Textfarbe (`DefaultTextStyle.of(context).style.color`). Dies verhält sich genau wie das `currentColor` in CSS.
* Beide Spinner besitzen eine Standard-Animationsdauer von 0,75 Sekunden, um exakt den HTML/CSS-Vorgaben von Bootstrap zu entsprechen.

## Besonderheiten und Einschränkungen
* Spinner in Flutter werden mittels eines expliziten `AnimationController` animiert. Das stellt sicher, dass die Animation flüssig und geräteunabhängig läuft.

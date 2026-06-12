# Placeholders (Platzhalter / Lade-Skelette)

## Vorschau

![Vorschau](../../assets/Placeholders.gif)

Placeholders (oder Skeleton Loaders) dienen dazu, temporäre Platzhalter-Strukturen für Inhalte anzuzeigen, die noch geladen werden. Sie verbessern die wahrgenommene Ladezeit und sorgen für eine ruhigere Benutzererfahrung, da Layoutverschiebungen (Layout Shifts) vermieden werden.

Sie basieren auf den CSS-Klassen und dem Design von Bootstrap 5.3.

## Verwendung

Die Platzhalter können entweder einzeln platziert werden oder in einem `BsPlaceholderContainer` gruppiert werden, um Animationen (wie ein Pulsieren oder Shimmer-Effekt) auf alle enthaltenen Elemente anzuwenden.

### 1. Einzelner statischer Platzhalter
Ein einfacher Platzhalter mit einer Breite von 75% der verfügbaren Breite:

```dart
BsPlaceholder(
  widthFactor: 0.75,
)
```

### 2. Animierte Platzhalter (Glow und Wave)
Um Platzhalter zu animieren, umschließe sie mit einem `BsPlaceholderContainer`.

**Wave (Shimmer-Effekt - Empfohlen):**
```dart
BsPlaceholderContainer(
  animation: BsPlaceholderAnimation.wave,
  child: Column(
    children: [
      BsPlaceholder(widthFactor: 0.5),
      SizedBox(height: 8),
      BsPlaceholder(widthFactor: 0.8),
    ],
  ),
)
```

**Glow (Pulsierender Opazitäts-Effekt):**
```dart
BsPlaceholderContainer(
  animation: BsPlaceholderAnimation.glow,
  child: Column(
    children: [
      BsPlaceholder(widthFactor: 0.6),
      SizedBox(height: 8),
      BsPlaceholder(widthFactor: 0.9),
    ],
  ),
)
```

## Größen (Sizing)

Die Höhe der Platzhalter-Zeilen kann über das `size` Attribut gesteuert werden:
- `BsSize.sm` (klein, ca. 11px hoch)
- `BsSize.md` (Standard, ca. 14px hoch)
- `BsSize.lg` (groß, ca. 18px hoch)

```dart
BsPlaceholder(
  size: BsSize.lg,
  widthFactor: 0.5,
)
```

Für ganz eigene Höhen kann auch der Parameter `height` direkt in Pixeln gesetzt werden.

## Breiten (Width Sizing)

Es gibt drei Möglichkeiten, die Breite eines Platzhalters zu definieren (wobei immer nur eine gleichzeitig verwendet werden darf):

1. **`width`**: Feste Breite in logischen Pixeln (z. B. `width: 150.0`).
2. **`widthFactor`**: Relative Breite zum Eltern-Widget als Prozentwert zwischen `0.0` und `1.0` (z. B. `widthFactor: 0.75` für 75% Breite). Entspricht Bootstraps `.w-75`.
3. **`colSpan`**: Breite basierend auf Bootstraps 12-Spalten-Raster. Werte von `1` bis `12` (z. B. `colSpan: 6` für 50% Breite). Entspricht Bootstraps `.col-6`.

## Farben und Varianten

Standardmäßig verwenden die Platzhalter eine leicht transparente Version der Textfarbe (`theme.bodyText.withValues(alpha: 0.175)`), was dem Bootstrap-Standard (`currentColor` mit Opazität) entspricht.

Du kannst jedoch vordefinierte Bootstrap-Farbvarianten (`BsVariant`) oder ganz eigene Farben vergeben:

```dart
// Verwendung einer Bootstrap-Farbvariante
BsPlaceholder(
  variant: BsVariant.primary,
  widthFactor: 0.5,
)

// Verwendung einer komplett eigenen Farbe
BsPlaceholder(
  color: Colors.teal[300],
  widthFactor: 0.5,
)
```

## Eigenschaften

### BsPlaceholderContainer

| Eigenschaft | Typ | Standardwert | Beschreibung |
| --- | --- | --- | --- |
| `child` | `Widget` | - | Die Kind-Elemente, auf die die Animation angewendet werden soll. |
| `animation` | `BsPlaceholderAnimation` | `BsPlaceholderAnimation.glow` | Der Animationstyp (`none`, `glow`, `wave`). |
| `duration` | `Duration` | `Duration(milliseconds: 2000)` | Die Dauer eines vollen Animationszyklus. |

### BsPlaceholder

| Eigenschaft | Typ | Standardwert | Beschreibung |
| --- | --- | --- | --- |
| `width` | `double?` | `null` | Feste Breite des Platzhalters in logischen Pixeln. |
| `widthFactor` | `double?` | `null` | Relative Breite relativ zum Elternwidget (`0.0` bis `1.0`). |
| `colSpan` | `int?` | `null` | Breite ausgedrückt in Rasterspalten (`1` bis `12`). |
| `height` | `double?` | `null` | Custom-Höhe in logischen Pixeln. Überschreibt `size`. |
| `size` | `BsSize` | `BsSize.md` | Die Größenvariante des Platzhalters (`sm`, `md`, `lg`). |
| `variant` | `BsVariant?` | `null` | Bootstrap-Farbvariante für den Platzhalter. |
| `color` | `Color?` | `null` | Custom Hintergrundfarbe. Überschreibt `variant`. |
| `borderRadius` | `BorderRadius?` | `BorderRadius.circular(4.0)` | Rahmenabrundung des Platzhalters. |

## Besonderheiten und Einschränkungen

* **Animations-Performance**: Durch die Nutzung von `AnimatedBuilder` und effizienten CustomPaintern (`_WavePainter`) werden Layout-Neuberechnungen minimiert und hervorragende Performance erzielt.
* **Exklusivität der Breiten**: Es darf maximal eine Breitenoption (`width`, `widthFactor` oder `colSpan`) übergeben werden. Andernfalls wird ein Assertion-Fehler ausgelöst.

# Progress (Fortschrittsbalken)

Progress-Komponenten (Fortschrittsbalken) zeigen dem Benutzer den Status eines laufenden Prozesses (z. B. Downloads, Uploads oder Berechnungen) an. Sie basieren auf dem Design und Verhalten von Bootstrap 5.3 und unterstützen Beschriftungen, Farbvarianten, gestreifte Muster, Animationen sowie das Stapeln (Stacking) mehrerer Segmente.

## Verwendung

Die Bibliothek stellt zwei Widgets bereit:
- `BsProgress`: Der äußere Container (die Spur), der die Höhe, Hintergrundfarbe und den Radius bestimmt.
- `BsProgressBar`: Der innere Balken, der den eigentlichen Fortschritt darstellt.

Für den Standardfall (einzelner Balken) gibt es die bequeme Factory-Methode `BsProgress.single()`.

### 1. Einfache Progressbar

```dart
BsProgress.single(
  value: 70.0, // Werte von 0.0 bis 100.0
)
```

### 2. Mit Label (Textbeschriftung)

Labels werden zentriert im Balken gerendert und bei Platzmangel automatisch abgeschnitten.

```dart
BsProgress.single(
  value: 25.0,
  label: '25% abgeschlossen',
)
```

### 3. Benutzerdefinierte Höhe

Die Standardhöhe beträgt `16.0` (entspricht `1rem` in Bootstrap). Sie kann frei angepasst werden:

```dart
BsProgress.single(
  value: 45.0,
  height: 8.0, // Sehr dünner Balken
)
```

### 4. Farbvarianten (Backgrounds)

Du kannst die Standard-Farbvarianten von Bootstrap verwenden oder eigene Farben übergeben:

```dart
// Bootstrap-Erfolgsfarbe (Grün)
BsProgress.single(
  value: 80.0,
  variant: BsVariant.success,
)

// Benutzerdefinierte Farbe
BsProgress.single(
  value: 60.0,
  barColor: Colors.deepPurple,
  textColor: Colors.white,
  label: 'Lila Fortschritt',
)
```

### 5. Gestreifte Progressbar (Striped)

Erzeugt diagonale Streifen über dem Fortschrittsbalken:

```dart
BsProgress.single(
  value: 50.0,
  striped: true,
)
```

### 6. Animierte Streifen (Animated stripes)

Die diagonalen Streifen werden fließend von links nach rechts animiert, um einen aktiven Prozess zu signalisieren. Dies läuft über eine optimierte Animationsschleife (Ticker) und wird nur bei Bedarf im Hintergrund ausgeführt:

```dart
BsProgress.single(
  value: 75.0,
  animated: true, // Schaltet automatisch auch striped ein
)
```

### 7. Gestapelte Segmente (Stacked Multiple Bars)

Du kannst mehrere `BsProgressBar`-Segmente in einen einzelnen `BsProgress`-Container packen. Der verbleibende Platz wird automatisch als leerer Hintergrund berechnet:

```dart
BsProgress(
  bars: [
    BsProgressBar(value: 15.0, variant: BsVariant.primary, label: '15%'),
    BsProgressBar(value: 30.0, variant: BsVariant.success, label: '30%'),
    BsProgressBar(value: 20.0, variant: BsVariant.info, label: '20%'),
  ],
)
```

## Eigenschaften

### BsProgress

| Eigenschaft | Typ | Standardwert | Beschreibung |
| --- | --- | --- | --- |
| `bars` | `List<BsProgressBar>` | - | Liste der Fortschritts-Segmente (für stacked Progress). |
| `height` | `double` | `16.0` | Die Höhe des Fortschrittsbalkens. |
| `backgroundColor` | `Color?` | `null` | Custom Hintergrundfarbe der Spur (Standard: hellgrau bzw. `#2b3035`). |
| `borderRadius` | `BorderRadius?` | `null` | Custom Eckenradius des Tracks (Standard: `6.0`). |

### BsProgressBar

| Eigenschaft | Typ | Standardwert | Beschreibung |
| --- | --- | --- | --- |
| `value` | `double` | - | Der Prozentwert von `0.0` bis `100.0`. |
| `label` | `String?` | `null` | Optionaler Text innerhalb des Segments. |
| `variant` | `BsVariant?` | `BsVariant.primary` | Die Bootstrap-Farbvariante. |
| `striped` | `bool` | `false` | Aktiviert die diagonalen Streifen. |
| `animated` | `bool` | `false` | Aktiviert die Bewegung der diagonalen Streifen. |
| `color` | `Color?` | `null` | Custom Hintergrundfarbe (überschreibt `variant`). |
| `textColor` | `Color?` | `null` | Custom Textfarbe des Labels (überschreibt `variant` standard). |

## Besonderheiten und Einschränkungen

* **ClipBehavior**: Der Container `BsProgress` verwendet `Clip.antiAlias`. Dadurch werden alle inneren `BsProgressBar`-Elemente an den Rändern automatisch beschnitten, sodass die Eckenabrundung des Tracks nahtlos beibehalten wird.
* **Proportionales Layout**: Die Segmente berechnen ihre Breitenanteile dynamisch über `Expanded` mit einem präzisen Flex-Faktor (`value * 1000`), sodass auch Nachkommastellen genau dargestellt werden und verbleibender Platz (Summe < 100 %) sauber freigelassen wird.
* **Barrierefreie Textfarben**: Bei hellen Farbvarianten (wie `BsVariant.light` und `BsVariant.warning`) wird automatisch dunkler Text verwendet, um die Lesbarkeit (Kontrast) sicherzustellen.

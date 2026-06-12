# Grid System

## Vorschau

![Vorschau](../../assets/Grid_System.gif)


Das Bootstrap-Grid-System basiert auf einem 12-Spalten-Layout und ist vollständig responsive.

## Container

`BsContainer` zentriert den Inhalt horizontal und bietet ein Standard-Padding.

```dart
BsContainer(
  type: BsContainerType.fixed, // oder .fluid, .sm, .md, etc.
  child: MyContent(),
)
```

## Row & Col

`BsRow` und `BsCol` bilden das eigentliche Grid.

```dart
BsRow(
  gutterX: BsSpacing.s3,
  gutterY: BsSpacing.s3,
  children: [
    BsCol(
      config: BsColConfig(xs: 12, md: 6, lg: 4),
      child: MyWidget(),
    ),
    BsCol(
      config: BsColConfig(xs: 12, md: 6, lg: 8),
      child: AnotherWidget(),
    ),
  ],
)
```

### BsColConfig

Definiert die Spaltenanzahl pro Breakpoint (Mobile-first).

| Breakpoint | Beschreibung |
| :--- | :--- |
| `xs` | < 576px (Standard) |
| `sm` | >= 576px |
| `md` | >= 768px |
| `lg` | >= 992px |
| `xl` | >= 1200px |
| `xxl` | >= 1400px |

## Offsets (Spalten verschieben)

Mit `BsOffsetConfig` können Spalten responsiv um eine bestimmte Anzahl von Rastern (1 bis 11) nach rechts verschoben werden (mobile-first):

```dart
BsCol(
  config: BsColConfig.all(4),
  offset: BsOffsetConfig(xs: 0, md: 4), // Verschiebt ab md um 4 Spaltenbreiten nach rechts
  child: MyWidget(),
)
```

## Ausrichtung (Alignment)

### Horizontale Ausrichtung (`justify`)
Über das `justify` Property in `BsRow` kann der freie Platz in einer Zeile horizontal verteilt werden (entspricht `.justify-content-*` in Bootstrap):

* `BsRowJustify.start` (Standard)
* `BsRowJustify.center`
* `BsRowJustify.end`
* `BsRowJustify.between`
* `BsRowJustify.around`

```dart
BsRow(
  justify: BsRowJustify.center,
  children: [ ... ],
)
```

### Vertikale Ausrichtung (`alignItems` & `alignSelf`)
Die vertikale Ausrichtung kann auf Zeilenebene (`BsRow.alignItems`) oder individuell pro Spalte überschrieben werden (`BsCol.alignSelf`):

* Werte für `alignItems`: `stretch` (Standard), `start`, `center`, `end`.
* Werte für `alignSelf`: `auto` (erbt von Row), `start`, `center`, `end`, `stretch`.

```dart
BsRow(
  alignItems: BsRowAlignItems.center, // Vertikal zentriert alle Spalten
  children: [
    BsCol(child: Text('Zentriert')),
    BsCol(
      alignSelf: BsColAlignSelf.end, // Überschreibt für diese Spalte (unten ausgerichtet)
      child: Text('Unten'),
    ),
  ],
)
```

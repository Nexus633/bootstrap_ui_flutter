# Grid System

## Preview

| Grid Auto | Grid MD |
|:---:|:---:|
| <img src="../../assets/Grid-auto.png" width="380" alt="Grid Auto"> | <img src="../../assets/Grid-md.png" width="380" alt="Grid MD"> |
| **Grid LG** | **Container Fluid & Gutter** |
| <img src="../../assets/Grid-lg.png" width="380" alt="Grid LG"> | <img src="../../assets/Container-fluid-and-gutter.png" width="380" alt="Container Fluid & Gutter"> |


The Bootstrap grid system is based on a 12-column layout and is fully responsive.

## Container

`BsContainer` centers content horizontally and provides standard padding.

```dart
BsContainer(
  type: BsContainerType.fixed, // or .fluid, .sm, .md, etc.
  child: MyContent(),
)
```

## Row & Col

`BsRow` and `BsCol` form the actual grid.

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

Defines the column span per breakpoint (mobile-first).

| Breakpoint | Description |
| :--- | :--- |
| `xs` | < 576px (Default) |
| `sm` | >= 576px |
| `md` | >= 768px |
| `lg` | >= 992px |
| `xl` | >= 1200px |
| `xxl` | >= 1400px |

## Offsets (Shifting Columns)

With `BsOffsetConfig` columns can be responsively shifted to the right by a specified number of grid columns (1 to 11), following a mobile-first approach:

```dart
BsCol(
  config: BsColConfig.all(4),
  offset: BsOffsetConfig(xs: 0, md: 4), // Shifts by 4 column widths starting at md
  child: MyWidget(),
)
```

## Alignment

### Horizontal Alignment (`justify`)
The `justify` property on `BsRow` horizontally distributes remaining space in a row (maps to `.justify-content-*` in Bootstrap):

* `BsRowJustify.start` (Default)
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

### Vertical Alignment (`alignItems` & `alignSelf`)
Vertical alignment can be configured on the row level (`BsRow.alignItems`) or overridden for individual columns (`BsCol.alignSelf`):

* Values for `alignItems`: `stretch` (Default), `start`, `center`, `end`.
* Values for `alignSelf`: `auto` (inherits from row), `start`, `center`, `end`, `stretch`.

```dart
BsRow(
  alignItems: BsRowAlignItems.center, // Vertically centers all columns
  children: [
    BsCol(child: Text('Centered')),
    BsCol(
      alignSelf: BsColAlignSelf.end, // Overrides for this column (aligned to bottom)
      child: Text('Bottom'),
    ),
  ],
)
```
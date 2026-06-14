# Helpers

## Preview

| Helpers 1 | Helpers 2 |
|:---:|:---:|
| <img src="../../assets/Helpers_1.png" width="380" alt="Helpers 1"> | <img src="../../assets/Helpers_2.png" width="380" alt="Helpers 2"> |


Bootstrap-inspired helper classes and widgets to speed up development and maintain consistency.

## Overview

| Helper | Type | Description |
| :--- | :--- | :--- |
| **Stacks** | Widget | `BsVStack` and `BsHStack` for easy vertical/horizontal layouts with gaps. |
| **Ratio** | Widget | `BsRatio` for managing aspect ratios (e.g., 16:9). |
| **Vertical Rule** | Widget | `BsVerticalRule` for vertical dividers. |
| **Links** | Widget | `BsLink` and `BsIconLink` for semantic colored links with hover effects. |
| **Truncation** | Extension | `.truncate()` extension for `Text` widgets. |

---

## Stacks

Stacks provide a streamlined way to lay out components with a consistent gap between items.

### Vertical Stack (vstack)

```dart
BsVStack(
  gap: 16,
  children: [
    Text('Item 1'),
    Text('Item 2'),
  ],
)
```

### Horizontal Stack (hstack)

```dart
BsHStack(
  gap: 8,
  children: [
    Text('Left'),
    BsVerticalRule(),
    Text('Right'),
  ],
)
```

---

## Ratio

Manage aspect ratios of content (e.g., for images or videos).

```dart
BsRatio(
  type: BsRatioType.ratio16x9,
  child: Image.network('...'),
)
```

---

## Vertical Rule

Use the vertical rule helper to create vertical dividers.

```dart
IntrinsicHeight(
  child: Row(
    children: [
      Text('Section 1'),
      BsVerticalRule().px3(),
      Text('Section 2'),
    ],
  ),
)
```

---

## Links

### Colored Links

```dart
BsLink(
  label: Text('Danger Link'),
  color: context.bs.danger,
  onPressed: () => print('Pressed'),
)
```

### Icon Links

```dart
BsIconLink(
  label: Text('Read more'),
  icon: Icon(Icons.arrow_forward, size: 16),
  onPressed: () {},
)
```

---

## Text Truncation

Easily truncate long text with an ellipsis.

```dart
Text('A very long text that should be truncated').truncate()
```
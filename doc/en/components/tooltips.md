# Tooltips

Documentation and examples for adding custom Bootstrap tooltips.

## Overview

Tooltips provide small, floating labels that appear on hover or focus. They rely on the `CompositedTransformTarget` and `OverlayEntry` APIs in Flutter to position themselves dynamically.

## Basic Example

Wrap the widget that should trigger the tooltip with a `BsTooltip`. Provide the `message` string.

```dart
BsTooltip(
  message: 'Tooltip on top',
  placement: BsPlacement.top,
  child: BsButton(
    label: 'Hover me',
    onPressed: () {},
  ),
)
```

## Placement

Four directions are available: `top`, `end` (right), `bottom`, and `start` (left) aligned.

- `BsPlacement.top`
- `BsPlacement.bottom`
- `BsPlacement.start`
- `BsPlacement.end`

Note: Tooltips will attempt to reposition themselves automatically if they detect they are going out of screen boundaries.

## Disabled Elements

Elements with the `disabled` attribute aren't interactive, meaning users cannot focus, hover, or click them to trigger a tooltip (or popover). You can disable the tooltip by setting the `disabled` property:

```dart
BsTooltip(
  message: 'This will not show',
  disabled: true,
  child: BsButton(
    label: 'Disabled Tooltip',
    onPressed: null,
  ),
)
```

## Color & Variants

Tooltips support custom background colors as well as all Bootstrap variants. If both are provided, `color` overrides the `variant`. The default color is black.

```dart
BsTooltip(
  message: 'Success Action',
  variant: BsVariant.success,
  child: BsButton(label: 'Save', onPressed: () {}),
)

// Custom Color
BsTooltip(
  message: 'Brand Colors',
  color: Colors.purple,
  child: BsButton(label: 'Custom', onPressed: () {}),
)
```

# Placeholders

## Preview

![Preview](../../assets/Placeholders.gif)

Placeholders (often called skeleton screens) are used to temporarily display loading states of components before real content is ready. They improve perceived performance and keep the UI stable by preventing sudden layout shifts.

They are designed following Bootstrap 5.3 specifications.

## Usage

Placeholders can be placed individually or grouped inside a `BsPlaceholderContainer` to apply smooth animations (glow pulse or wave shimmer) to all nested placeholder elements.

### 1. Basic Static Placeholder
A simple placeholder taking up 75% of the available width:

```dart
BsPlaceholder(
  widthFactor: 0.75,
)
```

### 2. Animated Placeholders (Glow and Wave)
Wrap placeholder elements inside a `BsPlaceholderContainer` to animate them.

**Wave (Shimmer Effect - Recommended):**
```dart
BsPlaceholderContainer(
  animation: .wave,
  child: Column(
    children: [
      BsPlaceholder(widthFactor: 0.5),
      SizedBox(height: 8),
      BsPlaceholder(widthFactor: 0.8),
    ],
  ),
)
```

**Glow (Pulse Opacity Effect):**
```dart
BsPlaceholderContainer(
  animation: .glow,
  child: Column(
    children: [
      BsPlaceholder(widthFactor: 0.6),
      SizedBox(height: 8),
      BsPlaceholder(widthFactor: 0.9),
    ],
  ),
)
```

## Sizing

Control the placeholder height using the `size` attribute:
- `.sm` (small, height: ~11px)
- `.md` (medium/default, height: ~14px)
- `.lg` (large, height: ~18px)

```dart
BsPlaceholder(
  size: .lg,
  widthFactor: 0.5,
)
```

For custom heights, you can define the exact height in logical pixels using the `height` parameter.

## Sizing and Widths

There are three mutually exclusive ways to define the width of a placeholder:

1. **`width`**: Fixed width in logical pixels (e.g. `width: 150.0`).
2. **`widthFactor`**: Fractional width relative to the parent widget (`0.0` to `1.0`, e.g. `widthFactor: 0.75` for 75% width). Equivalent to Bootstrap's `.w-75`.
3. **`colSpan`**: Width based on a 12-column grid (`1` to `12`, e.g. `colSpan: 6` for 50% width). Equivalent to Bootstrap's `.col-6`.

## Colors and Variants

By default, placeholders render in a semi-transparent version of the theme text color (`theme.bodyText.withValues(alpha: 0.175)`), matching Bootstrap's standard usage of `currentColor` with opacity.

You can customize it by providing predefined semantic Bootstrap colors (`BsVariant`) or completely custom colors:

```dart
// Predefined semantic variant
BsPlaceholder(
  variant: .primary,
  widthFactor: 0.5,
)

// Completely custom color
BsPlaceholder(
  color: Colors.teal[300],
  widthFactor: 0.5,
)
```

## Properties

### BsPlaceholderContainer

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| `child` | `Widget` | - | The child subtree containing placeholder widgets. |
| `animation` | `BsPlaceholderAnimation` | `.glow` | The animation type (`none`, `glow`, `wave`). |
| `duration` | `Duration` | `Duration(milliseconds: 2000)` | The duration of one full animation loop. |

### BsPlaceholder

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| `width` | `double?` | `null` | Fixed width of the placeholder in logical pixels. |
| `widthFactor` | `double?` | `null` | Fractional width relative to parent (`0.0` to `1.0`). |
| `colSpan` | `int?` | `null` | Width expressed in columns of a 12-column grid (`1` to `12`). |
| `height` | `double?` | `null` | Custom height in logical pixels. Overrides `size`. |
| `size` | `BsSize` | `.md` | Size variant (`sm`, `md`, `lg`). |
| `variant` | `BsVariant?` | `null` | Semantic Bootstrap color variant. |
| `color` | `Color?` | `null` | Custom background color. Overrides `variant`. |
| `borderRadius` | `BorderRadius?` | `BorderRadius.circular(4.0)` | Corner rounding of the placeholder. |

## Notes and Restrictions

* **Animation Performance**: Placeholders are highly optimized. Using `AnimatedBuilder` combined with custom painters (`_WavePainter`) ensures that animations do not trigger heavy widget layout rebuilds, resulting in excellent framerates.
* **Exclusivity of Sizing Options**: You may define at most one width parameter (`width`, `widthFactor`, or `colSpan`). Providing more than one will trigger an assertion error.

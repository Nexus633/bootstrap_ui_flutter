# Close Button

A generic close button (`BsCloseButton`) for dismissing content like modals, alerts, cards, and dropdowns. It inherits Bootstrap's `.btn-close` behaviors: dynamic color adjustment according to theme brightness, custom hover opacity changes, and disabled states.

## Usage

```dart
BsCloseButton(
  onPressed: () {
    print('Close button clicked');
  },
)

// Disabled state
BsCloseButton(
  disabled: true,
)

// Inverted white color for dark backgrounds
BsCloseButton(
  white: true,
)
```

## Properties

| Property | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `onPressed` | `VoidCallback?` | `null` | Callback triggered when the button is tapped. Ignored if `disabled` is true. |
| `disabled` | `bool` | `false` | Whether the button is disabled. If true, it ignores pointer events and displays at `25%` opacity. |
| `white` | `bool` | `false` | Forces the close button icon to be white. Ideal for placement on dark backgrounds. |
| `color` | `Color?` | `null` | A custom color override for the close icon. Overrides the default theme/white color mapping. |
| `size` | `double` | `16.0` | The size of the close icon. |
| `padding` | `EdgeInsetsGeometry` | `EdgeInsets.all(4.0)` | Padding around the close icon to increase the tap target. |

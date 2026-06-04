# Badge

The `BsBadge` is used to display small pieces of information such as counters or status labels.

## Usage

```dart
BsBadge(
  label: 'New',
  variant: BsBadgeVariant.primary,
  isPill: true,
)
```

## Properties

| Property | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `label` | `String` | **Required** | The text to display. |
| `variant` | `BsBadgeVariant` | `BsBadgeVariant.primary` | The color scheme of the badge. |
| `isPill` | `bool` | `false` | If `true`, the badge is fully rounded (pill style). |

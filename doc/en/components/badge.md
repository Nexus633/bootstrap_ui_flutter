# Badge

## Preview

| Badges Preview 1 | Badges Preview 2 |
|:---:|:---:|
| <img src="../../assets/Badges_1.png" width="380" alt="Badges Preview 1"> | <img src="../../assets/Badges_2.png" width="380" alt="Badges Preview 2"> |


The `BsBadge` is used to display small pieces of information such as counters or status labels.

## Usage

```dart
BsBadge(
  label: 'New',
  variant: .primary,
  isPill: true,
)
```

## Properties

| Property | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `label` | `String` | **Required** | The text to display. |
| `variant` | `BsBadgeVariant` | `.primary` | The color scheme of the badge. |
| `isPill` | `bool` | `false` | If `true`, the badge is fully rounded (pill style). |
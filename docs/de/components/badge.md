# Badge

Das `BsBadge` wird verwendet, um kleine Informationseinheiten wie Zähler oder Status-Labels anzuzeigen.

## Verwendung

```dart
BsBadge(
  label: 'Neu',
  variant: BsBadgeVariant.primary,
  isPill: true,
)
```

## Eigenschaften

| Eigenschaft | Typ | Standard | Beschreibung |
| :--- | :--- | :--- | :--- |
| `label` | `String` | **Erforderlich** | Der anzuzeigende Text. |
| `variant` | `BsBadgeVariant` | `BsBadgeVariant.primary` | Das Farbschema des Badges. |
| `isPill` | `bool` | `false` | Wenn `true`, wird das Badge vollständig abgerundet (Pill-Style). |

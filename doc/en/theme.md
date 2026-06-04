# Theme & Tokens

The framework uses a token-based system closely aligned with Bootstrap 5.3.

## Bootstrap Theme

The `BsThemeData` extension allows access to all Bootstrap-specific colors and styles via the BuildContext.

```dart
final bs = context.bs;
final primaryColor = bs.primary;
final bodyBg = bs.bodyBg;
```

### Light & Dark Mode

The framework natively supports light and dark modes. The respective themes are available via `BsThemeData.lightTheme` and `BsThemeData.darkTheme`.

## Colors (BsColors)

All Bootstrap base colors and palettes (100-900) are available in `BsColors`.

```dart
Color myColor = BsColors.blue[500]!;
```

## Spacing & Radius (BsSpacing, BsRadius)

The spacing system uses standard Bootstrap steps ($spacer = 16px).

| Token | Value | Description |
| :--- | :--- | :--- |
| `s1` | 4px | $spacer * 0.25 |
| `s2` | 8px | $spacer * 0.5 |
| `s3` | 16px | $spacer * 1 |
| `s4` | 24px | $spacer * 1.5 |
| `s5` | 48px | $spacer * 3 |

Border radius is also Bootstrap compliant (`sm`, `md`, `lg`, `pill`).

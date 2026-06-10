# Borders & Rounded

The `BsBorderExtension` provides Bootstrap-compliant border and rounding effects on any Flutter widget.

## Borders

### Border Styles

| Method | Description | Corresponds to Bootstrap |
| :--- | :--- | :--- |
| `.border({color, width})` | Adds a default border on all sides. | `.border` |
| `.border0()` | Removes all borders. | `.border-0` |
| `.borderTop({color, width})` | Adds a border on the top side. | `.border-top` |
| `.borderBottom({color, width})` | Adds a border on the bottom side. | `.border-bottom` |
| `.borderStart({color, width})` | Adds a border on the start (left) side. | `.border-start` |
| `.borderEnd({color, width})` | Adds a border on the end (right) side. | `.border-end` |

```dart
// Default border
Text('Content').border();

// Thick red border at the top
Text('Content').borderTop(color: Colors.red, width: 3.0);
```

### Border Colors

| Method | Description | Corresponds to Bootstrap |
| :--- | :--- | :--- |
| `.borderVariant(context, variant, {width})` | Colors the border using the Bootstrap theme colors. | `.border-*` |

```dart
// Border with Bootstrap "primary" theme color
Text('Content').borderVariant(context, BsVariant.primary);
```

---

## Rounded Corners

| Method | Description | Corresponds to Bootstrap |
| :--- | :--- | :--- |
| `.rounded()` | Default rounded corners (6px). | `.rounded` |
| `.rounded0()` | Removes all border radius. | `.rounded-0` |
| `.rounded1()` | Small border radius (4px). | `.rounded-1` |
| `.rounded2()` | Medium border radius (6px). | `.rounded-2` |
| `.rounded3()` | Large border radius (8px). | `.rounded-3` |
| `.rounded4()` | Extra large border radius (16px). | `.rounded-4` |
| `.rounded5()` | Extra extra large border radius (32px). | `.rounded-5` |
| `.roundedCircle()` | Makes the widget circular. | `.rounded-circle` |
| `.roundedPill()` | Capsule shape (fully rounded ends). | `.rounded-pill` |
| `.roundedTop({radius})` | Rounds only the top corners. | `.rounded-top` |
| `.roundedBottom({radius})` | Rounds only the bottom corners. | `.rounded-bottom` |
| `.roundedStart({radius})` | Rounds only the start (left) corners. | `.rounded-start` |
| `.roundedEnd({radius})` | Rounds only the end (right) corners. | `.rounded-end` |

```dart
// Pill-shaped container
Container(color: Colors.blue).roundedPill();

// Circular image
Image.asset('image.png').roundedCircle();
```

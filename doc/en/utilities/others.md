# Utility Extensions

## Preview

![Preview](../../assets/Utilities-2.png)


In addition to spacing, the library provides several other utility extensions to streamline your UI development.

## Display & Visibility

`BsDisplayExtension` handles showing, hiding, and opacity.

| Method | Description |
| :--- | :--- |
| `.visible(bool)` | Standard `Visibility` widget wrapper. |
| `.gone(bool)` | `Visibility` with `maintainState: false`. |
| `.dNone()` | Alias for `.gone(true)`. |
| `.opacity(double)` | `Opacity` widget wrapper. |

```dart
Text('Hidden').dNone();
Text('Transparent').opacity(0.5);
```

## Alignment

`BsAlignmentExtension` handles positioning.

| Method | Description |
| :--- | :--- |
| `.align(Alignment)` | `Align` widget wrapper. |
| `.center()` | `Center` widget wrapper. |
| `.alignStart()` | `Align` to `centerStart`. |
| `.alignEnd()` | `Align` to `centerEnd`. |
| `.alignTop()` | `Align` to `topCenter`. |
| `.alignBottom()` | `Align` to `bottomCenter`. |

```dart
Text('Centered').center();
Text('Left').alignStart();
```

## Sizing

`BsSizeExtension` handles dimensions and expansion.

| Method | Description |
| :--- | :--- |
| `.w(double)` | Sets fixed width using `SizedBox`. |
| `.h(double)` | Sets fixed height using `SizedBox`. |
| `.w100()`, `.w75()`, `.w50()`, `.w25()` | Sets width factor relative to parent. |
| `.h100()`, `.h75()`, `.h50()`, `.h25()` | Sets height factor relative to parent. |
| `.size100()` | Sets both width and height to infinity. |
| `.expanded([flex])` | `Expanded` widget wrapper. |

```dart
Container(color: Colors.red).w(50).h(50);
Button('50% Width').w50();
```
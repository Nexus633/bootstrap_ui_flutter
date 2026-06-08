# Text Utilities

This utility module provides a wide range of Bootstrap-compliant extension methods on the standard `Text` widget in Flutter. This allows for concise and clean text formatting using method chaining.

## Methods Overview

### 1. Font Size
Corresponds to the Bootstrap classes `.fs-1` to `.fs-6`.

| Method | Font Size | Equivalent |
| :--- | :--- | :--- |
| `.fs1()` | 40.0 px | H1 Heading |
| `.fs2()` | 32.0 px | H2 Heading |
| `.fs3()` | 28.0 px | H3 Heading |
| `.fs4()` | 24.0 px | H4 Heading |
| `.fs5()` | 20.0 px | H5 Heading |
| `.fs6()` | 16.0 px | H6 / Body Base |

```dart
Text('Large text').fs1();
Text('Small text').fs6();
```

---

### 2. Font Weight
Corresponds to the Bootstrap classes `.fw-*`.

| Method | Weight | Weight Value |
| :--- | :--- | :--- |
| `.fwLight()` | Light | 300 |
| `.fwLighter()` | Lighter | 200 |
| `.fwNormal()` | Normal | 400 |
| `.fwMedium()` | Medium | 500 |
| `.fwSemibold()` | Semibold | 600 |
| `.fwBold()` | Bold | 700 |
| `.fwBolder()` | Bolder | 800 |

```dart
Text('Bold text').fwBold();
Text('Light text').fwLight();
```

---

### 3. Font Style (Italics)
Corresponds to the Bootstrap classes `.fst-*`.

| Method | Description |
| :--- | :--- |
| `.fstItalic()` | Makes the text italic. |
| `.fstNormal()` | Resets the text to the normal style. |

```dart
Text('Italic text').fstItalic();
```

---

### 4. Line Height
Corresponds to the Bootstrap classes `.lh-*`.

| Method | Line Height | Description |
| :--- | :--- | :--- |
| `.lh1()` | 1.0 | Tight line height |
| `.lhSm()` | 1.25 | Small line height |
| `.lhBase()` | 1.5 | Base line height |
| `.lhLg()` | 2.0 | Large line height |

```dart
Text('Text with large line height').lhLg();
```

---

### 5. Text Alignment
Corresponds to the Bootstrap classes `.text-*`.

| Method | Description |
| :--- | :--- |
| `.textStart()` | Aligns the text to the start (left). |
| `.textCenter()` | Centers the text. |
| `.textEnd()` | Aligns the text to the end (right). |

```dart
Text('Centered text').textCenter();
```

---

### 6. Text Decoration
Corresponds to the Bootstrap classes `.text-decoration-*`.

| Method | Description |
| :--- | :--- |
| `.textDecorationUnderline()` | Underlines the text. |
| `.textDecorationLineThrough()` | Strikes through the text. |
| `.textDecorationNone()` | Removes any text decoration. |

```dart
Text('Underlined').textDecorationUnderline();
```

---

### 7. Text Truncate
Corresponds to the Bootstrap class `.text-truncate`.

| Method | Description |
| :--- | :--- |
| `.truncate()` | Truncates text with an ellipsis (`...`) if it exceeds one line. |

```dart
Text('This is a very long text that will be truncated...').truncate();
```

---

## Usage Examples

You can combine multiple styles using method chaining:

```dart
Text('Bootstrap in Flutter')
    .fs3()
    .fwBold()
    .fstItalic()
    .textCenter()
    .textDecorationUnderline();
```

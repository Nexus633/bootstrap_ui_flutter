# Spacing Utilities

## Preview

![Preview](../../assets/Utilities-1.png)


The `BsSpacingExtension` provides a set of concise methods to apply padding and margin to any Flutter widget, mirroring the naming convention of Bootstrap's utility classes.

## Features

- **Concise Syntax**: Chainable methods like `.p3()`, `.mb2()`, etc.
- **Bootstrap Alignment**: Uses standard Bootstrap spacing levels (1-5).
- **Flexible**: Allows custom values via `.p(double)`, `.m(double)`, etc.
- **Context Aware**: Correctly handles padding (inner space) and margin (outer space) concepts in Flutter's widget tree.

## Usage

Instead of wrapping a widget in a `Padding` widget manually:

```dart
// Standard Flutter (Padding)
Padding(
  padding: EdgeInsets.all(16.0),
  child: Text('Hello'),
)

// With BsSpacingExtension
Text('Hello').p3()

// Margin (Applying space outside a decorated box)
Container(color: Colors.red, child: Text('Alert'))
  .mb3() // Adds margin bottom outside the red box
```

## Available Methods

### Standard Levels (1-5)

These methods use the predefined `BsSpacing` tokens:

| Type | Padding Methods | Margin Methods | Bootstrap Equivalent |
| :--- | :--- | :--- | :--- |
| **Uniform** | `.p1()` to `.p5()` | `.m1()` to `.m5()` | `p-*` / `m-*` |
| **Horizontal** | `.px1()` to `.px5()` | `.mx1()` to `.mx5()` | `px-*` / `mx-*` |
| **Vertical** | `.py1()` to `.py5()` | `.my1()` to `.my5()` | `py-*` / `my-*` |
| **Top** | `.pt1()` to `.pt5()` | `.mt1()` to `.mt5()` | `pt-*` / `mt-*` |
| **Bottom** | `.pb1()` to `.pb5()` | `.mb1()` to `.mb5()` | `pb-*` / `mb-*` |
| **Start (Left)** | `.ps1()` to `.ps5()` | `.ms1()` to `.ms5()` | `ps-*` / `ms-*` |
| **End (Right)** | `.pe1()` to `.pe5()` | `.me1()` to `.me5()` | `pe-*` / `me-*` |

### Custom Values

If you need a specific pixel value that is not covered by the standard levels:

- Padding: `.p(val)`, `.px(val)`, `.py(val)`, `.pt(val)`, `.pb(val)`, `.ps(val)`, `.pe(val)`
- Margin: `.m(val)`, `.mx(val)`, `.my(val)`, `.mt(val)`, `.mb(val)`, `.ms(val)`, `.me(val)`

## Example

```dart
Column(
  children: [
    Text('Title').mb3(), // Margin bottom level 3 (spacing between items)
    Row(
      children: [
        Icon(Icons.star).pe2(), // Padding end level 2
        Text('Rating'),
      ],
    ).px4(), // Horizontal padding level 4
  ],
).p5() // Uniform padding level 5 for the container
```
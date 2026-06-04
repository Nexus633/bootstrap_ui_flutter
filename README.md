# Bootstrap Flutter

A Flutter component library that implements the Bootstrap 5.3 design system as faithfully as possible. Built for modern, responsive Flutter applications with the familiar Bootstrap aesthetic.

## Features

- **Responsive Grid:** Full 12-column grid with `BsContainer`, `BsRow`, and `BsCol`.
- **Bootstrap Tokens:** Native support for Bootstrap colors, spacing (s1-s5), radii, and typography.
- **Components:**
  - **Buttons & Button Groups:** Diverse variants (Solid, Outline), sizes, and loading states.
  - **Accordion:** Animated, collapsible content areas.
  - **Alerts:** Contextual messages with flexible animations (Fade, Slide) and auto-close functionality.
  - **Badges:** Small information units, also integrable into buttons.
- **Dark Mode:** Full, native support for the Bootstrap 5.3 dark theme.
- **Tested:** Comprehensive widget tests for all core components.

## Installation

Add `bootstrap_flutter` to your `pubspec.yaml`:

```yaml
dependencies:
  bootstrap_flutter: ^0.1.0
```

## Example: Theme Usage

To use the Bootstrap theme, wrap your app in a `MaterialApp` widget with the `BsThemeData` extensions:

```dart
import 'package:flutter/material.dart';
import 'package:bootstrap_flutter/bootstrap_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        extensions: [BsThemeData.lightTheme],
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        extensions: [BsThemeData.darkTheme],
      ),
      home: const MyHomePage(),
    );
  }
}
```

## Documentation & Example

- **Detailed Documentation:** Found in the [docs](./docs/index.md) folder (DE/EN).
- **Showcase App:** Check out the [example](./example) project to see all components in action.

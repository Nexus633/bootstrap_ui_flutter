# Bootstrap Flutter Showcase

This example app demonstrates all available components and layout features of the `bootstrap_flutter` package. It serves as both a reference implementation and a testing environment for new features.

## Showcase Features

- **Responsive Grid:** Interactive demonstration of the 12-column layout (Container, Row, Col).
- **Themes:** Real-time switching between Light Mode, Dark Mode, and system settings.
- **Component Gallery:**
  - **Buttons:** Various variants (Solid, Outline), sizes, icons, and loading states.
  - **Accordion:** Standard and "Always Open" variants with animated content.
  - **Alerts:** Demonstration of different animations (Fade, Slide) and the auto-close feature.
  - **Badges:** Standard and pill styles, plus integration into buttons.

## Running the Example

Make sure you are in the `example` directory:

```bash
cd example
flutter run
```

## Project Structure

- `lib/main.dart`: The app's entry point. Configures `MaterialApp` with `BsThemeData` extensions.
- `lib/ui/shell/showcase_shell.dart`: The main UI featuring a sidebar for navigation between showcases.
- `lib/ui/showcase/`: This folder contains individual showcase files for each component. Each file demonstrates the usage of a specific component in isolation (e.g., `button_showcase.dart`).

# Bootstrap Flutter Showcase

Diese Beispiel-App demonstriert alle verfügbaren Komponenten und Layout-Funktionen des `bootstrap_ui_flutter` Pakets. Sie dient sowohl als Referenz-Implementierung als auch als Testumgebung für neue Features.

## Funktionen des Showcase

- **Responsive Grid:** Interaktive Demonstration des 12-Spalten-Layouts (Container, Row, Col).
- **Themes:** Echtzeit-Umschaltung zwischen Light Mode, Dark Mode und Systemeinstellungen.
- **Komponenten-Galerie:**
  - **Buttons:** Verschiedene Varianten (Solid, Outline), Größen, Icons und Ladezustände.
  - **Accordion:** Standard- und "Always Open"-Varianten mit animierten Inhalten.
  - **Alerts:** Demonstration der verschiedenen Animationen (Fade, Slide) und der Auto-Close Funktion.
  - **Badges:** Standard- und Pill-Stile sowie Integration in Buttons.

## Starten des Beispiels

Stellen Sie sicher, dass Sie sich im `example` Verzeichnis befinden:

```bash
cd example
flutter run
```

## Projektstruktur

- `lib/main.dart`: Der Einstiegspunkt der App. Hier wird das `MaterialApp` Widget mit den `BsThemeData` Extensions konfiguriert.
- `lib/ui/shell/showcase_shell.dart`: Die Haupt-Benutzeroberfläche mit einer Sidebar zur Navigation zwischen den verschiedenen Showcases.
- `lib/ui/showcase/`: In diesem Ordner befinden sich die einzelnen Showcase-Dateien für jede Komponente. Jede Datei zeigt isoliert die Verwendung einer bestimmten Komponente (z.B. `button_showcase.dart`).

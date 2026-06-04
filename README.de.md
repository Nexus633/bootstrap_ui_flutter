# Bootstrap Flutter

Eine Flutter-Komponentenbibliothek, die das Bootstrap 5.3 Design-System so getreu wie möglich umsetzt. Entwickelt für moderne, responsive Flutter-Anwendungen mit der vertrauten Ästhetik von Bootstrap.

## Features

- **Responsive Grid:** Volles 12-Spalten-Grid mit `BsContainer`, `BsRow` und `BsCol`.
- **Bootstrap Tokens:** Native Unterstützung für Bootstrap-Farben, Spacing (s1-s5), Radien und Typografie.
- **Komponenten:**
  - **Buttons & Button Groups:** Vielfältige Varianten (Solid, Outline), Größen und Ladezustände.
  - **Accordion:** Animierte, ausklappbare Inhaltsbereiche.
  - **Alerts:** Kontextbezogene Nachrichten mit flexiblen Animationen (Fade, Slide) und Auto-Close.
  - **Badges:** Kleine Informationseinheiten, auch integrierbar in Buttons.
- **Dark Mode:** Vollständige, native Unterstützung für das Bootstrap 5.3 Dark-Theme.
- **Getestet:** Umfassende Widget-Tests für alle Kernkomponenten.

## Installation

Fügen Sie `bootstrap_flutter` zu Ihrer `pubspec.yaml` hinzu:

```yaml
dependencies:
  bootstrap_flutter: ^0.1.0
```

## Beispiel: Theme Nutzung

Um das Bootstrap-Theme zu nutzen, wickeln Sie Ihre App in ein `MaterialApp` Widget mit den `BsThemeData` Extensions ein:

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

## Dokumentation & Beispiel

- **Detaillierte Dokumentation:** Finden Sie im [docs](./docs/index.md) Ordner (DE/EN).
- **Showcase App:** Schauen Sie sich das [example](./example) Projekt an, um alle Komponenten in Aktion zu sehen.

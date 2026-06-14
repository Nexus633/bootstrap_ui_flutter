# Formulare (Forms)

## Vorschau

![Vorschau](../../assets/Forms.gif)


Formular-Komponenten sind essenziell für die Erfassung von Benutzereingaben. Das `bootstrap_ui_flutter` Paket bietet ein umfassendes Set an Steuerelementen, die das Verhalten von Bootstraps `.form-control`, `.form-select`, `.form-check` und `.input-group` exakt nachbilden und sich gleichzeitig nahtlos in Flutters natives `Form` und `FormField` System integrieren.

## Features

- **Native Validierung**: Alle Formular-Komponenten erweitern `FormField<T>`, wodurch Flutters Standard `validator`-Eigenschaft und `GlobalKey<FormState>` verwendet werden können.
- **Validierungs-Feedback**: Integrierte `.is-valid` und `.is-invalid` Zustände mit automatisch generierten Feedback-Meldungen (`BsFormFeedback`).
- **Größenanpassung (Sizing)**: Unterstützung für die standardmäßigen Bootstrap-Größen (`sm`, `md`, `lg`).
- **Fokus-Ringe**: Bootstrap-typische Fokus-Ringe (Focus Rings) mittels benutzerdefinierter Schatten.
- **Eingabegruppen (Input Groups)**: Nahtlose Kombination von Text-Zusätzen, Buttons und Eingabefeldern in einer Zeile mit intelligenter Verwaltung der Rahmenradien (Border Radius).

## Komponenten

### 1. `BsInput` (Formular-Steuerelemente)

Eine vielseitige Texteingabe-Komponente, die `TextFormField` ersetzt.

```dart
BsInput(
  placeholder: 'name@example.com',
  size: .md, // .form-control-md
  disabled: false,
  readonly: false,
  plainText: false, // .form-control-plaintext
  validator: (val) => val == null || val.isEmpty ? 'Pflichtfeld' : null,
)
```

### 2. `BsSelect` (Auswahlmenüs)

Ein benutzerdefiniertes Dropdown-Auswahlmenü, das `DropdownButtonFormField` ersetzt.

```dart
BsSelect<String>(
  placeholder: const Text('Menü öffnen'),
  items: const [
    DropdownMenuItem(value: '1', child: Text('Eins')),
    DropdownMenuItem(value: '2', child: Text('Zwei')),
  ],
  onChanged: (val) => print(val),
)
```

### 3. `BsCheckbox` (Checkboxen und Schalter)

Eine vereinheitlichte Komponente für Standard-Checkboxen und Toggle-Schalter (Switches).

```dart
// Standard Checkbox
BsCheckbox(
  label: const Text('Standard Checkbox'),
  initialValue: false,
)

// Schalter (Switch)
BsCheckbox(
  label: const Text('Schalter (Switch)'),
  isSwitch: true, // .form-switch
)
```

### 4. `BsRadio` (Radio-Buttons)

Eine Komponente für Standard-Radio-Buttons, die sich an Bootstraps Checkbox/Radio-Steuerelementen orientiert.

```dart
BsRadio<String>(
  value: 'eins',
  groupValue: selectedValue,
  onChanged: (val) => setState(() => selectedValue = val),
  label: const Text('Option Eins'),
)
```

### 5. `BsRange` (Schieberegler)

Ein benutzerdefinierter Schieberegler (Slider), der `.form-range` entspricht.

```dart
BsRange(
  initialValue: 50.0,
  min: 0.0,
  max: 100.0,
  onChanged: (val) => print(val),
)
```

### 6. `BsInputGroup` (Eingabegruppen)

Kombinieren Sie Eingabefelder problemlos mit Textzusätzen oder Buttons. Die `BsInputGroup` fungiert als Flex-Container, der mit seinen untergeordneten Elementen (`BsInput`, `BsSelect`, `BsButton`, `BsInputGroupText`) kommuniziert, um die Rahmenradien automatisch anzupassen und doppelte Rahmen zu vermeiden.

```dart
BsInputGroup(
  children: [
    const BsInputGroupText('@'), // Text-Zusatz
    BsInput(placeholder: 'Benutzername').expanded(), // Das eigentliche Eingabefeld
  ],
)

// Zusätze können auch Widgets sein, wie z. B. Checkboxen:
BsInputGroup(
  children: [
    BsInputGroupText.widget(child: BsCheckbox(initialValue: true)),
    BsInput(placeholder: 'Checkbox in der Gruppe...').expanded(),
  ],
)
```

### 7. Floating Labels (`.form-floating`)

Erstellen Sie elegant schwebende Formular-Labels, die sich über Ihre Eingabefelder legen, indem Sie den Parameter `floatingLabel` bei `BsInput` oder `BsSelect` nutzen.

```dart
BsInput(
  floatingLabel: 'E-Mail-Adresse',
  placeholder: 'name@example.com',
)

BsSelect<String>(
  floatingLabel: 'Funktioniert auch mit Selects',
  placeholder: const Text('Menü öffnen'),
  items: const [
    DropdownMenuItem(value: '1', child: Text('Eins')),
  ],
)
```

## Validierung & Zustand

Alle Eingabefelder unterstützen die Eigenschaft `validationState` für die explizite Zustandsverwaltung (z. B. bei der Validierung über eine externe API, ohne ein Flutter `Form` zu verwenden). Zudem wird automatisch der Bootstrap `BsShadows.focusRing` (in rot oder grün) angezeigt, wenn ein validiertes Feld fokussiert wird.

```dart
BsInput(
  validationState: .valid, // Erzwingt das .is-valid Styling
)
```

Wenn die Komponente innerhalb eines `Form` verwendet wird, nutzen Sie einfach die `validator` Eigenschaft. Die Komponente wechselt automatisch in den `invalid` Zustand und zeigt ein rotes `BsFormFeedback` Widget an, falls der Validator einen Fehlerstring zurückgibt.

### Barrierefreiheit & Lokalisierung (Accessibility & Localization)

Wenn Validierungsfehler auftreten, werden diese an die Semantics-Struktur des Widgets angehängt, damit sie von Screenreadern (z. B. TalkBack oder VoiceOver) erfasst werden. Standardmäßig wird vor dem Fehler der Präfix `"Error: "` bzw. `"Fehler: "` (bei deutscher App-Locale) gesprochen.

Du kannst dieses Präfix global in deiner App anpassen (z. B. in `main.dart`):

```dart
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

void main() {
  // Globales Fehlerpräfix für Semantics festlegen
  BsLocalizationConfig.errorSemanticsPrefix = 'Achtung';
  runApp(const MyApp());
}
```

Wenn kein globales Präfix definiert ist, ermittelt die Bibliothek das Präfix automatisch anhand der aktuellen `Locale` des `BuildContext` (z. B. `"Fehler"` für Deutsch, `"Error"` für Englisch und als Fallback).
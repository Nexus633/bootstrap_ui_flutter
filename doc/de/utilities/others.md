# Weitere Utilities

Zusätzlich zum Spacing bietet die Bibliothek weitere Extensions, um die UI-Entwicklung zu beschleunigen.

## Anzeige & Sichtbarkeit (Display)

`BsDisplayExtension` kümmert sich um das Ein-/Ausblenden und die Transparenz.

| Methode | Beschreibung |
| :--- | :--- |
| `.visible(bool)` | Wrapper für das `Visibility`-Widget. |
| `.gone(bool)` | `Visibility` mit `maintainState: false`. |
| `.dNone()` | Alias für `.gone(true)`. |
| `.opacity(double)` | Wrapper für das `Opacity`-Widget. |

```dart
Text('Versteckt').dNone();
Text('Transparent').opacity(0.5);
```

## Ausrichtung (Alignment)

`BsAlignmentExtension` kümmert sich um die Positionierung.

| Methode | Beschreibung |
| :--- | :--- |
| `.align(Alignment)` | Wrapper für das `Align`-Widget. |
| `.center()` | Wrapper für das `Center`-Widget. |
| `.alignStart()` | Ausrichtung am Anfang (`centerStart`). |
| `.alignEnd()` | Ausrichtung am Ende (`centerEnd`). |
| `.alignTop()` | Ausrichtung oben (`topCenter`). |
| `.alignBottom()` | Ausrichtung unten (`bottomCenter`). |

```dart
Text('Zentriert').center();
Text('Links').alignStart();
```

## Größenanpassung (Sizing)

`BsSizeExtension` kümmert sich um Dimensionen und Flexibilität.

| Methode | Beschreibung |
| :--- | :--- |
| `.w(double)` | Setzt eine feste Breite via `SizedBox`. |
| `.h(double)` | Setzt eine feste Höhe via `SizedBox`. |
| `.w100()`, `.w75()`, `.w50()`, `.w25()` | Setzt Breite relativ zum Eltern-Element. |
| `.h100()`, `.h75()`, `.h50()`, `.h25()` | Setzt Höhe relativ zum Eltern-Element. |
| `.size100()` | Setzt Breite und Höhe auf Unendlich. |
| `.expanded([flex])` | Wrapper für das `Expanded`-Widget. |

```dart
Container(color: Colors.red).w(50).h(50);
Button('50% Breite').w50();
```

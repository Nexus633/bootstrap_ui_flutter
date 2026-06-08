# Text-Utilities

Dieses Utility-Modul stellt eine Vielzahl von Bootstrap-konformen Erweiterungsmethoden (Extensions) auf dem Standard-`Text`-Widget in Flutter bereit. Damit lässt sich Text direkt verkettet und übersichtlich formatieren.

## Übersicht der Methoden

### 1. Schriftgrößen (Font Size)
Entspricht den Bootstrap-Klassen `.fs-1` bis `.fs-6`.

| Methode | Schriftgröße | Entspricht |
| :--- | :--- | :--- |
| `.fs1()` | 40.0 px | H1 Überschrift |
| `.fs2()` | 32.0 px | H2 Überschrift |
| `.fs3()` | 28.0 px | H3 Überschrift |
| `.fs4()` | 24.0 px | H4 Überschrift |
| `.fs5()` | 20.0 px | H5 Überschrift |
| `.fs6()` | 16.0 px | H6 / Fließtext-Basis |

```dart
Text('Großer Text').fs1();
Text('Kleiner Text').fs6();
```

---

### 2. Schriftgewichte (Font Weight)
Entspricht den Bootstrap-Klassen `.fw-*`.

| Methode | Gewicht | Gewichtswert |
| :--- | :--- | :--- |
| `.fwLight()` | Light | 300 |
| `.fwLighter()` | Lighter | 200 |
| `.fwNormal()` | Normal | 400 |
| `.fwMedium()` | Medium | 500 |
| `.fwSemibold()` | Semibold | 600 |
| `.fwBold()` | Bold | 700 |
| `.fwBolder()` | Bolder | 800 |

```dart
Text('Fetter Text').fwBold();
Text('Leichter Text').fwLight();
```

---

### 3. Schriftstil (Italics)
Entspricht den Bootstrap-Klassen `.fst-*`.

| Methode | Beschreibung |
| :--- | :--- |
| `.fstItalic()` | Macht den Text kursiv. |
| `.fstNormal()` | Setzt den Text auf den Standardstil zurück. |

```dart
Text('Kursiver Text').fstItalic();
```

---

### 4. Zeilenhöhe (Line Height)
Entspricht den Bootstrap-Klassen `.lh-*`.

| Methode | Zeilenhöhe | Beschreibung |
| :--- | :--- | :--- |
| `.lh1()` | 1.0 | Enge Zeilenhöhe |
| `.lhSm()` | 1.25 | Kleine Zeilenhöhe |
| `.lhBase()` | 1.5 | Standard-Zeilenhöhe |
| `.lhLg()` | 2.0 | Große Zeilenhöhe |

```dart
Text('Zeilentext mit viel Abstand').lhLg();
```

---

### 5. Textausrichtung (Alignment)
Entspricht den Bootstrap-Klassen `.text-*`.

| Methode | Beschreibung |
| :--- | :--- |
| `.textStart()` | Richtet den Text linksbündig (bzw. am Start) aus. |
| `.textCenter()` | Zentriert den Text. |
| `.textEnd()` | Richtet den Text rechtsbündig (bzw. am Ende) aus. |

```dart
Text('Zentrierter Text').textCenter();
```

---

### 6. Textdekoration (Decoration)
Entspricht den Bootstrap-Klassen `.text-decoration-*`.

| Methode | Beschreibung |
| :--- | :--- |
| `.textDecorationUnderline()` | Unterstreicht den Text. |
| `.textDecorationLineThrough()` | Streicht den Text durch. |
| `.textDecorationNone()` | Entfernt jegliche Textdekoration. |

```dart
Text('Unterstrichen').textDecorationUnderline();
```

---

### 7. Textkürzung (Truncate)
Entspricht der Bootstrap-Klasse `.text-truncate`.

| Methode | Beschreibung |
| :--- | :--- |
| `.truncate()` | Kürzt den Text bei Überschreitung einer Zeile mit Auslassungspunkten (`...`). |

```dart
Text('Dies ist ein sehr langer Text, der gekürzt wird...').truncate();
```

---

## Verwendungsbeispiele

Durch Kaskadierung (Chaining) können mehrere Stile kombiniert werden:

```dart
Text('Bootstrap in Flutter')
    .fs3()
    .fwBold()
    .fstItalic()
    .textCenter()
    .textDecorationUnderline();
```

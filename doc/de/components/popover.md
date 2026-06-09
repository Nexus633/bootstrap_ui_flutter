# Popovers

Popovers (Einblendungen) sind kleine Overlay-Boxen, die zusätzlichen Kontext oder Informationen zu einem Element anzeigen, wenn der Benutzer darauf klickt oder mit der Maus darüber fährt. Sie verhalten sich ähnlich wie Tooltips, bieten jedoch Platz für strukturiertere Inhalte (wie Überschriften, Listen oder Buttons).

Sie basieren auf dem Verhalten und Design von Bootstrap 5.3.

## Verwendung

Umschließe einfach das Trigger-Widget (z. B. einen Button) mit einem `BsPopover`-Widget.

### 1. Einfaches Popover (Standard: Click-Trigger)

```dart
BsPopover(
  titleText: 'Popover Titel',
  contentText: 'Dies ist der Inhalt des Popovers.',
  child: BsButton(
    label: 'Klick mich',
    onPressed: () {},
  ),
)
```

### 2. Hover-Trigger
Um das Popover beim Überfahren mit der Maus anzuzeigen, stelle `trigger` auf `BsPopoverTrigger.hover` ein.

```dart
BsPopover(
  titleText: 'Info',
  contentText: 'Dieses Popover öffnet sich beim Hovern.',
  trigger: BsPopoverTrigger.hover,
  child: BsButton(
    label: 'Fahre über mich',
    onPressed: () {},
  ),
)
```

### 3. Strukturierter/Rich Inhalt (Custom Widgets)
Popovers können statt einfachem Text beliebige Widgets für Titel und Inhalt enthalten:

```dart
BsPopover(
  placement: BsPopoverPlacement.bottom,
  title: Row(
    children: [
      Icon(Icons.info, size: 16),
      SizedBox(width: 8),
      Text('Information'),
    ],
  ),
  content: Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Hier steht strukturierter Text.'),
      SizedBox(height: 8),
      BsButton(
        label: 'Aktion ausführen',
        size: BsButtonSize.sm,
        onPressed: () {},
      ),
    ],
  ),
  child: BsButton(
    label: 'Öffne reiches Popover',
    onPressed: () {},
  ),
)
```

### 4. Programmatische Steuerung
Du kannst ein Popover auch über einen `BsPopoverController` öffnen, schließen oder toggeln:

```dart
final _controller = BsPopoverController();

// Im Build-Code:
Column(
  children: [
    BsButton(
      label: 'Popover umschalten',
      onPressed: () => _controller.toggle(),
    ),
    SizedBox(height: 16),
    BsPopover(
      controller: _controller,
      titleText: 'Gesteuertes Popover',
      contentText: 'Dieses Popover wird extern gesteuert.',
      child: Text('Ziel-Element'),
    ),
  ],
)
```

### 5. Custom Popovers (Theming)
Du kannst das Popover-Styling farblich vollständig anpassen, um beispielsweise eine Variante mit Primärfarbe oder eine dunkle Farbvariante zu erstellen. Der Ausrichtungs-Pfeil passt sich dabei farblich automatisch an (an den Header oder das Body-Element):

```dart
BsPopover(
  titleText: 'Primäres Popover',
  contentText: 'Dieses Popover verwendet Bootstrap-Primary Farben.',
  backgroundColor: Colors.white,
  borderColor: theme.primary,
  headerBackgroundColor: theme.primary,
  headerTextColor: Colors.white,
  bodyTextColor: theme.primary,
  child: BsButton(
    label: 'Primäres Popover',
    onPressed: () {},
  ),
)
```

## Ausrichtung (Placements)

Über die Eigenschaft `placement` kann die bevorzugte Richtung festgelegt werden:
- `BsPopoverPlacement.top` (Über dem Element - Standard)
- `BsPopoverPlacement.bottom` (Unter dem Element)
- `BsPopoverPlacement.start` (Links vom Element / start)
- `BsPopoverPlacement.end` (Rechts vom Element / end)

**Auto-Flip:** Falls am Bildschirmrand nicht genügend Platz in der Wunschrichtung vorhanden ist, klappt das Popover automatisch in die entgegengesetzte Richtung um, um immer sichtbar zu bleiben.

## Eigenschaften

### BsPopover

| Eigenschaft | Typ | Standardwert | Beschreibung |
| --- | --- | --- | --- |
| `child` | `Widget` | - | Das auslösende (Trigger-) Widget. |
| `title` | `Widget?` | `null` | Custom Titel-Widget (überschreibt `titleText`). |
| `content` | `Widget?` | `null` | Custom Inhalts-Widget (überschreibt `contentText`). |
| `titleText` | `String?` | `null` | Komfort-Titel als Textzeichenfolge. |
| `contentText` | `String?` | `null` | Komfort-Inhalt als Textzeichenfolge. |
| `placement` | `BsPopoverPlacement` | `BsPopoverPlacement.top` | Bevorzugte Ausrichtungsrichtung (`top`, `bottom`, `start`, `end`). |
| `trigger` | `BsPopoverTrigger` | `BsPopoverTrigger.click` | Die Interaktion zum Öffnen (`click`, `hover`). |
| `controller` | `BsPopoverController?` | `null` | Optionaler Controller zur programmgesteuerten Steuerung. |
| `maxWidth` | `double` | `276.0` | Maximale Breite der Popover-Box. |
| `disabled` | `bool` | `false` | Deaktiviert Interaktionen. |
| `backgroundColor` | `Color?` | `null` | Custom Hintergrundfarbe der Popover-Box (Standard: weiß bzw. `#2b3035`). |
| `borderColor` | `Color?` | `null` | Custom Rahmenfarbe des Popovers und des Pfeils. |
| `headerBackgroundColor` | `Color?` | `null` | Custom Hintergrundfarbe des Headers. |
| `headerTextColor` | `Color?` | `null` | Custom Textfarbe des Titels. |
| `bodyTextColor` | `Color?` | `null` | Custom Textfarbe des Inhalts. |

## Besonderheiten und Einschränkungen

* **Arrow-Darstellung**: Popovers zeichnen automatisch ein kleines Dreieck (Arrow), das auf den Auslöser zeigt. Die Rahmenlinien des Pfeils werden an den Ecken passgenau mit denen der Popover-Box verbunden (die Anbindungskante bleibt rahmenlos). Zudem gleicht der Pfeil seine Füllfarbe dynamisch an (Hintergrundfarbe des Headers bei Ausrichtung unten, andernfalls Body-Hintergrundfarbe).
* **Click-Outside**: Bei Verwendung des standardmäßigen `click` Triggers schließt sich das Popover automatisch bei Klicks außerhalb des Popovers (Klick-Barriere-Erkennung).
* **Auto-Flip**: Die Kollisionsprüfung erfolgt dynamisch zur Laufzeit basierend auf den Viewport-Dimensionen.

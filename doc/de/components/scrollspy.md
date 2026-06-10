# Scrollspy

Aktualisiert automatisch Bootstrap-Navigations- oder Listengruppen-Komponenten basierend auf der Scrollposition, um anzuzeigen, welcher Link im Sichtbereich (Viewport) gerade aktiv ist.

## Übersicht

Die Scrollspy-Komponente wird verwendet, um Navigationslinks automatisch zu aktualisieren, basierend auf der Scrollposition eines scrollbaren Bereichs. Sie basiert auf einem `BsScrollspyController` und einem `BsScrollspy` Widget.

## Verwendung

Um Scrollspy zu verwenden, benötigst du drei Elemente:
1. Einen **Controller**: `BsScrollspyController`
2. Die **Ziel-Bereiche (Targets)**: Übergebe `GlobalKey`s an die Bereiche und registriere sie im Controller.
3. Den **Scrollspy Wrapper**: Umschließe deinen scrollbaren Bereich mit `BsScrollspy`.

### Beispiel

```dart
final scrollspyController = BsScrollspyController();
final key1 = GlobalKey();
final key2 = GlobalKey();

@override
void initState() {
  super.initState();
  scrollspyController.registerTarget('section1', key1);
  scrollspyController.registerTarget('section2', key2);
}

// In deiner build-Methode:
BsScrollspy(
  controller: scrollspyController,
  child: SingleChildScrollView(
    controller: scrollspyController.scrollController,
    child: Column(
      children: [
        Container(key: key1, child: Text('Section 1')),
        Container(key: key2, child: Text('Section 2')),
      ],
    ),
  ),
);
```

Du kannst dann auf `scrollspyController` hören (z. B. in einem `AnimatedBuilder`), um die aktiven Status deiner `BsNav` oder `BsListGroup` zu aktualisieren.

## Eigenschaften

### BsScrollspy
| Eigenschaft | Typ | Beschreibung |
|---|---|---|
| `controller` | `BsScrollspyController` | Der Controller, der die Ziele und die Scrollposition verwaltet. |
| `child` | `Widget` | Der scrollbare Inhalt. Stelle sicher, dass er `controller.scrollController` verwendet. |
| `activationMargin` | `double` | Der vertikale Abstand von oben, um ein Ziel als aktiv zu betrachten. Standard ist `50.0`. |

### BsScrollspyController
* `activeTargetId`: Gibt die ID des aktuell aktiven Ziels zurück.
* `registerTarget(String id, GlobalKey key)`: Registriert einen Bereich zur Verfolgung.
* `scrollToTarget(String id, {bool smooth = true})`: Scrollt zum angegebenen Ziel.

## Hinweise und Einschränkungen
* **Lazy Loading**: Da Scrollspy die Position von gerenderten Widgets messen muss, funktioniert es am besten mit `SingleChildScrollView` oder `ListView` ohne Lazy Loading für die verfolgten Ziele. Bei Verwendung eines großen `ListView.builder` haben die Schlüssel von noch nicht erstellten Elementen keinen `currentContext`, wodurch Scrollspy sie nicht verfolgen kann.

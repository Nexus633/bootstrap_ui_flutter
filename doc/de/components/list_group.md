# Listengruppe (List Group)

## Vorschau

![Vorschau](../../assets/ListGroup.png)

Listengruppen (`BsListGroup`) sind flexible Komponenten zur Anzeige einer Reihe von Inhalten. Sie können für einfache Listen, verlinkte Listen, Buttons oder komplexe benutzerdefinierte Layouts verwendet werden.

## Verwendung

### Standard-Liste

```dart
BsListGroup(
  children: [
    BsListGroupItem(child: Text('Erstes Element')),
    BsListGroupItem(child: Text('Zweites Element')),
    BsListGroupItem(child: Text('Drittes Element')),
  ],
)
```

### Aktive und deaktivierte Elemente

```dart
BsListGroup(
  children: [
    BsListGroupItem(
      active: true,
      child: Text('Ein aktives Element'),
    ),
    BsListGroupItem(child: Text('Standard-Element')),
    BsListGroupItem(
      disabled: true,
      child: Text('Ein deaktiviertes Element'),
    ),
  ],
)
```

### Interaktive Elemente (Links/Buttons)
Wenn `onPressed` bereitgestellt wird, verhält sich das Element wie eine Schaltfläche mit Hover-Effekten und einem entsprechenden Mauszeiger.

```dart
BsListGroup(
  children: [
    BsListGroupItem(
      child: Text('Klickbares Element 1'),
      onPressed: () => print('Element 1 geklickt'),
    ),
    BsListGroupItem(
      child: Text('Klickbares Element 2'),
      onPressed: () => print('Element 2 geklickt'),
    ),
  ],
)
```

### Rahmenlos (Flush)
Entfernt äußere Rahmen und abgerundete Ecken, um Listengruppen bündig in anderen Containern (z. B. Cards) zu rendern (analog zu Bootstraps `.list-group-flush`).

```dart
BsListGroup(
  flush: true,
  children: [
    BsListGroupItem(child: Text('Bündiges Element 1')),
    BsListGroupItem(child: Text('Bündiges Element 2')),
  ],
)
```

### Nummerierte Listen

```dart
BsListGroup(
  numbered: true,
  children: [
    BsListGroupItem(child: Text('Erster Punkt')),
    BsListGroupItem(child: Text('Zweiter Punkt')),
  ],
)
```

### Horizontale Ausrichtung
Mit `horizontal: true` werden die Elemente nebeneinander statt untereinander dargestellt.

```dart
BsListGroup(
  horizontal: true,
  children: [
    BsListGroupItem(child: Text('Links')),
    BsListGroupItem(child: Text('Mitte')),
    BsListGroupItem(child: Text('Rechts')),
  ],
)
```

### Farbvarianten (Contextual Variants)

```dart
BsListGroup(
  children: [
    BsListGroupItem(
      variant: BsListGroupItemVariant.primary,
      child: Text('Primäres Element'),
    ),
    BsListGroupItem(
      variant: BsListGroupItemVariant.success,
      child: Text('Erfolgreiches Element'),
    ),
    BsListGroupItem(
      variant: BsListGroupItemVariant.danger,
      child: Text('Gefährliches Element'),
    ),
  ],
)
```

## Eigenschaften

### BsListGroup

| Eigenschaft | Typ | Standard | Beschreibung |
| :--- | :--- | :--- | :--- |
| `children` | `List<Widget>` | **Erforderlich** | Die Liste der enthaltenen Elemente (meistens `BsListGroupItem`). |
| `flush` | `bool` | `false` | Entfernt die äußeren Rahmen und Eckenradien (z.B. für Cards). |
| `numbered` | `bool` | `false` | Nummeriert die Elemente automatisch aufsteigend. |
| `horizontal` | `bool` | `false` | Richtet die Elemente horizontal statt vertikal aus. |
| `borderWidth` | `double` | `1.0` | Die Breite der Rahmenlinien. |
| `borderColor` | `Color?` | `null` | Optionale Überschreibung der Rahmenfarbe. |
| `borderRadius` | `BorderRadius?` | `null` | Optionale Überschreibung des Eckenradius der Gruppe. |

### BsListGroupItem

| Eigenschaft | Typ | Standard | Beschreibung |
| :--- | :--- | :--- | :--- |
| `child` | `Widget` | **Erforderlich** | Der Inhalt des Elements. |
| `onPressed` | `VoidCallback?` | `null` | Klick-Aktion. Macht das Element interaktiv mit Hover-Effekt. |
| `active` | `bool` | `false` | Hebt das Element farblich hervor (primäres Blau). |
| `disabled` | `bool` | `false` | Deaktiviert Interaktionen und graut das Element aus. |
| `variant` | `BsListGroupItemVariant?` | `null` | Semantische Farbvariante für das Element. |
| `padding` | `EdgeInsetsGeometry?` | `null` | Eigener Innenabstand (Standard: 16px horizontal, 12px vertikal). |

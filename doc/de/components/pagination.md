# Pagination (Seitennummerierung)

Pagination-Komponenten dienen dazu, Inhalte auf mehrere Seiten aufzuteilen und dem Benutzer das Navigieren zwischen diesen Seiten zu ermöglichen. Sie basieren auf den CSS-Klassen und dem Layout von Bootstrap 5.3.

## Verwendung

Pagination kann manuell durch die Angabe einzelner `BsPaginationItem`s oder vollautomatisch mittels des `BsPagination.automatic` Builders verwendet werden.

### 1. Manuelle Erstellung (Custom List)
Wenn du maximale Kontrolle über jedes einzelne Element (z. B. eigene Bezeichnungen, Icons, spezielle Zustände) haben möchtest.

```dart
BsPagination(
  items: [
    BsPaginationItem(
      child: Text('Zurück'),
      onPressed: () {
        // Vorherige Seite laden
      },
    ),
    BsPaginationItem(
      active: true,
      child: Text('1'),
    ),
    BsPaginationItem(
      child: Text('2'),
      onPressed: () {},
    ),
    BsPaginationItem(
      child: Text('3'),
      onPressed: () {},
    ),
    BsPaginationItem(
      child: Text('Weiter'),
      onPressed: () {},
    ),
  ],
)
```

### 2. Automatische Erstellung (Empfohlen)
Der `BsPagination.automatic` Konstruktor berechnet Seitenzahlen, Auslassungszeichen (`...`), sowie Vorherige/Nächste/Erste/Letzte Buttons vollautomatisch auf Basis der Gesamtanzahl und der aktuellen Seite.

```dart
BsPagination.automatic(
  currentPage: 5,
  totalPages: 10,
  maxVisiblePages: 5, // Maximale Anzahl an gleichzeitig angezeigten Seiten
  onPageChanged: (page) {
    setState(() {
      _currentPage = page;
    });
  },
)
```

## Größen (Sizing)

Du kannst die Größe über das `size` Attribut mit `BsSize.sm` (klein), `BsSize.md` (Standard) oder `BsSize.lg` (groß) anpassen.

```dart
BsPagination.automatic(
  currentPage: 1,
  totalPages: 5,
  size: BsSize.lg, // Große Seitennummerierung
  onPageChanged: (page) {},
)
```

## Ausrichtung (Alignment)

Pagination-Komponenten können horizontal ausgerichtet werden über das `alignment` Attribut:
- `BsPaginationAlignment.start` (Links-bündig - Standard)
- `BsPaginationAlignment.center` (Zentriert)
- `BsPaginationAlignment.end` (Rechts-bündig)

```dart
BsPagination.automatic(
  currentPage: 1,
  totalPages: 5,
  alignment: BsPaginationAlignment.center,
  onPageChanged: (page) {},
)
```

## Eigenschaften

### BsPagination

| Eigenschaft | Typ | Standardwert | Beschreibung |
| --- | --- | --- | --- |
| `items` | `List<BsPaginationItem>` | - | Die Liste der Pagination-Elemente, die angezeigt werden. |
| `size` | `BsSize` | `BsSize.md` | Die Größe der Pagination-Buttons (`sm`, `md`, `lg`). |
| `alignment` | `BsPaginationAlignment` | `BsPaginationAlignment.start` | Die horizontale Ausrichtung (`start`, `center`, `end`). |
| `activeVariant` | `BsVariant?` | `null` | Theme-Farbe für den Hintergrund im aktiven Zustand. |
| `activeColor` | `Color?` | `null` | Custom Hintergrundfarbe für den aktiven Zustand (überschreibt `activeVariant`). |
| `activeTextColor` | `Color?` | `null` | Custom Textfarbe für den aktiven Zustand. |
| `textColor` | `Color?` | `null` | Custom Textfarbe für den normalen Zustand. |
| `hoverTextColor` | `Color?` | `null` | Custom Textfarbe für den Hover-Zustand. |
| `bgColor` | `Color?` | `null` | Custom Hintergrundfarbe für den normalen Zustand. |
| `hoverBgColor` | `Color?` | `null` | Custom Hintergrundfarbe für den Hover-Zustand. |
| `borderColor` | `Color?` | `null` | Custom Rahmenfarbe. |

### BsPagination.automatic (Zusatzparameter)

| Eigenschaft | Typ | Standardwert | Beschreibung |
| --- | --- | --- | --- |
| `currentPage` | `int` | - | Die aktuell aktive Seite (1-basiert). |
| `totalPages` | `int` | - | Die Gesamtanzahl der Seiten. |
| `onPageChanged` | `ValueChanged<int>` | - | Callback, der ausgelöst wird, wenn eine Seitenzahl angeklickt wird. |
| `maxVisiblePages` | `int` | `5` | Maximale Anzahl an Seitenzahlen, die im Schiebefenster angezeigt werden. |
| `showFirstLast` | `bool` | `true` | Zeigt Knöpfe zum direkten Springen zur ersten und letzten Seite an. |
| `showPrevNext` | `bool` | `true` | Zeigt Knöpfe für Vorherige und Nächste Seite an. |
| `firstLabel` | `Widget?` | Icons.chevronDoubleLeft | Custom Widget für den "Erste Seite"-Button. |
| `prevLabel` | `Widget?` | Icons.chevronLeft | Custom Widget für den "Vorherige Seite"-Button. |
| `nextLabel` | `Widget?` | Icons.chevronRight | Custom Widget für den "Nächste Seite"-Button. |
| `lastLabel` | `Widget?` | Icons.chevronDoubleRight | Custom Widget für den "Letzte Seite"-Button. |
| `activeVariant` | `BsVariant?` | `null` | Theme-Farbe für den aktiven Zustand. |
| `activeColor` | `Color?` | `null` | Custom aktive Hintergrundfarbe. |
| `activeTextColor` | `Color?` | `null` | Custom aktive Textfarbe. |
| `textColor` | `Color?` | `null` | Custom Textfarbe. |
| `hoverTextColor` | `Color?` | `null` | Custom Hover-Textfarbe. |
| `bgColor` | `Color?` | `null` | Custom Hintergrundfarbe. |
| `hoverBgColor` | `Color?` | `null` | Custom Hover-Hintergrundfarbe. |
| `borderColor` | `Color?` | `null` | Custom Rahmenfarbe. |

### BsPaginationItem

| Eigenschaft | Typ | Standardwert | Beschreibung |
| --- | --- | --- | --- |
| `child` | `Widget` | - | Das Widget, das innerhalb des Buttons angezeigt wird (z. B. `Text` oder `Icon`). |
| `active` | `bool` | `false` | Gibt an, ob dieses Element die aktive Seite darstellt (wird blau/hervorgehoben dargestellt). |
| `disabled` | `bool` | `false` | Deaktiviert das Element (grau dargestellt, nicht anklickbar). |
| `onPressed` | `VoidCallback?` | `null` | Callback, der beim Tippen auf das Element aufgerufen wird. |
| `activeVariant` | `BsVariant?` | `null` | Einzeln überschriebene Theme-Farbe für aktiven Zustand. |
| `activeColor` | `Color?` | `null` | Einzeln überschriebene aktive Hintergrundfarbe. |
| `activeTextColor` | `Color?` | `null` | Einzeln überschriebene aktive Textfarbe. |
| `textColor` | `Color?` | `null` | Einzeln überschriebene Textfarbe. |
| `hoverTextColor` | `Color?` | `null` | Einzeln überschriebene Hover-Textfarbe. |
| `bgColor` | `Color?` | `null` | Einzeln überschriebene Hintergrundfarbe. |
| `hoverBgColor` | `Color?` | `null` | Einzeln überschriebene Hover-Hintergrundfarbe. |
| `borderColor` | `Color?` | `null` | Einzeln überschriebene Rahmenfarbe. |

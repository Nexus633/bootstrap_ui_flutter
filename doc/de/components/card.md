# Karte (Card)

Das `BsCard`-Widget ist ein flexibler und erweiterbarer Inhaltscontainer. Es unterstützt Kopfzeilen (Header), Fußzeilen (Footer), Hauptinhalte (Body), Bilder (oben, unten, links, rechts, Overlay), Farbvarianten und anpassbare Layouts.

## Verwendung

### Einfache Karte (Verwendung der `children`-Liste)
```dart
BsCard(
  body: BsCardBody(
    children: [
      BsCardTitle('Kartentitel'),
      BsCardSubtitle('Karten-Untertitel'),
      Text('Ein kurzer Beispieltext, der den Kartentitel ergänzt.'),
      SizedBox(height: 16),
      BsButton(
        label: 'Weiterlesen',
        onPressed: () {},
      ),
    ],
  ),
)
```

### Mit Kopf- und Fußzeile (Header & Footer)
```dart
BsCard(
  header: BsCardHeader(child: Text('Hervorgehoben')),
  body: BsCardBody(
    children: [
      BsCardTitle('Spezielle Titelbehandlung'),
      Text('Unterstützender Text als natürliche Einleitung für zusätzliche Inhalte.'),
    ],
  ),
  footer: BsCardFooter(child: Text('Vor 2 Tagen')),
)
```

### Mit Bild (With Image)
```dart
BsCard(
  image: Image.network('https://picsum.photos/300/200'),
  imagePosition: BsCardImagePosition.top,
  body: BsCardBody(
    children: [
      BsCardTitle('Karte mit Bild oben'),
      Text('Diese Karte hat ein Bild an der Oberseite.'),
    ],
  ),
)
```

### Horizontales Layout (Horizontal Layout)
```dart
BsCard(
  image: Image.network('https://picsum.photos/300/200', fit: BoxFit.cover),
  imagePosition: BsCardImagePosition.left,
  imageFlex: 4,
  contentFlex: 8,
  body: BsCardBody(
    children: [
      BsCardTitle('Horizontale Karte'),
      Text('Diese Karte zeigt das Bild links und den Inhalt rechts.'),
    ],
  ),
)
```

### Farb- und Rahmenvarianten (Color & Border Variants)
```dart
// Farbiger Hintergrund und passender Textkontrast
BsCard(
  variant: BsCardVariant.primary,
  body: BsCardBody(
    children: [
      BsCardTitle('Primäre Karte'),
      Text('Diese Karte nutzt den primären Hintergrund und Textkontrast.'),
    ],
  ),
)

// Nur farbiger Rahmen (Border Variant)
BsCard(
  borderVariant: BsCardVariant.danger,
  body: BsCardBody(
    children: [
      BsCardTitle('Rote Rahmen-Karte'),
      Text('Diese Karte hat eine rote Rahmenlinie.'),
    ],
  ),
)
```

### Kartengruppen (Card Groups)
Kartengruppen (`BsCardGroup`) verbinden mehrere Karten nahtlos miteinander und sorgen für gleiche Breiten und Höhen.
```dart
BsCardGroup(
  children: [
    BsCard(
      body: BsCardBody(
        children: [
          BsCardTitle('Karte 1'),
          Text('Erster Karteninhalt in einer horizontalen Kartengruppe.'),
        ],
      ),
    ),
    BsCard(
      body: BsCardBody(
        children: [
          BsCardTitle('Karte 2'),
          Text('Zweiter Karteninhalt.'),
        ],
      ),
    ),
  ],
)
```

## Eigenschaften

### `BsCard`

| Eigenschaft | Typ | Standard | Beschreibung |
| :--- | :--- | :--- | :--- |
| `header` | `Widget?` | `null` | Optionales Kopfzeilen-Widget (typischerweise `BsCardHeader`). |
| `body` | `Widget?` | `null` | Optionales Hauptinhalts-Widget (typischerweise `BsCardBody`). |
| `footer` | `Widget?` | `null` | Optionales Fußzeilen-Widget (typischerweise `BsCardFooter`). |
| `children` | `List<Widget>?` | `null` | Überschreibt Einzel-Layoutparameter für einen vertikalen Stapel (Column). |
| `image` | `Widget?` | `null` | Anzuzeigendes Bild-Widget. |
| `imagePosition` | `BsCardImagePosition` | `BsCardImagePosition.top` | Position des Bildes (top, bottom, left, right, overlay). |
| `imageFlex` | `int` | `4` | Flex-Verhältnis für horizontales Bild. |
| `contentFlex` | `int` | `8` | Flex-Verhältnis für horizontalen Inhalt. |
| `variant` | `BsCardVariant?` | `null` | Hintergrund- und Schriftfarbvariante (`.text-bg-*`). |
| `borderVariant` | `BsCardVariant?` | `null` | Rahmenfarbvariante (`.border-*`). |
| `color` | `Color?` | `null` | Eigene Hintergrundfarbe (überschreibt `variant`). |
| `borderColor` | `Color?` | `null` | Eigene Rahmenfarbe (überschreibt `borderVariant`). |
| `borderRadius` | `BorderRadius?` | `null` | Eigener Eckenradius (standardmäßig `BsRadius.md` = 6px). |
| `width` | `double?` | `null` | Eigene Breite. |
| `height` | `double?` | `null` | Eigene Höhe. |

### `BsCardBody`

| Eigenschaft | Typ | Standard | Beschreibung |
| :--- | :--- | :--- | :--- |
| `child` | `Widget?` | `null` | Einzelnes Kind-Widget. |
| `children` | `List<Widget>?` | `null` | Eine Liste von Elementen, die vertikal in einer Spalte (Column) angeordnet werden. |
| `padding` | `EdgeInsetsGeometry?` | `BsSpacing.s3` (16px) | Eigener Innenabstand (Padding) des Bodys. |

### `BsCardGroup`

| Eigenschaft | Typ | Standard | Beschreibung |
| :--- | :--- | :--- | :--- |
| `children` | `List<BsCard>` | **Erforderlich** | Die Liste der zu gruppierenden Karten. |
| `vertical` | `bool` | `false` | Falls true, werden die Karten vertikal statt horizontal gestapelt. |

# Image

Bilder-Komponente zur Nachbildung der Bootstrap 5 Image-Funktionalitäten.

## Zweck
`BsImage` bietet eine einfache Möglichkeit, Bilder mit Bootstrap-typischen Stylings wie Responsivität, Thumbnails, abgerundeten Ecken und Ausrichtungen zu versehen.

## Eigenschaften

| Eigenschaft | Typ | Standard | Beschreibung |
| :--- | :--- | :--- | :--- |
| `image` | `ImageProvider` | *Pflicht* | Das anzuzeigende Bild. |
| `fluid` | `bool` | `false` | Wenn `true`, passt sich das Bild der Breite des Elternelements an (max-width: 100%). |
| `thumbnail` | `bool` | `false` | Fügt einen 1px Rahmen, Padding und abgerundete Ecken hinzu. |
| `rounded` | `bool` | `false` | Rundet die Ecken des Bildes ab. |
| `circle` | `bool` | `false` | Macht das Bild kreisförmig. |
| `alignment` | `AlignmentGeometry?` | `null` | Richtet das Bild im Elternelement aus (z.B. links, rechts, zentriert). |
| `width` | `double?` | `null` | Optionale feste Breite. |
| `height` | `double?` | `null` | Optionale feste Höhe. |
| `fit` | `BoxFit?` | `null` | Bestimmt, wie das Bild in seinen Container eingepasst wird. |
| `semanticLabel` | `String?` | `null` | Barrierefreiheitsbeschreibung für das Bild. |

## Verwendung

### Responsive Bilder
Bilder werden mit der `fluid` Eigenschaft responsiv gemacht.

```dart
BsImage(
  image: AssetImage('assets/img.jpg'),
  fluid: true,
)
```

### Thumbnails
Verwende `thumbnail: true`, um dem Bild das typische Bootstrap-Thumbnail-Aussehen zu geben.

```dart
BsImage.network(
  'https://example.com/image.jpg',
  thumbnail: true,
)
```

### Abgerundete Ecken und Kreise

```dart
// Abgerundete Ecken
BsImage(
  image: NetworkImage(...),
  rounded: true,
)

// Kreisförmig
BsImage(
  image: NetworkImage(...),
  circle: true,
)
```

### Ausrichtung
Verwende die `alignment` Eigenschaft zur Positionierung.

```dart
BsImage(
  image: NetworkImage(...),
  alignment: Alignment.center, // Zentriert
)
```

## Besonderheiten
- `thumbnail` überschreibt `rounded`, da Thumbnails bereits abgerundete Ecken besitzen.
- `circle` hat Vorrang vor `rounded`.

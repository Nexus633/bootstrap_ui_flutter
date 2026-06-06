# Karussell (Carousel)

Eine Slideshow-Komponente zum Durchlaufen von Elementen (wie Bildern oder benutzerdefinierten Inhalten) mit Unterstützung für Steuerelemente (Controls), Indikatoren, Beschriftungen (Captions), automatischem Durchlauf mit individuellen Intervallen, Übergangseffekten (Slide/Fade), dunkler Variante (Dark Theme) und Wischgesten (Touch).

## Verwendung

```dart
BsCarousel(
  autoplay: true,
  defaultInterval: Duration(seconds: 5),
  controls: true,
  indicators: true,
  items: [
    BsCarouselItem(
      caption: BsCarouselCaption(
        title: Text('Erster Slide'),
        description: Text('Beschreibungsinhalt des ersten Slides.'),
      ),
      child: Image.network('https://picsum.photos/id/10/800/400', fit: BoxFit.cover),
    ),
    BsCarouselItem(
      interval: Duration(seconds: 10), // custom 10s Intervall für diesen Slide
      caption: BsCarouselCaption(
        title: Text('Zweiter Slide'),
      ),
      child: Image.network('https://picsum.photos/id/11/800/400', fit: BoxFit.cover),
    ),
  ],
)
```

## Eigenschaften

### BsCarousel

| Eigenschaft | Typ | Standard | Beschreibung |
| :--- | :--- | :--- | :--- |
| `items` | `List<BsCarouselItem>` | **Erforderlich** | Die Liste der anzuzeigenden Slides. Muss mindestens 1 Element enthalten. |
| `autoplay` | `bool` | `true` | Bestimmt, ob die Slideshow automatisch durchlaufen soll. |
| `defaultInterval` | `Duration` | `Duration(seconds: 5)` | Das Standard-Intervall zwischen den Slides beim automatischen Durchlauf. |
| `controls` | `bool` | `true` | Bestimmt, ob die Navigationspfeile (Zurück/Weiter) angezeigt werden. |
| `indicators` | `bool` | `true` | Bestimmt, ob die Indikator-Balken unten angezeigt werden. |
| `fade` | `bool` | `false` | Verwendet einen weichen Überblendeffekt (Fade) anstelle der standardmäßigen horizontalen Wischbewegung. |
| `pauseOnHover` | `bool` | `true` | Pausiert den automatischen Durchlauf, wenn der Benutzer mit der Maus über das Karussell fährt. |
| `touch` | `bool` | `true` | Aktiviert Wischgesten für die Navigation auf Touch-Geräten. |
| `dark` | `bool` | `false` | Wendet das dunkle Farbschema (`.carousel-dark`) an, um Pfeile, Indikatoren und Texte auf hellen Hintergründen lesbar zu machen. |
| `height` | `double?` | `300.0` (falls beide null) | Eine feste Höhe für das Karussell. |
| `aspectRatio` | `double?` | `null` | Ein Seitenverhältnis zur dynamischen Größenbeschränkung. Umhüllt das Karussell in ein `AspectRatio`-Widget. |
| `initialIndex` | `int` | `0` | Der Index des anfänglich anzuzeigenden Slides. |
| `onSlideChanged` | `ValueChanged<int>?` | `null` | Callback, das ausgelöst wird, wenn sich der aktive Slide ändert. |

### BsCarouselItem

| Eigenschaft | Typ | Standard | Beschreibung |
| :--- | :--- | :--- | :--- |
| `child` | `Widget` | **Erforderlich** | Der Inhalt des Slides (normalerweise ein Bild). |
| `interval` | `Duration?` | `null` | Ein benutzerdefiniertes Intervall für diesen spezifischen Slide. Überschreibt das Standard-Intervall. |
| `caption` | `BsCarouselCaption?` | `null` | Eine optionale Beschriftung für diesen Slide. |

### BsCarouselCaption

| Eigenschaft | Typ | Standard | Beschreibung |
| :--- | :--- | :--- | :--- |
| `title` | `Widget?` | `null` | Ein optionaler Titel (meistens eine Überschrift). |
| `description` | `Widget?` | `null` | Eine optionale Beschreibung. |
| `color` | `Color?` | `null` | Textfarbe für die Beschriftung. Standardmäßig weiß (oder dunkelgrau im Dark-Modus). |
| `alignment` | `AlignmentGeometry` | `Alignment.bottomCenter` | Ausrichtung der Beschriftung im Slide. |

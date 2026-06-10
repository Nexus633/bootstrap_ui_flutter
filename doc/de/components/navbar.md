# Navigationsleiste (Navbar)

Die Navigationsleiste (`BsNavbar`) ist ein responsiver Header-Container für die Navigation in deiner Anwendung. Sie unterstützt Branding (Logos), Links, Toggler-Buttons für mobile Ansichten, Formulare und Text-Elemente.

## Features

- **Responsive Breakpoints**: Entsprechend Bootstrap 5.3 kann gesteuert werden, ab welchem Breakpoint die Navbar expandiert (`expand`): `always`, `sm`, `md`, `lg` (Standard), `xl`, `xxl` oder `never`.
- **Eingebauter Toggler & Collapse**: Auf kleineren Bildschirmen wird automatisch ein Hamburger-Menü (`BsNavbarToggler`) gerendert, welches über ein sanftes Einklappverhalten (`BsNavbarCollapse`) verfügt.
- **Farbschemata**: Unterstützung für ein helles (Standard) oder dunkles (`dark: true`) Farbschema, das Texte und Symbole optimal an den Hintergrund anpasst.
- **Styling für Navigationslinks**: `BsNavbarLink` unterstützt Hover-Effekte, aktive Zustände (`active: true`) sowie deaktivierte Zustände (`disabled: true`).
- **Unterstützte Elemente**:
  - `BsNavbarBrand`: Markenlogo oder Text (mit Klickfunktion).
  - `BsNavbarIconBrand`: Ein spezielles Widget für ein Logo-Icon, das neben oder anstelle eines Text-Brands verwendet wird. Kann auch über den Konstruktor `BsNavbarIconBrand.network` für Netzwerkbilder verwendet werden.
  - `BsNavbarNav`: Die Navigationsgruppe, die sich auf Desktop horizontal und auf Mobilgeräten vertikal anordnet.
  - `BsNavbarLink`: Einzelne Textlinks.
  - `BsNavbarText`: Fließtext für sekundäre Informationen.
  - `BsNavbarSpacer`: Ein responsiver Abstandshalter, der auf großen Bildschirmen als `Spacer` fungiert, sich aber auf Mobilgeräten ausblendet.

## Verwendung

Hier ist ein einfaches Beispiel für eine Standard-Navbar:

```dart
BsNavbar(
  expand: BsNavbarExpand.lg,
  brand: Row(
    children: [
      BsNavbarIconBrand(
        child: const Icon(Icons.code),
        onPressed: () {},
      ),
      BsNavbarBrand(
        child: const Text('MyBrand'),
        onPressed: () {},
      ),
    ],
  ),
  collapse: BsNavbarCollapse(
    children: [
      BsNavbarNav(
        children: [
          BsNavbarLink(
            label: 'Home',
            active: true,
            onPressed: () {},
          ),
          BsNavbarLink(
            label: 'Features',
            onPressed: () {},
          ),
          BsNavbarLink(
            label: 'Disabled',
            disabled: true,
          ),
        ],
      ),
      const BsNavbarSpacer(),
      const BsNavbarText(
        child: Text('Version 1.0.0'),
      ),
    ],
  ),
)
```

## Eigenschaften

### BsNavbar

| Eigenschaft | Typ | Standard | Beschreibung |
| :--- | :--- | :--- | :--- |
| `brand` | `Widget?` | `null` | Die Marken-Komponente (meistens `BsNavbarBrand`). |
| `collapse` | `BsNavbarCollapse?` | `null` | Der kollabierbare Inhaltsbereich (meistens `BsNavbarCollapse`). |
| `expand` | `BsNavbarExpand` | `BsNavbarExpand.lg` | Der Breakpoint, ab dem sich das Menü horizontal ausbreitet (`always`, `sm`, `md`, `lg`, `xl`, `xxl`, `never`). |
| `dark` | `bool` | `false` | Falls `true`, wird die Navbar für dunkle Hintergründe optimiert (weißer Text/Icons). |
| `background` | `Color?` | `null` | Eigene Hintergrundfarbe. Standardmäßig abhängig vom Theme. |
| `padding` | `EdgeInsetsGeometry` | `symmetric(horizontal: 16, vertical: 8)` | Die Innenabstände der Navbar. |

### BsNavbarBrand

| Eigenschaft | Typ | Standard | Beschreibung |
| :--- | :--- | :--- | :--- |
| `child` | `Widget` | *erforderlich* | Das Marken-Widget (z.B. Text oder ein Logo). |
| `onPressed` | `VoidCallback?` | `null` | Aktion beim Antippen des Brands. |
| `variant` | `BsNavbarLinkVariant?` | `null` | Die Farbvariante für den Brand-Text. |
| `color` | `Color?` | `null` | Benutzerdefinierte Farbe für den Brand-Text. |

### BsNavbarIconBrand.network

| Eigenschaft | Typ | Standard | Beschreibung |
| :--- | :--- | :--- | :--- |
| `src` | `String` | *erforderlich* | Die URL des Netzwerkbildes. |
| `onPressed` | `VoidCallback?` | `null` | Aktion beim Antippen des Logos. |
| `color` | `Color?` | `null` | Eigene Farbe (falls anwendbar). |
| `size` | `double` | `24.0` | Standardgröße des Logos. |
| `padding` | `EdgeInsetsGeometry` | `only(right: 8.0)` | Abstand um das Logo. |
| `width` | `double?` | `size` | Breite des Logos (überschreibt Standardgröße). |
| `height` | `double?` | `size` | Höhe des Logos (überschreibt Standardgröße). |
| `fit` | `BoxFit?` | `null` | Skalierungsmodus des Bildes. |
| `semanticLabel` | `String?` | `null` | Barrierefreiheit-Label für Screenreader. |
| `errorBuilder` | `ImageErrorWidgetBuilder?` | `null` | Eigener Builder bei Fehlern beim Laden des Bildes. Standardmäßig wird ein broken-image Icon angezeigt. |

### BsNavbarIconBrand

| Eigenschaft | Typ | Standard | Beschreibung |
| :--- | :--- | :--- | :--- |
| `child` | `Widget` | *erforderlich* | Das anzuzeigende Icon oder Bild. |
| `onPressed` | `VoidCallback?` | `null` | Aktion beim Antippen des Icons. |
| `color` | `Color?` | `null` | Benutzerdefinierte Farbe für das Icon (überschreibt Standardfarben). |
| `size` | `double` | `24.0` | Größe des Icons. |
| `padding` | `EdgeInsetsGeometry` | `only(right: 8.0)` | Abstand um das Icon-Brand (standardmäßig 8px rechts, für Abstand zum Text). |

### BsNavbarLink

| Eigenschaft | Typ | Standard | Beschreibung |
| :--- | :--- | :--- | :--- |
| `label` | `String` | *erforderlich* | Der Anzeigetext des Navigationslinks. |
| `onPressed` | `VoidCallback?` | `null` | Aktion beim Klicken auf den Link. |
| `active` | `bool` | `false` | Ob der Link als aktuell aktiv dargestellt wird (fettere Schrift und stärkere Farbe). |
| `disabled` | `bool` | `false` | Ob der Link deaktiviert ist (ausgegraut und nicht klickbar). |
| `variant` | `BsNavbarLinkVariant?` | `null` | Die Farbvariante für den Link-Text. |
| `color` | `Color?` | `null` | Benutzerdefinierte Farbe für den Link-Text. |

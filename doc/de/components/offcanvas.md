# Offcanvas-Seitenteile (Offcanvas)

Offcanvas-Seitenteile ([`BsOffcanvas`](file:///E:/FlutterProjects/bootstrap_ui_flutter/lib/ui/components/offcanvas/bs_offcanvas.dart) und [`showBsOffcanvas`](file:///E:/FlutterProjects/bootstrap_ui_flutter/lib/ui/components/offcanvas/bs_offcanvas.dart#L282)) sind flexible Container, die sich von den Bildschirmrändern (links, rechts, oben oder unten) hereinschieben. Sie eignen sich ideal für Navigationen, Einkaufswagen, Filter-Panels oder zusätzliche Informationen.

## Features

- **Freie Platzierung**:
  - `start`: Schiebt sich vom linken Bildschirmrand herein (Standard).
  - `end`: Schiebt sich vom rechten Bildschirmrand herein.
  - `top`: Schiebt sich vom oberen Bildschirmrand herein.
  - `bottom`: Schiebt sich vom unteren Bildschirmrand herein.
- **Hintergrund-Verhalten (Backdrop)**:
  - `enabled`: Ein Klick auf den Hintergrund schließt das Offcanvas.
  - `static`: Klicks auf den Hintergrund schließen das Offcanvas nicht. Stattdessen wird eine Puls-Animation ausgelöst.
  - `disabled`: Kein Hintergrund-Overlay sichtbar.
- **Tastatur-Support**: Drücken von `Escape` schließt das Offcanvas automatisch (wenn aktiviert).
- **Inline / Standalone Support**: Das [`BsOffcanvas`](file:///E:/FlutterProjects/bootstrap_ui_flutter/lib/ui/components/offcanvas/bs_offcanvas.dart)-Widget kann direkt in einem `Stack` im normalen Widget-Tree gerendert werden, um statische Sidebars oder In-App Panels zu erzeugen.

## Verwendung

Offcanvas-Dialoge werden typischerweise über die Methode [`showBsOffcanvas`](file:///E:/FlutterProjects/bootstrap_ui_flutter/lib/ui/components/offcanvas/bs_offcanvas.dart#L282) aufgerufen:

```dart
showBsOffcanvas(
  context: context,
  placement: BsOffcanvasPlacement.start,
  backdrop: BsOffcanvasBackdrop.enabled,
  keyboard: true,
  builder: (context) => BsOffcanvas(
    placement: BsOffcanvasPlacement.start,
    header: const BsOffcanvasHeader(
      child: Text('Navigation'),
    ),
    body: BsOffcanvasBody(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Inhalt des Seitenteils...'),
        ],
      ),
    ),
  ),
);
```

## Eigenschaften

### [BsOffcanvas](file:///E:/FlutterProjects/bootstrap_ui_flutter/lib/ui/components/offcanvas/bs_offcanvas.dart)

| Eigenschaft | Typ | Standard | Beschreibung |
| :--- | :--- | :--- | :--- |
| `body` | `Widget` | *erforderlich* | Der primäre Inhaltsbereich des Panels (meist [`BsOffcanvasBody`](file:///E:/FlutterProjects/bootstrap_ui_flutter/lib/ui/components/offcanvas/bs_offcanvas.dart#L168)). |
| `header` | `BsOffcanvasHeader?` | `null` | Der Kopfbereich des Panels (meist [`BsOffcanvasHeader`](file:///E:/FlutterProjects/bootstrap_ui_flutter/lib/ui/components/offcanvas/bs_offcanvas.dart#L108)). |
| `placement` | `BsOffcanvasPlacement` | `BsOffcanvasPlacement.start` | Die Platzierungskante (`start`, `end`, `top`, `bottom`). |
| `width` | `double?` | `400.0` | Die Breite des Panels (nur bei `start` / `end`). Begrenzt auf die Bildschirmbreite. |
| `height` | `double?` | `300.0` | Die Höhe des Panels (nur bei `top` / `bottom`). Begrenzt auf die Bildschirmhöhe. |
| `variant` | `BsOffcanvasVariant?` | `null` | Farbvariante des Panels (entspricht Bootstrap `.text-bg-*`). |
| `color` | `Color?` | `null` | Benutzerdefinierte Hintergrundfarbe. Überschreibt `variant`. |


### [BsOffcanvasHeader](file:///E:/FlutterProjects/bootstrap_ui_flutter/lib/ui/components/offcanvas/bs_offcanvas.dart#L108)

| Eigenschaft | Typ | Standard | Beschreibung |
| :--- | :--- | :--- | :--- |
| `child` | `Widget` | *erforderlich* | Der Titeltext/das Titelwidget. |
| `showCloseButton` | `bool` | `true` | Zeigt das Schließen-Symbol ([`BsCloseButton`](file:///E:/FlutterProjects/bootstrap_ui_flutter/lib/ui/components/button/bs_close_button.dart)) auf der rechten Seite an. |
| `onClosePressed` | `VoidCallback?` | `null` | Eigene Aktion beim Drücken des Schließen-Buttons. Standardmäßig schließt es das Offcanvas (`Navigator.pop`). |
| `padding` | `EdgeInsetsGeometry` | `EdgeInsets.all(16)` | Innenabstand des Headers. |

### [BsOffcanvasBody](file:///E:/FlutterProjects/bootstrap_ui_flutter/lib/ui/components/offcanvas/bs_offcanvas.dart#L168)

| Eigenschaft | Typ | Standard | Beschreibung |
| :--- | :--- | :--- | :--- |
| `child` | `Widget` | *erforderlich* | Der Inhalt des Offcanvas. |
| `padding` | `EdgeInsetsGeometry` | `EdgeInsets.all(16)` | Innenabstand des Bodys. |
| `scrollable` | `bool` | `true` | Falls `true`, wird der Inhalt automatisch scrollbar gemacht (`SingleChildScrollView`). |

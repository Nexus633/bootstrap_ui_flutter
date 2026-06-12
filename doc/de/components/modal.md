# Modaldialoge (Modals)

## Vorschau

![Vorschau](../../assets/Modals.gif)

Modaldialoge (`BsModal` und `showBsModal`) sind flexible Container, die über dem Hauptinhalt der Seite eingeblendet werden, um Benutzerbenachrichtigungen, Formulare oder benutzerdefinierte Inhalte anzuzeigen.

## Features

- **Responsive Breiten**: Entsprechend Bootstrap 5.3 stehen verschiedene Größenklassen zur Verfügung: `sm` (300px), `md` (500px, Standard), `lg` (800px), `xl` (1140px) und `fullscreen`.
- **Hintergrund-Verhalten (Backdrop)**:
  - `enabled`: Ein Klick auf den Hintergrund schließt das Modal.
  - `static`: Klicks auf den Hintergrund schließen das Modal nicht. Stattdessen wird eine elastische Puls-Animation des Modals ausgelöst.
  - `disabled`: Kein Hintergrund-Overlay sichtbar.
- **Tastatur-Support**: Drücken von `Escape` schließt das Modal automatisch (wenn aktiviert).
- **Zentrierung**: Unterstützung für vertikale Zentrierung (`centered`).
- **Scrollbares Gehäuse**: Unabhängiges Scrollen des Modal-Bodys, während Header und Footer fixiert bleiben (`scrollable`).

## Verwendung

Modaldialoge werden mit der Methode `showBsModal` aufgerufen:

```dart
showBsModal(
  context: context,
  backdrop: BsModalBackdrop.enabled, // Hintergrund-Verhalten
  keyboard: true,                    // Escape schließt Modal
  centered: true,                    // Vertikal zentrieren
  builder: (context) => BsModal(
    size: BsModalSize.md,
    header: const BsModalHeader(
      child: Text('Modal Titel'),
    ),
    body: const BsModalBody(
      child: Text('Dies ist der Inhalt des Modaldialogs.'),
    ),
    footer: BsModalFooter(
      children: [
        BsButton(
          label: 'Abbrechen',
          variant: BsButtonVariant.secondary,
          onPressed: () => Navigator.of(context).pop(),
        ),
        BsButton(
          label: 'Speichern',
          variant: BsButtonVariant.primary,
          onPressed: () {
            // Speichern-Logik
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  ),
);
```

## Eigenschaften

### BsModal

| Eigenschaft | Typ | Standard | Beschreibung |
| :--- | :--- | :--- | :--- |
| `body` | `Widget` | *erforderlich* | Der primäre Inhaltsbereich des Modals. |
| `header` | `BsModalHeader?` | `null` | Die Kopfzeile des Modals. |
| `footer` | `BsModalFooter?` | `null` | Die Fußzeile des Modals. |
| `size` | `BsModalSize` | `BsModalSize.md` | Die maximale Breite des Modals (`sm`, `md`, `lg`, `xl`, `fullscreen`). |
| `centered` | `bool` | `false` | Falls `true`, wird das Modal vertikal in der Mitte zentriert. |
| `scrollable` | `bool` | `false` | Falls `true`, scrollt nur der Body-Inhalt, während Header und Footer fixiert bleiben. |

### BsModalHeader

| Eigenschaft | Typ | Standard | Beschreibung |
| :--- | :--- | :--- | :--- |
| `child` | `Widget` | *erforderlich* | Der Titeltext/das Titelwidget. |
| `showCloseButton` | `bool` | `true` | Zeigt das Schließen-Symbol (`BsCloseButton`) auf der rechten Seite an. |
| `onClosePressed` | `VoidCallback?` | `null` | Eigene Aktion beim Drücken des Schließen-Buttons. Standardmäßig schließt es das Modal (`Navigator.pop`). |

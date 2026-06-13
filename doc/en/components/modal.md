# Modals

## Preview

![Preview](../../assets/Modals.gif)

Modals (`BsModal` and `showBsModal`) are flexible dialog prompts that overlay the main page content to display notifications, forms, or custom user interactions.

## Features

- **Responsive Widths**: Supports Bootstrap 5.3 size classes: `sm` (300px), `md` (500px, default), `lg` (800px), `xl` (1140px), and `fullscreen`.
- **Backdrop Behavior**:
  - `enabled`: Clicking the backdrop closes the modal.
  - `static`: Clicking the backdrop does not close the modal. Instead, it triggers a pulse/shake scale animation.
  - `disabled`: No backdrop overlay is visible, clicking outside has no effect.
- **Keyboard Support**: Pressing the `Escape` key automatically closes the modal (when enabled).
- **Vertical Alignment**: Supports vertical centering (`centered`).
- **Scrollable Body**: Independent scrolling of the modal body while keeping header and footer fixed in place (`scrollable`).

## Usage

Modals are displayed using the helper function `showBsModal`:

```dart
showBsModal(
  context: context,
  backdrop: .enabled, // Backdrop behavior
  keyboard: true,                    // Escape closes modal
  centered: true,                    // Vertically center modal
  builder: (context) => BsModal(
    size: .md,
    header: const BsModalHeader(
      child: Text('Modal Title'),
    ),
    body: const BsModalBody(
      child: Text('This is the content of the modal dialog.'),
    ),
    footer: BsModalFooter(
      children: [
        BsButton(
          label: 'Cancel',
          variant: .secondary,
          onPressed: () => Navigator.of(context).pop(),
        ),
        BsButton(
          label: 'Save changes',
          variant: .primary,
          onPressed: () {
            // Save changes logic
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  ),
);
```

## Properties

### BsModal

| Property | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `body` | `Widget` | *required* | The primary body content area of the modal. |
| `header` | `BsModalHeader?` | `null` | The header of the modal. |
| `footer` | `BsModalFooter?` | `null` | The footer of the modal. |
| `size` | `BsModalSize` | `.md` | The width configuration of the modal (`sm`, `md`, `lg`, `xl`, `fullscreen`). |
| `centered` | `bool` | `false` | If `true`, centers the modal vertically in the viewport. |
| `scrollable` | `bool` | `false` | If `true`, enables vertical scrolling of the body while keeping header and footer fixed. |

### BsModalHeader

| Property | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `child` | `Widget` | *required* | The title text or widget in the header. |
| `showCloseButton` | `bool` | `true` | Whether to display the close button (`BsCloseButton`) on the right. |
| `onClosePressed` | `VoidCallback?` | `null` | Custom callback when close button is pressed. Defaults to popping the modal (`Navigator.pop`). |

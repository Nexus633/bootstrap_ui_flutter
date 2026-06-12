# Offcanvas Sidebar (Offcanvas)

## Preview

![Preview](../../assets/Offcanvas.gif)

Offcanvas sidebars ([`BsOffcanvas`](file:///E:/FlutterProjects/bootstrap_ui_flutter/lib/ui/components/offcanvas/bs_offcanvas.dart) and [`showBsOffcanvas`](file:///E:/FlutterProjects/bootstrap_ui_flutter/lib/ui/components/offcanvas/bs_offcanvas.dart#L282)) are flexible containers that slide in from the edges of the viewport (left, right, top, or bottom). They are perfect for navigation, shopping carts, filter panels, or displaying supplementary details.

## Features

- **Edge Placement**:
  - `start`: Slides in from the left edge (default).
  - `end`: Slides in from the right edge.
  - `top`: Slides in from the top edge.
  - `bottom`: Slides in from the bottom edge.
- **Backdrop Overlay Behavior**:
  - `enabled`: Clicking on the backdrop closes the offcanvas.
  - `static`: Clicking on the backdrop does not close the offcanvas. Instead, it triggers a pulse/shake animation on the panel.
  - `disabled`: The backdrop overlay is completely hidden.
- **Keyboard Dismissal**: Pressing `Escape` closes the offcanvas panel automatically (when enabled).
- **Inline / Standalone Support**: The [`BsOffcanvas`](file:///E:/FlutterProjects/bootstrap_ui_flutter/lib/ui/components/offcanvas/bs_offcanvas.dart) widget can be rendered directly inside a `Stack` within the standard widget tree to build static sidebars or inline dashboard panels.

## Usage

Offcanvas dialog panels are typically opened using the [`showBsOffcanvas`](file:///E:/FlutterProjects/bootstrap_ui_flutter/lib/ui/components/offcanvas/bs_offcanvas.dart#L282) helper function:

```dart
showBsOffcanvas(
  context: context,
  placement: BsOffcanvasPlacement.start,
  backdrop: BsOffcanvasBackdrop.enabled,
  keyboard: true,
  builder: (context) => BsOffcanvas(
    placement: BsOffcanvasPlacement.start,
    header: const BsOffcanvasHeader(
      child: Text('Navigation Menu'),
    ),
    body: BsOffcanvasBody(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Sidebar menu items...'),
        ],
      ),
    ),
  ),
);
```

## Properties

### [BsOffcanvas](file:///E:/FlutterProjects/bootstrap_ui_flutter/lib/ui/components/offcanvas/bs_offcanvas.dart)

| Property | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `body` | `Widget` | *required* | The primary content area of the panel (usually [`BsOffcanvasBody`](file:///E:/FlutterProjects/bootstrap_ui_flutter/lib/ui/components/offcanvas/bs_offcanvas.dart#L168)). |
| `header` | `BsOffcanvasHeader?` | `null` | The header widget of the panel (usually [`BsOffcanvasHeader`](file:///E:/FlutterProjects/bootstrap_ui_flutter/lib/ui/components/offcanvas/bs_offcanvas.dart#L108)). |
| `placement` | `BsOffcanvasPlacement` | `BsOffcanvasPlacement.start` | The placement edge edge (`start`, `end`, `top`, `bottom`). |
| `width` | `double?` | `400.0` | The width of the panel (only applicable when `placement` is `start` or `end`). Clamped to viewport width. |
| `height` | `double?` | `300.0` | The height of the panel (only applicable when `placement` is `top` or `bottom`). Clamped to viewport height. |
| `variant` | `BsOffcanvasVariant?` | `null` | Color variant of the panel (maps to Bootstrap `.text-bg-*`). |
| `color` | `Color?` | `null` | Custom background color. Overrides `variant`. |


### [BsOffcanvasHeader](file:///E:/FlutterProjects/bootstrap_ui_flutter/lib/ui/components/offcanvas/bs_offcanvas.dart#L108)

| Property | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `child` | `Widget` | *required* | The title widget or text. |
| `showCloseButton` | `bool` | `true` | Displays the default close symbol ([`BsCloseButton`](file:///E:/FlutterProjects/bootstrap_ui_flutter/lib/ui/components/button/bs_close_button.dart)) on the right side. |
| `onClosePressed` | `VoidCallback?` | `null` | Custom callback when pressing the close button. Defaults to dismissing the panel (`Navigator.pop`). |
| `padding` | `EdgeInsetsGeometry` | `EdgeInsets.all(16)` | The internal padding of the header. |

### [BsOffcanvasBody](file:///E:/FlutterProjects/bootstrap_ui_flutter/lib/ui/components/offcanvas/bs_offcanvas.dart#L168)

| Property | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `child` | `Widget` | *required* | Content of the offcanvas body. |
| `padding` | `EdgeInsetsGeometry` | `EdgeInsets.all(16)` | The internal padding of the body. |
| `scrollable` | `bool` | `true` | If `true`, the content is wrapped in a `SingleChildScrollView` to make it scrollable. |

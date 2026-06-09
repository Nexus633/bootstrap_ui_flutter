# Popovers

Popovers are small overlay boxes that display secondary, contextual information when a user clicks or hovers over a trigger element. They behave similarly to tooltips but offer more structured layout options (e.g. bold header titles, structured list grids, or action buttons).

They are designed following Bootstrap 5.3 specifications.

## Usage

Simply wrap your trigger element (e.g. a button) with a `BsPopover` widget.

### 1. Basic Popover (Default: Click Trigger)

```dart
BsPopover(
  titleText: 'Popover Title',
  contentText: 'And here\'s some amazing content. It\'s very engaging. Right?',
  child: BsButton(
    label: 'Click to toggle popover',
    onPressed: () {},
  ),
)
```

### 2. Hover Trigger
To trigger the popover on hover, set the `trigger` parameter to `BsPopoverTrigger.hover`.

```dart
BsPopover(
  titleText: 'Hover Info',
  contentText: 'This popover opens when you hover the button.',
  trigger: BsPopoverTrigger.hover,
  child: BsButton(
    label: 'Hover over me',
    onPressed: () {},
  ),
)
```

### 3. Rich Custom Content
Popovers can accept custom widgets for headers and body contents instead of plain strings:

```dart
BsPopover(
  placement: BsPopoverPlacement.bottom,
  title: Row(
    children: [
      Icon(Icons.info, size: 16),
      SizedBox(width: 8),
      Text('Information Details'),
    ],
  ),
  content: Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('You can add custom action buttons here.'),
      SizedBox(height: 8),
      BsButton(
        label: 'Submit Action',
        size: BsButtonSize.sm,
        onPressed: () {},
      ),
    ],
  ),
  child: BsButton(
    label: 'Open Rich Popover',
    onPressed: () {},
  ),
)
```

### 4. Programmatic Control
Manage popover visibility programmatically from external buttons using a `BsPopoverController`:

```dart
final _controller = BsPopoverController();

// Inside Build:
Column(
  children: [
    BsButton(
      label: 'Toggle Popover',
      onPressed: () => _controller.toggle(),
    ),
    SizedBox(height: 16),
    BsPopover(
      controller: _controller,
      titleText: 'Controlled Popover',
      contentText: 'This is controlled programmatically.',
      child: Text('Target element'),
    ),
  ],
)
```

### 5. Custom Popovers (Theming)
You can customize the appearance of popovers using custom colors for background, border, header background, and text colors. The directional pointer arrow automatically adjusts its fill color (using the header color when pointing down from the bottom, or the body background otherwise):

```dart
BsPopover(
  titleText: 'Primary Popover',
  contentText: 'This popover uses Bootstrap\'s primary color theme.',
  backgroundColor: Colors.white,
  borderColor: theme.primary,
  headerBackgroundColor: theme.primary,
  headerTextColor: Colors.white,
  bodyTextColor: theme.primary,
  child: BsButton(
    label: 'Primary Popover',
    onPressed: () {},
  ),
)
```

## Placements

Position popovers horizontally or vertically using the `placement` attribute:
- `BsPopoverPlacement.top` (Above the element - default)
- `BsPopoverPlacement.bottom` (Below the element)
- `BsPopoverPlacement.start` (Left of the element / start)
- `BsPopoverPlacement.end` (Right of the element / end)

**Auto-Flip:** Popovers dynamically check viewport boundaries. If there is insufficient space in the selected direction, it automatically flips to the opposite direction.

## Properties

### BsPopover

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| `child` | `Widget` | - | The trigger widget that toggles the popover. |
| `title` | `Widget?` | `null` | Custom title header widget (overrides `titleText`). |
| `content` | `Widget?` | `null` | Custom content body widget (overrides `contentText`). |
| `titleText` | `String?` | `null` | Plain text label for the title header. |
| `contentText` | `String?` | `null` | Plain text label for the content body. |
| `placement` | `BsPopoverPlacement` | `BsPopoverPlacement.top` | Preferred placement direction (`top`, `bottom`, `start`, `end`). |
| `trigger` | `BsPopoverTrigger` | `BsPopoverTrigger.click` | Event that opens the popover (`click`, `hover`). |
| `controller` | `BsPopoverController?` | `null` | Optional controller for programmatic management. |
| `maxWidth` | `double` | `276.0` | Maximum width of the popover box. |
| `disabled` | `bool` | `false` | Disables popover interactions. |
| `backgroundColor` | `Color?` | `null` | Custom background color of the popover container (defaults to white or `#2b3035`). |
| `borderColor` | `Color?` | `null` | Custom border color of the popover and its arrow. |
| `headerBackgroundColor` | `Color?` | `null` | Custom background color of the header. |
| `headerTextColor` | `Color?` | `null` | Custom text color of the title header. |
| `bodyTextColor` | `Color?` | `null` | Custom text color of the content body. |

## Notes and Restrictions

* **Arrow Custom Painting**: Popovers automatically paint a small indicator arrow pointing to the trigger widget. The painter (`_ArrowPainter`) connects the arrow borders to the popover box, leaving the boundary interface open for a seamless visual appearance. It also dynamically syncs its color (matching the header background color when placement is bottom and a header is present, otherwise body background).
* **Auto-Close Tap Detector**: When using the `click` trigger, popovers display a translucent barrier behind the overlay to automatically dismiss it when the user clicks elsewhere.
* **Auto-Flip Collision Detection**: The viewport checks are computed dynamically at layout time.

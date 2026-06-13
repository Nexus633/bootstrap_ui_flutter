# Breadcrumb

## Preview

![Preview](../../assets/Breadcrumbs.png)


Indicate the current page's location within a navigational hierarchy that automatically adds separators via CSS.

## Usage

Breadcrumbs are used to show the current location within a hierarchy.

```dart
BsBreadcrumb(
  items: [
    BsBreadcrumbItem(
      label: Text('Home'),
      onPressed: () {
        // Navigate to home
      },
    ),
    BsBreadcrumbItem(
      label: Text('Library'),
      onPressed: () {
        // Navigate to library
      },
    ),
    BsBreadcrumbItem(
      label: Text('Data'),
      active: true,
    ),
  ],
)

BsBreadcrumb(
  items: [
    const Text('Home'),
    const Text('Library'),
    const Text('Data')
  ]
)
```

## Changing the Divider

The divider can be changed by providing the `divider` property to `BsBreadcrumb`. It accepts a `Widget`.

```dart
BsBreadcrumb(
  divider: const Text('>'),
  items: [...],
)

// Or with an icon
BsBreadcrumb(
  divider: Icon(Icons.chevron_right, size: 16),
  items: [...],
)
```

## Properties

### BsBreadcrumb

| Property | Type | Description |
| --- | --- | --- |
| `items` | `List<BsBreadcrumbItem>` | The list of breadcrumb items to display. |
| `divider` | `Widget?` | The divider to display between items. Defaults to "/". |

### BsBreadcrumbItem

| Property | Type | Description |
| --- | --- | --- |
| `label` | `Widget` | The label of the breadcrumb item. |
| `onPressed` | `VoidCallback?` | Callback when the item is pressed. |
| `active` | `bool` | Whether this item is the currently active page. |

# List Group

## Preview

![Preview](../../assets/ListGroup.png)

List groups (`BsListGroup`) are flexible components for displaying a series of content. They can be customized for basic list items, interactive links/buttons, contextual styles, and custom layouts.

## Usage

### Basic List

```dart
BsListGroup(
  children: [
    BsListGroupItem(child: Text('An item')),
    BsListGroupItem(child: Text('A second item')),
    BsListGroupItem(child: Text('A third item')),
  ],
)
```

### Active and Disabled Items

```dart
BsListGroup(
  children: [
    BsListGroupItem(
      active: true,
      child: Text('An active item'),
    ),
    BsListGroupItem(child: Text('A standard item')),
    BsListGroupItem(
      disabled: true,
      child: Text('A disabled item'),
    ),
  ],
)
```

### Interactive Items (Links/Buttons)
When `onPressed` is provided, the item behaves like an interactive button, featuring hover transitions and click feedback.

```dart
BsListGroup(
  children: [
    BsListGroupItem(
      child: Text('Clickable item 1'),
      onPressed: () => print('Item 1 clicked'),
    ),
    BsListGroupItem(
      child: Text('Clickable item 2'),
      onPressed: () => print('Item 2 clicked'),
    ),
  ],
)
```

### Flush Layout
Removes outer borders and rounded corners to render list group items edge-to-edge in parent containers (e.g., inside cards).

```dart
BsListGroup(
  flush: true,
  children: [
    BsListGroupItem(child: Text('Flush item 1')),
    BsListGroupItem(child: Text('Flush item 2')),
  ],
)
```

### Numbered Lists

```dart
BsListGroup(
  numbered: true,
  children: [
    BsListGroupItem(child: Text('First numbered item')),
    BsListGroupItem(child: Text('Second numbered item')),
  ],
)
```

### Horizontal Layout
Use `horizontal: true` to place list group items horizontally instead of vertically.

```dart
BsListGroup(
  horizontal: true,
  children: [
    BsListGroupItem(child: Text('Left')),
    BsListGroupItem(child: Text('Center')),
    BsListGroupItem(child: Text('Right')),
  ],
)
```

### Contextual Variants

```dart
BsListGroup(
  children: [
    BsListGroupItem(
      variant: BsListGroupItemVariant.primary,
      child: Text('Primary item'),
    ),
    BsListGroupItem(
      variant: BsListGroupItemVariant.success,
      child: Text('Success item'),
    ),
    BsListGroupItem(
      variant: BsListGroupItemVariant.danger,
      child: Text('Danger item'),
    ),
  ],
)
```

## Properties

### BsListGroup

| Property | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `children` | `List<Widget>` | **Required** | The list group items (usually `BsListGroupItem`s). |
| `flush` | `bool` | `false` | Removes outer borders and rounded corners (useful for placing in cards). |
| `numbered` | `bool` | `false` | Automatically numbers the items sequentially. |
| `horizontal` | `bool` | `false` | Sets layout horizontally instead of vertically. |
| `borderWidth` | `double` | `1.0` | The border width around and between items. |
| `borderColor` | `Color?` | `null` | Optional border color override. |
| `borderRadius` | `BorderRadius?` | `null` | Optional border radius override for the group. |

### BsListGroupItem

| Property | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `child` | `Widget` | **Required** | The content of the item. |
| `onPressed` | `VoidCallback?` | `null` | Click action. Makes the item interactive with hover feedback. |
| `active` | `bool` | `false` | Highlights the item with primary accent theme color. |
| `disabled` | `bool` | `false` | Disables user interactions and grays out the item. |
| `variant` | `BsListGroupItemVariant?` | `null` | Semantic color variant of the item. |
| `padding` | `EdgeInsetsGeometry?` | `null` | Custom padding override (default: 16px horizontal, 12px vertical). |

# Accordion

The `BsAccordion` is a component that allows content to be organized in space-saving collapsible areas.

## Usage

```dart
BsAccordion(
  items: [
    BsAccordionItem(
      title: 'First Item',
      body: Text('Content of the first item'),
    ),
    BsAccordionItem(
      title: 'Second Item',
      body: Text('Content of the second item'),
    ),
  ],
)
```

## Properties

| Property | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `items` | `List<BsAccordionItem>` | **Required** | The list of accordion items to display. |
| `alwaysOpen` | `bool` | `false` | If `true`, multiple items can be open at the same time. |
| `flush` | `bool` | `false` | If `true`, removes outer borders and rounded corners (similar to Bootstrap's `.accordion-flush`). |
| `activeColor` | `Color?` | `bsTheme.primary` | The color of the header and icon when the item is open. |
| `mouseCursor` | `MouseCursor?` | `null` | The mouse cursor when hovering over the header. |

### BsAccordionItem

| Property | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `title` | `String` | **Required** | The text in the item's header. |
| `body` | `Widget` | **Required** | The content that becomes visible when expanded. |
| `initiallyExpanded` | `bool` | `false` | Determines if the item is open on initial render. |

# Navs and Tabs

## Preview

![Preview](../../assets/Navs_Tabs.gif)

`BsNav` is a flexible navigation component built with Flexbox. It supports multiple display styles (plain links, tabs, pills, and underline), custom alignments, vertical stacked layouts, and tab content switching with a fade transition.

## Features

- **Visual Variants**:
  - `plain`: A simple list of navigation links.
  - `tabs`: Classic tabbed style with a bottom border and border overlays for active tabs.
  - `pills`: Background-highlighted links.
  - `underline`: Clean, modern underline indicator for active states.
- **Horizontal & Vertical Layouts**: Set `vertical: true` to stack navigation items vertically.
- **Flex Alignment**: Supports horizontal alignment utilities (`start`, `center`, `end`, `fill`, and `justified` for expanding items to fill the container).
- **Tab Content Panes**: Easily build switchable tab pages using `BsTabContent` and `BsTabPane` with built-in smooth fade transitions.
- **Custom Triggers**: `BsNavLink` accepts custom widgets, automatically applying theme colors to children.

## Usage

### Simple Tabbed Interface

Here is how to set up a functional tab navigation using `BsNav` and `BsTabContent`:

```dart
class MyTabbedWidget extends StatefulWidget {
  const MyTabbedWidget({super.key});

  @override
  State<MyTabbedWidget> createState() => _MyTabbedWidgetState();
}

class _MyTabbedWidgetState extends State<MyTabbedWidget> {
  int _activeTab = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BsNav(
          variant: BsNavVariant.tabs,
          children: [
            BsNavLink(
              label: 'Home',
              active: _activeTab == 0,
              onPressed: () => setState(() => _activeTab = 0),
            ),
            BsNavLink(
              label: 'Profile',
              active: _activeTab == 1,
              onPressed: () => setState(() => _activeTab = 1),
            ),
            BsNavLink(
              label: 'Contact',
              active: _activeTab == 2,
              onPressed: () => setState(() => _activeTab = 2),
            ),
            const BsNavLink(
              label: 'Disabled',
              disabled: true,
            ),
          ],
        ),
        Expanded(
          child: BsTabContent(
            activeIndex: _activeTab,
            children: const [
              BsTabPane(child: Center(child: Text('Home Content'))),
              BsTabPane(child: Center(child: Text('Profile Content'))),
              BsTabPane(child: Center(child: Text('Contact Content'))),
            ],
          ),
        ),
      ],
    );
  }
}
```

### Pills Navigation

Pills display active navigation links with solid background colors:

```dart
BsNav(
  variant: BsNavVariant.pills,
  alignment: BsNavAlignment.center,
  children: [
    BsNavLink(label: 'Active', active: true, onPressed: () {}),
    BsNavLink(label: 'Link', onPressed: () {}),
    BsNavLink(label: 'Link', onPressed: () {}),
  ],
)
```

### Underline Navigation

Underline uses bottom lines to indicate active states:

```dart
BsNav(
  variant: BsNavVariant.underline,
  children: [
    BsNavLink(label: 'Active', active: true, onPressed: () {}),
    BsNavLink(label: 'Link', onPressed: () {}),
    BsNavLink(label: 'Link', onPressed: () {}),
  ],
)
```

### Custom Link Colors

You can optionally override default link text and icon colors for both active and normal/inactive states:

```dart
BsNav(
  variant: BsNavVariant.plain,
  children: [
    BsNavLink(
      label: 'Green Link',
      color: Colors.green,
      activeColor: Colors.green,
      onPressed: () {},
    ),
    BsNavLink(
      label: 'Red Link',
      color: Colors.red,
      activeColor: Colors.red,
      onPressed: () {},
    ),
  ],
)
```

---

## Properties

### BsNav

| Property | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `children` | `List<Widget>` | *required* | The navigation items (typically [BsNavLink]s). |
| `variant` | `BsNavVariant` | `BsNavVariant.plain` | The visual variant style (`plain`, `tabs`, `pills`, `underline`). |
| `alignment` | `BsNavAlignment` | `BsNavAlignment.start` | Horizontal alignment of the links (`start`, `center`, `end`, `fill`, `justified`). |
| `vertical` | `bool` | `false` | Whether navigation items stack vertically. |
| `padding` | `EdgeInsetsGeometry` | `EdgeInsets.zero` | Padding around the nav container. |

### BsNavLink

| Property | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `label` | `String?` | `null*` | The text label to display (required if `child` is null). |
| `child` | `Widget?` | `null*` | Custom widget to display (required if `label` is null). |
| `active` | `bool` | `false` | Marks the item as active, applying highlight styles. |
| `disabled` | `bool` | `false` | Disables interaction and renders the item in a grayed-out state. |
| `onPressed` | `VoidCallback?` | `null` | Callback triggered when the item is tapped. |
| `padding` | `EdgeInsetsGeometry?` | `null` | Custom padding override. |
| `color` | `Color?` | `null` | Optional custom text/icon color in normal/inactive state. |
| `activeColor` | `Color?` | `null` | Optional custom text/icon color in active state. |

### BsTabContent

| Property | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `children` | `List<Widget>` | *required* | The list of tab pane children. |
| `activeIndex` | `int` | *required* | The index of the currently active pane. |
| `fade` | `bool` | `true` | If true, performs a smooth fade animation when tabs switch. |

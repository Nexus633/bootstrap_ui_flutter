# Dropdown

## Preview

| Dropdown Left | Dropdown Split Button | Dropdown Up |
|:---:|:---:|:---:|
| <img src="../../assets/Dropdown-1.png" width="250" alt="Dropdown Left"> | <img src="../../assets/Dropdown-2.png" width="250" alt="Dropdown Split Button"> | <img src="../../assets/Dropdown-3.png" width="250" alt="Dropdown Up"> |
| **Dropdown Right** | **Dropdown Left** | **Dropdown Alignment** |
| <img src="../../assets/Dropdown-4.png" width="250" alt="Dropdown Right"> | <img src="../../assets/Dropdown-5.png" width="250" alt="Dropdown Left"> | <img src="../../assets/Dropdown-6.png" width="250" alt="Dropdown Alignment"> |


Dropdowns are toggleable overlays that display lists of links or actions. The suite contains:
* `BsDropdown`: The main wrapper managing trigger actions and floating overlay alignment.
* `BsDropdownMenu`: The actual menu container holding items.
* `BsDropdownItem`: Selectable list actions.
* `BsDropdownHeader`: Sub-headers for grouping items.
* `BsDropdownDivider`: Thin horizontal separator lines.
* `BsDropdownText`: Plain informative text paragraphs.

---

## Usage

### Basic Dropdown
A standard dropdown can be defined simply using a `label`. It automatically renders a toggle button with a caret arrow.

```dart
BsDropdown(
  label: 'Dropdown Button',
  toggleVariant: BsButtonVariant.primary,
  menu: BsDropdownMenu(
    children: [
      BsDropdownItem(
        child: Text('Action'),
        onPressed: () => print('Action clicked'),
      ),
      BsDropdownItem(
        child: Text('Another action'),
        onPressed: () {},
      ),
      BsDropdownDivider(),
      BsDropdownItem(
        child: Text('Separated link'),
        onPressed: () {},
      ),
    ],
  ),
)
```

### Split Button Dropdown
To create double buttons where the main button triggers an action and a secondary chevron caret triggers the menu, use `toggleBuilder`.

```dart
BsDropdown(
  toggleBuilder: (context, toggleMenu, isOpen) {
    return BsButtonGroup(
      children: [
        BsButton(
          label: 'Split Button',
          onPressed: () => print('Primary Action'),
        ),
        BsButton(
          label: '',
          icon: isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
          onPressed: toggleMenu,
        ),
      ],
    );
  },
  menu: BsDropdownMenu(
    children: [
      BsDropdownItem(child: Text('Action 1'), onPressed: () {}),
      BsDropdownItem(child: Text('Action 2'), onPressed: () {}),
    ],
  ),
)
```

### Directions & Alignments
You can open dropdowns in four directions: `down` (default), `up` (dropup), `end` (dropend/right), and `start` (dropstart/left). You can also align the menu edges with the start or end of the trigger.

```dart
BsDropdown(
  direction: BsDropdownDirection.up, // Opens above
  alignment: BsDropdownAlignment.end, // Right-aligned menu
  toggle: BsButton(label: 'Dropup Right', onPressed: () {}),
  menu: BsDropdownMenu(
    children: [
      BsDropdownItem(child: Text('Item 1'), onPressed: () {}),
    ],
  ),
)
```

### Collision Detection & Auto-Flip
Dropdowns feature built-in smart boundary collision detection. If a dropdown menu would render off-screen (e.g., at the very bottom of the window), it automatically flips its opening direction (e.g., opening upwards as a Dropup). If screen space is constrained in both directions, the dropdown menu constrains its height and becomes scrollable with smooth rounded corner clipping, preventing screen overflow.

### Auto Close Behavior
Adjust how the dropdown closes when clicking inside or outside the menu:
* `always` (default): Closes on clicking outside the menu OR clicking a menu item.
* `inside`: Closes only when clicking a menu item.
* `outside`: Closes only when clicking outside the menu.
* `none`: Must be toggled manually by clicking the trigger button again.

```dart
BsDropdown(
  autoClose: BsDropdownAutoClose.outside,
  toggle: BsButton(label: 'Click outside to close', onPressed: () {}),
  menu: BsDropdownMenu(
    children: [
      BsDropdownItem(child: Text('Clicking me won\'t close'), onPressed: () {}),
    ],
  ),
)
```

### Colors & Dark Variant
By default, the dropdown menu automatically shifts its color scheme based on the application's active `ThemeMode` (Light/Dark). You can explicitly force a light/dark layout, apply semantic variants, or set custom colors.

```dart
// 1. Force Dark Mode Menu explicitly (.dropdown-menu-dark)
BsDropdownMenu(
  dark: true,
  children: [...],
)

// 2. Apply a semantic color variant
BsDropdownMenu(
  variant: BsCardVariant.success,
  children: [...],
)

// 3. Set a completely custom background color
BsDropdownMenu(
  color: Colors.purple.shade900,
  children: [...],
)
```

---

## Properties

### `BsDropdown`

| Property | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `label` | `String?` | `null` | The label text to render on the default trigger button (used if toggle/toggleBuilder are null). |
| `toggle` | `Widget?` | `null` | A custom static widget to act as the toggle trigger. |
| `toggleBuilder` | `Widget Function(BuildContext, VoidCallback, bool)?` | `null` | A custom builder giving access to the toggle action and open state (perfect for split buttons). |
| `menu` | `BsDropdownMenu` | **Required** | The overlay menu widget containing items. |
| `direction` | `BsDropdownDirection` | `BsDropdownDirection.down` | Direction the menu opens (down, up, start, end). |
| `alignment` | `BsDropdownAlignment` | `BsDropdownAlignment.start` | Menu alignment (start, end). |
| `autoClose` | `BsDropdownAutoClose` | `BsDropdownAutoClose.always` | Controls auto-closing interactions. |
| `toggleVariant` | `BsButtonVariant` | `BsButtonVariant.primary` | The color variant of the default trigger button. |
| `toggleSize` | `BsButtonSize` | `BsButtonSize.md` | The size variant of the default trigger button. |
| `showCaret` | `bool` | `true` | Whether to display the caret arrow icon on the default trigger button. |
| `disabled` | `bool` | `false` | Disables interactions if true. |

### `BsDropdownMenu`

| Property | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `children` | `List<Widget>` | **Required** | List of dropdown items, dividers, headers. |
| `dark` | `bool?` | `null` | Force dark theme (true) or light theme (false). If null, matches the active theme. |
| `variant` | `BsCardVariant?` | `null` | Semantic Bootstrap variant color to use for background/text. |
| `color` | `Color?` | `null` | Custom background color override. |
| `minWidth` | `double` | `160.0` | Minimum width constraint. |
| `padding` | `EdgeInsetsGeometry` | `EdgeInsets.symmetric(vertical: 8.0)` | Interior menu padding. |

### `BsDropdownItem`

| Property | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `child` | `Widget` | **Required** | Clickable content label. |
| `onPressed` | `VoidCallback?` | `null` | Action click callback. If null, disables the item. |
| `active` | `bool` | `false` | Marks item as selected/active (renders primary color background). |
| `disabled` | `bool` | `false` | Renders the item in a muted, non-interactive disabled state. |
| `icon` | `Widget?` | `null` | Optional leading icon. |

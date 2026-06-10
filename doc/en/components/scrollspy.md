# Scrollspy

Automatically update Bootstrap navigation or list group components based on scroll position to indicate which link is currently active in the viewport.

## Overview

The Scrollspy component is used to automatically update navigation links based on the scroll position of a scrollable area. It relies on a `BsScrollspyController` and a `BsScrollspy` widget.

## Usage

To use Scrollspy, you need three elements:
1. A **Controller**: `BsScrollspyController`
2. The **Target Sections**: Provide `GlobalKey`s to the sections and register them in the controller.
3. The **Scrollspy Wrapper**: Wrap your scrollable area with `BsScrollspy`.

### Example

```dart
final scrollspyController = BsScrollspyController();
final key1 = GlobalKey();
final key2 = GlobalKey();

@override
void initState() {
  super.initState();
  scrollspyController.registerTarget('section1', key1);
  scrollspyController.registerTarget('section2', key2);
}

// In your build method:
BsScrollspy(
  controller: scrollspyController,
  child: SingleChildScrollView(
    controller: scrollspyController.scrollController,
    child: Column(
      children: [
        Container(key: key1, child: Text('Section 1')),
        Container(key: key2, child: Text('Section 2')),
      ],
    ),
  ),
);
```

You can then listen to `scrollspyController` or use it in an `AnimatedBuilder` to update your `BsNav` or `BsListGroup` active states.

## Properties

### BsScrollspy
| Property | Type | Description |
|---|---|---|
| `controller` | `BsScrollspyController` | The controller managing the targets and scroll position. |
| `child` | `Widget` | The scrollable content. Ensure it uses `controller.scrollController`. |
| `activationMargin` | `double` | The vertical margin from the top to consider a target active. Defaults to `50.0`. |

### BsScrollspyController
* `activeTargetId`: Returns the currently active target's ID.
* `registerTarget(String id, GlobalKey key)`: Registers a section to track.
* `scrollToTarget(String id, {bool smooth = true})`: Scrolls to the specified target.

## Notes and Restrictions
* **Lazy Loading**: Since Scrollspy requires measuring the position of rendered widgets, it works best with `SingleChildScrollView` or `ListView` without lazy loading for tracked targets. If using a large `ListView.builder`, the keys of items not yet built won't have a `currentContext`, preventing Scrollspy from tracking them.

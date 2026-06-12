# Toasts

## Preview

![Preview](../../assets/Toasts.gif)

Push notifications to your visitors with a toast, a lightweight and easily customizable alert message.

## Overview

Toasts are lightweight notifications designed to mimic the push notifications that have been popularized by mobile and desktop operating systems. They’re built with flexbox, so they’re easy to align and position.

## Basic Example

To encourage extensible and predictable toasts, we recommend a header and body. Toast headers use flexbox, allowing easy alignment of content.

```dart
BsToast(
  header: BsToastHeader(
    icon: const BsIcon(BsIcons.bootstrap, color: Colors.blue),
    title: const Text('Bootstrap'),
    subtitle: const Text('11 mins ago'),
    onClose: () {},
  ),
  child: const Text('Hello, world! This is a toast message.'),
)
```

## Toast Manager

For a fully floating experience, use `BsToastManager`. It automatically handles the `Overlay` and adds smooth entrance animations and automatic dismissals.

```dart
BsToastManager.show(
  context,
  duration: const Duration(seconds: 4),
  toast: BsToast(
    header: BsToastHeader(
      title: const Text('Notification'),
      onClose: () => BsToastManager.dismissAll(),
    ),
    child: const Text('This toast will disappear in 4 seconds.'),
  ),
);
```

## Color Schemes

Like other components, toasts come with different variants:

```dart
BsToast(
  variant: BsVariant.success,
  header: BsToastHeader(
    title: const Text('Success'),
    onClose: () {},
  ),
  child: const Text('Action completed successfully.'),
)
```

# Grid System

The Bootstrap grid system is based on a 12-column layout and is fully responsive.

## Container

`BsContainer` centers content horizontally and provides standard padding.

```dart
BsContainer(
  type: BsContainerType.fixed, // or .fluid, .sm, .md, etc.
  child: MyContent(),
)
```

## Row & Col

`BsRow` and `BsCol` form the actual grid.

```dart
BsRow(
  gutterX: BsSpacing.s3,
  gutterY: BsSpacing.s3,
  children: [
    BsCol(
      config: BsColConfig(xs: 12, md: 6, lg: 4),
      child: MyWidget(),
    ),
    BsCol(
      config: BsColConfig(xs: 12, md: 6, lg: 8),
      child: AnotherWidget(),
    ),
  ],
)
```

### BsColConfig

Defines the column span per breakpoint (mobile-first).

| Breakpoint | Description |
| :--- | :--- |
| `xs` | < 576px (Default) |
| `sm` | >= 576px |
| `md` | >= 768px |
| `lg` | >= 992px |
| `xl` | >= 1200px |
| `xxl` | >= 1400px |

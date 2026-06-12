# Typography

## Preview

![Preview](../../assets/Headings.png)


The `BsHeading` widget is used to render standard heading levels from `<h1>` to `<h6>` with Bootstrap-compatible styles, including the default bottom margins and correct line heights.

## Usage

```dart
BsHeading(
  'Example Heading 1',
  level: BsHeadingLevel.h1,
)

BsHeading(
  'Example Heading 6 without margin',
  level: BsHeadingLevel.h6,
  removeMargin: true,
  color: BsColors.secondary,
)
```

## Properties

| Property | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `text` | `String` | **Required** | The heading text content. |
| `level` | `BsHeadingLevel` | `BsHeadingLevel.h1` | The heading level from `h1` (largest) to `h6` (smallest). |
| `color` | `Color?` | `null` | Custom text color. Defaults to the theme's body text color. |
| `textAlign` | `TextAlign?` | `null` | Optional horizontal alignment. **Note:** If set, the heading behaves like a block-level element and takes up `double.infinity` width. If used inside a `Row`, wrap the heading in an `Expanded` widget to avoid layout errors. |
| `removeMargin` | `bool` | `false` | If `true`, removes the default `0.5rem` (8px) bottom margin (applied via padding-bottom). |

## Blockquote

For quoting blocks of content from another source within your document. Use `BsBlockquote` and optionally include a footer citation.

```dart
BsBlockquote(
  footer: const Text('Someone famous in Source Title'),
  child: const Text('A well-known quote, contained in a blockquote element.'),
)
```

## Inline Code

Wrap inline snippets of code with `BsCode`. This styles the text in a monospace font and applies the default Bootstrap code color (pink-500).

```dart
BsCode('import bs;')
```

## User Input (KBD)

Use the `BsKbd` widget to indicate input that is typically entered via keyboard. This styles the text with a dark background, white text, rounded corners, and a monospace font.

```dart
BsKbd('cd')
BsKbd('ctrl + ,')
```
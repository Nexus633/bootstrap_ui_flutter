# Table

## Preview

| Standard Table | Striped Table | Dark Table | Borderless Table |
|:---:|:---:|:---:|:---:|
| <img src="../../assets/Tables_1.png" width="180" alt="Standard Table"> | <img src="../../assets/Tables_2.png" width="180" alt="Striped Table"> | <img src="../../assets/Tables_3.png" width="180" alt="Dark Table"> | <img src="../../assets/Tables_4.png" width="180" alt="Borderless Table"> |


Documentation and examples for opt-in styling of tables (given their prevalent use in ubiquitous widgets like calendars and date pickers).

## Features

- **Semantic Structure**: Supports `head`, `body`, and `foot` sections.
- **Contextual Variants**: Use `BsTableVariant` to color the whole table, specific rows, or individual cells.
- **Striped Rows**: Adds zebra-striping to any table row within the body.
- **Striped Columns**: Adds zebra-striping to table columns.
- **Hoverable Rows**: Enables a hover state on rows.
- **Active State**: Highlights a specific row or cell.
- **Borders**: Support for bordered and borderless variations.
- **Compact Tables**: `small` property to cut cell padding in half.
- **Captions**: Positionable captions for accessibility and description.
- **Responsive**: Horizontal scrolling for wide tables on small screens.

## Usage

```dart
BsTable(
  head: BsTableHead(
    rows: [
      BsTableRow(
        children: [
          BsTableCell.header(child: Text('#')),
          BsTableCell.header(child: Text('First')),
          BsTableCell.header(child: Text('Last')),
        ],
      ),
    ],
  ),
  children: [
    BsTableRow(
      children: [
        BsTableCell(child: Text('1')),
        BsTableCell(child: Text('Mark')),
        BsTableCell(child: Text('Otto')),
      ],
    ),
  ],
)
```

## Properties

### BsTable

| Property | Type | Description |
| :--- | :--- | :--- |
| `head` | `BsTableHead?` | Configuration for the `<thead>` section. |
| `foot` | `BsTableFoot?` | Configuration for the `<tfoot>` section. |
| `children` | `List<BsTableRow>` | The body rows of the table. |
| `variant` | `BsTableVariant?` | Base color variant for the table. |
| `striped` | `bool` | Enables zebra-striping for rows. |
| `stripedColumns` | `bool` | Enables zebra-striping for columns. |
| `hover` | `bool` | Enables hover state on rows. |
| `bordered` | `bool` | Adds borders on all sides of the table and cells. |
| `borderless` | `bool` | Removes all borders. |
| `small` | `bool` | Makes the table more compact. |
| `caption` | `Widget?` | Optional caption widget. |
| `captionTop` | `bool` | Moves the caption to the top. |
| `isResponsive` | `bool` | Enables horizontal scrolling. |
| `verticalAlign` | `BsTableVerticalAlign` | Vertical alignment for all cells. |
| `groupDivider` | `bool` | Adds a thicker border between head and body. |

### BsTableRow

| Property | Type | Description |
| :--- | :--- | :--- |
| `variant` | `BsTableVariant?` | Color variant for the row. |
| `active` | `bool` | Highlights the row. |
| `verticalAlign` | `BsTableVerticalAlign?` | Vertical alignment for cells in this row. |
| `children` | `List<BsTableCell>` | The cells in the row. |

### BsTableCell

| Property | Type | Description |
| :--- | :--- | :--- |
| `variant` | `BsTableVariant?` | Color variant for the cell. |
| `active` | `bool` | Highlights the cell. |
| `isHeader` | `bool` | Whether it is a header cell (bold text). |
| `verticalAlign` | `BsTableVerticalAlign?` | Vertical alignment for this cell. |
| `child` | `Widget` | Content of the cell. |

## Variants

Available variants: `primary`, `secondary`, `success`, `danger`, `warning`, `info`, `light`, `dark`.

```dart
BsTable(
  variant: BsTableVariant.dark,
  children: [...],
)
```

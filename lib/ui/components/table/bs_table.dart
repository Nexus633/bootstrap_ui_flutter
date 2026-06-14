import 'package:flutter/material.dart';
import '../../tokens/bootstrap_theme.dart';
import '../../tokens/enums.dart';
import '../../utilities/spacing_extension.dart';

/// A Bootstrap-style table component.
///
/// Orientated towards Bootstrap 5.3 specifications.
/// Supports semantic structuring (head, body, foot), contextual variants,
/// and all standard modifiers (striped, hover, active, bordered, borderless, small, responsive).
///
/// Example:
/// ```dart
/// BsTable(
///   head: BsTableHead(
///     rows: [
///       BsTableRow(
///         children: [
///           BsTableCell.header(child: Text('#')),
///           BsTableCell.header(child: Text('First')),
///           BsTableCell.header(child: Text('Last')),
///         ],
///       ),
///     ],
///   ),
///   children: [
///     BsTableRow(
///       children: [
///         BsTableCell(child: Text('1')),
///         BsTableCell(child: Text('Mark')),
///         BsTableCell(child: Text('Otto')),
///       ],
///     ),
///   ],
/// )
/// ```
class BsTable extends StatefulWidget {
  /// Creates a [BsTable].
  const BsTable({
    super.key,
    this.variant,
    this.striped = false,
    this.stripedColumns = false,
    this.hover = false,
    this.bordered = false,
    this.borderless = false,
    this.small = false,
    this.caption,
    this.captionTop = false,
    this.responsive = .always,
    this.isResponsive = false,
    this.verticalAlign = .top,
    this.groupDivider = false,
    this.columnWidths,
    this.defaultColumnWidth = const FlexColumnWidth(1.0),
    this.textBaseline,
    this.textDirection,
    this.head,
    this.foot,
    required this.children,
  });

  /// The table's base variant (contextual class).
  final BsVariant? variant;

  /// Whether the table rows should be zebra-striped.
  final bool striped;

  /// Whether the table columns should be zebra-striped.
  final bool stripedColumns;

  /// Whether rows should have a hover state.
  final bool hover;

  /// Whether the table should have borders on all sides.
  final bool bordered;

  /// Whether the table should have no borders.
  final bool borderless;

  /// Whether the table should be compact (small).
  final bool small;

  /// An optional caption for the table.
  final Widget? caption;

  /// Whether the caption should be placed at the top of the table.
  final bool captionTop;

  /// The responsive behavior of the table.
  /// Defaults to [BsTableResponsive.always] if [isResponsive] is true.
  final BsTableResponsive responsive;

  /// Whether the table should be responsive (horizontally scrollable).
  final bool isResponsive;

  /// The default vertical alignment for all cells in the table.
  final BsTableVerticalAlign verticalAlign;

  /// Whether to add a thicker divider between the table head and body.
  final bool groupDivider;

  /// How the horizontal space should be distributed among the columns.
  final Map<int, TableColumnWidth>? columnWidths;

  /// How to determine the width of columns that are not specified in [columnWidths].
  final TableColumnWidth defaultColumnWidth;

  /// The text baseline to use when aligning text.
  final TextBaseline? textBaseline;

  /// The direction in which the columns should be laid out.
  final TextDirection? textDirection;

  /// The table head configuration.
  final BsTableHead? head;

  /// The table foot configuration.
  final BsTableFoot? foot;

  /// The table body rows.
  final List<BsTableRow> children;

  @override
  State<BsTable> createState() => _BsTableState();
}

class _BsTableState extends State<BsTable> {
  int? _hoveredRowIndex;

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController
        .dispose(); // Wichtig: Speicher freigeben, wenn die Tabelle verschwindet
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.bs;

    // 1. Resolve Global Table Colors
    final tableColors = _TableColors.fromVariant(theme, widget.variant);

    // 2. Build Rows
    final List<TableRow> allRows = [];
    int globalRowIndex = 0;

    // Head
    if (widget.head != null) {
      for (final row in widget.head!.rows) {
        allRows.add(
          _buildTableRow(
            context: context,
            row: row,
            index: globalRowIndex++,
            sectionVariant: widget.head!.variant,
            sectionAlign: widget.head!.verticalAlign,
            isHead: true,
            tableColors: tableColors,
          ),
        );
      }
    }

    // Body
    for (int i = 0; i < widget.children.length; i++) {
      final row = widget.children[i];
      final bool isStriped =
          widget.striped &&
          i % 2 ==
              1; // Bootstrap defaults to odd (index 1, 3, ...) for striping

      allRows.add(
        _buildTableRow(
          context: context,
          row: row,
          index: globalRowIndex++,
          isStriped: isStriped,
          isFirstBodyRow: i == 0,
          tableColors: tableColors,
        ),
      );
    }

    // Foot
    if (widget.foot != null) {
      for (final row in widget.foot!.rows) {
        allRows.add(
          _buildTableRow(
            context: context,
            row: row,
            index: globalRowIndex++,
            sectionVariant: widget.foot!.variant,
            sectionAlign: widget.foot!.verticalAlign,
            isFoot: true,
            tableColors: tableColors,
          ),
        );
      }
    }

    // 3. Build Table Border
    TableBorder? border;
    if (widget.borderless) {
      border = null;
    } else if (widget.bordered) {
      border = TableBorder.all(
        color: tableColors.borderColor ?? theme.border,
        width: 1.0,
      );
    } else {
      // Bootstrap default: horizontal lines between rows and at the bottom
      border = TableBorder(
        horizontalInside: BorderSide(
          color: tableColors.borderColor ?? theme.border,
        ),
        bottom: BorderSide(color: tableColors.borderColor ?? theme.border),
      );
    }

    // 4. Assemble
    final Widget tableWidget = Table(
      columnWidths: widget.columnWidths,
      defaultColumnWidth: widget.isResponsive
          ? const IntrinsicColumnWidth()
          : widget.defaultColumnWidth,
      textBaseline: widget.textBaseline,
      textDirection: widget.textDirection,
      border: border,
      children: allRows,
    );

    Widget buildCaption() => DefaultTextStyle(
      style: TextStyle(color: theme.bodyTextSecondary, fontSize: 14),
      child: widget.caption!,
    ).px(8).py(8);

    // Wrap with Caption if needed
    if (widget.caption != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.captionTop) buildCaption(),
          tableWidget,
          if (!widget.captionTop) buildCaption(),
        ],
      );
    }

    // Wrap with Responsive scroll if needed
    if (widget.isResponsive) {
      return LayoutBuilder(
        builder: (context, constraints) {
          final double minW = constraints.maxWidth.isFinite
              ? constraints.maxWidth
              : 0.0;

          Widget responsiveContent = ConstrainedBox(
            constraints: BoxConstraints(minWidth: minW),
            child: tableWidget,
          );

          if (widget.caption != null) {
            responsiveContent = Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.captionTop) buildCaption(),
                responsiveContent,
                if (!widget.captionTop) buildCaption(),
              ],
            );
          }

          return Scrollbar(
            controller: _scrollController,
            trackVisibility: true,
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: responsiveContent.pb3(),
            ),
          );
        },
      );
    }

    return tableWidget;
  }

  TableRow _buildTableRow({
    required BuildContext context,
    required BsTableRow row,
    required int index,
    required _TableColors tableColors,
    BsVariant? sectionVariant,
    BsTableVerticalAlign? sectionAlign,
    bool isHead = false,
    bool isFoot = false,
    bool isStriped = false,
    bool isFirstBodyRow = false,
  }) {
    final theme = context.bs;
    final bool isHovered = widget.hover && _hoveredRowIndex == index;

    // Resolve Row Colors
    final rowColors = _TableColors.fromVariant(
      theme,
      row.variant ?? sectionVariant,
    );

    Color? bgColor = rowColors.bgColor;
    final Color? textColor = rowColors.textColor;
    final Color borderColor =
        rowColors.borderColor ?? tableColors.borderColor ?? theme.border;

    if (row.active) {
      bgColor = _TableColors.activeBg(
        theme,
        row.variant ?? sectionVariant ?? widget.variant,
      );
    } else if (isHovered) {
      bgColor = _TableColors.hoverBg(
        theme,
        row.variant ?? sectionVariant ?? widget.variant,
      );
    } else if (isStriped) {
      bgColor = _TableColors.stripedBg(
        theme,
        row.variant ?? sectionVariant ?? widget.variant,
      );
    }

    // Group Divider logic
    BorderSide topBorder = BorderSide.none;
    if (isFirstBodyRow && widget.groupDivider) {
      topBorder = BorderSide(color: borderColor, width: 2.0);
    }

    return TableRow(
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(
          top: topBorder,
          bottom: widget.borderless
              ? BorderSide.none
              : BorderSide(color: borderColor),
        ),
      ),
      children: row.children.asMap().entries.map((entry) {
        final colIndex = entry.key;
        final cell = entry.value;
        final bool isCellStriped = widget.stripedColumns && colIndex % 2 == 1;

        return TableCell(
          verticalAlignment: _mapVerticalAlign(
            cell.verticalAlign ??
                row.verticalAlign ??
                sectionAlign ??
                widget.verticalAlign,
          ),
          child: MouseRegion(
            onEnter: widget.hover
                ? (_) => setState(() => _hoveredRowIndex = index)
                : null,
            onExit: widget.hover
                ? (_) {
                    if (_hoveredRowIndex == index) {
                      setState(() => _hoveredRowIndex = null);
                    }
                  }
                : null,
            child: _BsTableCellWrapper(
              isHeader: cell.isHeader,
              small: widget.small,
              variant: cell.variant,
              active: cell.active,
              isStriped: isCellStriped,
              parentTextColor: textColor,
              tableColors: tableColors,
              child: cell.child,
            ),
          ),
        );
      }).toList(),
    );
  }

  TableCellVerticalAlignment _mapVerticalAlign(BsTableVerticalAlign align) {
    switch (align) {
      case .top:
        return TableCellVerticalAlignment.top;
      case .middle:
        return TableCellVerticalAlignment.middle;
      case .bottom:
        return TableCellVerticalAlignment.bottom;
    }
  }
}

/// A configuration object for a table head section.
class BsTableHead {
  /// Creates a [BsTableHead].
  const BsTableHead({this.variant, this.verticalAlign, required this.rows});

  /// The variant for the entire head section.
  final BsVariant? variant;

  /// The default vertical alignment for cells in the head.
  final BsTableVerticalAlign? verticalAlign;

  /// The rows in the table head.
  final List<BsTableRow> rows;
}

/// A configuration object for a table foot section.
class BsTableFoot {
  /// Creates a [BsTableFoot].
  const BsTableFoot({this.variant, this.verticalAlign, required this.rows});

  /// The variant for the entire foot section.
  final BsVariant? variant;

  /// The default vertical alignment for cells in the foot.
  final BsTableVerticalAlign? verticalAlign;

  /// The rows in the table foot.
  final List<BsTableRow> rows;
}

/// A configuration object for a table row.
class BsTableRow {
  /// Creates a [BsTableRow].
  const BsTableRow({
    this.variant,
    this.verticalAlign,
    this.active = false,
    required this.children,
  });

  /// The variant for this specific row.
  final BsVariant? variant;

  /// The vertical alignment for cells in this row.
  final BsTableVerticalAlign? verticalAlign;

  /// Whether this row is currently active (highlighted).
  final bool active;

  /// The cells in this row.
  final List<BsTableCell> children;
}

/// A configuration object for a table cell.
class BsTableCell {
  /// Creates a [BsTableCell].
  const BsTableCell({
    this.variant,
    this.verticalAlign,
    this.active = false,
    this.isHeader = false,
    required this.child,
  });

  /// Creates a [BsTableCell] marked as a header cell.
  const BsTableCell.header({
    this.variant,
    this.verticalAlign,
    this.active = false,
    this.isHeader = true,
    required this.child,
  });

  /// The variant for this specific cell.
  final BsVariant? variant;

  /// The vertical alignment for this cell.
  final BsTableVerticalAlign? verticalAlign;

  /// Whether this cell is currently active (highlighted).
  final bool active;

  /// Whether this cell is a header cell (`<th>` equivalent).
  final bool isHeader;

  /// The content of the cell.
  final Widget child;
}

/// Internal wrapper for the content of a [BsTableCell].
/// Handles padding, text styling, and cell-specific background colors.
class _BsTableCellWrapper extends StatelessWidget {
  const _BsTableCellWrapper({
    required this.isHeader,
    required this.small,
    this.variant,
    required this.active,
    required this.isStriped,
    this.parentTextColor,
    required this.tableColors,
    required this.child,
  });

  final bool isHeader;
  final bool small;
  final BsVariant? variant;
  final bool active;
  final bool isStriped;
  final Color? parentTextColor;
  final _TableColors tableColors;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = context.bs;

    // Resolve Cell-Specific Colors
    final cellColors = _TableColors.fromVariant(theme, variant);
    Color? bgColor = cellColors.bgColor;
    final Color? textColor =
        cellColors.textColor ?? parentTextColor ?? tableColors.textColor;

    if (active) {
      bgColor = _TableColors.activeBg(theme, variant);
    } else if (isStriped) {
      // Only apply column striping if cell doesn't have a variant
      if (variant == null) {
        bgColor = theme.emphasisColor.withValues(alpha: 0.05);
      }
    }

    final double paddingY = small ? 4.0 : 8.0;
    final double paddingX = small ? 4.0 : 8.0;

    Widget content = Padding(
      padding: EdgeInsets.symmetric(vertical: paddingY, horizontal: paddingX),
      child: DefaultTextStyle(
        style: TextStyle(
          color: textColor ?? theme.bodyText,
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
        ),
        child: child,
      ),
    );

    if (bgColor != null) {
      content = DecoratedBox(
        decoration: BoxDecoration(color: bgColor),
        child: content,
      );
    }

    return content;
  }
}

/// Helper class to resolve table-related colors from variants.
class _TableColors {
  const _TableColors({this.bgColor, this.textColor, this.borderColor});

  final Color? bgColor;
  final Color? textColor;
  final Color? borderColor;

  static _TableColors fromVariant(BsThemeData theme, BsVariant? variant) {
    if (variant == null) return const _TableColors();

    switch (variant) {
      case .primary:
        return _TableColors(
          bgColor: theme.primaryBgSubtle,
          textColor: theme.primaryTextEmphasis,
          borderColor: theme.primaryBorderSubtle,
        );
      case .secondary:
        return _TableColors(
          bgColor: theme.secondaryBgSubtle,
          textColor: theme.secondaryTextEmphasis,
          borderColor: theme.secondaryBorderSubtle,
        );
      case .success:
        return _TableColors(
          bgColor: theme.successBgSubtle,
          textColor: theme.successTextEmphasis,
          borderColor: theme.successBorderSubtle,
        );
      case .danger:
        return _TableColors(
          bgColor: theme.dangerBgSubtle,
          textColor: theme.dangerTextEmphasis,
          borderColor: theme.dangerBorderSubtle,
        );
      case .warning:
        return _TableColors(
          bgColor: theme.warningBgSubtle,
          textColor: theme.warningTextEmphasis,
          borderColor: theme.warningBorderSubtle,
        );
      case .info:
        return _TableColors(
          bgColor: theme.infoBgSubtle,
          textColor: theme.infoTextEmphasis,
          borderColor: theme.infoBorderSubtle,
        );
      case .light:
        return _TableColors(
          bgColor: theme.light,
          textColor: theme.bodyText,
          borderColor: theme.border,
        );
      case .dark:
        return _TableColors(
          bgColor: theme.dark,
          textColor: Colors.white,
          borderColor: Colors.grey[700],
        );
    }
  }

  static Color stripedBg(BsThemeData theme, BsVariant? variant) {
    if (variant == null) return theme.emphasisColor.withValues(alpha: 0.05);
    final colors = fromVariant(theme, variant);
    return (colors.textColor ?? theme.emphasisColor).withValues(alpha: 0.05);
  }

  static Color hoverBg(BsThemeData theme, BsVariant? variant) {
    if (variant == null) return theme.emphasisColor.withValues(alpha: 0.075);
    final colors = fromVariant(theme, variant);
    return (colors.textColor ?? theme.emphasisColor).withValues(alpha: 0.075);
  }

  static Color activeBg(BsThemeData theme, BsVariant? variant) {
    if (variant == null) return theme.emphasisColor.withValues(alpha: 0.1);
    final colors = fromVariant(theme, variant);
    return (colors.textColor ?? theme.emphasisColor).withValues(alpha: 0.1);
  }
}

import 'package:flutter/material.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

class TableShowcase extends StatelessWidget {
  const TableShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tables',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            'Documentation and examples for opt-in styling of tables (given their prevalent use in ubiquitous widgets like calendars and date pickers).',
          ),
          const SizedBox(height: 32),

          _section('Basic Example', _basicTable()),
          _section('Striped Rows', _stripedTable()),
          _section('Striped Columns', _stripedColumnsTable()),
          _section('Hoverable Rows', _hoverTable()),
          _section('Active Tables', _activeTable()),
          _section('Bordered Tables', _borderedTable()),
          _section('Borderless Tables', _borderlessTable()),
          _section('Small Tables', _smallTable()),
          _section('Table Variants', _variantsTable()),
          _section('Table Group Dividers', _groupDividerTable()),
          _section('Vertical Alignment', _alignmentTable()),
          _section('Captions', _captionTable()),
          _section('Responsive Table', _responsiveTable()),
        ],
      ).p(16),
    );
  }

  Widget _section(String title, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        child,
        const SizedBox(height: 48),
      ],
    );
  }

  Widget _basicTable() {
    return BsTable(
      head: const BsTableHead(
        rows: [
          BsTableRow(
            children: [
              BsTableCell.header(child: Text('#')),
              BsTableCell.header(child: Text('First')),
              BsTableCell.header(child: Text('Last')),
              BsTableCell.header(child: Text('Handle')),
            ],
          ),
        ],
      ),
      children: const [
        BsTableRow(
          children: [
            BsTableCell(child: Text('1')),
            BsTableCell(child: Text('Mark')),
            BsTableCell(child: Text('Otto')),
            BsTableCell(child: Text('@mdo')),
          ],
        ),
        BsTableRow(
          children: [
            BsTableCell(child: Text('2')),
            BsTableCell(child: Text('Jacob')),
            BsTableCell(child: Text('Thornton')),
            BsTableCell(child: Text('@fat')),
          ],
        ),
        BsTableRow(
          children: [
            BsTableCell(child: Text('3')),
            BsTableCell(child: Text('Larry the Bird')),
            BsTableCell(child: Text('')),
            BsTableCell(child: Text('@twitter')),
          ],
        ),
      ],
    );
  }

  Widget _stripedTable() {
    return BsTable(striped: true, children: _sampleRows());
  }

  Widget _stripedColumnsTable() {
    return BsTable(stripedColumns: true, children: _sampleRows());
  }

  Widget _hoverTable() {
    return BsTable(hover: true, children: _sampleRows());
  }

  Widget _activeTable() {
    return const BsTable(
      children: [
        BsTableRow(
          active: true,
          children: [
            BsTableCell(child: Text('Active')),
            BsTableCell(child: Text('Cell')),
            BsTableCell(child: Text('Cell')),
          ],
        ),
        BsTableRow(
          children: [
            BsTableCell(child: Text('Default')),
            BsTableCell(child: Text('Cell')),
            BsTableCell(child: Text('Cell')),
          ],
        ),
        BsTableRow(
          children: [
            BsTableCell(child: Text('Default')),
            BsTableCell.header(active: true, child: Text('Active Header Cell')),
            BsTableCell(child: Text('Cell')),
          ],
        ),
      ],
    );
  }

  Widget _borderedTable() {
    return BsTable(bordered: true, children: _sampleRows());
  }

  Widget _borderlessTable() {
    return BsTable(borderless: true, children: _sampleRows());
  }

  Widget _smallTable() {
    return BsTable(small: true, children: _sampleRows());
  }

  Widget _variantsTable() {
    return Column(
      children: [
        for (final variant in BsTableVariant.values)
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: BsTable(
              variant: variant,
              children: [
                BsTableRow(
                  children: [
                    BsTableCell(child: Text(variant.name.toUpperCase())),
                    const BsTableCell(child: Text('Cell')),
                    const BsTableCell(child: Text('Cell')),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _groupDividerTable() {
    return BsTable(
      groupDivider: true,
      head: const BsTableHead(
        rows: [
          BsTableRow(
            children: [
              BsTableCell.header(child: Text('Header 1')),
              BsTableCell.header(child: Text('Header 2')),
            ],
          ),
        ],
      ),
      children: const [
        BsTableRow(
          children: [
            BsTableCell(child: Text('Body 1')),
            BsTableCell(child: Text('Body 2')),
          ],
        ),
        BsTableRow(
          children: [
            BsTableCell(child: Text('Body 3')),
            BsTableCell(child: Text('Body 4')),
          ],
        ),
      ],
    );
  }

  Widget _alignmentTable() {
    return const BsTable(
      verticalAlign: BsTableVerticalAlign.middle,
      children: [
        BsTableRow(
          children: [
            BsTableCell(child: Text('Middle aligned')),
            BsTableCell(
              child: SizedBox(
                height: 60,
                child: Center(child: Text('Tall Cell')),
              ),
            ),
            BsTableCell(
              verticalAlign: BsTableVerticalAlign.bottom,
              child: Text('Bottom aligned'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _captionTable() {
    return Column(
      children: [
        BsTable(caption: const Text('List of users'), children: _sampleRows()),
        const SizedBox(height: 32),
        BsTable(
          caption: const Text('List of users (Top)'),
          captionTop: true,
          children: _sampleRows(),
        ),
      ],
    );
  }

  Widget _responsiveTable() {
    return const BsTable(
      isResponsive: true,
      children: [
        BsTableRow(
          children: [
            BsTableCell(
              child: Text('This is a very wide column to force scrolling.'),
            ),
            BsTableCell(child: Text('Yet another wide column.')),
            BsTableCell(child: Text('Yet another wide column.')),
            BsTableCell(child: Text('Yet another wide column.')),
            BsTableCell(child: Text('Yet another wide column.')),
            BsTableCell(child: Text('Yet another wide column.')),
            BsTableCell(child: Text('Yet another wide column.')),
            BsTableCell(child: Text('The last wide column.')),
          ],
        ),
      ],
    );
  }

  List<BsTableRow> _sampleRows() {
    return const [
      BsTableRow(
        children: [
          BsTableCell(child: Text('1')),
          BsTableCell(child: Text('Mark')),
          BsTableCell(child: Text('Otto')),
        ],
      ),
      BsTableRow(
        children: [
          BsTableCell(child: Text('2')),
          BsTableCell(child: Text('Jacob')),
          BsTableCell(child: Text('Thornton')),
        ],
      ),
      BsTableRow(
        children: [
          BsTableCell(child: Text('3')),
          BsTableCell(child: Text('Larry')),
          BsTableCell(child: Text('the Bird')),
        ],
      ),
    ];
  }
}

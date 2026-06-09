import 'package:flutter/material.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

class TableShowcase extends StatelessWidget {
  const TableShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.bs;

    return SingleChildScrollView(
      child: BsContainer.fluid(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card with beautiful Gradient
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [theme.primary, theme.info],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: theme.primary.withValues(alpha: 0.25),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tables',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ).pb2(),
                  Text(
                    'Styling for tables to display tabular data cleanly, with support for striped rows/columns, hover states, border styles, variants, vertical alignment, and responsiveness.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: 0.9),
                      height: 1.4,
                    ),
                  ),
                ],
              ).p4(),
            ).mb(32),

            // 1. Basic Example
            _Section(
              title: 'Basic Example',
              description: 'A clean default table style with a distinct header row.',
              child: _basicTable(),
            ),

            // 2. Striped Rows & Columns
            _Section(
              title: 'Striped Rows & Columns',
              description: 'Add zebra-striping to table rows or columns using the striped / stripedColumns flags.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Striped Rows').fwBold().fs6().pb2(),
                  _stripedTable().pb4(),
                  const Text('Striped Columns').fwBold().fs6().pb2(),
                  _stripedColumnsTable(),
                ],
              ),
            ),

            // 3. Hoverable & Active states
            _Section(
              title: 'Hoverable & Active',
              description: 'Enable hover highlights on rows or specify active rows/cells.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Hoverable Rows').fwBold().fs6().pb2(),
                  _hoverTable().pb4(),
                  const Text('Active Rows/Cells').fwBold().fs6().pb2(),
                  _activeTable(),
                ],
              ),
            ),

            // 4. Borders
            _Section(
              title: 'Borders Styling',
              description: 'Manage borders to create bordered or completely borderless tables.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Bordered Table').fwBold().fs6().pb2(),
                  _borderedTable().pb4(),
                  const Text('Borderless Table').fwBold().fs6().pb2(),
                  _borderlessTable(),
                ],
              ),
            ),

            // 5. Sizing & Group Dividers
            _Section(
              title: 'Sizing & Group Dividers',
              description: 'Make tables smaller with compact padding, or separate head and body with thicker group borders.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Small Table').fwBold().fs6().pb2(),
                  _smallTable().pb4(),
                  const Text('Group Divider Table').fwBold().fs6().pb2(),
                  _groupDividerTable(),
                ],
              ),
            ),

            // 6. Table Variants
            _Section(
              title: 'Table Variants',
              description: 'Apply theme contextual background and border colors directly to tables.',
              child: _variantsTable(),
            ),

            // 7. Alignment & Captions
            _Section(
              title: 'Alignment & Captions',
              description: 'Align cell content vertically (middle, top, bottom) or add explanatory captions.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Vertical Alignment (Middle vs Bottom)').fwBold().fs6().pb2(),
                  _alignmentTable().pb4(),
                  const Text('Table Captions').fwBold().fs6().pb2(),
                  _captionTable(),
                ],
              ),
            ),

            // 8. Responsive Tables
            _Section(
              title: 'Responsive Table',
              description: 'Wrap your table inside a responsive container to allow horizontal scrolling on small viewports.',
              child: _responsiveTable(),
            ),
          ],
        ),
      ),
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
            BsTableCell(child: Text('Active Row')),
            BsTableCell(child: Text('Cell')),
            BsTableCell(child: Text('Cell')),
          ],
        ),
        BsTableRow(
          children: [
            BsTableCell(child: Text('Default Row')),
            BsTableCell(child: Text('Cell')),
            BsTableCell(child: Text('Cell')),
          ],
        ),
        BsTableRow(
          children: [
            BsTableCell(child: Text('Default Row')),
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
        for (final variant in BsVariant.values)
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: BsTable(
              variant: variant,
              children: [
                BsTableRow(
                  children: [
                    BsTableCell(child: Text(variant.name.toUpperCase())),
                    const BsTableCell(child: Text('Variant cell background')),
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

class _Section extends StatelessWidget {
  const _Section({required this.title, this.description, required this.child});

  final String title;
  final String? description;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, letterSpacing: -0.5),
        ).pb(4),
        if (description != null) Text(description!).pb(16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: context.bs.bodyBg,
            border: Border.all(color: context.bs.border),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: child,
        ).pb(32),
      ],
    );
  }
}

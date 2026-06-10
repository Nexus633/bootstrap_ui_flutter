import 'package:flutter/material.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

class PaginationShowcase extends StatefulWidget {
  const PaginationShowcase({super.key});

  @override
  State<PaginationShowcase> createState() => _PaginationShowcaseState();
}

class _PaginationShowcaseState extends State<PaginationShowcase> {
  int _currentPage1 = 1;
  int _currentPage2 = 5;

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
                    'Pagination',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ).pb2(),
                  Text(
                    'Provide pagination links for your site or app, allowing users to navigate through series of related content across multiple pages.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: 0.9),
                      height: 1.4,
                    ),
                  ),
                ],
              ).p4(),
            ).mb(32),

            // 1. Basic Example (Manual)
            _Section(
              title: 'Basic Example (Manual List)',
              description: 'Building pagination manually by nesting page items inside a pagination row.',
              child: BsRow(
                children: [
                  BsCol(
                    config: const BsColConfig(xs: 12),
                    child: BsPagination(
                      items: [
                        BsPaginationItem(
                          child: const Text('Previous'),
                          onPressed: () {},
                        ),
                        const BsPaginationItem(
                          active: true,
                          child: Text('1'),
                        ),
                        BsPaginationItem(
                          child: const Text('2'),
                          onPressed: () {},
                        ),
                        BsPaginationItem(
                          child: const Text('3'),
                          onPressed: () {},
                        ),
                        BsPaginationItem(
                          child: const Text('Next'),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 2. Working with Icons
            _Section(
              title: 'Working with Icons',
              description: 'Using double arrows (chevron) or custom icon components for pagination links.',
              child: BsRow(
                children: [
                  BsCol(
                    config: const BsColConfig(xs: 12),
                    child: BsPagination(
                      items: [
                        BsPaginationItem(
                          child: const BsIcon(BsIcons.chevronDoubleLeft),
                          onPressed: () {},
                        ),
                        BsPaginationItem(
                          child: const BsIcon(BsIcons.chevronLeft),
                          onPressed: () {},
                        ),
                        BsPaginationItem(
                          child: const Text('1'),
                          onPressed: () {},
                        ),
                        const BsPaginationItem(
                          active: true,
                          child: Text('2'),
                        ),
                        BsPaginationItem(
                          child: const Text('3'),
                          onPressed: () {},
                        ),
                        BsPaginationItem(
                          child: const BsIcon(BsIcons.chevronRight),
                          onPressed: () {},
                        ),
                        BsPaginationItem(
                          child: const BsIcon(BsIcons.chevronDoubleRight),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 3. Disabled and Active States
            _Section(
              title: 'Disabled and Active States',
              description: 'Customize states to reflect current page selection and disabled borders.',
              child: BsRow(
                children: [
                  BsCol(
                    config: const BsColConfig(xs: 12),
                    child: BsPagination(
                      items: [
                        const BsPaginationItem(
                          disabled: true,
                          child: Text('Previous'),
                        ),
                        const BsPaginationItem(
                          active: true,
                          child: Text('1'),
                        ),
                        BsPaginationItem(
                          child: const Text('2'),
                          onPressed: () {},
                        ),
                        BsPaginationItem(
                          child: const Text('3'),
                          onPressed: () {},
                        ),
                        BsPaginationItem(
                          child: const Text('Next'),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 4. Sizing
            _Section(
              title: 'Sizing',
              description: 'Fancy larger or smaller pagination buttons? Add size options to change paddings and radii.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Large (sm):').fwBold().fs6().pb2(),
                  BsPagination.automatic(
                    currentPage: 2,
                    totalPages: 5,
                    size: BsSize.lg,
                    onPageChanged: (_) {},
                  ).pb4(),
                  const Text('Small (sm):').fwBold().fs6().pb2(),
                  BsPagination.automatic(
                    currentPage: 2,
                    totalPages: 5,
                    size: BsSize.sm,
                    onPageChanged: (_) {},
                  ),
                ],
              ),
            ),

            // 5. Alignment
            _Section(
              title: 'Alignment',
              description: 'Change the alignment of pagination items using flexbox alignment utilities.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Centered (center):').fwBold().fs6().pb2(),
                  BsPagination.automatic(
                    currentPage: 1,
                    totalPages: 5,
                    alignment: BsPaginationAlignment.center,
                    onPageChanged: (_) {},
                  ).pb4(),
                  const Text('Right-Aligned (end):').fwBold().fs6().pb2(),
                  BsPagination.automatic(
                    currentPage: 1,
                    totalPages: 5,
                    alignment: BsPaginationAlignment.end,
                    onPageChanged: (_) {},
                  ),
                ],
              ),
            ),

            // 6. Interactive Automatic Builder
            _Section(
              title: 'Interactive Automatic Builder (High-Level)',
              description: 'Demonstrating dynamic page lists, auto ellipsis (...), first/last page buttons, and active button callbacks.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Small total page count (3 pages):').fwBold().fs6().pb2(),
                  BsPagination.automatic(
                    currentPage: _currentPage1,
                    totalPages: 3,
                    maxVisiblePages: 5,
                    onPageChanged: (page) {
                      setState(() => _currentPage1 = page);
                    },
                  ).pb4(),
                  Text('Active Page: $_currentPage1').fs6().pb4(),
                  const Divider(),
                  const Text('Large total page count (20 pages, max 5 visible):').fwBold().fs6().pb2(),
                  BsPagination.automatic(
                    currentPage: _currentPage2,
                    totalPages: 20,
                    maxVisiblePages: 5,
                    onPageChanged: (page) {
                      setState(() => _currentPage2 = page);
                    },
                  ).pb4(),
                  Text('Active Page: $_currentPage2').fs6(),
                ],
              ),
            ),

            // 7. Custom Colors & Active Variants
            _Section(
              title: 'Custom Colors & Active Variants',
              description: 'Demonstrating active variants (success, danger, dark) and completely custom background, text, and border colors.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Active Variant (BsVariant.success):').fwBold().fs6().pb2(),
                  BsPagination.automatic(
                    currentPage: 3,
                    totalPages: 5,
                    activeVariant: BsVariant.success,
                    onPageChanged: (_) {},
                  ).pb4(),
                  const Text('Active Variant (BsVariant.danger):').fwBold().fs6().pb2(),
                  BsPagination.automatic(
                    currentPage: 2,
                    totalPages: 5,
                    activeVariant: BsVariant.danger,
                    onPageChanged: (_) {},
                  ).pb4(),
                  const Text('Fully Custom Color Theme (Teal / Orange Accent):').fwBold().fs6().pb2(),
                  BsPagination.automatic(
                    currentPage: 3,
                    totalPages: 5,
                    textColor: Colors.teal[800],
                    bgColor: Colors.teal[50],
                    borderColor: Colors.teal[200],
                    hoverTextColor: Colors.teal[900],
                    hoverBgColor: Colors.teal[100],
                    activeColor: Colors.orange[700],
                    activeTextColor: Colors.white,
                    onPageChanged: (_) {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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

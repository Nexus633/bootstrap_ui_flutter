import 'package:flutter/material.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

class BreadcrumbShowcase extends StatelessWidget {
  const BreadcrumbShowcase({super.key});

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
                    'Breadcrumbs',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ).pb2(),
                  Text(
                    'Indicate the current page\'s location within a navigational hierarchy. Separators are automatically added inside the breadcrumb trail.',
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
              description: 'Demonstrating 1-level, 2-level and 3-level breadcrumb paths.',
              child: BsRow(
                children: [
                  BsCol(
                    config: const BsColConfig(xs: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BsBreadcrumb(
                          items: [
                            BsBreadcrumbItem(label: const Text('Home'), active: true),
                          ],
                        ),
                        BsBreadcrumb(
                          items: [
                            BsBreadcrumbItem(label: const Text('Home'), onPressed: () {}),
                            BsBreadcrumbItem(label: const Text('Library'), active: true),
                          ],
                        ),
                        BsBreadcrumb(
                          items: [
                            BsBreadcrumbItem(label: const Text('Home'), onPressed: () {}),
                            BsBreadcrumbItem(label: const Text('Library'), onPressed: () {}),
                            BsBreadcrumbItem(label: const Text('Data'), active: true),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 2. Custom Dividers
            _Section(
              title: 'Custom Dividers',
              description: 'Separators can be customized with strings, empty dividers, or icon widgets.',
              child: BsRow(
                children: [
                  BsCol(
                    config: const BsColConfig(xs: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Arrow Divider (String):').fwBold().fs6().pb2(),
                        BsBreadcrumb(
                          divider: '>',
                          items: [
                            BsBreadcrumbItem(label: const Text('Home'), onPressed: () {}),
                            BsBreadcrumbItem(label: const Text('Library'), active: true),
                          ],
                        ),

                        const Text('Icon Divider (Widget):').fwBold().fs6().pb2(),
                        BsBreadcrumb(
                          divider: const BsIcon(BsIcons.chevronRight, size: 14),
                          items: [
                            BsBreadcrumbItem(label: const Text('Home'), onPressed: () {}),
                            BsBreadcrumbItem(label: const Text('Library'), active: true),
                          ],
                        ),

                        const Text('Empty Divider (None):').fwBold().fs6().pb2(),
                        BsBreadcrumb(
                          divider: '',
                          items: [
                            BsBreadcrumbItem(label: const Text('Home'), onPressed: () {}),
                            BsBreadcrumbItem(label: const Text('Library'), active: true),
                          ],
                        ),
                      ],
                    ),
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

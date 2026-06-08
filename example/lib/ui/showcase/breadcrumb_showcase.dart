import 'package:flutter/material.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

class BreadcrumbShowcase extends StatelessWidget {
  const BreadcrumbShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BsContainer.fluid(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Breadcrumbs',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ).pb(16),
            const Text(
              'Indicate the current page\'s location within a navigational hierarchy that automatically adds separators via CSS.',
            ).pb(24),

            // Example
            _Section(
              title: 'Example',
              child: BsBreadcrumb(
                items: [
                  BsBreadcrumbItem(label: const Text('Home'), active: true),
                ],
              ),
            ),
            _Section(
              title: 'Basic Example',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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

            // Dividers
            _Section(
              title: 'Dividers',
              description: 'Dividers are automatically added in CSS through ::before and content. They can be customized via --bs-breadcrumb-divider.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('String divider:').pb(8),
                  BsBreadcrumb(
                    divider: '>',
                    items: [
                      BsBreadcrumbItem(label: const Text('Home'), onPressed: () {}),
                      BsBreadcrumbItem(label: const Text('Library'), active: true),
                    ],
                  ),
                  const Text('Widget divider (Icon):').pb(8),
                  BsBreadcrumb(
                    divider: const BsIcon(BsIcons.chevronRight, size: 16),
                    items: [
                      BsBreadcrumbItem(label: const Text('Home'), onPressed: () {}),
                      BsBreadcrumbItem(label: const Text('Library'), active: true),
                    ],
                  ),
                  const Text('Empty divider:').pb(8),
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
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    this.description,
    required this.child,
  });

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
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ).pb(8),
        if (description != null)
          Text(description!).pb(16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: context.bs.border),
            borderRadius: BorderRadius.circular(8),
          ),
          child: child,
        ).pb(32),
      ],
    );
  }
}

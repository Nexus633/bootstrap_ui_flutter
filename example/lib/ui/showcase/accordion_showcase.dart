import 'package:flutter/material.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

class AccordionShowcase extends StatelessWidget {
  const AccordionShowcase({super.key});

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
                    'Accordion',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ).pb2(),
                  Text(
                    'Build vertically collapsing accordions. Perfect for stacked details panels, FAQs, and secondary information.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: 0.9),
                      height: 1.4,
                    ),
                  ),
                ],
              ).p4(),
            ).mb(32),

            // 1. Standard Accordion
            _Section(
              title: 'Standard Accordion',
              description: 'Typical Bootstrap accordion where only one item can be expanded at a time.',
              child: BsAccordion(
                flush: false,
                items: [
                  BsAccordionItem(
                    title: 'Accordion Item #1',
                    initiallyExpanded: true,
                    body: Text(
                      'This is the first item\'s accordion body. It is shown by default, until the collapse plugin adds the appropriate classes.',
                      style: TextStyle(color: theme.bodyTextSecondary),
                    ),
                  ),
                  BsAccordionItem(
                    title: 'Accordion Item #2',
                    body: Text(
                      'This is the second item\'s accordion body. It is hidden by default.',
                      style: TextStyle(color: theme.bodyTextSecondary),
                    ),
                  ),
                  BsAccordionItem(
                    title: 'Accordion Item #3',
                    body: Text(
                      'This is the third item\'s accordion body. It is also hidden by default.',
                      style: TextStyle(color: theme.bodyTextSecondary),
                    ),
                  ),
                ],
              ),
            ),

            // 2. Custom Cursor Accordion
            _Section(
              title: 'Accordion with Custom Cursor',
              description: 'Demonstrating an accordion configured with SystemMouseCursors.click for interactive feedback.',
              child: BsAccordion(
                mouseCursor: SystemMouseCursors.click,
                flush: false,
                items: [
                  BsAccordionItem(
                    title: 'Interactive Item #1',
                    initiallyExpanded: true,
                    body: Text(
                      'Hovering over the headers will show a pointer hand cursor.',
                      style: TextStyle(color: theme.bodyTextSecondary),
                    ),
                  ),
                  BsAccordionItem(
                    title: 'Interactive Item #2',
                    body: Text(
                      'This element is closed by default.',
                      style: TextStyle(color: theme.bodyTextSecondary),
                    ),
                  ),
                ],
              ),
            ),

            // 3. Always Open Accordion
            _Section(
              title: 'Always Open Accordion',
              description: 'Set alwaysOpen to true to keep accordion items open when other items are toggled.',
              child: BsAccordion(
                alwaysOpen: true,
                items: [
                  BsAccordionItem(
                    title: 'Item A (Independent Toggle)',
                    body: Text(
                      'Toggling this item will not affect Item B.',
                      style: TextStyle(color: theme.bodyTextSecondary),
                    ),
                  ),
                  BsAccordionItem(
                    title: 'Item B (Independent Toggle)',
                    body: Text(
                      'Toggling this item will not affect Item A.',
                      style: TextStyle(color: theme.bodyTextSecondary),
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

import 'package:flutter/material.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

class CollapseShowcase extends StatefulWidget {
  const CollapseShowcase({super.key});

  @override
  State<CollapseShowcase> createState() => _CollapseShowcaseState();
}

class _CollapseShowcaseState extends State<CollapseShowcase> {
  bool _isVerticalExpanded = false;
  bool _isHorizontalExpanded = false;
  bool _multiExpandedA = false;
  bool _multiExpandedB = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BsContainer.fluid(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Collapse',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ).pb(16),
            const Text(
              'Toggle the visibility of content across your project with a few classes and our collapse component. Built-in support for vertical and horizontal transitions.',
            ).pb(24),

            // 1. Vertical Collapse
            _Section(
              title: 'Vertical Collapse (Default)',
              description: 'Click the button below to show and hide another element via a smooth height animation.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BsButton(
                    label: 'Link with href',
                    variant: BsButtonVariant.primary,
                    onPressed: () {
                      setState(() => _isVerticalExpanded = !_isVerticalExpanded);
                    },
                  ).pb3(),
                  BsCollapse(
                    isExpanded: _isVerticalExpanded,
                    child: BsCard(
                      body: BsCardBody(
                        children: [
                          const Text(
                            'Some placeholder content for the collapse component. This panel is hidden by default but appears when the user activates the trigger.',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 2. Horizontal Collapse
            _Section(
              title: 'Horizontal Collapse',
              description: 'Use the horizontal property to transition the width instead of height.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BsButton(
                    label: 'Toggle Width Collapse',
                    variant: BsButtonVariant.primary,
                    onPressed: () {
                      setState(() => _isHorizontalExpanded = !_isHorizontalExpanded);
                    },
                  ).pb3(),
                  // Fixed-height container holds the horizontal collapse so layout remains stable
                  SizedBox(
                    height: 120,
                    child: BsCollapse(
                      isExpanded: _isHorizontalExpanded,
                      horizontal: true,
                      child: SizedBox(
                        width: 300,
                        height: 120,
                        child: BsCard(
                          body: BsCardBody(
                            children: [
                              const Text(
                                'This is some placeholder content for a horizontal collapse. It expands and collapses width-wise.',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 3. Multiple Targets
            _Section(
              title: 'Multiple Targets',
              description: 'Toggle individual elements or activate both simultaneously by changing their states.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BsRow(
                    children: [
                      BsCol(
                        config: const BsColConfig(xs: 12, md: 4),
                        child: BsButton(
                          label: 'Toggle Element A',
                          variant: BsButtonVariant.primary,
                          fullWidth: true,
                          onPressed: () {
                            setState(() => _multiExpandedA = !_multiExpandedA);
                          },
                        ).pb2(),
                      ),
                      BsCol(
                        config: const BsColConfig(xs: 12, md: 4),
                        child: BsButton(
                          label: 'Toggle Element B',
                          variant: BsButtonVariant.primary,
                          fullWidth: true,
                          onPressed: () {
                            setState(() => _multiExpandedB = !_multiExpandedB);
                          },
                        ).pb2(),
                      ),
                      BsCol(
                        config: const BsColConfig(xs: 12, md: 4),
                        child: BsButton(
                          label: 'Toggle Both Elements',
                          variant: BsButtonVariant.primary,
                          fullWidth: true,
                          onPressed: () {
                            setState(() {
                              // If they are in different states, expand both. Otherwise, toggle both.
                              if (_multiExpandedA != _multiExpandedB) {
                                _multiExpandedA = true;
                                _multiExpandedB = true;
                              } else {
                                _multiExpandedA = !_multiExpandedA;
                                _multiExpandedB = !_multiExpandedB;
                              }
                            });
                          },
                        ).pb2(),
                      ),
                    ],
                  ).pb3(),
                  BsRow(
                    children: [
                      BsCol(
                        config: const BsColConfig(xs: 12, md: 6),
                        child: BsCollapse(
                          isExpanded: _multiExpandedA,
                          child: BsCard(
                            body: BsCardBody(
                              children: [
                                const BsCardTitle('Element A'),
                                const Text('Placeholder content for the first collapsible element.'),
                              ],
                            ),
                          ),
                        ).pb2(),
                      ),
                      BsCol(
                        config: const BsColConfig(xs: 12, md: 6),
                        child: BsCollapse(
                          isExpanded: _multiExpandedB,
                          child: BsCard(
                            body: BsCardBody(
                              children: [
                                const BsCardTitle('Element B'),
                                const Text('Placeholder content for the second collapsible element.'),
                              ],
                            ),
                          ),
                        ).pb2(),
                      ),
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

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
                    'Collapse',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ).pb2(),
                  Text(
                    'Toggle the visibility of content across your project with smooth width or height transition animations.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: 0.9),
                      height: 1.4,
                    ),
                  ),
                ],
              ).p4(),
            ).mb(32),

            // 1. Vertical Collapse
            _Section(
              title: 'Vertical Collapse (Default)',
              description: 'Toggle visibility of vertical elements smoothly using height transitions.',
              child: BsRow(
                children: [
                  BsCol(
                    config: const BsColConfig(xs: 12, md: 8, lg: 6),
                    alignSelf: BsColAlignSelf.start,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BsButton(
                          label: 'Toggle Content',
                          variant: BsButtonVariant.primary,
                          onPressed: () {
                            setState(() => _isVerticalExpanded = !_isVerticalExpanded);
                          },
                        ).pb3(),
                        BsCollapse(
                          key: const ValueKey('collapse_vertical'),
                          isExpanded: _isVerticalExpanded,
                          child: BsCard(
                            body: BsCardBody(
                              children: [
                                Text(
                                  'Some placeholder content for the vertical collapse component. This panel is hidden by default but appears when the user activates the trigger.',
                                  style: TextStyle(color: theme.bodyTextSecondary),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 2. Horizontal Collapse
            _Section(
              title: 'Horizontal Collapse',
              description: 'Transition width instead of height by setting the horizontal flag.',
              child: BsRow(
                children: [
                  BsCol(
                    config: const BsColConfig(xs: 12, md: 8, lg: 6),
                    alignSelf: BsColAlignSelf.start,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BsButton(
                          label: 'Toggle Horizontal Collapse',
                          variant: BsButtonVariant.primary,
                          onPressed: () {
                            setState(() => _isHorizontalExpanded = !_isHorizontalExpanded);
                          },
                        ).pb3(),
                        ConstrainedBox(
                          constraints: const BoxConstraints(minHeight: 130),
                          child: BsCollapse(
                            key: const ValueKey('collapse_horizontal'),
                            isExpanded: _isHorizontalExpanded,
                            horizontal: true,
                            child: SizedBox(
                              width: 320,
                              child: BsCard(
                                body: BsCardBody(
                                  child: Text(
                                    'This is some placeholder content for a horizontal collapse. It expands and collapses width-wise.',
                                    style: TextStyle(color: theme.bodyTextSecondary),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
                    gutterX: BsSpacing.s2,
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
                        ),
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
                        ),
                      ),
                      BsCol(
                        config: const BsColConfig(xs: 12, md: 4),
                        child: BsButton(
                          label: 'Toggle Both',
                          variant: BsButtonVariant.secondary,
                          fullWidth: true,
                          onPressed: () {
                            setState(() {
                              if (_multiExpandedA != _multiExpandedB) {
                                _multiExpandedA = true;
                                _multiExpandedB = true;
                              } else {
                                _multiExpandedA = !_multiExpandedA;
                                _multiExpandedB = !_multiExpandedB;
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ).pb3(),
                  BsRow(
                    gutterX: BsSpacing.s3,
                    children: [
                      BsCol(
                        config: const BsColConfig(xs: 12, md: 6),
                        alignSelf: BsColAlignSelf.start,
                        child: BsCollapse(
                          key: const ValueKey('collapse_multi_a'),
                          isExpanded: _multiExpandedA,
                          child: BsCard(
                            body: BsCardBody(
                              children: [
                                const BsCardTitle('Element A'),
                                Text(
                                  'Placeholder content for the first collapsible element.',
                                  style: TextStyle(color: theme.bodyTextSecondary),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      BsCol(
                        config: const BsColConfig(xs: 12, md: 6),
                        alignSelf: BsColAlignSelf.start,
                        child: BsCollapse(
                          key: const ValueKey('collapse_multi_b'),
                          isExpanded: _multiExpandedB,
                          child: BsCard(
                            body: BsCardBody(
                              children: [
                                const BsCardTitle('Element B'),
                                Text(
                                  'Placeholder content for the second collapsible element.',
                                  style: TextStyle(color: theme.bodyTextSecondary),
                                ),
                              ],
                            ),
                          ),
                        ),
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

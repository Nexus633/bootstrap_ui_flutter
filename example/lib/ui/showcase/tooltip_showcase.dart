import 'package:flutter/material.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

class TooltipShowcase extends StatelessWidget {
  const TooltipShowcase({super.key});

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
                    'Tooltips',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ).pb2(),
                  Text(
                    'Documentation and examples for adding custom Bootstrap tooltips.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: 0.9),
                      height: 1.4,
                    ),
                  ),
                ],
              ).p4(),
            ).mb(32),

            _Section(
              title: 'Directions',
              description:
                  'Hover over the buttons below to see the four tooltips directions: top, right, bottom, and left.',
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  BsTooltip(
                    message: 'Tooltip on top',
                    placement: BsPlacement.top,
                    child: BsButton(label: 'Tooltip on top', onPressed: () {}),
                  ),
                  BsTooltip(
                    message: 'Tooltip on end',
                    placement: BsPlacement.end,
                    child: BsButton(
                      label: 'Tooltip on right',
                      onPressed: () {},
                    ),
                  ),
                  BsTooltip(
                    message: 'Tooltip on bottom',
                    placement: BsPlacement.bottom,
                    child: BsButton(
                      label: 'Tooltip on bottom',
                      onPressed: () {},
                    ),
                  ),
                  BsTooltip(
                    message: 'Tooltip on start',
                    placement: BsPlacement.start,
                    child: BsButton(label: 'Tooltip on left', onPressed: () {}),
                  ),
                ],
              ),
            ),
            _Section(
              title: 'Disabled elements',
              description: 'Tooltips can also be disabled.',
              child: BsTooltip(
                message: 'This will not show',
                disabled: true,
                child: const BsButton(
                  label: 'Disabled Tooltip',
                  onPressed: null,
                ),
              ),
            ),
            _Section(
              title: 'Color Variants',
              description:
                  'Tooltips support standard Bootstrap color variants and custom colors.',
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  BsTooltip(
                    message: 'Primary Tooltip',
                    variant: BsVariant.primary,
                    child: BsButton(
                      variant: BsButtonVariant.primary,
                      label: 'Primary',
                      onPressed: () {},
                    ),
                  ),
                  BsTooltip(
                    message: 'Success Tooltip',
                    variant: BsVariant.success,
                    child: BsButton(
                      variant: BsButtonVariant.success,
                      label: 'Success',
                      onPressed: () {},
                    ),
                  ),
                  BsTooltip(
                    message: 'Danger Tooltip',
                    variant: BsVariant.danger,
                    child: BsButton(
                      variant: BsButtonVariant.danger,
                      label: 'Danger',
                      onPressed: () {},
                    ),
                  ),
                  BsTooltip(
                    message: 'Custom Color',
                    color: Colors.purple,
                    child: BsButton(
                      color: Colors.purple,
                      label: 'Custom',
                      onPressed: () {},
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
  const _Section({required this.title, required this.child, this.description});

  final String title;
  final Widget child;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ).pb(8),
        if (description != null) Text(description!).pb(16),
        Container(
          width: double.infinity,
          alignment: Alignment.topLeft,
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

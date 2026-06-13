import 'package:flutter/material.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

class BadgeShowcase extends StatelessWidget {
  const BadgeShowcase({super.key});

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
                    'Badges',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ).pb2(),
                  Text(
                    'Documentation and examples for badges, our small count and labeling component. Scaled to match the size of the immediate parent element.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: 0.9),
                      height: 1.4,
                    ),
                  ),
                ],
              ).p4(),
            ).mb(32),

            // 1. Standard Badges
            _Section(
              title: 'Standard Badges',
              description: 'Contextual badges with semantic colors and counts.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: const [
                      BsBadge(label: 'Primary', variant: BsVariant.primary),
                      BsBadge(label: 'Secondary', variant: BsVariant.secondary),
                      BsBadge(label: 'Success', variant: BsVariant.success),
                      BsBadge(label: 'Danger', variant: BsVariant.danger),
                      BsBadge(label: 'Warning', variant: BsVariant.warning),
                      BsBadge(label: 'Info', variant: BsVariant.info),
                      BsBadge(label: 'Light', variant: BsVariant.light),
                      BsBadge(label: 'Dark', variant: BsVariant.dark),
                    ],
                  ).pb3(),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: const [
                      BsBadge(label: '8', variant: BsVariant.primary),
                      BsBadge(label: '12', variant: BsVariant.secondary),
                      BsBadge(label: '8', variant: BsVariant.success),
                      BsBadge(label: '5', variant: BsVariant.danger),
                      BsBadge(label: '6', variant: BsVariant.warning),
                      BsBadge(label: '1', variant: BsVariant.info),
                      BsBadge(label: '0', variant: BsVariant.light),
                      BsBadge(label: '99', variant: BsVariant.dark),
                    ],
                  ),
                ],
              ),
            ),

            // 2. Pill Badges
            _Section(
              title: 'Pill Badges',
              description:
                  'Use the isPill property to make badges more rounded (with a larger border-radius).',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: const [
                      BsBadge(
                        label: 'Primary',
                        variant: BsVariant.primary,
                        isPill: true,
                      ),
                      BsBadge(
                        label: 'Secondary',
                        variant: BsVariant.secondary,
                        isPill: true,
                      ),
                      BsBadge(
                        label: 'Success',
                        variant: BsVariant.success,
                        isPill: true,
                      ),
                      BsBadge(
                        label: 'Danger',
                        variant: BsVariant.danger,
                        isPill: true,
                      ),
                      BsBadge(
                        label: 'Warning',
                        variant: BsVariant.warning,
                        isPill: true,
                      ),
                      BsBadge(
                        label: 'Info',
                        variant: BsVariant.info,
                        isPill: true,
                      ),
                      BsBadge(
                        label: 'Light',
                        variant: BsVariant.light,
                        isPill: true,
                      ),
                      BsBadge(
                        label: 'Dark',
                        variant: BsVariant.dark,
                        isPill: true,
                      ),
                    ],
                  ).pb3(),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: const [
                      BsBadge(
                        label: '8',
                        variant: BsVariant.primary,
                        isPill: true,
                      ),
                      BsBadge(
                        label: '12',
                        variant: BsVariant.secondary,
                        isPill: true,
                      ),
                      BsBadge(
                        label: '8',
                        variant: BsVariant.success,
                        isPill: true,
                      ),
                      BsBadge(
                        label: '5',
                        variant: BsVariant.danger,
                        isPill: true,
                      ),
                      BsBadge(
                        label: '6',
                        variant: BsVariant.warning,
                        isPill: true,
                      ),
                      BsBadge(
                        label: '1',
                        variant: BsVariant.info,
                        isPill: true,
                      ),
                      BsBadge(
                        label: '0',
                        variant: BsVariant.light,
                        isPill: true,
                      ),
                      BsBadge(
                        label: '99',
                        variant: BsVariant.dark,
                        isPill: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 3. Typographic Integration
            _Section(
              title: 'Typographic Integration',
              description:
                  'Badges scale to match the size of their parent text element.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: const Text('Example Heading 1').fs1().fwBold(),
                      ),
                      const SizedBox(width: 12),
                      const BsBadge(label: 'New', variant: BsVariant.primary),
                    ],
                  ).pb3(),
                  Row(
                    children: [
                      Expanded(
                        child: const Text('Example Heading 3').fs3().fwBold(),
                      ),
                      const SizedBox(width: 10),
                      const BsBadge(label: 'New', variant: BsVariant.secondary),
                    ],
                  ).pb3(),
                  Row(
                    children: [
                      Expanded(
                        child: const Text('Notifications').fs5().fwSemibold(),
                      ),
                      const SizedBox(width: 8),
                      const BsBadge(label: '9+', variant: BsVariant.danger),
                    ],
                  ),
                ],
              ),
            ),

            // 4. Buttons with Badges (Pill & Standard)
            _Section(
              title: 'Buttons with Badges',
              description:
                  'Badges can be positioned inside buttons at various locations (topRight, leading, trailing, etc.).',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Pill Badges in Buttons:').fwBold().fs5().pb3(),
                  Wrap(
                    spacing: 28,
                    runSpacing: 12,
                    children: [
                      BsButton(
                        label: 'Inbox',
                        variant: BsButtonVariant.primary,
                        badge: const BsBadge(
                          label: '4',
                          variant: BsVariant.light,
                          isPill: true,
                        ),
                        badgePosition: BsBadgePosition.trailing,
                        onPressed: () {},
                      ),
                      BsButton(
                        label: 'Notifications',
                        variant: BsButtonVariant.secondary,
                        badge: const BsBadge(
                          label: '99+',
                          variant: BsVariant.danger,
                          isPill: true,
                        ),
                        badgePosition: BsBadgePosition.topRight,
                        onPressed: () {},
                      ),
                      BsButton(
                        label: 'Tasks',
                        variant: BsButtonVariant.success,
                        badge: const BsBadge(
                          label: 'Done',
                          variant: BsVariant.light,
                          isPill: true,
                        ),
                        badgePosition: BsBadgePosition.leading,
                        onPressed: () {},
                      ),
                      BsButton(
                        label: 'Warnings',
                        variant: BsButtonVariant.warning,
                        badge: const BsBadge(
                          label: '3',
                          variant: BsVariant.danger,
                          isPill: true,
                        ),
                        badgePosition: BsBadgePosition.topLeft,
                        onPressed: () {},
                      ),
                    ],
                  ).pb4(),
                  const Text(
                    'Standard Badges in Buttons:',
                  ).fwBold().fs5().pb3(),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      BsButton(
                        label: 'Inbox',
                        variant: BsButtonVariant.primary,
                        outline: true,
                        badge: const BsBadge(
                          label: '4',
                          variant: BsVariant.primary,
                        ),
                        badgePosition: BsBadgePosition.trailing,
                        onPressed: () {},
                      ),
                      BsButton(
                        label: 'Errors',
                        variant: BsButtonVariant.danger,
                        badge: const BsBadge(
                          label: 'Alert',
                          variant: BsVariant.light,
                        ),
                        badgePosition: BsBadgePosition.topRight,
                        onPressed: () {},
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
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
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

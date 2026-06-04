import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';
import 'package:flutter/material.dart';

class BadgeShowcase extends StatelessWidget {
  const BadgeShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    // Get theme
    final bsTheme = context.bs;

    return Scaffold(
      backgroundColor: bsTheme.bodyBg, // Adjust Scaffold background
      appBar: AppBar(
        title: const Text('Badge Showcase'),
        backgroundColor: bsTheme.bodyBg,
        foregroundColor: bsTheme.bodyText, // Adjust text & back button
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: bsTheme.border, height: 1.0),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Standard Badges',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: bsTheme.bodyText,
              ),
            ),
            const SizedBox(height: 16),

            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      spacing: 8.0,
                      children: const [
                        BsBadge(
                          label: 'Primary',
                          variant: BsBadgeVariant.primary,
                        ),
                        BsBadge(
                          label: 'Secondary',
                          variant: BsBadgeVariant.secondary,
                        ),
                        BsBadge(
                          label: 'Success',
                          variant: BsBadgeVariant.success,
                        ),
                        BsBadge(
                          label: 'Danger',
                          variant: BsBadgeVariant.danger,
                        ),
                        BsBadge(
                          label: 'Warning',
                          variant: BsBadgeVariant.warning,
                        ),
                        BsBadge(label: 'Info', variant: BsBadgeVariant.info),
                        BsBadge(label: 'Light', variant: BsBadgeVariant.light),
                        BsBadge(label: 'Dark', variant: BsBadgeVariant.dark),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      spacing: 8.0,
                      children: const [
                        BsBadge(label: '8', variant: BsBadgeVariant.primary),
                        BsBadge(label: '12', variant: BsBadgeVariant.secondary),
                        BsBadge(label: '8', variant: BsBadgeVariant.success),
                        BsBadge(label: '5', variant: BsBadgeVariant.danger),
                        BsBadge(label: '6', variant: BsBadgeVariant.warning),
                        BsBadge(label: '1', variant: BsBadgeVariant.info),
                        BsBadge(label: '0', variant: BsBadgeVariant.light),
                        BsBadge(label: '99', variant: BsBadgeVariant.dark),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 48),

            Text(
              'Pill Badges (.rounded-pill)',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: bsTheme.bodyText,
              ),
            ),
            const SizedBox(height: 16),

            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                Row(
                  spacing: 8.0,
                  children: const [
                    BsBadge(
                      label: 'Primary',
                      variant: BsBadgeVariant.primary,
                      isPill: true,
                    ),
                    BsBadge(
                      label: 'Secondary',
                      variant: BsBadgeVariant.secondary,
                      isPill: true,
                    ),
                    BsBadge(
                      label: 'Success',
                      variant: BsBadgeVariant.success,
                      isPill: true,
                    ),
                    BsBadge(
                      label: 'Danger',
                      variant: BsBadgeVariant.danger,
                      isPill: true,
                    ),
                    BsBadge(
                      label: 'Warning',
                      variant: BsBadgeVariant.warning,
                      isPill: true,
                    ),
                    BsBadge(
                      label: 'Info',
                      variant: BsBadgeVariant.info,
                      isPill: true,
                    ),
                    BsBadge(
                      label: 'Light',
                      variant: BsBadgeVariant.light,
                      isPill: true,
                    ),
                    BsBadge(
                      label: 'Dark',
                      variant: BsBadgeVariant.dark,
                      isPill: true,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  spacing: 8.0,
                  children: const [
                    BsBadge(
                      label: '8',
                      variant: BsBadgeVariant.primary,
                      isPill: true,
                    ),
                    BsBadge(
                      label: '12',
                      variant: BsBadgeVariant.secondary,
                      isPill: true,
                    ),
                    BsBadge(
                      label: '8',
                      variant: BsBadgeVariant.success,
                      isPill: true,
                    ),
                    BsBadge(
                      label: '5',
                      variant: BsBadgeVariant.danger,
                      isPill: true,
                    ),
                    BsBadge(
                      label: '6',
                      variant: BsBadgeVariant.warning,
                      isPill: true,
                    ),
                    BsBadge(
                      label: '1',
                      variant: BsBadgeVariant.info,
                      isPill: true,
                    ),
                    BsBadge(
                      label: '0',
                      variant: BsBadgeVariant.light,
                      isPill: true,
                    ),
                    BsBadge(
                      label: '99',
                      variant: BsBadgeVariant.dark,
                      isPill: true,
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 48),

            Text(
              'Typographic Integration',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: bsTheme.bodyText,
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Text(
                  'Notifications',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: bsTheme.bodyText,
                  ),
                ),
                const SizedBox(width: 8),
                const BsBadge(label: 'New', variant: BsBadgeVariant.danger),
              ],
            ),

            const SizedBox(height: 48),

            Text(
              'Buttons with Badges (Pill)',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: bsTheme.bodyText,
              ),
            ),
            const SizedBox(height: 16),

            Row(
              spacing: 16.0,
              children: [
                BsButton(
                  label: 'TopLeft',
                  variant: BsButtonVariant.warning,
                  badge: const BsBadge(
                    label: '3',
                    variant: BsBadgeVariant.light,
                    isPill: true,
                  ),
                  badgePosition: BsBadgePosition.topLeft,
                  onPressed: () {},
                ),
                BsButton(
                  label: 'TopRight',
                  variant: BsButtonVariant.danger,
                  badge: const BsBadge(
                    label: '3',
                    variant: BsBadgeVariant.warning,
                    isPill: true,
                  ),
                  badgePosition: BsBadgePosition.topRight,
                  onPressed: () {},
                ),
                BsButton(
                  label: 'BottomLeft',
                  variant: BsButtonVariant.primary,
                  badge: const BsBadge(
                    label: '3',
                    variant: BsBadgeVariant.success,
                    isPill: true,
                  ),
                  badgePosition: BsBadgePosition.bottomLeft,
                  onPressed: () {},
                ),
                BsButton(
                  label: 'BottomRight',
                  variant: BsButtonVariant.secondary,
                  badge: const BsBadge(
                    label: '3',
                    variant: BsBadgeVariant.info,
                    isPill: true,
                  ),
                  badgePosition: BsBadgePosition.bottomRight,
                  onPressed: () {},
                ),
                BsButton(
                  label: 'Leading',
                  variant: BsButtonVariant.info,
                  badge: const BsBadge(
                    label: '3',
                    variant: BsBadgeVariant.warning,
                    isPill: true,
                  ),
                  badgePosition: BsBadgePosition.leading,
                  onPressed: () {},
                ),
                BsButton(
                  label: 'Trailing',
                  variant: BsButtonVariant.success,
                  badge: const BsBadge(
                    label: '3',
                    variant: BsBadgeVariant.danger,
                    isPill: true,
                  ),
                  badgePosition: BsBadgePosition.trailing,
                  onPressed: () {},
                ),
              ],
            ),

            const SizedBox(height: 48),

            Text(
              'Buttons with Badges (Standard)',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: bsTheme.bodyText,
              ),
            ),
            const SizedBox(height: 16),

            Row(
              spacing: 16.0,
              children: [
                BsButton(
                  label: 'TopLeft',
                  variant: BsButtonVariant.warning,
                  badge: const BsBadge(
                    label: '3',
                    variant: BsBadgeVariant.light,
                    isPill: false,
                  ),
                  badgePosition: BsBadgePosition.topLeft,
                  onPressed: () {},
                ),
                BsButton(
                  label: 'TopRight',
                  variant: BsButtonVariant.danger,
                  badge: const BsBadge(
                    label: '3',
                    variant: BsBadgeVariant.warning,
                    isPill: false,
                  ),
                  badgePosition: BsBadgePosition.topRight,
                  onPressed: () {},
                ),
                BsButton(
                  label: 'BottomLeft',
                  variant: BsButtonVariant.primary,
                  badge: const BsBadge(
                    label: '3',
                    variant: BsBadgeVariant.success,
                    isPill: false,
                  ),
                  badgePosition: BsBadgePosition.bottomLeft,
                  onPressed: () {},
                ),
                BsButton(
                  label: 'BottomRight',
                  variant: BsButtonVariant.secondary,
                  badge: const BsBadge(
                    label: '3',
                    variant: BsBadgeVariant.info,
                    isPill: false,
                  ),
                  badgePosition: BsBadgePosition.bottomRight,
                  onPressed: () {},
                ),
                BsButton(
                  label: 'Leading',
                  variant: BsButtonVariant.info,
                  badge: const BsBadge(
                    label: '3',
                    variant: BsBadgeVariant.warning,
                    isPill: false,
                  ),
                  badgePosition: BsBadgePosition.leading,
                  onPressed: () {},
                ),
                BsButton(
                  label: 'Trailing',
                  variant: BsButtonVariant.success,
                  badge: const BsBadge(
                    label: '3',
                    variant: BsBadgeVariant.danger,
                    isPill: false,
                  ),
                  badgePosition: BsBadgePosition.trailing,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

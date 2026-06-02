import 'package:flutter/material.dart';
import '../components/badge/bs_badge.dart';
import '../components/button/bs_button.dart';
// Wichtig: Hier deinen Button importieren, falls du das Button-Beispiel testen willst!
// import '../components/button/bs_button.dart';

class BadgeShowcase extends StatelessWidget {
  const BadgeShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Badge Showcase')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Standard Badges',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Wrap ist perfekt für kleine Tags/Badges
            Wrap(
              spacing: 8.0, // Horizontaler Abstand
              runSpacing: 8.0, // Vertikaler Abstand beim Umbruch
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

            const Text(
              'Pill Badges (.rounded-pill)',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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

            const Text(
              'Typografische Integration',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // So würde ein Badge neben einem Header aussehen
            Row(
              children: const [
                Text(
                  'Benachrichtigungen',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 8),
                BsBadge(label: 'Neu', variant: BsBadgeVariant.danger),
              ],
            ),

            const SizedBox(height: 48),

            const Text(
              'Buttons mit Badges (Pill)',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // So würde ein Badge neben einem Header aussehen
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [],
            ),
            Row(
              spacing: 16.0,
              children: [
                AppButton(
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
                AppButton(
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
                AppButton(
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
                AppButton(
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
                AppButton(
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
                AppButton(
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

            const Text(
              'Buttons mit Badges (Standard)',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // So würde ein Badge neben einem Header aussehen
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [],
            ),
            Row(
              spacing: 16.0,
              children: [
                AppButton(
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
                AppButton(
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
                AppButton(
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
                AppButton(
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
                AppButton(
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
                AppButton(
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
            // ─── OPTIONAL: Integration in den eigenen AppButton ─────────────
            // Falls du deinen AppButton hier hast, kannst du sehen, wie gut das Badge darin aussieht!
            /*
            AppButton(
              label: 'Posteingang',
              variant: BsButtonVariant.primary,
              onPressed: () {},
              // Wenn dein Button ein 'child' oder 'trailing' Widget unterstützen würde,
              // könnte das Badge so eingebaut werden:
              // trailing: const BsBadge(label: '99+', variant: BsBadgeVariant.danger, isPill: true),
            ),
            */
          ],
        ),
      ),
    );
  }
}

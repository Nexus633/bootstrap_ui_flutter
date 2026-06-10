import 'package:flutter/material.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

class IconShowcase extends StatelessWidget {
  const IconShowcase({super.key});

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
                    'Icons',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ).pb2(),
                  Text(
                    'Use Bootstrap Icons in Flutter with the BsIcon widget and BsIcons constants. Supports color variants, custom sizes, custom colors, and inline styling.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: 0.9),
                      height: 1.4,
                    ),
                  ),
                ],
              ).p4(),
            ).mb(32),

            // 1. Basic Icons
            _Section(
              title: 'Basic Icons',
              description: 'A selection of standard Bootstrap Icons mapped natively.',
              child: Wrap(
                spacing: BsSpacing.s3,
                runSpacing: BsSpacing.s3,
                children: const [
                  _IconCard(icon: BsIcons.house, label: 'house'),
                  _IconCard(icon: BsIcons.alarm, label: 'alarm'),
                  _IconCard(icon: BsIcons.gear, label: 'gear'),
                  _IconCard(icon: BsIcons.checkCircle, label: 'checkCircle'),
                  _IconCard(icon: BsIcons.exclamationTriangle, label: 'warning'),
                  _IconCard(icon: BsIcons.infoCircle, label: 'infoCircle'),
                  _IconCard(icon: BsIcons.trash, label: 'trash'),
                  _IconCard(icon: BsIcons.search, label: 'search'),
                ],
              ),
            ),

            // 2. Icon Variants
            _Section(
              title: 'Icon Variants (Colors)',
              description: 'Theme color variants corresponding to Bootstrap\'s semantic classes.',
              child: Wrap(
                spacing: BsSpacing.s3,
                runSpacing: BsSpacing.s3,
                children: [
                  const _IconCard(
                    icon: BsIcons.checkCircleFill,
                    label: 'primary',
                    iconWidget: BsIcon(BsIcons.checkCircleFill, variant: BsVariant.primary, size: 28),
                  ),
                  const _IconCard(
                    icon: BsIcons.infoCircleFill,
                    label: 'secondary',
                    iconWidget: BsIcon(BsIcons.infoCircleFill, variant: BsVariant.secondary, size: 28),
                  ),
                  const _IconCard(
                    icon: BsIcons.checkCircleFill,
                    label: 'success',
                    iconWidget: BsIcon(BsIcons.checkCircleFill, variant: BsVariant.success, size: 28),
                  ),
                  const _IconCard(
                    icon: BsIcons.xCircleFill,
                    label: 'danger',
                    iconWidget: BsIcon(BsIcons.xCircleFill, variant: BsVariant.danger, size: 28),
                  ),
                  const _IconCard(
                    icon: BsIcons.exclamationTriangleFill,
                    label: 'warning',
                    iconWidget: BsIcon(BsIcons.exclamationTriangleFill, variant: BsVariant.warning, size: 28),
                  ),
                  const _IconCard(
                    icon: BsIcons.infoCircleFill,
                    label: 'info',
                    iconWidget: BsIcon(BsIcons.infoCircleFill, variant: BsVariant.info, size: 28),
                  ),
                  const _IconCard(
                    icon: BsIcons.lightbulb,
                    label: 'dark',
                    iconWidget: BsIcon(BsIcons.lightbulb, variant: BsVariant.dark, size: 28),
                  ),
                  _IconCard(
                    icon: BsIcons.sunFill,
                    label: 'light',
                    backgroundColor: theme.dark,
                    borderColor: theme.dark,
                    textColor: theme.onDark,
                    iconWidget: const BsIcon(BsIcons.sunFill, variant: BsVariant.light, size: 28),
                  ),
                ],
              ),
            ),

            // 3. Sizes
            _Section(
              title: 'Sizes',
              description: 'Control the size of your icon easily using the size parameter.',
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Column(
                    children: [
                      BsIcon(BsIcons.alarm, size: 16),
                      SizedBox(height: BsSpacing.s1),
                      Text('16px', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  SizedBox(width: BsSpacing.s4),
                  Column(
                    children: [
                      BsIcon(BsIcons.alarm, size: 24),
                      SizedBox(height: BsSpacing.s1),
                      Text('24px', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  SizedBox(width: BsSpacing.s4),
                  Column(
                    children: [
                      BsIcon(BsIcons.alarm, size: 32, variant: BsVariant.primary),
                      SizedBox(height: BsSpacing.s1),
                      Text('32px', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  SizedBox(width: BsSpacing.s4),
                  Column(
                    children: [
                      BsIcon(BsIcons.alarm, size: 48, variant: BsVariant.success),
                      SizedBox(height: BsSpacing.s1),
                      Text('48px', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  SizedBox(width: BsSpacing.s4),
                  Column(
                    children: [
                      BsIcon(BsIcons.alarm, size: 64, variant: BsVariant.danger),
                      SizedBox(height: BsSpacing.s1),
                      Text('64px', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),

            // 4. Custom Colors
            _Section(
              title: 'Custom Colors',
              description: 'Use standard Flutter colors for custom branding or styling. Custom colors override the variant value.',
              child: Wrap(
                spacing: BsSpacing.s3,
                runSpacing: BsSpacing.s3,
                children: const [
                  _IconCard(
                    icon: BsIcons.heartFill,
                    label: 'Pink',
                    iconWidget: BsIcon(BsIcons.heartFill, color: Colors.pink, size: 28),
                  ),
                  _IconCard(
                    icon: BsIcons.starFill,
                    label: 'Amber',
                    iconWidget: BsIcon(BsIcons.starFill, color: Colors.amber, size: 28),
                  ),
                  _IconCard(
                    icon: BsIcons.shieldFillCheck,
                    label: 'Teal',
                    iconWidget: BsIcon(BsIcons.shieldFillCheck, color: Colors.teal, size: 28),
                  ),
                  _IconCard(
                    icon: BsIcons.cloudLightningRainFill,
                    label: 'Purple',
                    iconWidget: BsIcon(BsIcons.cloudLightningRainFill, color: Colors.deepPurple, size: 28),
                  ),
                ],
              ),
            ),

            // 5. Icon Links Integration
            _Section(
              title: 'Icon Links Integration',
              description: 'BsIcon can be combined with BsIconLink for actionable elements.',
              child: Row(
                children: [
                  BsIconLink(
                    label: const Text('Read More'),
                    icon: const BsIcon(BsIcons.arrowRight, size: 16),
                    onPressed: () {},
                  ),
                  const SizedBox(width: BsSpacing.s4),
                  BsIconLink(
                    label: const Text('Go Home'),
                    icon: const BsIcon(BsIcons.house, size: 16),
                    iconAfter: false,
                    onPressed: () {},
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

class _IconCard extends StatelessWidget {
  const _IconCard({
    required this.icon,
    required this.label,
    this.iconWidget,
    this.textColor,
    this.backgroundColor,
    this.borderColor,
  });

  final IconData icon;
  final String label;
  final Widget? iconWidget;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final theme = context.bs;
    return SizedBox(
      width: 120,
      height: 100,
      child: BsCard(
        color: backgroundColor ?? theme.bodyBgSecondary,
        borderColor: borderColor ?? theme.border,
        borderRadius: BorderRadius.circular(8),
        body: BsCardBody(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          children: [
            Center(child: iconWidget ?? BsIcon(icon, size: 28)),
            const SizedBox(height: BsSpacing.s2),
            Center(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: textColor ?? theme.bodyText,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

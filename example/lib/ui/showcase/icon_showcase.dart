import 'package:flutter/material.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

class IconShowcase extends StatelessWidget {
  const IconShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    final bsTheme = context.bs;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Icons', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: BsSpacing.s3),
          _description(
            'Use Bootstrap Icons in Flutter with the BsIcon widget and BsIcons constants. Supports color variants, custom sizes, custom colors, and inline styling.',
          ),
          const SizedBox(height: BsSpacing.s4),

          // ─── Basic Icons ───────────────────────────────────────────────────
          _sectionTitle('Basic Icons'),
          _description(
            'A selection of standard Bootstrap Icons mapped natively.',
          ),
          Wrap(
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
          const SizedBox(height: BsSpacing.s4),

          // ─── Icon Variants ─────────────────────────────────────────────────
          _sectionTitle('Icon Variants (Colors)'),
          _description(
            'Theme color variants corresponding to Bootstrap\'s semantic classes.',
          ),
          Wrap(
            spacing: BsSpacing.s3,
            runSpacing: BsSpacing.s3,
            children: [
              _IconCard(
                icon: BsIcons.checkCircleFill,
                label: 'primary',
                iconWidget: const BsIcon(BsIcons.checkCircleFill, variant: BsIconVariant.primary, size: 28),
              ),
              _IconCard(
                icon: BsIcons.infoCircleFill,
                label: 'secondary',
                iconWidget: const BsIcon(BsIcons.infoCircleFill, variant: BsIconVariant.secondary, size: 28),
              ),
              _IconCard(
                icon: BsIcons.checkCircleFill,
                label: 'success',
                iconWidget: const BsIcon(BsIcons.checkCircleFill, variant: BsIconVariant.success, size: 28),
              ),
              _IconCard(
                icon: BsIcons.xCircleFill,
                label: 'danger',
                iconWidget: const BsIcon(BsIcons.xCircleFill, variant: BsIconVariant.danger, size: 28),
              ),
              _IconCard(
                icon: BsIcons.exclamationTriangleFill,
                label: 'warning',
                iconWidget: const BsIcon(BsIcons.exclamationTriangleFill, variant: BsIconVariant.warning, size: 28),
              ),
              _IconCard(
                icon: BsIcons.infoCircleFill,
                label: 'info',
                iconWidget: const BsIcon(BsIcons.infoCircleFill, variant: BsIconVariant.info, size: 28),
              ),
              _IconCard(
                icon: BsIcons.lightbulb,
                label: 'dark',
                iconWidget: const BsIcon(BsIcons.lightbulb, variant: BsIconVariant.dark, size: 28),
              ),
              _IconCard(
                icon: BsIcons.sunFill,
                label: 'light',
                backgroundColor: bsTheme.dark,
                borderColor: bsTheme.dark,
                textColor: bsTheme.onDark,
                iconWidget: const BsIcon(BsIcons.sunFill, variant: BsIconVariant.light, size: 28),
              ),
            ],
          ),
          const SizedBox(height: BsSpacing.s4),

          // ─── Sizes ─────────────────────────────────────────────────────────
          _sectionTitle('Sizes'),
          _description(
            'Control the size of your icon easily using the size parameter.',
          ),
          Row(
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
                  BsIcon(BsIcons.alarm, size: 32, variant: BsIconVariant.primary),
                  SizedBox(height: BsSpacing.s1),
                  Text('32px', style: TextStyle(fontSize: 12)),
                ],
              ),
              SizedBox(width: BsSpacing.s4),
              Column(
                children: [
                  BsIcon(BsIcons.alarm, size: 48, variant: BsIconVariant.success),
                  SizedBox(height: BsSpacing.s1),
                  Text('48px', style: TextStyle(fontSize: 12)),
                ],
              ),
              SizedBox(width: BsSpacing.s4),
              Column(
                children: [
                  BsIcon(BsIcons.alarm, size: 64, variant: BsIconVariant.danger),
                  SizedBox(height: BsSpacing.s1),
                  Text('64px', style: TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
          const SizedBox(height: BsSpacing.s4),

          // ─── Custom Colors ─────────────────────────────────────────────────
          _sectionTitle('Custom Colors'),
          _description(
            'Use standard Flutter colors for custom branding or styling. Custom colors override the variant value.',
          ),
          Wrap(
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
          const SizedBox(height: BsSpacing.s4),

          // ─── Icon Links ────────────────────────────────────────────────────
          _sectionTitle('Icon Links integration'),
          _description(
            'BsIcon can be combined with BsIconLink for actionable elements.',
          ),
          Row(
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
        ],
      ).p3(),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: BsSpacing.s2),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _description(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: BsSpacing.s3),
      child: Text(
        text,
        style: const TextStyle(color: Colors.grey),
      ),
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
    return Card(
      elevation: 0,
      color: backgroundColor ?? context.bs.bodyBgSecondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: borderColor ?? context.bs.border),
      ),
      child: SizedBox(
        width: 120,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconWidget ?? BsIcon(icon, size: 28),
            const SizedBox(height: BsSpacing.s2),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: textColor ?? context.bs.bodyText,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

class ThemeShowcase extends StatelessWidget {
  const ThemeShowcase({
    super.key,
    required this.currentMode,
    required this.onThemeChanged,
  });

  final ThemeMode currentMode;
  final ValueChanged<ThemeMode> onThemeChanged;

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
                    'Themes',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ).pb2(),
                  Text(
                    'Bootstrap-style themes allow you to build applications that respond instantly to system, dark, and light configuration modes.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: 0.9),
                      height: 1.4,
                    ),
                  ),
                ],
              ).p4(),
            ).mb(32),

            // 1. Appearance Mode
            _Section(
              title: 'Appearance Mode Settings',
              description: 'Select between Light, Dark or System theme preference presets.',
              child: Container(
                decoration: BoxDecoration(
                  color: theme.bodyBgSecondary,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: theme.border),
                ),
                child: Row(
                  children: [
                    _buildToggleItem(
                      label: 'System Default',
                      icon: BsIcons.circleHalf,
                      mode: ThemeMode.system,
                      isActive: currentMode == ThemeMode.system,
                      theme: theme,
                    ),
                    _buildToggleItem(
                      label: 'Light Mode',
                      icon: BsIcons.sunFill,
                      mode: ThemeMode.light,
                      isActive: currentMode == ThemeMode.light,
                      theme: theme,
                    ),
                    _buildToggleItem(
                      label: 'Dark Mode',
                      icon: BsIcons.moonFill,
                      mode: ThemeMode.dark,
                      isActive: currentMode == ThemeMode.dark,
                      theme: theme,
                    ),
                  ],
                ),
              ),
            ),

            // 2. Color Swatches
            _Section(
              title: 'Bootstrap Semantic Palette',
              description: 'Main accent palette theme tokens matching theme configurations.',
              child: Wrap(
                spacing: 24,
                runSpacing: 16,
                children: [
                  _ColorSwatch(name: 'Primary', color: theme.primary),
                  _ColorSwatch(name: 'Secondary', color: theme.secondary),
                  _ColorSwatch(name: 'Success', color: theme.success),
                  _ColorSwatch(name: 'Danger', color: theme.danger),
                  _ColorSwatch(name: 'Warning', color: theme.warning),
                  _ColorSwatch(name: 'Info', color: theme.info),
                  _ColorSwatch(name: 'Light', color: theme.light),
                  _ColorSwatch(name: 'Dark', color: theme.dark),
                ],
              ),
            ),

            // 3. Live Component testing
            _Section(
              title: 'Theme Integration Test',
              description: 'Verify badge layouts, alerts, and button states against currently loaded colors.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BsButton(
                    label: 'Primary Action Button',
                    variant: BsButtonVariant.primary,
                    icon: BsIcons.sendFill,
                    badge: BsBadge(label: 'Launch', variant: BsVariant.warning),
                    badgePosition: BsBadgePosition.topRight,
                  ).pb4(),

                  const BsAlert(
                    variant: BsVariant.success,
                    icon: BsIcons.checkCircleFill,
                    dismissible: true,
                    child: Text('Live Theme Update: The color configurations was applied successfully!'),
                  ).pb3(),

                  const BsAlert(
                    variant: BsVariant.dark,
                    icon: BsIcons.moonFill,
                    child: Text('Live Dark Theme Test: Checking background blending offsets.'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleItem({
    required String label,
    required IconData icon,
    required ThemeMode mode,
    required bool isActive,
    required BsThemeData theme,
  }) {
    return GestureDetector(
      onTap: () => onThemeChanged(mode),
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
          color: isActive ? theme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(11),
        ),
        child: Column(
          children: [
            BsIcon(
              icon,
              size: 20,
              color: isActive ? Colors.white : theme.bodyText,
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                color: isActive ? Colors.white : theme.bodyText,
              ),
            ),
          ],
        ).py(16),
      ),
    ).expanded();
  }
}

class _ColorSwatch extends StatelessWidget {
  const _ColorSwatch({required this.name, required this.color});

  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = context.bs;
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: theme.border, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(name, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: theme.bodyText)),
      ],
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

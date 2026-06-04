import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';
import 'package:flutter/material.dart';

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
    // Access the current theme!
    final bsTheme = context.bs;

    return Scaffold(
      // The background color is automatically set by the theme,
      // but we can also explicitly use bsTheme.bodyBg.
      backgroundColor: bsTheme.bodyBg,
      appBar: AppBar(
        title: const Text('Theme Settings'),
        backgroundColor: bsTheme.bodyBg,
        foregroundColor: bsTheme.bodyText,
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
            // ─── Appearance ──────────────────────────────────────────────────
            Text(
              'Appearance',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: bsTheme.bodyText,
              ),
            ),
            const SizedBox(height: 16),

            // An elegant toggle to switch between modes
            Container(
              decoration: BoxDecoration(
                color: bsTheme.light, // Uses the light color as background
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: bsTheme.border),
              ),
              child: Row(
                children: [
                  _buildToggleItem(
                    label: 'System',
                    icon: Icons.brightness_auto,
                    mode: ThemeMode.system,
                    isActive: currentMode == ThemeMode.system,
                    theme: bsTheme,
                  ),
                  _buildToggleItem(
                    label: 'Light',
                    icon: Icons.light_mode,
                    mode: ThemeMode.light,
                    isActive: currentMode == ThemeMode.light,
                    theme: bsTheme,
                  ),
                  _buildToggleItem(
                    label: 'Dark',
                    icon: Icons.dark_mode,
                    mode: ThemeMode.dark,
                    isActive: currentMode == ThemeMode.dark,
                    theme: bsTheme,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 48),

            // ─── Color palette for verification ───────────────────────────────────
            Text(
              'Semantic Colors',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: bsTheme.bodyText,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _ColorSwatch(name: 'Primary', color: bsTheme.primary),
                _ColorSwatch(name: 'Success', color: bsTheme.success),
                _ColorSwatch(name: 'Warning', color: bsTheme.warning),
                _ColorSwatch(name: 'Danger', color: bsTheme.danger),
                _ColorSwatch(name: 'Info', color: bsTheme.info),
              ],
            ),

            const SizedBox(height: 48),

            // ─── Live component test ─────────────────────────────────────
            Text(
              'Live Components',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: bsTheme.bodyText,
              ),
            ),
            const SizedBox(height: 16),

            // Test Button
            const BsButton(
              label: 'Primary Action',
              variant: BsButtonVariant.primary,
              icon: Icons.send,
              badge: BsBadge(label: 'New', variant: BsBadgeVariant.warning),
              badgePosition: BsBadgePosition.topRight,
            ),

            const SizedBox(height: 24),

            // Test Alert
            BsAlert(
              variant: BsAlertVariant.success,
              icon: Icons.check_circle,
              dismissible: true,
              child: const Text('The theme has been successfully loaded!'),
            ),

            const SizedBox(height: 16),

            BsAlert(
              variant: BsAlertVariant.dark,
              icon: Icons.dark_mode,
              child: const Text(
                'This dark alert blends perfectly into the UI.',
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Helper widgets for the showcase ─────────────────────────────────────────

  Widget _buildToggleItem({
    required String label,
    required IconData icon,
    required ThemeMode mode,
    required bool isActive,
    required BsThemeData theme,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onThemeChanged(mode),
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          decoration: BoxDecoration(
            color: isActive ? theme.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(
              7.0,
            ), // 1px smaller than the outer frame
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 20,
                color: isActive ? Colors.white : theme.bodyText,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  color: isActive ? Colors.white : theme.bodyText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Small widget to draw color swatches
class _ColorSwatch extends StatelessWidget {
  const _ColorSwatch({required this.name, required this.color});

  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: context.bs.border, width: 1),
          ),
        ),
        const SizedBox(height: 8),
        Text(name, style: TextStyle(fontSize: 12, color: context.bs.bodyText)),
      ],
    );
  }
}

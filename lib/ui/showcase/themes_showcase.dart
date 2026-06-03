import 'package:flutter/material.dart';
import '../tokens/bs_theme.dart';
import '../components/button/bs_button.dart';
import '../components/alert/bs_alert.dart';
import '../components/badge/bs_badge.dart';

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
    // Hier greifen wir auf unser aktuelles Theme zu!
    final bsTheme = context.bs;

    return Scaffold(
      // Die Hintergrundfarbe wird automatisch durch das Theme gesetzt,
      // aber wir können auch explizit bsTheme.bodyBg nutzen.
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
            // ─── Theme Switcher ───────────────────────────────────────────────
            Text(
              'Erscheinungsbild',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: bsTheme.bodyText,
              ),
            ),
            const SizedBox(height: 16),

            // Ein eleganter Toggle, um zwischen den Modes zu wechseln
            Container(
              decoration: BoxDecoration(
                color: bsTheme.light, // Nutzt die Light-Farbe als Hintergrund
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

            // ─── Farb-Palette zur Kontrolle ───────────────────────────────────
            Text(
              'Semantische Farben',
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

            // ─── Komponenten im Live-Test ─────────────────────────────────────
            Text(
              'Live Komponenten',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: bsTheme.bodyText,
              ),
            ),
            const SizedBox(height: 16),

            // Test Button
            const AppButton(
              label: 'Primary Action',
              variant: BsButtonVariant.primary,
              icon: Icons.send,
              badge: BsBadge(label: 'Neu', variant: BsBadgeVariant.warning),
              badgePosition: BsBadgePosition.topRight,
            ),

            const SizedBox(height: 24),

            // Test Alert
            BsAlert(
              variant: BsAlertVariant.success,
              icon: Icons.check_circle,
              dismissible: true,
              child: const Text('Das Theme wurde erfolgreich geladen!'),
            ),

            const SizedBox(height: 16),

            BsAlert(
              variant: BsAlertVariant.dark,
              icon: Icons.dark_mode,
              child: const Text(
                'Dieser Dark-Alert passt sich perfekt ins UI ein.',
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Hilfs-Widgets für den Showcase ─────────────────────────────────────────

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
            ), // 1px kleiner als der Außenrahmen
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

// Kleines Widget, um die Farbkreise zu zeichnen
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

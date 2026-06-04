import 'package:bootstrap_flutter/bootstrap_flutter.dart';
import 'package:flutter/material.dart';
import '../showcase/accordion_showcase.dart';
import '../showcase/alert_showcase.dart';
import '../showcase/badge_showcase.dart';
import '../showcase/button_showcase.dart';
import '../showcase/grid_showcase.dart';
import '../showcase/themes_showcase.dart';
import '../../main.dart';
// ─── Navigation Item Model ────────────────────────────────────────────────────

class _NavItem {
  const _NavItem({
    required this.label,
    required this.icon,
    required this.page,
    this.group,
  });

  final String label;
  final IconData icon;
  final Widget page;

  /// Gruppe für die Sidebar-Überschriften (z.B. "Layout", "Components").
  final String? group;
}

// ─── Showcase Shell ───────────────────────────────────────────────────────────

/// Die Haupt-Shell für alle Showcases.
/// Füge einfach einen neuen _NavItem zur [_items] Liste hinzu
/// um eine neue Komponente anzuzeigen.
class ShowcaseShell extends StatefulWidget {
  const ShowcaseShell({super.key});

  @override
  State<ShowcaseShell> createState() => _ShowcaseShellState();
}

class _ShowcaseShellState extends State<ShowcaseShell> {
  // ── Navigation Items ────────────────────────────────────────────────────────
  // Neue Komponenten hier einfach anhängen!
  final List<_NavItem> _items = [
    _NavItem(
      group: 'Layout',
      label: 'Grid System',
      icon: Icons.grid_view_rounded,
      page: GridShowcase(),
    ),
    _NavItem(
      group: 'Layout',
      label: 'Themes',
      icon: Icons.palette_rounded,
      page: ValueListenableBuilder<ThemeMode>(
        // WICHTIG: Du musst hier den themeNotifier aus deiner main.dart importieren!
        // z.B. import '../../main.dart';
        valueListenable: themeNotifier,
        builder: (context, mode, _) {
          return ThemeShowcase(
            currentMode: mode,
            onThemeChanged: (newMode) {
              // Aktualisiert den globalen State -> App zeichnet sich neu
              themeNotifier.value = newMode;
            },
          );
        },
      ),
    ),
    _NavItem(
      group: 'Components',
      label: 'Buttons',
      icon: Icons.smart_button_rounded,
      page: ButtonShowcase(),
    ),
    _NavItem(
      group: 'Components',
      label: 'Accordion',
      icon: Icons.expand_more_rounded,
      page: AccordionShowcase(),
    ),
    _NavItem(
      group: 'Components',
      label: 'Alert',
      icon: Icons.info_rounded,
      page: AlertShowcase(),
    ),
    _NavItem(
      group: 'Components',
      label: 'Badge',
      icon: Icons.badge_rounded,
      page: BadgeShowcase(),
    ),
    // Zukünftige Komponenten:
    // _NavItem(group: 'Components', label: 'Badge',  icon: Icons.label_rounded,       page: BadgeShowcase()),
    // _NavItem(group: 'Components', label: 'Alert',  icon: Icons.info_rounded,         page: AlertShowcase()),
    // _NavItem(group: 'Components', label: 'Card',   icon: Icons.credit_card_rounded,  page: CardShowcase()),
    // _NavItem(group: 'Components', label: 'Input',  icon: Icons.text_fields_rounded,  page: InputShowcase()),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // ── Sidebar ──────────────────────────────────────────────────────────
          _Sidebar(
            items: _items,
            selectedIndex: _selectedIndex,
            onSelect: (index) => setState(() => _selectedIndex = index),
          ),
          // ── Vertikaler Divider ────────────────────────────────────────────────
          const VerticalDivider(width: 1, color: BsColors.border),
          // ── Content ───────────────────────────────────────────────────────────
          Expanded(child: _items[_selectedIndex].page),
        ],
      ),
    );
  }
}

// ─── Sidebar ──────────────────────────────────────────────────────────────────

class _Sidebar extends StatelessWidget {
  const _Sidebar({
    required this.items,
    required this.selectedIndex,
    required this.onSelect,
  });

  final List<_NavItem> items;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    // Baue die Sidebar-Einträge mit Gruppen-Überschriften.
    final List<Widget> sidebarChildren = [];
    String? lastGroup;

    for (int i = 0; i < items.length; i++) {
      final item = items[i];

      // Gruppen-Überschrift einfügen wenn sich die Gruppe ändert.
      if (item.group != null && item.group != lastGroup) {
        if (lastGroup != null) {
          // Trennlinie zwischen Gruppen
          sidebarChildren.add(
            const Padding(
              padding: EdgeInsets.symmetric(vertical: BsSpacing.s2),
              child: Divider(color: BsColors.border, height: 1),
            ),
          );
        }
        sidebarChildren.add(_GroupLabel(item.group!));
        lastGroup = item.group;
      }

      sidebarChildren.add(
        _NavTile(
          item: item,
          isSelected: selectedIndex == i,
          onTap: () => onSelect(i),
        ),
      );
    }

    return SizedBox(
      width: 220,
      child: ColoredBox(
        color: BsColors.dark,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Logo / Header ──────────────────────────────────────────────────
            const _SidebarHeader(),
            const Divider(color: Color(0xFF495057), height: 1),
            // ── Nav Items ──────────────────────────────────────────────────────
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  vertical: BsSpacing.s2,
                  horizontal: BsSpacing.s2,
                ),
                children: sidebarChildren,
              ),
            ),
            // ── Footer ─────────────────────────────────────────────────────────
            const Divider(color: Color(0xFF495057), height: 1),
            const _SidebarFooter(),
          ],
        ),
      ),
    );
  }
}

// ─── Sidebar Header ───────────────────────────────────────────────────────────

class _SidebarHeader extends StatelessWidget {
  const _SidebarHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(BsSpacing.s3),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: BsColors.primary,
              borderRadius: BsRadius.md,
            ),
            child: const Icon(
              Icons.bolt_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: BsSpacing.s2),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bootstrap UI',
                style: BsTypography.body.copyWith(
                  color: Colors.white,
                  fontWeight: BsTypography.weightBold,
                  fontSize: 14,
                ),
              ),
              Text(
                'Flutter Components',
                style: BsTypography.body.copyWith(
                  color: const Color(0xFFadb5bd),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Group Label ─────────────────────────────────────────────────────────────

class _GroupLabel extends StatelessWidget {
  const _GroupLabel(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        BsSpacing.s2,
        BsSpacing.s2,
        BsSpacing.s2,
        BsSpacing.s1,
      ),
      child: Text(
        label.toUpperCase(),
        style: BsTypography.body.copyWith(
          color: const Color(0xFF6c757d),
          fontSize: 10,
          fontWeight: BsTypography.weightBold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

// ─── Nav Tile ─────────────────────────────────────────────────────────────────

class _NavTile extends StatelessWidget {
  const _NavTile({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  final _NavItem item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Material(
        color: Colors.transparent,
        borderRadius: BsRadius.md,
        child: InkWell(
          onTap: onTap,
          borderRadius: BsRadius.md,
          hoverColor: Colors.white.withValues(alpha: 0.05),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(
              horizontal: BsSpacing.s2,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: isSelected
                  ? BsColors.primary.withValues(alpha: 0.2)
                  : Colors.transparent,
              borderRadius: BsRadius.md,
              border: isSelected
                  ? Border.all(color: BsColors.primary.withValues(alpha: 0.4))
                  : null,
            ),
            child: Row(
              children: [
                Icon(
                  item.icon,
                  size: 16,
                  color: isSelected
                      ? BsColors.primary
                      : const Color(0xFFadb5bd),
                ),
                const SizedBox(width: BsSpacing.s2),
                Text(
                  item.label,
                  style: BsTypography.body.copyWith(
                    fontSize: 13,
                    color: isSelected ? Colors.white : const Color(0xFFadb5bd),
                    fontWeight: isSelected
                        ? BsTypography.weightMedium
                        : BsTypography.weightNormal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Sidebar Footer ───────────────────────────────────────────────────────────

class _SidebarFooter extends StatelessWidget {
  const _SidebarFooter();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(BsSpacing.s3),
      child: Text(
        'Bootstrap 5 · Flutter',
        style: BsTypography.body.copyWith(
          color: const Color(0xFF495057),
          fontSize: 11,
        ),
      ),
    );
  }
}

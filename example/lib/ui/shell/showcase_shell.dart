import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';
import 'package:flutter/material.dart';
import '../showcase/accordion_showcase.dart';
import '../showcase/alert_showcase.dart';
import '../showcase/badge_showcase.dart';
import '../showcase/button_showcase.dart';
import '../showcase/grid_showcase.dart';
import '../showcase/themes_showcase.dart';
import '../showcase/image_showcase.dart';
import '../showcase/figure_showcase.dart';
import '../showcase/table_showcase.dart';
import '../showcase/form_showcase.dart';
import '../showcase/breadcrumb_showcase.dart';
import '../showcase/helpers_showcase.dart';
import '../showcase/utilities_showcase.dart';
import '../showcase/heading_showcase.dart';
import '../showcase/card_showcase.dart';
import '../showcase/carousel_showcase.dart';
import '../showcase/collapse_showcase.dart';
import '../showcase/dropdown_showcase.dart';
import '../showcase/list_group_showcase.dart';
import '../showcase/modal_showcase.dart';
import '../showcase/navbar_showcase.dart';
import '../showcase/nav_showcase.dart';
import '../showcase/icon_showcase.dart';
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

  /// Group for sidebar headings (e.g., "Layout", "Components").
  final String? group;
}

// ─── Showcase Shell ───────────────────────────────────────────────────────────

/// Main shell for all showcases.
/// Simply add a new _NavItem to the [_items] list
/// to display a new component.
class ShowcaseShell extends StatefulWidget {
  const ShowcaseShell({super.key});

  @override
  State<ShowcaseShell> createState() => _ShowcaseShellState();
}

class _ShowcaseShellState extends State<ShowcaseShell> {
  // ── Navigation Items ────────────────────────────────────────────────────────
  // Simply append new components here!
  final List<_NavItem> _items = [
    // ── Layout ───────────────────────────────────────────────────────────────
    _NavItem(
      group: 'Layout',
      label: 'Grid System',
      icon: BsIcons.grid3x3GapFill,
      page: GridShowcase(),
    ),
    _NavItem(
      group: 'Layout',
      label: 'Themes',
      icon: BsIcons.paletteFill,
      page: ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (context, mode, _) {
          return ThemeShowcase(
            currentMode: mode,
            onThemeChanged: (newMode) {
              themeNotifier.value = newMode;
            },
          );
        },
      ),
    ),

    // ── Components ───────────────────────────────────────────────────────────
    _NavItem(
      group: 'Components',
      label: 'Accordion',
      icon: BsIcons.chevronDown,
      page: AccordionShowcase(),
    ),
    _NavItem(
      group: 'Components',
      label: 'Alert',
      icon: BsIcons.exclamationOctagonFill,
      page: AlertShowcase(),
    ),
    _NavItem(
      group: 'Components',
      label: 'Badge',
      icon: BsIcons.bookmarkFill,
      page: BadgeShowcase(),
    ),
    _NavItem(
      group: 'Components',
      label: 'Breadcrumb',
      icon: BsIcons.slashSquareFill,
      page: BreadcrumbShowcase(),
    ),
    _NavItem(
      group: 'Components',
      label: 'Buttons',
      icon: BsIcons.playCircleFill,
      page: ButtonShowcase(),
    ),
    _NavItem(
      group: 'Components',
      label: 'Card',
      icon: BsIcons.cardText,
      page: const CardShowcase(),
    ),
    _NavItem(
      group: 'Components',
      label: 'Carousel',
      icon: BsIcons.images,
      page: const CarouselShowcase(),
    ),
    _NavItem(
      group: 'Components',
      label: 'Collapse',
      icon: BsIcons.arrowsAngleContract,
      page: const CollapseShowcase(),
    ),
    _NavItem(
      group: 'Components',
      label: 'Dropdown',
      icon: BsIcons.menuButtonWideFill,
      page: const DropdownShowcase(),
    ),
    _NavItem(
      group: 'Components',
      label: 'Figure',
      icon: BsIcons.imageFill,
      page: FigureShowcase(),
    ),
    _NavItem(
      group: 'Components',
      label: 'Forms',
      icon: BsIcons.inputCursorText,
      page: FormShowcase(),
    ),
    _NavItem(
      group: 'Components',
      label: 'Headings',
      icon: BsIcons.typeH1,
      page: const HeadingShowcase(),
    ),
    _NavItem(
      group: 'Components',
      label: 'Icons',
      icon: BsIcons.starFill,
      page: const IconShowcase(),
    ),
    _NavItem(
      group: 'Components',
      label: 'Image',
      icon: BsIcons.image,
      page: ImageShowcase(),
    ),
    _NavItem(
      group: 'Components',
      label: 'Table',
      icon: BsIcons.table,
      page: TableShowcase(),
    ),
    _NavItem(
      group: 'Components',
      label: 'List Group',
      icon: BsIcons.listUl,
      page: const ListGroupShowcase(),
    ),
    _NavItem(
      group: 'Components',
      label: 'Modal',
      icon: BsIcons.window,
      page: const ModalShowcase(),
    ),
    _NavItem(
      group: 'Components',
      label: 'Navbar',
      icon: BsIcons.segmentedNav,
      page: const NavbarShowcase(),
    ),
    _NavItem(
      group: 'Components',
      label: 'Navs & Tabs',
      icon: BsIcons.compass,
      page: const NavShowcase(),
    ),

    // ── Helpers ──────────────────────────────────────────────────────────────
    _NavItem(
      group: 'Helpers',
      label: 'Helpers',
      icon: BsIcons.questionCircle,
      page: HelpersShowcase(),
    ),

    // ── Utilities ────────────────────────────────────────────────────────────
    _NavItem(
      group: 'Utilities',
      label: 'Utilities',
      icon: BsIcons.wrench,
      page: UtilitiesShowcase(),
    ),
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
          // ── Vertical Divider ────────────────────────────────────────────────
          VerticalDivider(width: 1, color: context.bs.border),
          // ── Content ───────────────────────────────────────────────────────────
          _items[_selectedIndex].page.expanded(),
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
    // Build sidebar entries with group headings.
    final List<Widget> sidebarChildren = [];
    String? lastGroup;

    for (int i = 0; i < items.length; i++) {
      final item = items[i];

      // Insert group heading if the group changes.
      if (item.group != null && item.group != lastGroup) {
        if (lastGroup != null) {
          // Divider between groups
          sidebarChildren.add(
            Divider(color: context.bs.border, height: 1).py2(),
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
        color: context.bs.bodyBg,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Logo / Header ──────────────────────────────────────────────────
            const _SidebarHeader(),
            const Divider(color: Color(0xFF495057), height: 1),
            // ── Nav Items ──────────────────────────────────────────────────────
            ListView(children: sidebarChildren).px2().py2().expanded(),
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
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: context.bs.primary,
            borderRadius: BsRadius.md,
          ),
          child: const BsIcon(BsIcons.bootstrap, color: Colors.white, size: 20),
        ),
        const SizedBox(width: BsSpacing.s2),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bootstrap UI',
              style: BsTypography.body.copyWith(
                color: context.bs.bodyText,
                fontWeight: BsTypography.weightBold,
                fontSize: 14,
              ),
            ),
            Text(
              'Flutter Components',
              style: BsTypography.body.copyWith(
                color: context.bs.bodyTextSecondary,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ],
    ).p3();
  }
}

// ─── Group Label ─────────────────────────────────────────────────────────────

class _GroupLabel extends StatelessWidget {
  const _GroupLabel(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label.toUpperCase(),
      style: BsTypography.body.copyWith(
        color: const Color(0xFF6c757d),
        fontSize: 10,
        fontWeight: BsTypography.weightBold,
        letterSpacing: 1.2,
      ),
    ).ps2().pe2().pt2().pb1();
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
    final bs = context.bs;

    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Material(
        color: Colors.transparent,
        borderRadius: BsRadius.md,
        child: InkWell(
          mouseCursor: SystemMouseCursors.click,
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
                  ? bs.primary.withValues(alpha: 0.2)
                  : Colors.transparent,
              borderRadius: BsRadius.md,
              border: isSelected
                  ? Border.all(color: bs.primary.withValues(alpha: 0.4))
                  : null,
            ),
            child: Row(
              children: [
                BsIcon(
                  item.icon,
                  size: 16,
                  color: isSelected ? bs.primary : const Color(0xFFadb5bd),
                ),
                const SizedBox(width: BsSpacing.s2),
                Text(
                  item.label,
                  style: BsTypography.body.copyWith(
                    fontSize: 13,
                    color: isSelected
                        ? context.bs.bodyText
                        : context.bs.bodyText,
                    fontWeight: isSelected
                        ? BsTypography.weightBold
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
    return Text(
      'Bootstrap 5 · Flutter',
      style: BsTypography.body.copyWith(
        color: context.bs.bodyTextSecondary,
        fontSize: 11,
      ),
    ).p3();
  }
}

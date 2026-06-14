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
import '../showcase/typography_showcase.dart';
import '../showcase/card_showcase.dart';
import '../showcase/carousel_showcase.dart';
import '../showcase/collapse_showcase.dart';
import '../showcase/dropdown_showcase.dart';
import '../showcase/list_group_showcase.dart';
import '../showcase/modal_showcase.dart';
import '../showcase/navbar_showcase.dart';
import '../showcase/nav_showcase.dart';
import '../showcase/icon_showcase.dart';
import '../showcase/offcanvas_showcase.dart';
import '../showcase/pagination_showcase.dart';
import '../showcase/placeholder_showcase.dart';
import '../showcase/popover_showcase.dart';
import '../showcase/progress_showcase.dart';
import '../showcase/scrollspy_showcase.dart';
import '../showcase/spinner_showcase.dart';
import '../showcase/toast_showcase.dart';
import '../showcase/tooltip_showcase.dart';
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
      label: 'Typography',
      icon: BsIcons.typeH1,
      page: const TypographyShowcase(),
    ),
    _NavItem(
      group: 'Components',
      label: 'Icons',
      icon: BsIcons.starFill,
      page: const IconShowcase(),
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
      label: 'Offcanvas',
      icon: BsIcons.layoutSidebar,
      page: const OffcanvasShowcase(),
    ),
    _NavItem(
      group: 'Components',
      label: 'Pagination',
      icon: BsIcons.listOl,
      page: const PaginationShowcase(),
    ),
    _NavItem(
      group: 'Components',
      label: 'Placeholder',
      icon: BsIcons.threeDots,
      page: const PlaceholderShowcase(),
    ),
    _NavItem(
      group: 'Components',
      label: 'Popover',
      icon: BsIcons.chatSquareText,
      page: const PopoverShowcase(),
    ),
    _NavItem(
      group: 'Components',
      label: 'Progress',
      icon: BsIcons.barChart,
      page: const ProgressShowcase(),
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
    _NavItem(
      group: 'Components',
      label: 'Scrollspy',
      icon: BsIcons.eye,
      page: const ScrollspyShowcase(),
    ),
    _NavItem(
      group: 'Components',
      label: 'Spinners',
      icon: BsIcons.arrowRepeat,
      page: const SpinnerShowcase(),
    ),
    _NavItem(
      group: 'Components',
      label: 'Toasts',
      icon: BsIcons.appIndicator,
      page: const ToastShowcase(),
    ),
    _NavItem(
      group: 'Components',
      label: 'Tooltips',
      icon: BsIcons.infoCircle,
      page: const TooltipShowcase(),
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
  bool _isSidebarCollapsed = false;

  void _openNavigationOffcanvas(BuildContext context) {
    showBsOffcanvas<void>(
      context: context,
      placement: BsOffcanvasPlacement.start,
      builder: (context) {
        return BsOffcanvas(
          width: 280,
          header: const BsOffcanvasHeader(
            child: Text('Navigation'),
          ),
          body: BsOffcanvasBody(
            padding: EdgeInsets.zero,
            scrollable: false,
            child: _Sidebar(
              items: _items,
              selectedIndex: _selectedIndex,
              onSelect: (index) {
                setState(() => _selectedIndex = index);
                Navigator.pop(context);
              },
              isCollapsed: false,
              showToggle: false,
              width: double.infinity,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < BsBreakpoints.lg;

    if (isMobile) {
      return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              BsNavbar(
                expand: BsNavbarExpand.never,
                brand: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
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
                          Text(
                            'Bootstrap UI',
                            style: BsTypography.body.copyWith(
                              color: context.bs.bodyText,
                              fontWeight: BsTypography.weightBold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      BsNavbarToggler(
                        onPressed: () => _openNavigationOffcanvas(context),
                        isOpen: false,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: _items[_selectedIndex].page,
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Sidebar ──────────────────────────────────────────────────────────
          _Sidebar(
            items: _items,
            selectedIndex: _selectedIndex,
            onSelect: (index) => setState(() => _selectedIndex = index),
            isCollapsed: _isSidebarCollapsed,
            onToggleCollapse: () => setState(() => _isSidebarCollapsed = !_isSidebarCollapsed),
            showToggle: true,
          ),
          // ── Vertical Divider ────────────────────────────────────────────────
          VerticalDivider(width: 1, color: context.bs.border),
          // ── Content ───────────────────────────────────────────────────────────
          Expanded(
            child: SafeArea(
              child: _items[_selectedIndex].page,
            ),
          ),
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
    this.isCollapsed = false,
    this.onToggleCollapse,
    this.showToggle = true,
    this.width,
  });

  final List<_NavItem> items;
  final int selectedIndex;
  final ValueChanged<int> onSelect;
  final bool isCollapsed;
  final VoidCallback? onToggleCollapse;
  final bool showToggle;
  final double? width;

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
        if (!isCollapsed) {
          sidebarChildren.add(_GroupLabel(item.group!));
        }
        lastGroup = item.group;
      }

      sidebarChildren.add(
        _NavTile(
          item: item,
          isSelected: selectedIndex == i,
          onTap: () => onSelect(i),
          isCollapsed: isCollapsed,
        ),
      );
    }

    return SizedBox(
      width: width ?? (isCollapsed ? 70.0 : 220.0),
      child: ColoredBox(
        color: context.bs.bodyBg,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Logo / Header ──────────────────────────────────────────────────
            _SidebarHeader(
              isCollapsed: isCollapsed,
              onToggle: onToggleCollapse ?? () {},
              showToggle: showToggle,
            ),
            const Divider(color: Color(0xFF495057), height: 1),
            // ── Nav Items ──────────────────────────────────────────────────────
            ListView(children: sidebarChildren).px2().py2().expanded(),
            // ── Footer ─────────────────────────────────────────────────────────
            const Divider(color: Color(0xFF495057), height: 1),
            _SidebarFooter(isCollapsed: isCollapsed),
          ],
        ),
      ),
    );
  }
}

// ─── Sidebar Header ───────────────────────────────────────────────────────────

class _SidebarHeader extends StatelessWidget {
  const _SidebarHeader({
    required this.isCollapsed,
    required this.onToggle,
    this.showToggle = true,
  });

  final bool isCollapsed;
  final VoidCallback onToggle;
  final bool showToggle;

  @override
  Widget build(BuildContext context) {
    if (isCollapsed) {
      return Column(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: context.bs.primary,
              borderRadius: BsRadius.md,
            ),
            child: const BsIcon(BsIcons.bootstrap, color: Colors.white, size: 20),
          ).mb2(),
          IconButton(
            icon: const Icon(Icons.chevron_right, size: 16),
            onPressed: onToggle,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            style: IconButton.styleFrom(
              minimumSize: const Size(24, 24),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      ).py3();
    }

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
        Expanded(
          child: Column(
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
        ),
        if (showToggle)
          IconButton(
            icon: const Icon(Icons.chevron_left, size: 16),
            onPressed: onToggle,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            style: IconButton.styleFrom(
              minimumSize: const Size(24, 24),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
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
    required this.isCollapsed,
  });

  final _NavItem item;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isCollapsed;

  @override
  Widget build(BuildContext context) {
    final bs = context.bs;

    Widget iconWidget = BsIcon(
      item.icon,
      size: 16,
      color: isSelected ? bs.primary : const Color(0xFFadb5bd),
    );

    if (isCollapsed) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 2),
        child: Tooltip(
          message: item.label,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            decoration: BoxDecoration(
              color: isSelected
                  ? bs.primary.withValues(alpha: 0.2)
                  : Colors.transparent,
              borderRadius: BsRadius.md,
              border: isSelected
                  ? Border.all(color: bs.primary.withValues(alpha: 0.4))
                  : null,
            ),
            child: Material(
              color: Colors.transparent,
              borderRadius: BsRadius.md,
              child: InkWell(
                mouseCursor: SystemMouseCursors.click,
                onTap: onTap,
                borderRadius: BsRadius.md,
                hoverColor: Colors.white.withValues(alpha: 0.05),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: iconWidget,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: isSelected
              ? bs.primary.withValues(alpha: 0.2)
              : Colors.transparent,
          borderRadius: BsRadius.md,
          border: isSelected
              ? Border.all(color: bs.primary.withValues(alpha: 0.4))
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BsRadius.md,
          child: InkWell(
            mouseCursor: SystemMouseCursors.click,
            onTap: onTap,
            borderRadius: BsRadius.md,
            hoverColor: Colors.white.withValues(alpha: 0.05),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: BsSpacing.s2,
                vertical: 10,
              ),
              child: Row(
                children: [
                  iconWidget,
                  const SizedBox(width: BsSpacing.s2),
                  Expanded(
                    child: Text(
                      item.label,
                      overflow: TextOverflow.ellipsis,
                      style: BsTypography.body.copyWith(
                        fontSize: 13,
                        color: context.bs.bodyText,
                        fontWeight: isSelected
                            ? BsTypography.weightBold
                            : BsTypography.weightNormal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Sidebar Footer ───────────────────────────────────────────────────────────

class _SidebarFooter extends StatelessWidget {
  const _SidebarFooter({required this.isCollapsed});
  final bool isCollapsed;

  @override
  Widget build(BuildContext context) {
    if (isCollapsed) {
      return Text(
        'B5',
        textAlign: TextAlign.center,
        style: BsTypography.body.copyWith(
          color: context.bs.bodyTextSecondary,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ).py3();
    }

    return Text(
      'Bootstrap 5 · Flutter',
      style: BsTypography.body.copyWith(
        color: context.bs.bodyTextSecondary,
        fontSize: 11,
      ),
    ).p3();
  }
}

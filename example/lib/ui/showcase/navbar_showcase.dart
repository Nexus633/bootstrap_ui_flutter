import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';
import 'package:flutter/material.dart';

class NavbarShowcase extends StatefulWidget {
  const NavbarShowcase({super.key});

  @override
  State<NavbarShowcase> createState() => _NavbarShowcaseState();
}

class _NavbarShowcaseState extends State<NavbarShowcase> {
  String _activeLink = 'Home';

  @override
  Widget build(BuildContext context) {
    final theme = context.bs;

    return Scaffold(
      backgroundColor: theme.bodyBg,
      appBar: AppBar(
        backgroundColor: theme.bodyBg,
        foregroundColor: theme.bodyText,
        title: const Text('Navbars'),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: theme.border, height: 1.0),
        ),
      ),
      body: SingleChildScrollView(
        child: BsContainer(
          padding: const EdgeInsets.all(0),
          type: BsContainerType.fluid,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─── Introduction ──────────────────────────────────────────────
              const Text(
                'Navbars are responsive navigation headers that support branding, links, forms, and color schemes. They automatically collapse on smaller screens and expand on larger ones based on the configured breakpoint.',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ).mb4().px2(),

              // ─── 1. Default Light Navbar ───────────────────────────────────
              _sectionTitle('Default Light Navbar').px2(),
              const Text(
                'A standard light navbar with navigation links, branding, and an inline search form. It expands horizontally at the lg (992px) breakpoint.',
                style: TextStyle(color: Colors.grey),
              ).mb3().px2(),

              BsNavbar(
                expand: BsNavbarExpand.md,
                brand: BsNavbarBrand(
                  child: const Text('Navbar'),
                  onPressed: () {},
                ),
                collapse: BsNavbarCollapse(
                  children: [
                    BsNavbarNav(
                      children: [
                        BsNavbarLink(
                          label: 'Home',
                          active: _activeLink == 'Home',
                          onPressed: () => setState(() => _activeLink = 'Home'),
                        ),
                        BsNavbarLink(
                          label: 'Features',
                          active: _activeLink == 'Features',
                          onPressed: () =>
                              setState(() => _activeLink = 'Features'),
                        ),
                        BsNavbarLink(
                          label: 'Pricing',
                          active: _activeLink == 'Pricing',
                          onPressed: () =>
                              setState(() => _activeLink = 'Pricing'),
                        ),
                        const BsNavbarLink(label: 'Disabled', disabled: true),
                      ],
                    ),
                    const BsNavbarSpacer(),
                    // Inline search form using BsInput and BsButton (gap-2)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 180,
                          child: BsInput(
                            placeholder: 'Search',
                            size: BsInputSize.sm,
                          ),
                        ),
                        const SizedBox(width: 8),
                        BsButton(
                          label: 'Search',
                          variant: BsButtonVariant.outlineSuccess,
                          size: BsButtonSize.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ).mb4(),

              // ─── 2. Color Schemes (Bootstrap 5.3) ──────────────────────────
              _sectionTitle('Color Schemes').px2(),
              const Text(
                "Navbar’s color schemes are now powered by theme-level dark mode since v5.3.0. You can set them using the dark property (which maps to data-bs-theme=\"dark\") alongside background utilities or custom background colors.",
                style: TextStyle(color: Colors.grey),
              ).mb3().px2(),

              // Example 1: Dark Navbar (bg-dark)
              const Text(
                'Dark navbar with a dark background:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ).mb2().px2(),
              BsNavbar(
                dark: false,
                expand: BsNavbarExpand.lg,
                brand: BsNavbarBrand(
                  child: const Text('Navbar'),
                  onPressed: () {},
                ),
                collapse: BsNavbarCollapse(
                  children: [
                    BsNavbarNav(
                      children: [
                        BsNavbarLink(
                          label: 'Home',
                          active: _activeLink == 'HomeDark',
                          onPressed: () =>
                              setState(() => _activeLink = 'HomeDark'),
                        ),
                        BsNavbarLink(
                          label: 'Features',
                          active: _activeLink == 'FeaturesDark',
                          onPressed: () =>
                              setState(() => _activeLink = 'FeaturesDark'),
                        ),
                        BsNavbarLink(
                          label: 'Pricing',
                          active: _activeLink == 'PricingDark',
                          onPressed: () =>
                              setState(() => _activeLink = 'PricingDark'),
                        ),
                        const BsNavbarLink(label: 'Disabled', disabled: true),
                      ],
                    ),
                    const BsNavbarSpacer(),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 180,
                          child: BsInput(
                            placeholder: 'Search',
                            size: BsInputSize.sm,
                          ),
                        ),
                        const SizedBox(width: 8),
                        BsButton(
                          label: 'Search',
                          variant: BsButtonVariant.outlineSuccess,
                          size: BsButtonSize.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ).mb4(),

              // Example 2: Primary Navbar (bg-primary)
              const Text(
                'Primary navbar with a blue background (using theme.primary):',
                style: TextStyle(fontWeight: FontWeight.bold),
              ).mb2().px2(),
              BsNavbar(
                dark: true,
                expand: BsNavbarExpand.lg,
                background: theme.primary,
                brand: BsNavbarBrand(
                  child: const Text('Navbar'),
                  onPressed: () {},
                ),
                collapse: BsNavbarCollapse(
                  children: [
                    BsNavbarNav(
                      children: [
                        BsNavbarLink(
                          label: 'Home',
                          active: _activeLink == 'HomePrimary',
                          onPressed: () =>
                              setState(() => _activeLink = 'HomePrimary'),
                        ),
                        BsNavbarLink(
                          label: 'Features',
                          active: _activeLink == 'FeaturesPrimary',
                          onPressed: () =>
                              setState(() => _activeLink = 'FeaturesPrimary'),
                        ),
                        BsNavbarLink(
                          label: 'Pricing',
                          active: _activeLink == 'PricingPrimary',
                          onPressed: () =>
                              setState(() => _activeLink = 'PricingPrimary'),
                        ),
                        const BsNavbarLink(label: 'Disabled', disabled: true),
                      ],
                    ),
                    const BsNavbarSpacer(),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 180,
                          child: BsInput(
                            placeholder: 'Search',
                            size: BsInputSize.sm,
                          ),
                        ),
                        const SizedBox(width: 8),
                        BsButton(
                          label: 'Search',
                          variant: BsButtonVariant.light,
                          size: BsButtonSize.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ).mb4(),

              // Example 3: Custom Light Navbar (background-color: #e3f2fd)
              const Text(
                'Navbar with a custom light background color (#e3f2fd):',
                style: TextStyle(fontWeight: FontWeight.bold),
              ).mb2().px2(),
              BsNavbar(
                expand: BsNavbarExpand.lg,
                background: const Color(0xFFE3F2FD),
                brand: BsNavbarBrand(
                  child: const Text('Navbar'),
                  onPressed: () {},
                ),
                collapse: BsNavbarCollapse(
                  children: [
                    BsNavbarNav(
                      children: [
                        BsNavbarLink(
                          label: 'Home',
                          active: _activeLink == 'HomeCustom',
                          onPressed: () =>
                              setState(() => _activeLink = 'HomeCustom'),
                        ),
                        BsNavbarLink(
                          label: 'Features',
                          active: _activeLink == 'FeaturesCustom',
                          onPressed: () =>
                              setState(() => _activeLink = 'FeaturesCustom'),
                        ),
                        BsNavbarLink(
                          label: 'Pricing',
                          active: _activeLink == 'PricingCustom',
                          onPressed: () =>
                              setState(() => _activeLink = 'PricingCustom'),
                        ),
                        const BsNavbarLink(label: 'Disabled', disabled: true),
                      ],
                    ),
                    const BsNavbarSpacer(),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 180,
                          child: BsInput(
                            placeholder: 'Search',
                            size: BsInputSize.sm,
                          ),
                        ),
                        const SizedBox(width: 8),
                        BsButton(
                          label: 'Search',
                          variant: BsButtonVariant.outlinePrimary,
                          size: BsButtonSize.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ).mb4(),

              // Example 4: Link Colors & Brand Customization (variant and color)
              _sectionTitle('Link Colors & Brand Customization').px2(),
              const Text(
                'Customize individual links and branding colors using the variant and color properties. Active and hover states dynamically adapt to these colors.',
                style: TextStyle(color: Colors.grey),
              ).mb3().px2(),
              BsNavbar(
                expand: BsNavbarExpand.lg,
                brand: BsNavbarBrand(
                  variant: BsNavbarLinkVariant.danger,
                  child: const Text('Danger Brand'),
                  onPressed: () {},
                ),
                collapse: BsNavbarCollapse(
                  children: [
                    BsNavbarNav(
                      children: [
                        BsNavbarLink(
                          label: 'Primary Link',
                          variant: BsNavbarLinkVariant.primary,
                          active: true,
                        ),
                        BsNavbarLink(
                          label: 'Secondary Link',
                          variant: BsNavbarLinkVariant.secondary,
                        ),
                        const BsNavbarLink(
                          label: 'Success Link',
                          variant: BsNavbarLinkVariant.success,
                        ),
                        const BsNavbarLink(
                          label: 'Warning Link',
                          variant: BsNavbarLinkVariant.warning,
                        ),
                        const BsNavbarLink(
                          label: 'Custom Pink',
                          color: Colors.pink,
                        ),
                      ],
                    ),
                  ],
                ),
              ).mb4(),

              // Example 5: Icon & Image Branding
              _sectionTitle('Icon & Image Branding').px2(),
              const Text(
                'Show icons next to brand names using BsNavbarIconBrand, or display logo images directly from a URL using the BsNavbarIconBrand.network constructor.',
                style: TextStyle(color: Colors.grey),
              ).mb3().px2(),

              // Showcase 5.1: Icon Brand + Text Brand
              const Text(
                'Icon Brand next to a Text Brand:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ).mb2().px2(),
              BsNavbar(
                expand: BsNavbarExpand.lg,
                brand: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BsNavbarIconBrand(
                      child: const Icon(Icons.flutter_dash_rounded),
                      onPressed: () {},
                    ),
                    BsNavbarBrand(
                      child: const Text('Flutter Bootstrap'),
                      onPressed: () {},
                    ),
                  ],
                ),
                collapse: BsNavbarCollapse(
                  children: [
                    BsNavbarNav(
                      children: [
                        BsNavbarLink(
                          label: 'Home',
                          active: true,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ).mb3(),

              // Showcase 5.2: Network Image Brand
              const Text(
                'Image Brand from Network URL:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ).mb2().px2(),
              BsNavbar(
                expand: BsNavbarExpand.lg,
                brand: BsNavbarIconBrand.network(
                  'https://storage.googleapis.com/cms-storage-bucket/0dbfcc77d22115a337ae.svg', // Flutter Logo URL
                  size: 24,
                  onPressed: () {},
                ),
                collapse: BsNavbarCollapse(
                  children: [
                    BsNavbarNav(
                      children: [
                        BsNavbarLink(
                          label: 'Docs',
                          active: true,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ).mb4(),

              // Example 6: Navbar with Dropdown
              _sectionTitle('Navbar with Dropdown').px2(),
              const Text(
                'Integrate BsDropdown widgets within the navbar. They can be styled as simple text triggers to match the rest of the navbar links.',
                style: TextStyle(color: Colors.grey),
              ).mb3().px2(),
              BsNavbar(
                expand: BsNavbarExpand.lg,
                brand: BsNavbarBrand(
                  child: const Text('NavbarDropdown'),
                  onPressed: () {},
                ),
                collapse: BsNavbarCollapse(
                  children: [
                    BsNavbarNav(
                      children: [
                        BsNavbarLink(
                          label: 'Home',
                          active: true,
                          onPressed: () {},
                        ),
                        BsDropdown(
                          toggleBuilder: (context, toggleMenu, isOpen) {
                            final theme = context.bs;
                            return MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: toggleMenu,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Dropdown',
                                        style: TextStyle(
                                          color: theme.bodyText.withValues(alpha: isOpen ? 0.9 : 0.55),
                                          fontSize: 16.0,
                                          fontWeight: isOpen ? FontWeight.w500 : FontWeight.normal,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      AnimatedRotation(
                                        turns: isOpen ? 0.5 : 0.0,
                                        duration: const Duration(milliseconds: 150),
                                        child: Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 16.0,
                                          color: theme.bodyText.withValues(alpha: isOpen ? 0.9 : 0.55),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          menu: BsDropdownMenu(
                            children: [
                              BsDropdownItem(
                                child: const Text('Action 1'),
                                onPressed: () {},
                              ),
                              BsDropdownItem(
                                child: const Text('Action 2'),
                                onPressed: () {},
                              ),
                              const BsDropdownDivider(),
                              BsDropdownItem(
                                child: const Text('Separated Link'),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ).mb4(),
            ],
          ),
        ),
      ),

    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    ).mb2();
  }
}

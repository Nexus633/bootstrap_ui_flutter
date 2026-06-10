import 'package:flutter/material.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

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
                    'Navbars',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ).pb2(),
                  Text(
                    'Responsive navigation headers that support branding, navigation links, forms, and custom color schemas with built-in dark/light mode toggles.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: 0.9),
                      height: 1.4,
                    ),
                  ),
                ],
              ).p4(),
            ).mb(32),

            // 1. Default Light Navbar
            _Section(
              title: 'Default Light Navbar',
              description: 'A standard light navbar with navigation links, branding, and an inline search form. Expands at md breakpoint.',
              child: BsNavbar(
                expand: BsNavbarExpand.md,
                brand: BsNavbarBrand(
                  child: const Text('BrandLogo'),
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
                          onPressed: () => setState(() => _activeLink = 'Features'),
                        ),
                        BsNavbarLink(
                          label: 'Pricing',
                          active: _activeLink == 'Pricing',
                          onPressed: () => setState(() => _activeLink = 'Pricing'),
                        ),
                        const BsNavbarLink(label: 'Disabled', disabled: true),
                      ],
                    ),
                    const BsNavbarSpacer(),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 150,
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
              ),
            ),

            // 2. Color Schemes
            _Section(
              title: 'Color Schemes',
              description: 'Power navbars with different theme backgrounds like dark, primary, or custom colors.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Dark Navbar:').fwBold().fs6().pb2(),
                  BsNavbar(
                    dark: true,
                    expand: BsNavbarExpand.lg,
                    background: const Color(0xFF212529),
                    brand: BsNavbarBrand(
                      child: const Text('DarkBrand'),
                      onPressed: () {},
                    ),
                    collapse: BsNavbarCollapse(
                      children: [
                        BsNavbarNav(
                          children: [
                            BsNavbarLink(
                              label: 'Dashboard',
                              active: true,
                              onPressed: () {},
                            ),
                            BsNavbarLink(
                              label: 'Settings',
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ).pb4(),

                  const Text('Primary Color Background (theme.primary):').fwBold().fs6().pb2(),
                  BsNavbar(
                    dark: true,
                    expand: BsNavbarExpand.lg,
                    background: theme.primary,
                    brand: BsNavbarBrand(
                      child: const Text('PrimaryBrand'),
                      onPressed: () {},
                    ),
                    collapse: BsNavbarCollapse(
                      children: [
                        BsNavbarNav(
                          children: [
                            BsNavbarLink(
                              label: 'Services',
                              active: true,
                              onPressed: () {},
                            ),
                            BsNavbarLink(
                              label: 'Projects',
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ).pb4(),

                  const Text('Custom Soft Blue Background (#e3f2fd):').fwBold().fs6().pb2(),
                  BsNavbar(
                    expand: BsNavbarExpand.lg,
                    background: const Color(0xFFE3F2FD),
                    brand: BsNavbarBrand(
                      child: const Text('SoftBlueBrand'),
                      onPressed: () {},
                    ),
                    collapse: BsNavbarCollapse(
                      children: [
                        BsNavbarNav(
                          children: [
                            BsNavbarLink(
                              label: 'About Us',
                              active: true,
                              onPressed: () {},
                            ),
                            BsNavbarLink(
                              label: 'Careers',
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 3. Link Colors & Customization
            _Section(
              title: 'Link Colors & Customization',
              description: 'Override individual link and branding colors using variant presets or custom colors.',
              child: BsNavbar(
                expand: BsNavbarExpand.lg,
                brand: BsNavbarBrand(
                  variant: BsVariant.danger,
                  child: const Text('Danger Brand'),
                  onPressed: () {},
                ),
                collapse: BsNavbarCollapse(
                  children: [
                    BsNavbarNav(
                      children: [
                        BsNavbarLink(
                          label: 'Primary Link',
                          variant: BsVariant.primary,
                          active: true,
                        ),
                        BsNavbarLink(
                          label: 'Secondary Link',
                          variant: BsVariant.secondary,
                        ),
                        const BsNavbarLink(
                          label: 'Success Link',
                          variant: BsVariant.success,
                        ),
                        const BsNavbarLink(
                          label: 'Custom Pink',
                          color: Colors.pink,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // 4. Icon & Image Branding
            _Section(
              title: 'Icon & Image Branding',
              description: 'Embed logos or graphical elements directly inside the brand headers.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Icon Branding:').fwBold().fs6().pb2(),
                  BsNavbar(
                    expand: BsNavbarExpand.lg,
                    brand: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BsNavbarIconBrand(
                          child: const BsIcon(BsIcons.bootstrap),
                          onPressed: () {},
                        ),
                        BsNavbarBrand(
                          child: const Text('Bootstrap UI'),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    collapse: BsNavbarCollapse(
                      children: [
                        BsNavbarNav(
                          children: [
                            BsNavbarLink(label: 'Home', active: true, onPressed: () {}),
                          ],
                        ),
                      ],
                    ),
                  ).pb4(),

                  const Text('Network Image Logo Brand:').fwBold().fs6().pb2(),
                  BsNavbar(
                    expand: BsNavbarExpand.lg,
                    brand: BsNavbarIconBrand.network(
                      'https://storage.googleapis.com/cms-storage-bucket/0dbfcc77d22115a337ae.svg', // Flutter Logo
                      size: 24,
                      onPressed: () {},
                    ),
                    collapse: BsNavbarCollapse(
                      children: [
                        BsNavbarNav(
                          children: [
                            BsNavbarLink(label: 'SDK Documentation', active: true, onPressed: () {}),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 5. Dropdown Navigation
            _Section(
              title: 'Navbar with Dropdown',
              description: 'Integrate dropdown overlay menus inside responsive headers.',
              child: BsNavbar(
                expand: BsNavbarExpand.lg,
                brand: BsNavbarBrand(
                  child: const Text('DropdownNav'),
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
                            final themeData = context.bs;
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
                                        'Explore Menu',
                                        style: TextStyle(
                                          color: themeData.bodyText.withValues(alpha: isOpen ? 0.9 : 0.55),
                                          fontSize: 16.0,
                                          fontWeight: isOpen ? FontWeight.w500 : FontWeight.normal,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      AnimatedRotation(
                                        turns: isOpen ? 0.5 : 0.0,
                                        duration: const Duration(milliseconds: 150),
                                        child: BsIcon(
                                          BsIcons.chevronDown,
                                          size: 16.0,
                                          color: themeData.bodyText.withValues(alpha: isOpen ? 0.9 : 0.55),
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
                                child: const Text('Developer API'),
                                onPressed: () {},
                              ),
                              BsDropdownItem(
                                child: const Text('Release Notes'),
                                onPressed: () {},
                              ),
                              const BsDropdownDivider(),
                              BsDropdownItem(
                                child: const Text('Terms of Use'),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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

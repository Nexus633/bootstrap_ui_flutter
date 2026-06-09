import 'package:flutter/material.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

class NavShowcase extends StatefulWidget {
  const NavShowcase({super.key});

  @override
  State<NavShowcase> createState() => _NavShowcaseState();
}

class _NavShowcaseState extends State<NavShowcase> {
  int _activeTab1 = 0;
  int _activePill = 0;
  int _activeUnderline = 0;
  int _activeVerticalTab = 0;

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
                    'Navs & Tabs',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ).pb2(),
                  Text(
                    'Flexible and highly customizable navigation components. Build tabbed interfaces, pills, inline lists, or vertically stacked sidebar menus.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: 0.9),
                      height: 1.4,
                    ),
                  ),
                ],
              ).p4(),
            ).mb(32),

            // 1. Plain Nav Links
            _Section(
              title: 'Plain Nav Links & Colors',
              description: 'Standard navigation without tabs, featuring active, hover, disabled and custom color overrides.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BsNav(
                    variant: BsNavVariant.plain,
                    children: [
                      BsNavLink(label: 'Active link', active: true, onPressed: () {}),
                      BsNavLink(label: 'Standard Link', onPressed: () {}),
                      BsNavLink(label: 'Another Link', onPressed: () {}),
                      const BsNavLink(label: 'Disabled Link', disabled: true),
                    ],
                  ).pb4(),

                  const Text('Custom Color Overrides:').fwBold().fs6().pb2(),
                  BsNav(
                    variant: BsNavVariant.plain,
                    children: [
                      BsNavLink(
                        label: 'Green Link',
                        active: true,
                        color: Colors.green,
                        activeColor: Colors.green,
                        onPressed: () {},
                      ),
                      BsNavLink(
                        label: 'Orange Link',
                        color: Colors.orange,
                        activeColor: Colors.orange,
                        onPressed: () {},
                      ),
                      BsNavLink(
                        label: 'Red Link',
                        color: Colors.red,
                        activeColor: Colors.red,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 2. Alignment
            _Section(
              title: 'Horizontal Alignment',
              description: 'Align nav items horizontally using center, end, or justified styles.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Alignment: Center').fwBold().fs6().pb2(),
                  BsNav(
                    alignment: BsNavAlignment.center,
                    children: [
                      BsNavLink(label: 'Active', active: true, onPressed: () {}),
                      BsNavLink(label: 'Link', onPressed: () {}),
                      BsNavLink(label: 'Link', onPressed: () {}),
                    ],
                  ).pb4(),

                  const Text('Alignment: End (Right Aligned)').fwBold().fs6().pb2(),
                  BsNav(
                    alignment: BsNavAlignment.end,
                    children: [
                      BsNavLink(label: 'Active', active: true, onPressed: () {}),
                      BsNavLink(label: 'Link', onPressed: () {}),
                      BsNavLink(label: 'Link', onPressed: () {}),
                    ],
                  ).pb4(),

                  const Text('Alignment: Justified (Equal Width)').fwBold().fs6().pb2(),
                  BsNav(
                    alignment: BsNavAlignment.justified,
                    children: [
                      BsNavLink(label: 'Home Tab', active: true, onPressed: () {}),
                      BsNavLink(label: 'Profile Settings', onPressed: () {}),
                      BsNavLink(label: 'System Billing', onPressed: () {}),
                    ],
                  ),
                ],
              ),
            ),

            // 3. Tabs Navigation
            _Section(
              title: 'Tabs & Content Panes',
              description: 'Tab-based layout mapping each active tab item to its corresponding content pane.',
              child: BsCard(
                children: [
                  BsNav(
                    variant: BsNavVariant.tabs,
                    children: [
                      BsNavLink(
                        label: 'Home',
                        active: _activeTab1 == 0,
                        onPressed: () => setState(() => _activeTab1 = 0),
                      ),
                      BsNavLink(
                        label: 'Profile',
                        active: _activeTab1 == 1,
                        onPressed: () => setState(() => _activeTab1 = 1),
                      ),
                      BsNavLink(
                        label: 'Contact',
                        active: _activeTab1 == 2,
                        onPressed: () => setState(() => _activeTab1 = 2),
                      ),
                    ],
                  ).p3(),
                  BsCardBody(
                    child: SizedBox(
                      height: 80,
                      child: BsTabContent(
                        activeIndex: _activeTab1,
                        children: const [
                          BsTabPane(
                            child: Text(
                              'Home Content: Welcome to the Bootstrap-styled home tab pane details!',
                            ),
                          ),
                          BsTabPane(
                            child: Text(
                              'Profile Content: Manage your user profile and settings in this section.',
                            ),
                          ),
                          BsTabPane(
                            child: Text(
                              'Contact Content: Get in touch with our team via email or support channels.',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 4. Pills Navigation
            _Section(
              title: 'Pill Navigation',
              description: 'Round badges/pills layout displaying active states with solid primary highlights.',
              child: Column(
                children: [
                  BsNav(
                    variant: BsNavVariant.pills,
                    children: [
                      BsNavLink(
                        label: 'Overview',
                        active: _activePill == 0,
                        onPressed: () => setState(() => _activePill = 0),
                      ),
                      BsNavLink(
                        label: 'Reports',
                        active: _activePill == 1,
                        onPressed: () => setState(() => _activePill = 1),
                      ),
                      BsNavLink(
                        label: 'Messages',
                        active: _activePill == 2,
                        onPressed: () => setState(() => _activePill = 2),
                      ),
                    ],
                  ).pb3(),
                  BsCard(
                    body: BsCardBody(
                      child: SizedBox(
                        height: 50,
                        child: BsTabContent(
                          activeIndex: _activePill,
                          children: const [
                            BsTabPane(child: Text('Summary of account activity.')),
                            BsTabPane(child: Text('Download financial statistics reports.')),
                            BsTabPane(child: Text('Your inbox messages will display here.')),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 5. Underline Navigation
            _Section(
              title: 'Underline Navigation',
              description: 'Clean modern tab layout featuring a bottom border-underline for active tabs.',
              child: Column(
                children: [
                  BsNav(
                    variant: BsNavVariant.underline,
                    children: [
                      BsNavLink(
                        label: 'General',
                        active: _activeUnderline == 0,
                        onPressed: () => setState(() => _activeUnderline = 0),
                      ),
                      BsNavLink(
                        label: 'Security',
                        active: _activeUnderline == 1,
                        onPressed: () => setState(() => _activeUnderline = 1),
                      ),
                      BsNavLink(
                        label: 'Integrations',
                        active: _activeUnderline == 2,
                        onPressed: () => setState(() => _activeUnderline = 2),
                      ),
                    ],
                  ).pb3(),
                  BsCard(
                    body: BsCardBody(
                      child: SizedBox(
                        height: 50,
                        child: BsTabContent(
                          activeIndex: _activeUnderline,
                          children: const [
                            BsTabPane(child: Text('General app configuration settings.')),
                            BsTabPane(child: Text('Manage passwords, 2FA tokens and sessions.')),
                            BsTabPane(child: Text('Webhook links and developer API integrations.')),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 6. Vertical Stacked
            _Section(
              title: 'Vertical Stacked Tabs',
              description: 'Utilize vertical layout configurations to structure side-aligned navigations.',
              child: BsRow(
                gutterX: BsSpacing.s4,
                children: [
                  BsCol(
                    config: const BsColConfig(xs: 12, md: 3),
                    child: BsNav(
                      variant: BsNavVariant.pills,
                      vertical: true,
                      children: [
                        BsNavLink(
                          label: 'Overview',
                          active: _activeVerticalTab == 0,
                          onPressed: () => setState(() => _activeVerticalTab = 0),
                        ),
                        BsNavLink(
                          label: 'Credentials',
                          active: _activeVerticalTab == 1,
                          onPressed: () => setState(() => _activeVerticalTab = 1),
                        ),
                        BsNavLink(
                          label: 'Invoices',
                          active: _activeVerticalTab == 2,
                          onPressed: () => setState(() => _activeVerticalTab = 2),
                        ),
                      ],
                    ).pb3(),
                  ),
                  BsCol(
                    config: const BsColConfig(xs: 12, md: 9),
                    child: BsCard(
                      body: BsCardBody(
                        child: SizedBox(
                          height: 100,
                          child: BsTabContent(
                            activeIndex: _activeVerticalTab,
                            children: const [
                              BsTabPane(child: Text('Overview: Main dashboard indicators.')),
                              BsTabPane(child: Text('Credentials: Edit passwords, user keys, and tokens.')),
                              BsTabPane(child: Text('Invoices: Review monthly subscription bills and transactions.')),
                            ],
                          ),
                        ),
                      ),
                    ),
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

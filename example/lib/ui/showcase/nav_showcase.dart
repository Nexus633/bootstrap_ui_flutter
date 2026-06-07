import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';
import 'package:flutter/material.dart';

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

    return Scaffold(
      backgroundColor: theme.bodyBg,
      appBar: AppBar(
        title: const Text('Navs and Tabs Showcase'),
        backgroundColor: theme.bodyBg,
        foregroundColor: theme.bodyText,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: theme.border, height: 1.0),
        ),
      ),
      body: SingleChildScrollView(
        child: BsContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─── Plain Navigation Links ──────────────────────────────────────
              _sectionTitle('Plain Nav Links', theme),
              const Text(
                'Base navigation component with simple text links. Supports active and disabled states.',
                style: TextStyle(color: Colors.grey),
              ).mb3(),
              BsNav(
                variant: BsNavVariant.plain,
                children: [
                  BsNavLink(label: 'Active', active: true, onPressed: () {}),
                  BsNavLink(label: 'Link', onPressed: () {}),
                  BsNavLink(label: 'Link', onPressed: () {}),
                  const BsNavLink(label: 'Disabled', disabled: true),
                ],
              ).mb5(),

              // ─── Custom Colored Links ────────────────────────────────────────
              _sectionTitle('Custom Colored Links', theme),
              const Text(
                'Optionally customize text colors for both normal and active states using custom color parameters.',
                style: TextStyle(color: Colors.grey),
              ).mb3(),
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
              ).mb5(),

              // ─── Alignment Options ───────────────────────────────────────────
              _sectionTitle('Horizontal Alignment', theme),
              const Text(
                'Align navigation links to the center, end, or expand them to fill the width (fill / justified).',
                style: TextStyle(color: Colors.grey),
              ).mb3(),
              const Text(
                'Centered (BsNavAlignment.center):',
                style: TextStyle(fontWeight: FontWeight.w600),
              ).mb2(),
              BsNav(
                alignment: BsNavAlignment.center,
                children: [
                  BsNavLink(label: 'Active', active: true, onPressed: () {}),
                  BsNavLink(label: 'Link', onPressed: () {}),
                  BsNavLink(label: 'Link', onPressed: () {}),
                ],
              ).mb3(),
              const Text(
                'Right aligned (BsNavAlignment.end):',
                style: TextStyle(fontWeight: FontWeight.w600),
              ).mb2(),
              BsNav(
                alignment: BsNavAlignment.end,
                children: [
                  BsNavLink(label: 'Active', active: true, onPressed: () {}),
                  BsNavLink(label: 'Link', onPressed: () {}),
                  BsNavLink(label: 'Link', onPressed: () {}),
                ],
              ).mb3(),
              const Text(
                'Justified equal width (BsNavAlignment.justified):',
                style: TextStyle(fontWeight: FontWeight.w600),
              ).mb2(),
              BsNav(
                alignment: BsNavAlignment.justified,
                children: [
                  BsNavLink(label: 'Home', active: true, onPressed: () {}),
                  BsNavLink(label: 'Profile Info', onPressed: () {}),
                  BsNavLink(label: 'Settings', onPressed: () {}),
                ],
              ).mb5(),

              // ─── Tabs Navigation (Functional) ────────────────────────────────
              _sectionTitle('Tabs & Content Panes', theme),
              const Text(
                'Classic tabbed interface with bottom borders. Combined with BsTabContent and BsTabPane to switch views.',
                style: TextStyle(color: Colors.grey),
              ).mb3(),
              BsCard(
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
                      height: 120,
                      child: BsTabContent(
                        activeIndex: _activeTab1,
                        children: const [
                          BsTabPane(
                            child: Text(
                              'Home Content: Welcome to the Bootstrap-styled home tab!',
                            ),
                          ),
                          BsTabPane(
                            child: Text(
                              'Profile Content: Manage your user settings and personal profile details.',
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
              ).mb5(),

              // ─── Pills Navigation ────────────────────────────────────────────
              _sectionTitle('Pills Navigation', theme),
              const Text(
                'Pill-style navigation displaying active links with solid background highlights.',
                style: TextStyle(color: Colors.grey),
              ).mb3(),
              BsNav(
                variant: BsNavVariant.pills,
                children: [
                  BsNavLink(
                    label: 'Home',
                    active: _activePill == 0,
                    onPressed: () => setState(() => _activePill = 0),
                  ),
                  BsNavLink(
                    label: 'Profile',
                    active: _activePill == 1,
                    onPressed: () => setState(() => _activePill = 1),
                  ),
                  BsNavLink(
                    label: 'Messages',
                    active: _activePill == 2,
                    onPressed: () => setState(() => _activePill = 2),
                  ),
                  const BsNavLink(label: 'Disabled', disabled: true),
                ],
              ).mb3(),
              BsCard(
                body: BsCardBody(
                  child: SizedBox(
                    height: 40,
                    child: BsTabContent(
                      activeIndex: _activePill,
                      children: const [
                        BsTabPane(child: Text('Home Pane Content (Pill)')),
                        BsTabPane(child: Text('Profile Pane Content (Pill)')),
                        BsTabPane(child: Text('Messages Pane Content (Pill)')),
                      ],
                    ),
                  ),
                ),
              ).mb5(),

              // ─── Underline Navigation ────────────────────────────────────────
              _sectionTitle('Underline Navigation', theme),
              const Text(
                'Modern navigation variant featuring a clean bottom-line indicator for the active item.',
                style: TextStyle(color: Colors.grey),
              ).mb3(),
              BsNav(
                variant: BsNavVariant.underline,
                children: [
                  BsNavLink(
                    label: 'Dashboard',
                    active: _activeUnderline == 0,
                    onPressed: () => setState(() => _activeUnderline = 0),
                  ),
                  BsNavLink(
                    label: 'Analytics',
                    active: _activeUnderline == 1,
                    onPressed: () => setState(() => _activeUnderline = 1),
                  ),
                  BsNavLink(
                    label: 'Reports',
                    active: _activeUnderline == 2,
                    onPressed: () => setState(() => _activeUnderline = 2),
                  ),
                ],
              ).mb3(),
              BsCard(
                body: BsCardBody(
                  child: SizedBox(
                    height: 40,
                    child: BsTabContent(
                      activeIndex: _activeUnderline,
                      children: const [
                        BsTabPane(child: Text('Dashboard Section Details')),
                        BsTabPane(child: Text('Live Analytics Visualizers')),
                        BsTabPane(child: Text('Exportable Financial Reports')),
                      ],
                    ),
                  ),
                ),
              ).mb5(),

              // ─── Vertical Tabs (Flex Column) ────────────────────────────────
              _sectionTitle('Vertical Stacked Tabs', theme),
              const Text(
                'Align navigation elements vertically using the vertical: true layout. Perfect for sidebar layouts.',
                style: TextStyle(color: Colors.grey),
              ).mb3(),
              BsRow(
                children: [
                  BsCol(
                    config: const BsColConfig(xs: 12, md: 2),
                    child: BsNav(
                      variant: BsNavVariant.plain,
                      vertical: true,
                      children: [
                        BsNavLink(
                          label: 'Overview',
                          active: _activeVerticalTab == 0,
                          onPressed: () =>
                              setState(() => _activeVerticalTab = 0),
                        ),
                        BsNavLink(
                          label: 'Security',
                          active: _activeVerticalTab == 1,
                          onPressed: () =>
                              setState(() => _activeVerticalTab = 1),
                        ),
                        BsNavLink(
                          label: 'Billing',
                          active: _activeVerticalTab == 2,
                          onPressed: () =>
                              setState(() => _activeVerticalTab = 2),
                        ),
                      ],
                    ).mb3(),
                  ),
                  BsCol(
                    config: const BsColConfig(xs: 12, md: 10),
                    child: BsCard(
                      body: BsCardBody(
                        child: SizedBox(
                          height: 120,
                          child: BsTabContent(
                            activeIndex: _activeVerticalTab,
                            children: const [
                              BsTabPane(
                                child: Text(
                                  'Overview Sidebar Pane: Summary of dashboard modules.',
                                ),
                              ),
                              BsTabPane(
                                child: Text(
                                  'Security Sidebar Pane: Manage system credentials, two-factor authentication, and tokens.',
                                ),
                              ),
                              BsTabPane(
                                child: Text(
                                  'Billing Sidebar Pane: Invoices list, subscription status, and payment configurations.',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ).mb5(),
            ],
          ).py(24),
        ),
      ),
    );
  }

  Widget _sectionTitle(String text, BsThemeData theme) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: theme.bodyText,
      ),
    ).mb2();
  }
}

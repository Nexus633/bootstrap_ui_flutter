import 'package:flutter/material.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

class ScrollspyShowcase extends StatefulWidget {
  const ScrollspyShowcase({super.key});

  @override
  State<ScrollspyShowcase> createState() => _ScrollspyShowcaseState();
}

class _ScrollspyShowcaseState extends State<ScrollspyShowcase> {
  final BsScrollspyController _scrollspyController = BsScrollspyController();
  final GlobalKey _section1Key = GlobalKey();
  final GlobalKey _section2Key = GlobalKey();
  final GlobalKey _section3Key = GlobalKey();
  final GlobalKey _section4Key = GlobalKey();

  final BsScrollspyController _navbarScrollspyController =
      BsScrollspyController();
  final GlobalKey _navSec1 = GlobalKey();
  final GlobalKey _navSec2 = GlobalKey();
  final GlobalKey _navDrop1 = GlobalKey();
  final GlobalKey _navDrop2 = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollspyController.registerTarget('item-1', _section1Key);
    _scrollspyController.registerTarget('item-2', _section2Key);
    _scrollspyController.registerTarget('item-3', _section3Key);
    _scrollspyController.registerTarget('item-4', _section4Key);

    _navbarScrollspyController.registerTarget('first', _navSec1);
    _navbarScrollspyController.registerTarget('second', _navSec2);
    _navbarScrollspyController.registerTarget('drop1', _navDrop1);
    _navbarScrollspyController.registerTarget('drop2', _navDrop2);
  }

  @override
  void dispose() {
    _scrollspyController.dispose();
    _navbarScrollspyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.bs;

    return SingleChildScrollView(
      child: BsContainer.fluid(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card
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
                    'Scrollspy',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ).pb2(),
                  Text(
                    'Automatically update Bootstrap navigation or list group components based on scroll position to indicate which link is currently active in the viewport.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: 0.9),
                      height: 1.4,
                    ),
                  ),
                ],
              ).p4(),
            ).mb(32),

            _Section(
              title: 'Basic Example',
              description:
                  'Scroll the area below and watch the active item change in the navigation menu.',
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Navigation menu observing the scrollspy controller
                  Expanded(
                    flex: 1,
                    child: AnimatedBuilder(
                      animation: _scrollspyController,
                      builder: (context, _) {
                        return BsNav(
                          variant: BsNavVariant.pills,
                          vertical: true,
                          children: [
                            BsNavLink(
                              label: 'Item 1',
                              active:
                                  _scrollspyController.activeTargetId ==
                                  'item-1',
                              onPressed: () =>
                                  _scrollspyController.scrollToTarget('item-1'),
                            ),
                            BsNavLink(
                              label: 'Item 2',
                              active:
                                  _scrollspyController.activeTargetId ==
                                  'item-2',
                              onPressed: () =>
                                  _scrollspyController.scrollToTarget('item-2'),
                            ),
                            BsNavLink(
                              label: 'Item 3',
                              active:
                                  _scrollspyController.activeTargetId ==
                                  'item-3',
                              onPressed: () =>
                                  _scrollspyController.scrollToTarget('item-3'),
                            ),
                            BsNavLink(
                              label: 'Item 4',
                              active:
                                  _scrollspyController.activeTargetId ==
                                  'item-4',
                              onPressed: () =>
                                  _scrollspyController.scrollToTarget('item-4'),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 24),
                  // Scrollable Area
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 300,
                      decoration: BoxDecoration(
                        color: theme.bodyBgSecondary,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: theme.border),
                      ),
                      // Provide the controller to the child and wrap it in BsScrollspy
                      child: BsScrollspy(
                        controller: _scrollspyController,
                        child: SingleChildScrollView(
                          controller: _scrollspyController.scrollController,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _ContentSection(
                                  key: _section1Key,
                                  title: 'Item 1',
                                  text:
                                      'This is some placeholder content for the scrollspy page. ' *
                                      5,
                                  theme: theme,
                                ),
                                _ContentSection(
                                  key: _section2Key,
                                  title: 'Item 2',
                                  text:
                                      'This is some placeholder content for the scrollspy page. ' *
                                      8,
                                  theme: theme,
                                ),
                                _ContentSection(
                                  key: _section3Key,
                                  title: 'Item 3',
                                  text:
                                      'This is some placeholder content for the scrollspy page. ' *
                                      6,
                                  theme: theme,
                                ),
                                _ContentSection(
                                  key: _section4Key,
                                  title: 'Item 4',
                                  text:
                                      'This is some placeholder content for the scrollspy page. ' *
                                      10,
                                  theme: theme,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            _Section(
              title: 'Navbar with Dropdown',
              description:
                  'Scrollspy works with navbars and dropdowns. In this example, the dropdown item becomes active when the scroll reaches its target.',
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: theme.light,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(8),
                      ),
                      border: Border.all(color: theme.border),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 16,
                      runSpacing: 8,
                      children: [
                        const Text(
                          'Navbar',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        AnimatedBuilder(
                          animation: _navbarScrollspyController,
                          builder: (context, _) {
                            return BsNav(
                              variant: BsNavVariant.pills,
                              children: [
                                BsNavLink(
                                  label: 'First',
                                  active:
                                      _navbarScrollspyController
                                          .activeTargetId ==
                                      'first',
                                  onPressed: () =>
                                      _navbarScrollspyController
                                          .scrollToTarget('first'),
                                ),
                                BsNavLink(
                                  label: 'Second',
                                  active:
                                      _navbarScrollspyController
                                          .activeTargetId ==
                                      'second',
                                  onPressed: () =>
                                      _navbarScrollspyController
                                          .scrollToTarget('second'),
                                ),
                                BsDropdown(
                                  toggleBuilder: (context, toggle, isOpen) {
                                    final isDropdownActive =
                                        _navbarScrollspyController
                                                .activeTargetId ==
                                            'drop1' ||
                                        _navbarScrollspyController
                                                .activeTargetId ==
                                            'drop2';
                                    return BsNavLink(
                                      label: 'Dropdown',
                                      active: isDropdownActive,
                                      onPressed: toggle,
                                    );
                                  },
                                  menu: BsDropdownMenu(
                                    children: [
                                      BsDropdownItem(
                                        active:
                                            _navbarScrollspyController
                                                .activeTargetId ==
                                            'drop1',
                                        onPressed: () =>
                                            _navbarScrollspyController
                                                .scrollToTarget('drop1'),
                                        child: const Text('Third'),
                                      ),
                                      BsDropdownItem(
                                        active:
                                            _navbarScrollspyController
                                                .activeTargetId ==
                                            'drop2',
                                        onPressed: () =>
                                            _navbarScrollspyController
                                                .scrollToTarget('drop2'),
                                        child: const Text('Fourth'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                      color: theme.bodyBgSecondary,
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(8),
                      ),
                      border: Border(
                        left: BorderSide(color: theme.border),
                        right: BorderSide(color: theme.border),
                        bottom: BorderSide(color: theme.border),
                      ),
                    ),
                    child: BsScrollspy(
                      controller: _navbarScrollspyController,
                      child: SingleChildScrollView(
                        controller: _navbarScrollspyController.scrollController,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _ContentSection(
                                key: _navSec1,
                                title: 'First',
                                text:
                                    'This is some placeholder content for the scrollspy page. ' *
                                    5,
                                theme: theme,
                              ),
                              _ContentSection(
                                key: _navSec2,
                                title: 'Second',
                                text:
                                    'This is some placeholder content for the scrollspy page. ' *
                                    5,
                                theme: theme,
                              ),
                              _ContentSection(
                                key: _navDrop1,
                                title: 'Third (Dropdown)',
                                text:
                                    'This is some placeholder content for the scrollspy page. ' *
                                    8,
                                theme: theme,
                              ),
                              _ContentSection(
                                key: _navDrop2,
                                title: 'Fourth (Dropdown)',
                                text:
                                    'This is some placeholder content for the scrollspy page. ' *
                                    8,
                                theme: theme,
                              ),
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

class _ContentSection extends StatelessWidget {
  const _ContentSection({
    super.key,
    required this.title,
    required this.text,
    required this.theme,
  });

  final String title;
  final String text;
  final BsThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ).pb2(),
        Text(text, style: TextStyle(color: theme.bodyText)).pb4(),
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
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
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

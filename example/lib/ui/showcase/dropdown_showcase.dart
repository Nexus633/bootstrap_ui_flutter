import 'package:flutter/material.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

class DropdownShowcase extends StatefulWidget {
  const DropdownShowcase({super.key});

  @override
  State<DropdownShowcase> createState() => _DropdownShowcaseState();
}

class _DropdownShowcaseState extends State<DropdownShowcase> {
  String _selectedAction = 'No action clicked yet';

  BsDropdownMenu _buildMenu(String name) {
    return BsDropdownMenu(
      children: [
        BsDropdownHeader(child: Text('$name Menu')),
        BsDropdownItem(
          icon: const BsIcon(BsIcons.star),
          onPressed: () => setState(() => _selectedAction = '$name: Action 1 clicked'),
          child: const Text('Action 1'),
        ),
        BsDropdownItem(
          icon: const BsIcon(BsIcons.gear),
          onPressed: () => setState(() => _selectedAction = '$name: Action 2 clicked'),
          child: const Text('Action 2'),
        ),
        const BsDropdownDivider(),
        BsDropdownItem(
          icon: const BsIcon(BsIcons.slashCircle),
          disabled: true,
          onPressed: () => setState(() => _selectedAction = '$name: Disabled clicked'),
          child: const Text('Disabled Option'),
        ),
        BsDropdownItem(
          icon: const BsIcon(BsIcons.boxArrowRight),
          active: true,
          onPressed: () => setState(() => _selectedAction = '$name: Active Action clicked'),
          child: const Text('Active Action'),
        ),
      ],
    );
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
                    'Dropdowns',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ).pb2(),
                  Text(
                    'Toggle contextual overlays for displaying lists of links and more. Compatible with Bootstrap 5.3 specifications.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: 0.9),
                      height: 1.4,
                    ),
                  ),
                ],
              ).p4(),
            ).mb(32),

            // Live Info Bar
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: theme.bodyBgSecondary,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: theme.border),
              ),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8,
                runSpacing: 4,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BsIcon(BsIcons.infoCircle, color: theme.primary),
                      const SizedBox(width: 8),
                      const Text(
                        'Last Action: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Text(
                    _selectedAction,
                    style: TextStyle(
                      color: theme.primary,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ).mb(32),

            // 1. Standard Button Dropdowns
            _Section(
              title: 'Standard Button Dropdowns',
              description: 'Toggles wrapped directly around standard Bootstrap buttons. Arrow carets are enabled by default.',
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  BsDropdown(
                    label: 'Primary',
                    toggleVariant: BsButtonVariant.primary,
                    menu: _buildMenu('Primary'),
                  ),
                  BsDropdown(
                    label: 'Secondary',
                    toggleVariant: BsButtonVariant.secondary,
                    menu: _buildMenu('Secondary'),
                  ),
                  BsDropdown(
                    label: 'Success (No Arrow)',
                    toggleVariant: BsButtonVariant.success,
                    showCaret: false,
                    menu: _buildMenu('Success'),
                  ),
                  BsDropdown(
                    label: 'Danger',
                    toggleVariant: BsButtonVariant.danger,
                    menu: _buildMenu('Danger'),
                  ),
                  BsDropdown(
                    label: 'Info',
                    toggleVariant: BsButtonVariant.info,
                    menu: _buildMenu('Info'),
                  ),
                ],
              ),
            ),

            // 2. Split Button Dropdowns
            _Section(
              title: 'Split Button Dropdowns',
              description: 'Double button layouts where the primary button triggers an action and the caret toggles the dropdown.',
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  BsDropdown(
                    toggleBuilder: (context, toggleMenu, isOpen) {
                      return BsButtonGroup(
                        children: [
                          BsButton(
                            label: 'Primary Action',
                            variant: BsButtonVariant.primary,
                            onPressed: () => setState(() => _selectedAction = 'Split: Primary Action clicked'),
                          ),
                          BsButton(
                            label: '',
                            variant: BsButtonVariant.primary,
                            icon: isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                            onPressed: toggleMenu,
                          ),
                        ],
                      );
                    },
                    menu: _buildMenu('Split Primary'),
                  ),
                  BsDropdown(
                    toggleBuilder: (context, toggleMenu, isOpen) {
                      return BsButtonGroup(
                        children: [
                          BsButton(
                            label: 'Danger Action',
                            variant: BsButtonVariant.danger,
                            onPressed: () => setState(() => _selectedAction = 'Split: Danger Action clicked'),
                          ),
                          BsButton(
                            label: '',
                            variant: BsButtonVariant.danger,
                            icon: isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                            onPressed: toggleMenu,
                          ),
                        ],
                      );
                    },
                    menu: _buildMenu('Split Danger'),
                  ),
                ],
              ),
            ),

             // 3. Directions & Alignments
            _Section(
              title: 'Directions & Alignments',
              description: 'Position the menu above (Dropup), to the left (Dropstart), to the right (Dropend), or align it to the end.',
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  BsDropdown(
                    direction: .up,
                    label: 'Dropup',
                    toggleVariant: BsButtonVariant.secondary,
                    menu: _buildMenu('Dropup'),
                  ),
                  BsDropdown(
                    direction: .end,
                    label: 'Dropend (Right)',
                    toggleVariant: BsButtonVariant.secondary,
                    menu: _buildMenu('Dropend'),
                  ),
                  BsDropdown(
                    direction: .start,
                    label: 'Dropstart (Left)',
                    toggleVariant: BsButtonVariant.secondary,
                    menu: _buildMenu('Dropstart'),
                  ),
                  BsDropdown(
                    alignment: .end,
                    label: 'End-Aligned',
                    toggleVariant: BsButtonVariant.secondary,
                    menu: _buildMenu('End-Aligned'),
                  ),
                ],
              ),
            ),

            // 4. Auto Close Behaviors
            _Section(
              title: 'Auto Close Behaviors',
              description: 'Control whether the dropdown closes when clicking inside the menu or outside.',
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  BsDropdown(
                    autoClose: .always,
                    label: 'always (Default)',
                    toggleVariant: BsButtonVariant.dark,
                    outline: true,
                    menu: _buildMenu('autoClose: always'),
                  ),
                  BsDropdown(
                    autoClose: .inside,
                    label: 'inside (Only close on item click)',
                    toggleVariant: BsButtonVariant.dark,
                    outline: true,
                    menu: _buildMenu('autoClose: inside'),
                  ),
                  BsDropdown(
                    autoClose: .outside,
                    label: 'outside (Only close on outside click)',
                    toggleVariant: BsButtonVariant.dark,
                    outline: true,
                    menu: _buildMenu('autoClose: outside'),
                  ),
                  BsDropdown(
                    autoClose: .none,
                    label: 'none (Manual toggle)',
                    toggleVariant: BsButtonVariant.dark,
                    outline: true,
                    menu: _buildMenu('autoClose: none'),
                  ),
                ],
              ),
            ),

            // 5. Customized Dropdown Menus
            _Section(
              title: 'Custom Styles & Overrides',
              description: 'Force dark theme styling, use custom backgrounds/gradients, or add headers and informational texts.',
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  BsDropdown(
                    label: 'Forced Dark Menu',
                    toggleVariant: BsButtonVariant.dark,
                    menu: BsDropdownMenu(
                      dark: true,
                      children: [
                        const BsDropdownHeader(child: Text('Forced Dark Scheme')),
                        BsDropdownItem(
                          icon: const BsIcon(BsIcons.moon),
                          onPressed: () => setState(() => _selectedAction = 'Dark Menu: Night option selected'),
                          child: const Text('Night Mode Option'),
                        ),
                        const BsDropdownDivider(),
                        const BsDropdownText(child: Text('This text is rendered styled inside a dark dropdown menu.')),
                      ],
                    ),
                  ),
                  BsDropdown(
                    label: 'Custom Color Menu',
                    toggleVariant: BsButtonVariant.warning,
                    menu: BsDropdownMenu(
                      color: const Color(0xFF6F42C1), // Deep Bootstrap Purple
                      children: [
                        const BsDropdownHeader(child: Text('Custom Purple Style')),
                        BsDropdownItem(
                          icon: const BsIcon(BsIcons.lightning),
                          onPressed: () => setState(() => _selectedAction = 'Purple Menu: Turbo option clicked'),
                          child: const Text('Turbo Mode'),
                        ),
                        const BsDropdownDivider(),
                        const BsDropdownText(
                          child: Text('Contrast text color is automatically selected based on background luminance!'),
                        ),
                      ],
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

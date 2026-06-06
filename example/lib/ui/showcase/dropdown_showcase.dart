import 'package:flutter/material.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

class DropdownShowcase extends StatefulWidget {
  const DropdownShowcase({super.key});

  @override
  State<DropdownShowcase> createState() => _DropdownShowcaseState();
}

class _DropdownShowcaseState extends State<DropdownShowcase> {
  // Demo states
  String _selectedAction = 'No action clicked yet';

  BsDropdownMenu _buildMenu(String name) {
    return BsDropdownMenu(
      children: [
        BsDropdownHeader(child: Text('$name Menu')),
        BsDropdownItem(
          icon: const Icon(Icons.star_rounded),
          onPressed: () => setState(() => _selectedAction = '$name: Action 1 clicked'),
          child: const Text('Action 1'),
        ),
        BsDropdownItem(
          icon: const Icon(Icons.settings_rounded),
          onPressed: () => setState(() => _selectedAction = '$name: Action 2 clicked'),
          child: const Text('Action 2'),
        ),
        const BsDropdownDivider(),
        BsDropdownItem(
          icon: const Icon(Icons.block_rounded),
          disabled: true,
          onPressed: () => setState(() => _selectedAction = '$name: Disabled clicked (should not happen)'),
          child: const Text('Disabled Option'),
        ),
        BsDropdownItem(
          icon: const Icon(Icons.logout_rounded),
          active: true,
          onPressed: () => setState(() => _selectedAction = '$name: Active Action clicked'),
          child: const Text('Active Action'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BsContainer.fluid(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header Banner ──────────────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Dropdowns',
                    style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                  ).pb(8),
                  Text(
                    'Toggle contextual overlays for displaying lists of links and more. Compatible with Bootstrap 5.3 specifications.',
                    style: BsTypography.body.copyWith(color: Colors.white70),
                  ),
                ],
              ),
            ).pb(24),

            // ── Live Info Bar ────────────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              decoration: BoxDecoration(
                color: context.bs.bodyBgSecondary,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: context.bs.border),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline_rounded, color: context.bs.primary),
                  const SizedBox(width: 8.0),
                  const Text(
                    'Last Action: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _selectedAction,
                    style: TextStyle(
                      color: context.bs.primary,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ).pb(24),

            // ── Section 1: Standard Button Dropdowns ────────────────────────
            _Section(
              title: 'Standard Button Dropdowns',
              description: 'Toggles wrapped directly around standard Bootstrap buttons. Clicking the button opens the menu. Arrow carets are enabled by default but can be disabled.',
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
                  BsDropdown(
                    label: 'Warning',
                    toggleVariant: BsButtonVariant.warning,
                    menu: _buildMenu('Warning'),
                  ),
                ],
              ),
            ),

            // ── Section 2: Split Button Dropdowns ───────────────────────────
            _Section(
              title: 'Split Button Dropdowns',
              description: 'Double button layouts where the primary button triggers an action and the caret button toggles the dropdown.',
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

            // ── Section 3: Directions and Alignments ────────────────────────
            _Section(
              title: 'Directions & Alignments',
              description: 'Position the menu above (Dropup), to the left (Dropstart), to the right (Dropend), or align it to the end.',
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  BsDropdown(
                    direction: BsDropdownDirection.up,
                    label: 'Dropup',
                    toggleVariant: BsButtonVariant.secondary,
                    menu: _buildMenu('Dropup'),
                  ),
                  BsDropdown(
                    direction: BsDropdownDirection.end,
                    label: 'Dropend (Right)',
                    toggleVariant: BsButtonVariant.secondary,
                    menu: _buildMenu('Dropend'),
                  ),
                  BsDropdown(
                    direction: BsDropdownDirection.start,
                    label: 'Dropstart (Left)',
                    toggleVariant: BsButtonVariant.secondary,
                    menu: _buildMenu('Dropstart'),
                  ),
                  BsDropdown(
                    alignment: BsDropdownAlignment.end,
                    label: 'End-Aligned',
                    toggleVariant: BsButtonVariant.secondary,
                    menu: _buildMenu('End-Aligned'),
                  ),
                ],
              ),
            ),

            // ── Section 4: Auto Close Behaviors ─────────────────────────────
            _Section(
              title: 'Auto Close Behaviors',
              description: 'Control whether the dropdown closes when clicking inside the menu or outside.',
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  BsDropdown(
                    autoClose: BsDropdownAutoClose.always,
                    label: 'always (Default)',
                    toggleVariant: BsButtonVariant.outlineDark,
                    menu: _buildMenu('autoClose: always'),
                  ),
                  BsDropdown(
                    autoClose: BsDropdownAutoClose.inside,
                    label: 'inside (Only close on item click)',
                    toggleVariant: BsButtonVariant.outlineDark,
                    menu: _buildMenu('autoClose: inside'),
                  ),
                  BsDropdown(
                    autoClose: BsDropdownAutoClose.outside,
                    label: 'outside (Only close on outside click)',
                    toggleVariant: BsButtonVariant.outlineDark,
                    menu: _buildMenu('autoClose: outside'),
                  ),
                  BsDropdown(
                    autoClose: BsDropdownAutoClose.none,
                    label: 'none (Manual toggle)',
                    toggleVariant: BsButtonVariant.outlineDark,
                    menu: _buildMenu('autoClose: none'),
                  ),
                ],
              ),
            ),

            // ── Section 5: Customized Dropdown Menus ───────────────────────
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
                          icon: const Icon(Icons.brightness_2_rounded),
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
                      color: const Color(0xFF6f42c1), // Deep Bootstrap Purple
                      children: [
                        const BsDropdownHeader(child: Text('Custom Purple Style')),
                        BsDropdownItem(
                          icon: const Icon(Icons.flash_on_rounded),
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
  const _Section({
    required this.title,
    this.description,
    required this.child,
  });

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
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ).pb(8),
        if (description != null)
          Text(description!).pb(16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(color: context.bs.border),
            borderRadius: BorderRadius.circular(8),
            color: context.bs.bodyBg,
          ),
          child: child,
        ).pb(32),
      ],
    );
  }
}

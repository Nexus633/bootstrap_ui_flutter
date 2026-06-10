import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';
import 'package:flutter/material.dart';

class ModalShowcase extends StatelessWidget {
  const ModalShowcase({super.key});

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
                    'Modals',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ).pb2(),
                  Text(
                    'Modals are streamlined, but flexible, dialog prompts with the minimum required functionality and smart defaults.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: 0.9),
                      height: 1.4,
                    ),
                  ),
                ],
              ).p4(),
            ).mb(32),

            // 1. Basic Examples
            _Section(
              title: 'Modal Launchers',
              description: 'Launch different modal styles with animations, backdrop configurations, and forms.',
              child: BsRow(
                children: [
                  BsCol(
                    config: const BsColConfig(xs: 12, md: 8, lg: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLauncher(
                          context,
                          label: 'Launch Demo Modal',
                          description: 'Standard modal dialog centered at the top of the viewport with default backdrop dismiss enabled.',
                          onPressed: () => _showDemoModal(context),
                        ),
                        _buildLauncher(
                          context,
                          label: 'Launch Centered Modal',
                          description: 'Aligns the modal dialog exactly in the vertical and horizontal center of the viewport.',
                          onPressed: () => _showCenteredModal(context),
                        ),
                        _buildLauncher(
                          context,
                          label: 'Launch Static Backdrop Modal',
                          description: 'Will not close when clicking outside. Instead, it triggers a pulse/shake animation.',
                          onPressed: () => _showStaticModal(context),
                          variant: BsButtonVariant.secondary,
                        ),
                        _buildLauncher(
                          context,
                          label: 'Launch Sign In Modal',
                          description: 'Demonstrates combining multiple Bootstrap form controls (inputs, checkboxes, radios) inside a modal dialog.',
                          onPressed: () => _showFormModal(context),
                          variant: BsButtonVariant.info,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 2. Sizes & Scroll Behavior
            _Section(
              title: 'Sizes & Scroll Behavior',
              description: 'Control layout boundaries, fullscreens, and internal scroll mechanics.',
              child: BsRow(
                children: [
                  BsCol(
                    config: const BsColConfig(xs: 12, md: 8, lg: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLauncher(
                          context,
                          label: 'Launch Scrollable Modal',
                          description: 'Header and footer stay fixed in place while the body scrolls independently for long content.',
                          onPressed: () => _showScrollableModal(context),
                        ),
                        const Text('Modal Size Configurations:').fwBold().fs6().pb2(),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            BsButton(
                              label: 'Small (sm)',
                              variant: BsButtonVariant.outlinePrimary,
                              onPressed: () => _showSizedModal(context, BsModalSize.sm),
                            ),
                            BsButton(
                              label: 'Large (lg)',
                              variant: BsButtonVariant.outlinePrimary,
                              onPressed: () => _showSizedModal(context, BsModalSize.lg),
                            ),
                            BsButton(
                              label: 'Extra Large (xl)',
                              variant: BsButtonVariant.outlinePrimary,
                              onPressed: () => _showSizedModal(context, BsModalSize.xl),
                            ),
                            BsButton(
                              label: 'Fullscreen',
                              variant: BsButtonVariant.outlinePrimary,
                              onPressed: () => _showSizedModal(context, BsModalSize.fullscreen),
                            ),
                          ],
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

  Widget _buildLauncher(
    BuildContext context, {
    required String label,
    required String description,
    required VoidCallback onPressed,
    BsButtonVariant variant = BsButtonVariant.primary,
  }) {
    final theme = context.bs;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: theme.bodyBgSecondary,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(description, style: TextStyle(color: theme.bodyTextSecondary, fontSize: 13)).pb3(),
          BsButton(
            label: label,
            variant: variant,
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }

  // ─── Modal Launchers ────────────────────────────────────────────────────────

  void _showDemoModal(BuildContext context) {
    showBsModal<void>(
      context: context,
      builder: (context) => BsModal(
        header: const BsModalHeader(
          child: Text('Modal title'),
        ),
        body: const BsModalBody(
          child: Text('Woohoo, you\'re reading this text in a modal!'),
        ),
        footer: BsModalFooter(
          children: [
            BsButton(
              label: 'Close',
              variant: BsButtonVariant.secondary,
              onPressed: () => Navigator.of(context).pop(),
            ),
            BsButton(
              label: 'Save changes',
              variant: BsButtonVariant.primary,
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Changes saved successfully!')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showCenteredModal(BuildContext context) {
    showBsModal<void>(
      context: context,
      centered: true,
      builder: (context) => BsModal(
        centered: true,
        header: const BsModalHeader(
          child: Text('Centered Modal'),
        ),
        body: const BsModalBody(
          child: Text('This modal dialog is vertically and horizontally centered.'),
        ),
        footer: BsModalFooter(
          children: [
            BsButton(
              label: 'Close',
              variant: BsButtonVariant.secondary,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }

  void _showStaticModal(BuildContext context) {
    showBsModal<void>(
      context: context,
      backdrop: BsBackdrop.static,
      builder: (context) => BsModal(
        header: const BsModalHeader(
          child: Text('Static Backdrop'),
        ),
        body: const BsModalBody(
          child: Text('I will not close if you click outside of me. Tap outside to see the pulse animation!'),
        ),
        footer: BsModalFooter(
          children: [
            BsButton(
              label: 'Understood',
              variant: BsButtonVariant.primary,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }

  void _showFormModal(BuildContext context) {
    bool rememberMe = false;
    String selectedRole = 'user';

    showBsModal<void>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return BsModal(
              header: const BsModalHeader(
                child: Text('Sign In'),
              ),
              body: BsModalBody(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Email address').mb2(),
                    BsInput(
                      placeholder: 'name@example.com',
                      keyboardType: TextInputType.emailAddress,
                    ).mb3(),
                    const Text('Password').mb2(),
                    BsInput(
                      placeholder: 'Password',
                      obscureText: true,
                    ).mb3(),
                    BsCheckbox(
                      label: const Text('Remember me'),
                      initialValue: rememberMe,
                      onChanged: (val) {
                        setState(() {
                          rememberMe = val ?? false;
                        });
                      },
                    ).mb3(),
                    const Text('Select Role').mb2(),
                    Row(
                      children: [
                        BsRadio<String>(
                          value: 'user',
                          groupValue: selectedRole,
                          label: const Text('User'),
                          inline: true,
                          onChanged: (val) {
                            setState(() {
                              selectedRole = val!;
                            });
                          },
                        ),
                        BsRadio<String>(
                          value: 'admin',
                          groupValue: selectedRole,
                          label: const Text('Admin'),
                          inline: true,
                          onChanged: (val) {
                            setState(() {
                              selectedRole = val!;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              footer: BsModalFooter(
                children: [
                  BsButton(
                    label: 'Cancel',
                    variant: BsButtonVariant.secondary,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  BsButton(
                    label: 'Sign In',
                    variant: BsButtonVariant.primary,
                    onPressed: () {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Signed in as $selectedRole. Remember me: $rememberMe',
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showScrollableModal(BuildContext context) {
    showBsModal<void>(
      context: context,
      builder: (context) => BsModal(
        scrollable: true,
        header: const BsModalHeader(
          child: Text('Scrollable Content'),
        ),
        body: BsModalBody(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              25,
              (index) => Text(
                'This is line number ${index + 1} of a very long scrolling modal body. Notice how the header and footer stay locked in place as you scroll.',
              ).pb3(),
            ),
          ),
        ),
        footer: BsModalFooter(
          children: [
            BsButton(
              label: 'Close',
              variant: BsButtonVariant.secondary,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }

  void _showSizedModal(BuildContext context, BsModalSize size) {
    final sizeName = size.toString().split('.').last.toUpperCase();
    showBsModal<void>(
      context: context,
      builder: (context) => BsModal(
        size: size,
        header: BsModalHeader(
          child: Text('Modal Size: $sizeName'),
        ),
        body: BsModalBody(
          child: Text('This is a $sizeName modal dialog example.'),
        ),
        footer: BsModalFooter(
          children: [
            BsButton(
              label: 'Close',
              variant: BsButtonVariant.secondary,
              onPressed: () => Navigator.of(context).pop(),
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

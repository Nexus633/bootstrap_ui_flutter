import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';
import 'package:flutter/material.dart';

class ModalShowcase extends StatelessWidget {
  const ModalShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.bs;

    return Scaffold(
      backgroundColor: theme.bodyBg,
      appBar: AppBar(
        backgroundColor: theme.bodyBg,
        foregroundColor: theme.bodyText,
        title: const Text('Modals'),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: theme.border, height: 1.0),
        ),
      ),
      body: SingleChildScrollView(
        child: BsContainer(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─── Introduction ──────────────────────────────────────────────
              const Text(
                'Modals are streamlined, but flexible, dialog prompts. They support a variety of use cases from user notifications to complex forms and sizes.',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ).mb4(),

              BsRow(
                gutterX: BsSpacing.s4,
                gutterY: BsSpacing.s4,
                children: [
                  // ─── COLUMN 1: Basic Examples ──────────────────────────────
                  BsCol(
                    config: const BsColConfig(md: 6, xs: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionTitle('Modal Components'),
                        const SizedBox(height: 8),
                        const Text(
                          'Click the buttons below to launch different modal types. Each modal demonstrates a specific Bootstrap 5 configuration.',
                          style: TextStyle(color: Colors.grey),
                        ).mb3(),

                        // 1. Standard Modal
                        _buildLauncher(
                          context,
                          label: 'Launch Demo Modal',
                          description: 'Standard modal dialog centered at the top of the viewport with default medium sizing and backdrop dismiss enabled.',
                          onPressed: () => _showDemoModal(context),
                        ),

                        // 2. Vertically Centered
                        _buildLauncher(
                          context,
                          label: 'Vertically Centered Modal',
                          description: 'Aligns the modal dialog exactly in the vertical and horizontal center of the viewport.',
                          onPressed: () => _showCenteredModal(context),
                        ),

                        // 3. Static Backdrop
                        _buildLauncher(
                          context,
                          label: 'Static Backdrop Modal',
                          description: 'When backdrop is set to static, the modal will not close when clicking outside it. Instead, it triggers a pulse/shake animation.',
                          onPressed: () => _showStaticModal(context),
                          variant: BsButtonVariant.secondary,
                        ),

                        // 4. Form Modal
                        _buildLauncher(
                          context,
                          label: 'Form Modal',
                          description: 'Demonstrates combining multiple Bootstrap form controls (inputs, checkboxes, radios) inside a modal dialog.',
                          onPressed: () => _showFormModal(context),
                          variant: BsButtonVariant.info,
                        ),
                      ],
                    ),
                  ),

                  // ─── COLUMN 2: Sizes & Scroll ──────────────────────────────
                  BsCol(
                    config: const BsColConfig(md: 6, xs: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionTitle('Sizes & Scrolling'),
                        const SizedBox(height: 8),
                        const Text(
                          'Control modal sizing and scroll behavior. Modals can scroll their entire body or container, and fit different screen requirements.',
                          style: TextStyle(color: Colors.grey),
                        ).mb3(),

                        // 4. Scrollable Modal
                        _buildLauncher(
                          context,
                          label: 'Scrollable Modal',
                          description: 'When the modal content is too long, the body scrolls independently while the header and footer remain fixed.',
                          onPressed: () => _showScrollableModal(context),
                        ),

                        // 5. Sizes
                        _sectionSubTitle('Modal Sizes'),
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
                        ).mb3(),
                      ],
                    ),
                  ),
                ],
              ),
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
    );
  }

  Widget _sectionSubTitle(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ).mb2();
  }

  Widget _buildLauncher(
    BuildContext context, {
    required String label,
    required String description,
    required VoidCallback onPressed,
    BsButtonVariant variant = BsButtonVariant.primary,
  }) {
    return BsCard(
      body: BsCardBody(
        children: [
          Text(description).mb3(),
          BsButton(
            label: label,
            variant: variant,
            onPressed: onPressed,
          ),
        ],
      ),
    ).mb3();
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
      backdrop: BsModalBackdrop.static,
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

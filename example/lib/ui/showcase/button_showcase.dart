import 'package:flutter/material.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

class ButtonShowcase extends StatefulWidget {
  const ButtonShowcase({super.key});

  @override
  State<ButtonShowcase> createState() => _ButtonShowcaseState();
}

class _ButtonShowcaseState extends State<ButtonShowcase> {
  bool _isLoading = false;

  Future<void> _simulateLoading() async {
    setState(() => _isLoading = true);
    await Future<void>.delayed(const Duration(seconds: 2));
    setState(() => _isLoading = false);
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
                    'Buttons',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ).pb2(),
                  Text(
                    'Use Bootstrap\'s custom button styles for actions in forms, dialogs, and more. Support for multiple sizes, states, outline variants, and grouping.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: 0.9),
                      height: 1.4,
                    ),
                  ),
                ],
              ).p4(),
            ).mb(32),

            // 1. Solid Variants
            _Section(
              title: 'Solid Buttons',
              description: 'Standard button variants using key semantic background colors.',
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  BsButton(label: 'Primary', variant: BsButtonVariant.primary, onPressed: () {}),
                  BsButton(label: 'Secondary', variant: BsButtonVariant.secondary, onPressed: () {}),
                  BsButton(label: 'Success', variant: BsButtonVariant.success, onPressed: () {}),
                  BsButton(label: 'Danger', variant: BsButtonVariant.danger, onPressed: () {}),
                  BsButton(label: 'Warning', variant: BsButtonVariant.warning, onPressed: () {}),
                  BsButton(label: 'Info', variant: BsButtonVariant.info, onPressed: () {}),
                  BsButton(label: 'Light', variant: BsButtonVariant.light, onPressed: () {}),
                  BsButton(label: 'Dark', variant: BsButtonVariant.dark, onPressed: () {}),
                  BsButton(label: 'Link', variant: BsButtonVariant.link, onPressed: () {}),
                ],
              ),
            ),

            // 2. Outline Variants
            _Section(
              title: 'Outline Buttons',
              description: 'In need of a button, but not the hefty background colors they bring? Replace with outline properties.',
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  BsButton(label: 'Primary', variant: BsButtonVariant.primary, outline: true, onPressed: () {}),
                  BsButton(label: 'Secondary', variant: BsButtonVariant.secondary, outline: true, onPressed: () {}),
                  BsButton(label: 'Success', variant: BsButtonVariant.success, outline: true, onPressed: () {}),
                  BsButton(label: 'Danger', variant: BsButtonVariant.danger, outline: true, onPressed: () {}),
                  BsButton(label: 'Warning', variant: BsButtonVariant.warning, outline: true, onPressed: () {}),
                  BsButton(label: 'Info', variant: BsButtonVariant.info, outline: true, onPressed: () {}),
                  BsButton(label: 'Dark', variant: BsButtonVariant.dark, outline: true, onPressed: () {}),
                ],
              ),
            ),

            // 2.5 Custom Color
            _Section(
              title: 'Custom Color',
              description: 'Override the standard variant by passing a custom color. Text color adjusts automatically based on background luminance.',
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  BsButton(label: 'Custom Purple', color: Colors.purple, onPressed: () {}),
                  BsButton(label: 'Custom Yellow', color: Colors.yellow, onPressed: () {}),
                  BsButton(label: 'Custom Cyan', color: Colors.cyan, onPressed: () {}),
                ],
              ),
            ),

            // 3. Sizes
            _Section(
              title: 'Button Sizes',
              description: 'Fancy larger or smaller buttons? Customize with sm or lg size options.',
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  BsButton(
                    label: 'Small Button',
                    variant: BsButtonVariant.primary,
                    size: BsButtonSize.sm,
                    onPressed: () {},
                  ),
                  BsButton(
                    label: 'Medium Button',
                    variant: BsButtonVariant.primary,
                    size: BsButtonSize.md,
                    onPressed: () {},
                  ),
                  BsButton(
                    label: 'Large Button',
                    variant: BsButtonVariant.primary,
                    size: BsButtonSize.lg,
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // 4. Icons & States
            _Section(
              title: 'Icons & States',
              description: 'Support for pre-configured leading icons, loading indicators, and disabled states.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Leading Icons:').fwBold().fs6().pb2(),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      BsButton(
                        label: 'Save',
                        variant: BsButtonVariant.primary,
                        icon: BsIcons.save,
                        onPressed: () {},
                      ),
                      BsButton(
                        label: 'Delete',
                        variant: BsButtonVariant.danger,
                        icon: BsIcons.trash,
                        onPressed: () {},
                      ),
                      BsButton(
                        label: 'Info Info',
                        variant: BsButtonVariant.info,
                        icon: BsIcons.info,
                        onPressed: () {},
                      ),
                    ],
                  ).pb4(),

                  const Text('Button States (Disabled & Loading):').fwBold().fs6().pb2(),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      const BsButton(
                        label: 'Disabled Solid',
                        variant: BsButtonVariant.primary,
                      ),
                      const BsButton(
                        label: 'Disabled Outline',
                        variant: BsButtonVariant.primary,
                        outline: true,
                      ),
                      BsButton(
                        label: 'Click to Load',
                        variant: BsButtonVariant.primary,
                        isLoading: _isLoading,
                        onPressed: _simulateLoading,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 5. Full Width & Grouping
            _Section(
              title: 'Block Buttons & Groups',
              description: 'Create responsive stacks of buttons with block styles and unified button groups.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Block Buttons (Full Width):').fwBold().fs6().pb2(),
                  BsButton(
                    label: 'Block Primary Button',
                    variant: BsButtonVariant.primary,
                    fullWidth: true,
                    onPressed: () {},
                  ).pb2(),
                  BsButton(
                    label: 'Block Outline Button',
                    variant: BsButtonVariant.secondary,
                    outline: true,
                    fullWidth: true,
                    onPressed: () {},
                  ).pb4(),

                  const Text('Button Groups:').fwBold().fs6().pb2(),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: BsButtonGroup(
                      groupSize: BsButtonSize.md,
                      children: [
                        BsButton(label: 'Left', variant: BsButtonVariant.primary, outline: true, onPressed: () {}),
                        BsButton(label: 'Middle', variant: BsButtonVariant.primary, outline: true, onPressed: () {}),
                        BsButton(label: 'Right', variant: BsButtonVariant.primary, outline: true, onPressed: () {}),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 6. Close Buttons
            _Section(
              title: 'Close Buttons',
              description: 'A generic close button for dismissing content like modals and alerts.',
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Column(
                    children: [
                      BsCloseButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Close button clicked!')),
                          );
                        },
                      ).pb2(),
                      const Text('Default', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  Column(
                    children: [
                      const BsCloseButton(disabled: true).pb2(),
                      const Text('Disabled', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF212529),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const BsCloseButton(white: true),
                      ).pb2(),
                      const Text('White (Dark Bg)', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  Column(
                    children: [
                      const BsCloseButton(color: Colors.blue).pb2(),
                      const Text('Custom Color', style: TextStyle(fontSize: 12)),
                    ],
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

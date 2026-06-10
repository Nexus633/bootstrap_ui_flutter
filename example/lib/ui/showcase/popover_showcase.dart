import 'package:flutter/material.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

class PopoverShowcase extends StatefulWidget {
  const PopoverShowcase({super.key});

  @override
  State<PopoverShowcase> createState() => _PopoverShowcaseState();
}

class _PopoverShowcaseState extends State<PopoverShowcase> {
  final BsPopoverController _controller = BsPopoverController();

  @override
  void dispose() {
    _controller.dispose();
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
                    'Popovers',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ).pb2(),
                  Text(
                    'Add small overlays of content, like those on iPad, to any element for housing secondary information.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: 0.9),
                      height: 1.4,
                    ),
                  ),
                ],
              ).p4(),
            ).mb(32),

            // 1. Four Placements
            _Section(
              title: 'Four Directions',
              description: 'Four positioning options are available: top, right (end), bottom, and left (start) aligned. Popovers auto-flip when screen boundaries are reached.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Click the buttons to toggle popovers:').fs6().pb4(),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      BsPopover(
                        placement: BsPopoverPlacement.top,
                        titleText: 'Popover on top',
                        contentText: 'Vivamus sagittis lacus vel augue laoreet rutrum faucibus.',
                        child: BsButton(
                          label: 'Popover on top',
                          variant: BsButtonVariant.secondary,
                          onPressed: () {},
                        ),
                      ),
                      BsPopover(
                        placement: BsPopoverPlacement.end,
                        titleText: 'Popover on right',
                        contentText: 'Vivamus sagittis lacus vel augue laoreet rutrum faucibus.',
                        child: BsButton(
                          label: 'Popover on right',
                          variant: BsButtonVariant.secondary,
                          onPressed: () {},
                        ),
                      ),
                      BsPopover(
                        placement: BsPopoverPlacement.bottom,
                        titleText: 'Popover on bottom',
                        contentText: 'Vivamus sagittis lacus vel augue laoreet rutrum faucibus.',
                        child: BsButton(
                          label: 'Popover on bottom',
                          variant: BsButtonVariant.secondary,
                          onPressed: () {},
                        ),
                      ),
                      BsPopover(
                        placement: BsPopoverPlacement.start,
                        titleText: 'Popover on left',
                        contentText: 'Vivamus sagittis lacus vel augue laoreet rutrum faucibus.',
                        child: BsButton(
                          label: 'Popover on left',
                          variant: BsButtonVariant.secondary,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 2. Triggers (Click vs Hover)
            _Section(
              title: 'Triggers',
              description: 'Popovers can be configured to toggle on click (default, dismissible by clicking outside) or show on hover.',
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  BsPopover(
                    titleText: 'Click Dismissible',
                    contentText: 'And here\'s some amazing content. It\'s very engaging. Right?',
                    trigger: BsPopoverTrigger.click,
                    child: BsButton(
                      label: 'Click Trigger (Default)',
                      variant: BsButtonVariant.danger,
                      onPressed: () {},
                    ),
                  ),
                  BsPopover(
                    titleText: 'Hover Popover',
                    contentText: 'This popover shows when your mouse enters the button, and hides when it exits.',
                    trigger: BsPopoverTrigger.hover,
                    child: BsButton(
                      label: 'Hover Trigger',
                      variant: BsButtonVariant.success,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),

            // 3. Rich Custom Content
            _Section(
              title: 'Rich HTML / Custom Content',
              description: 'Popovers can contain custom child widgets for rich title headers and body content panels.',
              child: BsPopover(
                placement: BsPopoverPlacement.bottom,
                title: Row(
                  children: [
                    const Icon(Icons.info_outline, color: Colors.blue, size: 16).pe2(),
                    const Text('Rich Header Info'),
                  ],
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('You can insert custom columns, buttons, and structured widgets here.').pb2(),
                    BsButton(
                      label: 'Action inside Popover',
                      variant: BsButtonVariant.primary,
                      size: BsButtonSize.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                child: BsButton(
                  label: 'Popover with Custom Content',
                  variant: BsButtonVariant.info,
                  onPressed: () {},
                ),
              ),
            ),

            // 4. Programmatic Control
            _Section(
              title: 'Programmatic Control',
              description: 'Use a BsPopoverController to show, hide, or toggle a popover from other elements in your application.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      BsButton(
                        label: 'Force Open',
                        variant: BsButtonVariant.outlinePrimary,
                        onPressed: () => _controller.open(),
                      ),
                      BsButton(
                        label: 'Force Close',
                        variant: BsButtonVariant.outlineSecondary,
                        onPressed: () => _controller.close(),
                      ),
                      BsButton(
                        label: 'Toggle State',
                        variant: BsButtonVariant.outlineDark,
                        onPressed: () => _controller.toggle(),
                      ),
                    ],
                  ).mb4(),
                  Center(
                    child: BsPopover(
                      controller: _controller,
                      titleText: 'Programmatic Popover',
                      contentText: 'This popover is driven by an external controller.',
                      placement: BsPopoverPlacement.bottom,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        decoration: BoxDecoration(
                          color: theme.bodyBgSecondary,
                          border: Border.all(color: theme.border),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text('Target Element').fwBold(),
                      ),
                    ),
                  ).py4(),
                ],
              ),
            ),

            // 5. Custom Popover (Theming / Variant)
            _Section(
              title: 'Custom Popovers (Theming)',
              description: 'Customize the appearance of popovers using custom colors for background, border, header background, and text colors.',
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  BsPopover(
                    placement: BsPopoverPlacement.top,
                    titleText: 'Primary Popover',
                    contentText: 'This popover is themed with Bootstrap\'s primary color scheme.',
                    backgroundColor: Colors.white,
                    borderColor: theme.primary,
                    headerBackgroundColor: theme.primary,
                    headerTextColor: Colors.white,
                    bodyTextColor: theme.primary,
                    child: BsButton(
                      label: 'Primary Custom Popover',
                      variant: BsButtonVariant.primary,
                      onPressed: () {},
                    ),
                  ),
                  BsPopover(
                    placement: BsPopoverPlacement.bottom,
                    titleText: 'Dark Style Popover',
                    contentText: 'A custom dark-colored popover with light-colored texts.',
                    backgroundColor: const Color(0xFF212529),
                    borderColor: const Color(0xFF343A40),
                    headerBackgroundColor: const Color(0xFF1C1F23),
                    headerTextColor: Colors.white,
                    bodyTextColor: const Color(0xFFDEE2E6),
                    child: BsButton(
                      label: 'Dark Custom Popover',
                      variant: BsButtonVariant.dark,
                      onPressed: () {},
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

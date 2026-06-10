import 'package:flutter/material.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

class OffcanvasShowcase extends StatefulWidget {
  const OffcanvasShowcase({super.key});

  @override
  State<OffcanvasShowcase> createState() => _OffcanvasShowcaseState();
}

class _OffcanvasShowcaseState extends State<OffcanvasShowcase> {
  bool _showInlineOffcanvas = false;

  void _openOffcanvas(BsOffcanvasPlacement placement, BsBackdrop backdrop) {
    showBsOffcanvas<void>(
      context: context,
      placement: placement,
      backdrop: backdrop,
      builder: (context) => BsOffcanvas(
        placement: placement,
        header: BsOffcanvasHeader(
          child: Text('Offcanvas - ${placement.name.toUpperCase()}'),
        ),
        body: BsOffcanvasBody(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('This is the offcanvas body content.').pb(16),
              const Text('Configure this panel using placements and backdrops:').pb(8),
              Text('• Placement: ${placement.name}').pb(4),
              Text('• Backdrop: ${backdrop.name}').pb(16),
              BsButton(
                label: 'Close Offcanvas',
                variant: BsButtonVariant.secondary,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openStyledOffcanvas(BsVariant variant) {
    showBsOffcanvas<void>(
      context: context,
      backdrop: BsBackdrop.enabled,
      builder: (context) => BsOffcanvas(
        variant: variant,
        header: BsOffcanvasHeader(
          child: Text('Offcanvas - ${variant.name.toUpperCase()}'),
        ),
        body: BsOffcanvasBody(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('This panel is styled with the ${variant.name} variant.').pb(16),
              const Text('Notice that the text, borders, and close button colors adapt automatically!').pb(16),
              BsButton(
                label: 'Close',
                variant: BsButtonVariant.secondary,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
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
                    'Offcanvas',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ).pb2(),
                  Text(
                    'Build hidden sidebars into your project for navigation, shopping carts, or custom menus. Supports slides from any viewport edge and backdrop overrides.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: 0.9),
                      height: 1.4,
                    ),
                  ),
                ],
              ).p4(),
            ).mb(32),

            // 1. Live Demo Placements
            _Section(
              title: 'Placement Demo',
              description: 'Toggle the offcanvas from any of the four viewport edges.',
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  BsButton(
                    label: 'Toggle Start (Left)',
                    onPressed: () => _openOffcanvas(BsOffcanvasPlacement.start, BsBackdrop.enabled),
                  ),
                  BsButton(
                    label: 'Toggle End (Right)',
                    onPressed: () => _openOffcanvas(BsOffcanvasPlacement.end, BsBackdrop.enabled),
                  ),
                  BsButton(
                    label: 'Toggle Top',
                    onPressed: () => _openOffcanvas(BsOffcanvasPlacement.top, BsBackdrop.enabled),
                  ),
                  BsButton(
                    label: 'Toggle Bottom',
                    onPressed: () => _openOffcanvas(BsOffcanvasPlacement.bottom, BsBackdrop.enabled),
                  ),
                ],
              ),
            ),

            // 2. Backdrop Options
            _Section(
              title: 'Backdrop Options',
              description: 'Manage backdrop overlay visibility and dismiss behavior.',
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  BsButton(
                    label: 'Backdrop Enabled (Default)',
                    variant: BsButtonVariant.primary,
                    onPressed: () => _openOffcanvas(BsOffcanvasPlacement.start, BsBackdrop.enabled),
                  ),
                  BsButton(
                    label: 'Static Backdrop (Click outside pulses)',
                    variant: BsButtonVariant.secondary,
                    onPressed: () => _openOffcanvas(BsOffcanvasPlacement.start, BsBackdrop.static),
                  ),
                  BsButton(
                    label: 'Disabled Backdrop (Overlay hidden)',
                    variant: BsButtonVariant.dark,
                    onPressed: () => _openOffcanvas(BsOffcanvasPlacement.start, BsBackdrop.disabled),
                  ),
                ],
              ),
            ),

            // 3. Color & Variant
            _Section(
              title: 'Color & Variant Customization',
              description: 'Change the background and text color of the offcanvas panel using theme variants.',
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  BsButton(
                    label: 'Primary Variant',
                    variant: BsButtonVariant.primary,
                    onPressed: () => _openStyledOffcanvas(BsVariant.primary),
                  ),
                  BsButton(
                    label: 'Dark Variant',
                    variant: BsButtonVariant.dark,
                    onPressed: () => _openStyledOffcanvas(BsVariant.dark),
                  ),
                  BsButton(
                    label: 'Success Variant',
                    variant: BsButtonVariant.success,
                    onPressed: () => _openStyledOffcanvas(BsVariant.success),
                  ),
                  BsButton(
                    label: 'Danger Variant',
                    variant: BsButtonVariant.danger,
                    onPressed: () => _openStyledOffcanvas(BsVariant.danger),
                  ),
                ],
              ),
            ),

            // 4. Inline / Standalone Stack Usage
            _Section(
              title: 'Inline / Standalone Stack Integration',
              description: 'BsOffcanvas can be placed directly inside a Stack for side-by-side or overlay panels in-app.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BsButton(
                    label: _showInlineOffcanvas ? 'Hide Inline Panel' : 'Show Inline Panel',
                    variant: _showInlineOffcanvas ? BsButtonVariant.danger : BsButtonVariant.success,
                    onPressed: () => setState(() => _showInlineOffcanvas = !_showInlineOffcanvas),
                  ).pb(16),
                  Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: theme.border),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Container(
                            color: theme.bodyBgSecondary,
                            child: const Center(
                              child: Text('Main Page Content Area'),
                            ),
                          ),
                        ),
                        if (_showInlineOffcanvas)
                          Positioned(
                            left: 0,
                            top: 0,
                            bottom: 0,
                            child: BsOffcanvas(
                              placement: BsOffcanvasPlacement.start,
                              width: 200,
                              header: BsOffcanvasHeader(
                                child: const Text('Inline Panel'),
                                onClosePressed: () => setState(() => _showInlineOffcanvas = false),
                              ),
                              body: const BsOffcanvasBody(
                                child: Text('This offcanvas panel is built inline inside a Stack!'),
                              ),
                            ),
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

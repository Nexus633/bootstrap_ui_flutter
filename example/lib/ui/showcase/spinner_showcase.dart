import 'package:flutter/material.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

class SpinnerShowcase extends StatelessWidget {
  const SpinnerShowcase({super.key});

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
                    'Spinners',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ).pb2(),
                  Text(
                    'Indicate the loading state of a component or page with Bootstrap spinners.',
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
              title: 'Border spinner',
              description: 'Use the border spinners for a lightweight loading indicator.',
              child: const BsSpinner.border(),
            ),

            _Section(
              title: 'Colors',
              description: 'The border spinner uses currentColor for its border-color, meaning you can customize the color with variant utilities.',
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: BsVariant.values.map((variant) {
                  final spinner = BsSpinner.border(variant: variant);
                  if (variant == BsVariant.light) {
                    return Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: theme.dark,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: spinner,
                    );
                  }
                  return spinner;
                }).toList(),
              ),
            ),

            _Section(
              title: 'Growing spinner',
              description: 'If you don\'t fancy a border spinner, switch to the grow spinner. While it doesn\'t technically spin, it does repeatedly grow!',
              child: const BsSpinner.grow(),
            ),

            _Section(
              title: 'Growing Colors',
              description: 'Once again, this spinner is built with currentColor, so you can easily change its appearance with color variants.',
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: BsVariant.values.map((variant) {
                  final spinner = BsSpinner.grow(variant: variant);
                  if (variant == BsVariant.light) {
                    return Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: theme.dark,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: spinner,
                    );
                  }
                  return spinner;
                }).toList(),
              ),
            ),

            _Section(
              title: 'Size',
              description: 'Use BsSpinnerSize.sm to make a smaller spinner that can quickly be used within other components.',
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const BsSpinner.border(size: BsSpinnerSize.sm).pe(12),
                  const BsSpinner.grow(size: BsSpinnerSize.sm).pe(12),
                  const BsSpinner.border().pe(12),
                  const BsSpinner.grow().pe(12),
                ],
              ),
            ),

            _Section(
              title: 'Alignment',
              description: 'Use Flutter layout widgets like Align, Center, or Row/Column mainAxisAlignment to place spinners exactly where you need them.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(border: Border.all(color: context.bs.border)),
                    child: const Align(
                      alignment: Alignment.center,
                      child: BsSpinner.border(variant: BsVariant.primary),
                    ),
                  ).pb(12),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(border: Border.all(color: context.bs.border)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Loading...').ms(12),
                        const BsSpinner.border(variant: BsVariant.primary).me(12),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            _Section(
              title: 'Custom Duration (Speed)',
              description: 'Adjust the animationDuration property to change how fast the spinner animates. Default is 750ms.',
              child: Row(
                children: [
                  const Column(
                    children: [
                      BsSpinner.border(animationDuration: Duration(milliseconds: 300)),
                      SizedBox(height: 8),
                      Text('Fast (300ms)'),
                    ],
                  ).pe(24),
                  const Column(
                    children: [
                      BsSpinner.border(animationDuration: Duration(milliseconds: 1500)),
                      SizedBox(height: 8),
                      Text('Slow (1500ms)'),
                    ],
                  ),
                ],
              ),
            ),

            _Section(
              title: 'Buttons',
              description: 'Use spinners within buttons to indicate an action is currently processing or taking place.',
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BsButton(
                    onPressed: () {},
                    label: '',
                    isLoading: true,
                  ).pe(12),
                  BsButton(
                    onPressed: () {},
                    label: 'Loading...',
                    isLoading: true,
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
          alignment: Alignment.topLeft,
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

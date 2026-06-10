import 'package:flutter/material.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

class ProgressShowcase extends StatefulWidget {
  const ProgressShowcase({super.key});

  @override
  State<ProgressShowcase> createState() => _ProgressShowcaseState();
}

class _ProgressShowcaseState extends State<ProgressShowcase> {
  double _dynamicValue = 45.0;

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
                  colors: [theme.primary, theme.success],
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
                    'Progress bars',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ).pb2(),
                  Text(
                    'Documentation and examples for using Bootstrap custom progress bars featuring support for stacked bars, animated backgrounds, and text labels.',
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
              title: 'Basic Example',
              description: 'Progress components are built with a track (BsProgress) and a fill (BsProgressBar) denoting completion.',
              child: Column(
                children: [
                  BsProgress.single(value: 0.0).mb3(),
                  BsProgress.single(value: 25.0).mb3(),
                  BsProgress.single(value: 50.0).mb3(),
                  BsProgress.single(value: 75.0).mb3(),
                  BsProgress.single(value: 100.0),
                ],
              ),
            ),

            // 2. Labels
            _Section(
              title: 'Labels',
              description: 'Add labels to your progress bars by providing a String. Text aligns to the center and clips gracefully.',
              child: Column(
                children: [
                  BsProgress.single(value: 25.0, label: '25% Complete').mb3(),
                  BsProgress.single(value: 60.0, label: 'Processing data (60%)').mb3(),
                  BsProgress.single(
                    value: 100.0,
                    label: 'Finished!',
                    variant: BsVariant.success,
                  ),
                ],
              ),
            ),

            // 3. Height
            _Section(
              title: 'Height',
              description: 'Set custom height values. Standard height is 16.0 (1rem). Dynamic children scale automatically.',
              child: Column(
                children: [
                  const Text('1px height (Micro progress):').fs6().pb2(),
                  BsProgress.single(value: 50.0, height: 1.0).mb3(),
                  const Text('8px height (Subtle progress):').fs6().pb2(),
                  BsProgress.single(value: 65.0, height: 8.0).mb3(),
                  const Text('24px height (Large with Label):').fs6().pb2(),
                  BsProgress.single(
                    value: 80.0,
                    height: 24.0,
                    label: '80% Loaded',
                  ),
                ],
              ),
            ),

            // 4. Background Colors
            _Section(
              title: 'Backgrounds (Colors)',
              description: 'Use theme color variants or custom colors to match your branding.',
              child: Column(
                children: [
                  BsProgress.single(value: 12.0, variant: BsVariant.secondary).mb3(),
                  BsProgress.single(value: 25.0, variant: BsVariant.success).mb3(),
                  BsProgress.single(value: 38.0, variant: BsVariant.info).mb3(),
                  BsProgress.single(value: 50.0, variant: BsVariant.warning).mb3(),
                  BsProgress.single(value: 62.0, variant: BsVariant.danger).mb3(),
                  BsProgress.single(value: 75.0, variant: BsVariant.dark).mb3(),
                  BsProgress.single(
                    value: 90.0,
                    variant: BsVariant.light,
                    label: 'Light variant',
                  ).mb3(),
                  BsProgress.single(
                    value: 70.0,
                    barColor: Colors.deepPurple,
                    textColor: Colors.white,
                    label: 'Custom Colors (Purple)',
                  ),
                ],
              ),
            ),

            // 5. Stacked Multiple Bars
            _Section(
              title: 'Multiple Bars (Stacked)',
              description: 'Include multiple progress bar segments in a single progress container to stack them. Track handles unused space automatically.',
              child: const BsProgress(
                bars: [
                  BsProgressBar(value: 15.0, variant: BsVariant.primary, label: '15%'),
                  BsProgressBar(value: 30.0, variant: BsVariant.success, label: '30%'),
                  BsProgressBar(value: 20.0, variant: BsVariant.info, label: '20%'),
                ],
              ),
            ),

            // 6. Striped Pattern
            _Section(
              title: 'Striped',
              description: 'Apply diagonal striped pattern to the progress bar filling for a textured appearance.',
              child: Column(
                children: [
                  BsProgress.single(value: 10.0, striped: true).mb3(),
                  BsProgress.single(value: 25.0, variant: BsVariant.success, striped: true).mb3(),
                  BsProgress.single(value: 50.0, variant: BsVariant.info, striped: true).mb3(),
                  BsProgress.single(value: 75.0, variant: BsVariant.warning, striped: true).mb3(),
                  BsProgress.single(value: 100.0, variant: BsVariant.danger, striped: true),
                ],
              ),
            ),

            // 7. Animated Stripes
            _Section(
              title: 'Animated Stripes',
              description: 'Animate diagonal stripes to represent active processing. Uses an optimized repeating ticker loop.',
              child: Column(
                children: [
                  BsProgress.single(value: 75.0, animated: true).mb4(),
                  BsProgress.single(
                    value: 40.0,
                    variant: BsVariant.success,
                    striped: true,
                    animated: true,
                    label: 'Active Upload',
                  ).mb4(),
                  
                  // Interactive Slider control
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.bodyBgSecondary,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: theme.border),
                    ),
                    child: Column(
                      children: [
                        const Text('Drag the slider to update progress in real-time:').fs6().pb2(),
                        Slider(
                          value: _dynamicValue,
                          min: 0.0,
                          max: 100.0,
                          onChanged: (newValue) {
                            setState(() {
                              _dynamicValue = newValue;
                            });
                          },
                        ),
                        const SizedBox(height: 12),
                        BsProgress.single(
                          value: _dynamicValue,
                          label: '${_dynamicValue.toStringAsFixed(1)}%',
                          variant: _dynamicValue > 80.0
                              ? BsVariant.success
                              : _dynamicValue > 40.0
                                  ? BsVariant.primary
                                  : BsVariant.danger,
                          animated: true,
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

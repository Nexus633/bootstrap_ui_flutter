import 'package:flutter/material.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

class UtilitiesShowcase extends StatelessWidget {
  const UtilitiesShowcase({super.key});

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
                    'Bootstrap Utilities',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ).pb2(),
                  Text(
                    'A rich set of chainable extension methods on Widget to style, lay out, align, and decorate UI components inline.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: 0.9),
                      height: 1.4,
                    ),
                  ),
                ],
              ).p4(),
            ).mb(32),

            // 1. Borders & Rounded Section (NEW!)
            _Section(
              title: 'Borders & Rounded Utilities',
              description:
                  'Manage borders, side-specific borders, border colors, and border-radius corners.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Border Configurations:').fwBold().fs5().pb3(),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      _BorderBox(
                        label: 'Full Border',
                        child: SizedBox(width: 80, height: 60).border(
                          color: theme.emphasisColor.withValues(alpha: 0.3),
                        ),
                      ),
                      _BorderBox(
                        label: 'Border Top',
                        child: SizedBox(width: 80, height: 60).borderTop(
                          color: theme.emphasisColor.withValues(alpha: 0.3),
                          width: 3.0,
                        ),
                      ),
                      _BorderBox(
                        label: 'Border Bottom',
                        child: SizedBox(width: 80, height: 60).borderBottom(
                          color: theme.emphasisColor.withValues(alpha: 0.3),
                          width: 3.0,
                        ),
                      ),
                      _BorderBox(
                        label: 'Border Start',
                        child: SizedBox(width: 80, height: 60).borderStart(
                          color: theme.emphasisColor.withValues(alpha: 0.3),
                          width: 3.0,
                        ),
                      ),
                      _BorderBox(
                        label: 'Border End',
                        child: SizedBox(width: 80, height: 60).borderEnd(
                          color: theme.emphasisColor.withValues(alpha: 0.3),
                          width: 3.0,
                        ),
                      ),
                    ],
                  ).pb4(),

                  const Text(
                    'Border Colors (borderVariant):',
                  ).fwBold().fs5().pb3(),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      _BorderBox(
                        label: 'Primary',
                        child: const SizedBox(
                          width: 80,
                          height: 60,
                        ).borderVariant(context, BsVariant.primary, width: 2.0),
                      ),
                      _BorderBox(
                        label: 'Success',
                        child: const SizedBox(
                          width: 80,
                          height: 60,
                        ).borderVariant(context, BsVariant.success, width: 2.0),
                      ),
                      _BorderBox(
                        label: 'Danger',
                        child: const SizedBox(
                          width: 80,
                          height: 60,
                        ).borderVariant(context, BsVariant.danger, width: 2.0),
                      ),
                      _BorderBox(
                        label: 'Warning',
                        child: const SizedBox(
                          width: 80,
                          height: 60,
                        ).borderVariant(context, BsVariant.warning, width: 2.0),
                      ),
                      _BorderBox(
                        label: 'Dark',
                        child: const SizedBox(
                          width: 80,
                          height: 60,
                        ).borderVariant(context, BsVariant.dark, width: 2.0),
                      ),
                    ],
                  ).pb4(),

                  const Text('Border Radius (rounded*):').fwBold().fs5().pb3(),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      _BorderBox(
                        label: 'rounded-1 (4px)',
                        child: Container(
                          width: 80,
                          height: 60,
                          color: theme.primary,
                        ).rounded1(),
                      ),
                      _BorderBox(
                        label: 'rounded-3 (8px)',
                        child: Container(
                          width: 80,
                          height: 60,
                          color: theme.primary,
                        ).rounded3(),
                      ),
                      _BorderBox(
                        label: 'rounded-5 (32px)',
                        child: Container(
                          width: 80,
                          height: 60,
                          color: theme.primary,
                        ).rounded5(),
                      ),
                      _BorderBox(
                        label: 'rounded-pill',
                        child: Container(
                          width: 100,
                          height: 50,
                          color: theme.primary,
                        ).roundedPill(),
                      ),
                      _BorderBox(
                        label: 'rounded-circle',
                        child: Container(
                          width: 60,
                          height: 60,
                          color: theme.primary,
                        ).roundedCircle(),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 2. Spacing Section
            _Section(
              title: 'Spacing Utilities',
              description:
                  'Padding (p*) and Margin (m*) utilities. Level 0-5 and auto margins.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Padding Levels (Outer container padding):',
                  ).fwBold().fs5().pb3(),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      _SpacingBox(
                        label: 'p0',
                        paddingWidget: Container(
                          color: theme.primary,
                          width: 30,
                          height: 30,
                        ).p0(),
                      ),
                      _SpacingBox(
                        label: 'p1',
                        paddingWidget: Container(
                          color: theme.primary,
                          width: 30,
                          height: 30,
                        ).p1(),
                      ),
                      _SpacingBox(
                        label: 'p2',
                        paddingWidget: Container(
                          color: theme.primary,
                          width: 30,
                          height: 30,
                        ).p2(),
                      ),
                      _SpacingBox(
                        label: 'p3',
                        paddingWidget: Container(
                          color: theme.primary,
                          width: 30,
                          height: 30,
                        ).p3(),
                      ),
                      _SpacingBox(
                        label: 'p4',
                        paddingWidget: Container(
                          color: theme.primary,
                          width: 30,
                          height: 30,
                        ).p4(),
                      ),
                      _SpacingBox(
                        label: 'p5',
                        paddingWidget: Container(
                          color: theme.primary,
                          width: 30,
                          height: 30,
                        ).p5(),
                      ),
                    ],
                  ).pb4(),

                  const Text(
                    'Auto Margin Layout (Push-alignment in Stack/Flex):',
                  ).fwBold().fs5().pb3(),
                  Container(
                    width: double.infinity,
                    height: 120,
                    decoration: BoxDecoration(
                      color: theme.lightBgSubtle,
                      border: Border.all(color: theme.border),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Stack(
                      children: [
                        // Centered via mxAuto()
                        Container(
                          width: 80,
                          height: 40,
                          color: theme.primary,
                          child: const Center(
                            child: Text(
                              'mxAuto',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ).mxAuto(),
                        // Left Aligned via meAuto()
                        Container(
                          width: 80,
                          height: 40,
                          color: theme.danger,
                          child: const Center(
                            child: Text(
                              'meAuto',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ).meAuto(),
                        // Right Aligned via msAuto()
                        Container(
                          width: 80,
                          height: 40,
                          color: theme.success,
                          child: const Center(
                            child: Text(
                              'msAuto',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ).msAuto(),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 3. Sizing Section
            _Section(
              title: 'Sizing & Viewport Utilities',
              description:
                  'Control width/height percentages and viewport dimensions (vw, vh).',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Percentage Widths:').fwBold().fs5().pb3(),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: theme.lightBgSubtle,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: theme.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 24,
                          color: theme.info,
                          child: const Center(
                            child: Text(
                              'w25',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ).w25().pb2(),
                        Container(
                          height: 24,
                          color: theme.info,
                          child: const Center(
                            child: Text(
                              'w50',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ).w50().pb2(),
                        Container(
                          height: 24,
                          color: theme.info,
                          child: const Center(
                            child: Text(
                              'w75',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ).w75().pb2(),
                        Container(
                          height: 24,
                          color: theme.info,
                          child: const Center(
                            child: Text(
                              'w100',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ).w100(),
                      ],
                    ),
                  ).pb4(),

                  const Text('Viewport Sizing Demo:').fwBold().fs5().pb3(),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      BsButton(
                        label: 'Show 50vh Area',
                        onPressed: () {
                          showDialog<void>(
                            context: context,
                            builder: (context) => Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: theme.bodyBg,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: theme.border,
                                    width: 1.5,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.3,
                                      ),
                                      blurRadius: 24,
                                      offset: const Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.height,
                                      size: 48,
                                      color: theme.primary,
                                    ).pb3(),
                                    const Text(
                                      '50vh Viewport Height',
                                    ).fwBold().fs4().pb2(),
                                    Text(
                                      'This container is exactly 50vh tall!',
                                      style: TextStyle(
                                        color: theme.bodyTextSecondary,
                                      ),
                                    ).pb4(),
                                    BsButton(
                                      label: 'Close Demo',
                                      variant: BsButtonVariant.secondary,
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ],
                                ).p4(),
                              ).vh50(context).w(320),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 4. Text Utilities
            _Section(
              title: 'Text & Casing Utilities',
              description:
                  'Font weights, styles, decoration, wrapping, and text transform operations.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Casing Transformations (NEW!):',
                  ).fwBold().fs5().pb3(),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.lightBgSubtle,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: theme.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ORIGINAL: bootstrap ui flutter',
                        ).fwBold().pb2(),
                        const Text(
                          'bootstrap ui flutter',
                        ).textUppercase().pb2(),
                        const Text(
                          'BOOTSTRAP UI FLUTTER',
                        ).textLowercase().pb2(),
                        const Text('bootstrap ui flutter').textCapitalize(),
                      ],
                    ),
                  ).pb4(),

                  const Text('Text Wrapping:').fwBold().fs5().pb3(),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(color: theme.border),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'This text wraps automatically to multiple lines because it is configured with textWrap().',
                          ).textWrap(),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(color: theme.border),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: const Text(
                            'This text will not wrap and overflows textNowrap()',
                          ).textNowrap(),
                        ),
                      ),
                    ],
                  ).pb4(),

                  const Text(
                    'Display Headings (display-1 to display-6):',
                  ).fwBold().fs5().pb3(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Display 1').display1().pb2(),
                      const Text('Display 2').display2().pb2(),
                      const Text('Display 3').display3().pb2(),
                      const Text('Display 4').display4().pb2(),
                      const Text('Display 5').display5().pb2(),
                      const Text('Display 6').display6().pb4(),
                    ],
                  ),

                  const Text('Font Sizes (fs-1 to fs-6):').fwBold().fs5().pb3(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Font Size 1 (40px)').fs1().pb2(),
                      const Text('Font Size 2 (32px)').fs2().pb2(),
                      const Text('Font Size 3 (28px)').fs3().pb2(),
                      const Text('Font Size 4 (24px)').fs4().pb2(),
                      const Text('Font Size 5 (20px)').fs5().pb2(),
                      const Text('Font Size 6 (16px)').fs6().pb4(),
                    ],
                  ),

                  const Text('Font Weights:').fwBold().fs5().pb3(),
                  Wrap(
                    spacing: 16,
                    runSpacing: 8,
                    children: [
                      const Text('Light').fwLight(),
                      const Text('Normal').fwNormal(),
                      const Text('Medium').fwMedium(),
                      const Text('Semibold').fwSemibold(),
                      const Text('Bold').fwBold(),
                      const Text('Bolder').fwBolder(),
                    ],
                  ).pb4(),

                  const Text('Font Styles & Decorations:').fwBold().fs5().pb3(),
                  Wrap(
                    spacing: 16,
                    runSpacing: 8,
                    children: [
                      const Text('Italic text').fstItalic(),
                      const Text('Underlined text').textDecorationUnderline(),
                      const Text(
                        'Line-through text',
                      ).textDecorationLineThrough(),
                      const Text(
                        'Underline Strike',
                      ).textDecorationUnderline().textDecorationLineThrough(),
                    ],
                  ),
                ],
              ),
            ),

            // 5. Breakpoints & Responsive Utilities
            _Section(
              title: 'Responsive Breakpoint Utilities',
              description:
                  'Utilities that apply dynamically based on screen width.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Display & Visibility:').fwBold().fs5().pb3(),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.info.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: theme.info.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Builder(
                          builder: (context) {
                            final width = MediaQuery.sizeOf(context).width;
                            return Text(
                              'Current Window Width: ${width.toStringAsFixed(0)}px',
                              style: TextStyle(
                                color: theme.info,
                                fontWeight: FontWeight.bold,
                              ),
                            ).pb2();
                          },
                        ),
                        const Text(
                          'Resize window to see effects.',
                        ).fwLight().pb2(),
                        Row(
                          children: [
                            const Icon(Icons.phone_android).pe2(),
                            const Text('Always Visible'),
                          ],
                        ).pb2(),
                        Row(
                          children: [
                            const Icon(Icons.tablet).pe2(),
                            Text(
                              'Hidden on Medium (md) & Up',
                              style: TextStyle(
                                color: theme.danger,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ).dNone(BsBreakpoints.md).pb2(),
                        Row(
                          children: [
                            const Icon(Icons.desktop_windows).pe2(),
                            Text(
                              'Visible ONLY on Large (lg) & Up',
                              style: TextStyle(
                                color: theme.success,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ).dBlock(BsBreakpoints.xxl).pb2(),
                      ],
                    ),
                  ).pb4(),

                  const Text('Responsive Spacing:').fwBold().fs5().pb3(),
                  Container(
                    color: theme.primary,
                    child: const Text(
                      'p1 on small, p5 on medium',
                      style: TextStyle(color: Colors.white),
                    ).p1().p5(BsBreakpoints.md),
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

class _BorderBox extends StatelessWidget {
  const _BorderBox({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = context.bs;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.bodyBgSecondary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: child,
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: theme.bodyText,
          ),
        ),
      ],
    );
  }
}

class _SpacingBox extends StatelessWidget {
  const _SpacingBox({required this.label, required this.paddingWidget});

  final String label;
  final Widget paddingWidget;

  @override
  Widget build(BuildContext context) {
    final theme = context.bs;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: theme.bodyBgSecondary,
            border: Border.all(color: theme.border),
            borderRadius: BorderRadius.circular(8),
          ),
          child: paddingWidget,
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: theme.bodyText,
          ),
        ),
      ],
    );
  }
}

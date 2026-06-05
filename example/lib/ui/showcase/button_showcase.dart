import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';
import 'package:flutter/material.dart';

class ButtonShowcase extends StatefulWidget {
  const ButtonShowcase({super.key});

  @override
  State<ButtonShowcase> createState() => _ButtonShowcaseState();
}

class _ButtonShowcaseState extends State<ButtonShowcase> {
  bool _isLoading = false;

  Future<void> _simulateLoading() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    // Get theme
    final bsTheme = context.bs;

    return Scaffold(
      backgroundColor: bsTheme.bodyBg, // Dynamic background
      appBar: AppBar(
        backgroundColor: bsTheme.bodyBg,
        foregroundColor: bsTheme.bodyText,
        title: const Text('Buttons'),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: bsTheme.border, height: 1.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('Solid Variants'),
            _description('Corresponds to: btn btn-primary, btn-secondary, etc.'),
            _Wrap(
              children: [
                BsButton(
                  label: 'Primary',
                  variant: BsButtonVariant.primary,
                  onPressed: () {},
                ),
                BsButton(
                  label: 'Secondary',
                  variant: BsButtonVariant.secondary,
                  onPressed: () {},
                ),
                BsButton(
                  label: 'Success',
                  variant: BsButtonVariant.success,
                  onPressed: () {},
                ),
                BsButton(
                  label: 'Danger',
                  variant: BsButtonVariant.danger,
                  onPressed: () {},
                ),
                BsButton(
                  label: 'Warning',
                  variant: BsButtonVariant.warning,
                  onPressed: () {},
                ),
                BsButton(
                  label: 'Info',
                  variant: BsButtonVariant.info,
                  onPressed: () {},
                ),
                BsButton(
                  label: 'Light',
                  variant: BsButtonVariant.light,
                  onPressed: () {},
                ),
                BsButton(
                  label: 'Dark',
                  variant: BsButtonVariant.dark,
                  onPressed: () {},
                ),
                BsButton(
                  label: 'Link',
                  variant: BsButtonVariant.link,
                  onPressed: () {},
                ),
              ],
            ).pt2(),

            _divider(bsTheme.border),
            _sectionTitle('Outline Variants'),
            _description('Corresponds to: btn btn-outline-primary, etc.'),
            _Wrap(
              children: [
                BsButton(
                  label: 'Primary',
                  variant: BsButtonVariant.outlinePrimary,
                  onPressed: () {},
                ),
                BsButton(
                  label: 'Secondary',
                  variant: BsButtonVariant.outlineSecondary,
                  onPressed: () {},
                ),
                BsButton(
                  label: 'Success',
                  variant: BsButtonVariant.outlineSuccess,
                  onPressed: () {},
                ),
                BsButton(
                  label: 'Danger',
                  variant: BsButtonVariant.outlineDanger,
                  onPressed: () {},
                ),
                BsButton(
                  label: 'Warning',
                  variant: BsButtonVariant.outlineWarning,
                  onPressed: () {},
                ),
                BsButton(
                  label: 'Info',
                  variant: BsButtonVariant.outlineInfo,
                  onPressed: () {},
                ),
                BsButton(
                  label: 'Dark',
                  variant: BsButtonVariant.outlineDark,
                  onPressed: () {},
                ),
              ],
            ).pt2(),

            _divider(bsTheme.border),
            _sectionTitle('Sizes'),
            _description('Corresponds to: btn-sm, (default), btn-lg'),
            _Wrap(
              children: [
                BsButton(
                  label: 'Small',
                  variant: BsButtonVariant.primary,
                  size: BsButtonSize.sm,
                  onPressed: () {},
                ),
                BsButton(
                  label: 'Medium',
                  variant: BsButtonVariant.primary,
                  size: BsButtonSize.md,
                  onPressed: () {},
                ),
                BsButton(
                  label: 'Large',
                  variant: BsButtonVariant.primary,
                  size: BsButtonSize.lg,
                  onPressed: () {},
                ),
              ],
            ).pt2(),

            _divider(bsTheme.border),
            _sectionTitle('With Icon'),
            _description(
              'Corresponds to: <button><i class="bi bi-..."></i> Label</button>',
            ),
            _Wrap(
              children: [
                BsButton(
                  label: 'Save',
                  variant: BsButtonVariant.primary,
                  icon: Icons.save,
                  iconVariant:
                      BsIconVariant.light, // Example of icon variant
                  iconColor: Colors.yellow, // Example of icon color
                  onPressed: () {},
                ),
                BsButton(
                  label: 'Delete',
                  variant: BsButtonVariant.danger,
                  icon: Icons.delete,
                  onPressed: () {},
                ),
                BsButton(
                  label: 'Info',
                  variant: BsButtonVariant.info,
                  icon: Icons.info,
                  onPressed: () {},
                ),
              ],
            ).pt2(),

            _divider(bsTheme.border),
            _sectionTitle('States'),
            _description('Disabled (onPressed: null) and Loading'),
            _Wrap(
              children: [
                const BsButton(
                  label: 'Disabled',
                  variant: BsButtonVariant.primary,
                ),
                const BsButton(
                  label: 'Disabled',
                  variant: BsButtonVariant.outlinePrimary,
                ),
                BsButton(
                  label: 'Loading...',
                  variant: BsButtonVariant.primary,
                  isLoading: _isLoading,
                  onPressed: _simulateLoading,
                ),
              ],
            ).pt2(),

            _divider(bsTheme.border),
            _sectionTitle('Full Width (d-grid)'),
            _description(
              'Corresponds to: <div class="d-grid"> → Button takes full width',
            ),
            BsButton(
              label: 'Full Width Button',
              variant: BsButtonVariant.primary,
              fullWidth: true,
              onPressed: () {},
            ).pt2(),
            BsButton(
              label: 'Full Width Outline',
              variant: BsButtonVariant.outlinePrimary,
              fullWidth: true,
              onPressed: () {},
            ).pt2(),

            _divider(bsTheme.border),
            _sectionTitle('Button Groups'),
            _description('Corresponds to: btn-group '),
            BsButtonGroup(
              groupSize: BsButtonSize.md,
              children: [
                BsButton(
                  label: 'Left',
                  variant: BsButtonVariant.primary,
                  onPressed: () {},
                ),
                BsButton(
                  label: 'Middle',
                  variant: BsButtonVariant.warning,
                  onPressed: () {},
                ),
                BsButton(
                  label: 'Right',
                  variant: BsButtonVariant.danger,
                  onPressed: () {},
                ),
              ],
            ).pt2(),
          ],
        ).p3(),
      ),
    );
  }

  // ─── Helpers ────────────────────────────────────────────────────────────────

  Widget _sectionTitle(String text) => Text(
    text,
    style: BsTypography.body.copyWith(
      fontSize: BsTypography.h5,
      fontWeight: BsTypography.weightBold,
      color: context.bs.bodyText,
    ),
  );

  Widget _description(String text) => Text(
    text,
    style: BsTypography.body.copyWith(
      color: context.bs.bodyTextSecondary,
      fontSize: BsTypography.fontSizeSm,
    ),
  );

  Widget _divider(Color borderColor) => Padding(
    padding: const EdgeInsets.symmetric(vertical: BsSpacing.s4),
    child: Divider(color: borderColor),
  );
}

class _Wrap extends StatelessWidget {
  const _Wrap({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: BsSpacing.s2,
      runSpacing: BsSpacing.s2,
      children: children,
    );
  }
}

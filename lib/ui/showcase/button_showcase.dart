import 'package:flutter/material.dart';
import '../tokens/colors.dart';
import '../tokens/spacing.dart';
import '../tokens/typography.dart';
import '../components/button/bs_button.dart';
import '../components/button/bs_button_group.dart';

/// Zeigt alle AppButton-Varianten und Größen — wie die Bootstrap Dokumentation.
/// Diese Seite dient als lebendige Referenz für das Design-System.
class ButtonShowcase extends StatefulWidget {
  const ButtonShowcase({super.key});

  @override
  State<ButtonShowcase> createState() => _ButtonShowcaseState();
}

class _ButtonShowcaseState extends State<ButtonShowcase> {
  // State für den Loading-Button Demo.
  bool _isLoading = false;

  Future<void> _simulateLoading() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BsColors.bodyBg,
      appBar: AppBar(
        backgroundColor: BsColors.dark,
        title: const Text('Buttons', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(BsSpacing.s3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('Solid Varianten'),
            _description('Entspricht: btn btn-primary, btn-secondary, etc.'),
            const SizedBox(height: BsSpacing.s2),
            _Wrap(
              children: [
                AppButton(
                  label: 'Primary',
                  variant: BsButtonVariant.primary,
                  onPressed: () {},
                ),
                AppButton(
                  label: 'Secondary',
                  variant: BsButtonVariant.secondary,
                  onPressed: () {},
                ),
                AppButton(
                  label: 'Success',
                  variant: BsButtonVariant.success,
                  onPressed: () {},
                ),
                AppButton(
                  label: 'Danger',
                  variant: BsButtonVariant.danger,
                  onPressed: () {},
                ),
                AppButton(
                  label: 'Warning',
                  variant: BsButtonVariant.warning,
                  onPressed: () {},
                ),
                AppButton(
                  label: 'Info',
                  variant: BsButtonVariant.info,
                  onPressed: () {},
                ),
                AppButton(
                  label: 'Light',
                  variant: BsButtonVariant.light,
                  onPressed: () {},
                ),
                AppButton(
                  label: 'Dark',
                  variant: BsButtonVariant.dark,
                  onPressed: () {},
                ),
                AppButton(
                  label: 'Link',
                  variant: BsButtonVariant.link,
                  onPressed: () {},
                ),
              ],
            ),

            _divider(),
            _sectionTitle('Outline Varianten'),
            _description('Entspricht: btn btn-outline-primary, etc.'),
            const SizedBox(height: BsSpacing.s2),
            _Wrap(
              children: [
                AppButton(
                  label: 'Primary',
                  variant: BsButtonVariant.outlinePrimary,
                  onPressed: () {},
                ),
                AppButton(
                  label: 'Secondary',
                  variant: BsButtonVariant.outlineSecondary,
                  onPressed: () {},
                ),
                AppButton(
                  label: 'Success',
                  variant: BsButtonVariant.outlineSuccess,
                  onPressed: () {},
                ),
                AppButton(
                  label: 'Danger',
                  variant: BsButtonVariant.outlineDanger,
                  onPressed: () {},
                ),
                AppButton(
                  label: 'Warning',
                  variant: BsButtonVariant.outlineWarning,
                  onPressed: () {},
                ),
                AppButton(
                  label: 'Info',
                  variant: BsButtonVariant.outlineInfo,
                  onPressed: () {},
                ),
                AppButton(
                  label: 'Dark',
                  variant: BsButtonVariant.outlineDark,
                  onPressed: () {},
                ),
              ],
            ),

            _divider(),
            _sectionTitle('Größen'),
            _description('Entspricht: btn-sm, (default), btn-lg'),
            const SizedBox(height: BsSpacing.s2),
            _Wrap(
              children: [
                AppButton(
                  label: 'Small',
                  variant: BsButtonVariant.primary,
                  size: BsButtonSize.sm,
                  onPressed: () {},
                ),
                AppButton(
                  label: 'Medium',
                  variant: BsButtonVariant.primary,
                  size: BsButtonSize.md,
                  onPressed: () {},
                ),
                AppButton(
                  label: 'Large',
                  variant: BsButtonVariant.primary,
                  size: BsButtonSize.lg,
                  onPressed: () {},
                ),
              ],
            ),

            _divider(),
            _sectionTitle('Mit Icon'),
            _description(
              'Entspricht: <button><i class="bi bi-..."></i> Label</button>',
            ),
            const SizedBox(height: BsSpacing.s2),
            _Wrap(
              children: [
                AppButton(
                  label: 'Speichern',
                  variant: BsButtonVariant.primary,
                  icon: Icons.save,
                  onPressed: () {},
                ),
                AppButton(
                  label: 'Löschen',
                  variant: BsButtonVariant.danger,
                  icon: Icons.delete,
                  onPressed: () {},
                ),
                AppButton(
                  label: 'Info',
                  variant: BsButtonVariant.info,
                  icon: Icons.info,
                  onPressed: () {},
                ),
              ],
            ),

            _divider(),
            _sectionTitle('States'),
            _description('Disabled (onPressed: null) und Loading'),
            const SizedBox(height: BsSpacing.s2),
            _Wrap(
              children: [
                // Disabled: onPressed ist null → Bootstrap's disabled-Attribut
                const AppButton(
                  label: 'Disabled',
                  variant: BsButtonVariant.primary,
                ),
                const AppButton(
                  label: 'Disabled',
                  variant: BsButtonVariant.outlinePrimary,
                ),
                // Loading State
                AppButton(
                  label: 'Laden...',
                  variant: BsButtonVariant.primary,
                  isLoading: _isLoading,
                  onPressed: _simulateLoading,
                ),
              ],
            ),

            _divider(),
            _sectionTitle('Full Width (d-grid)'),
            _description(
              'Entspricht: <div class="d-grid"> → Button nimmt volle Breite',
            ),
            const SizedBox(height: BsSpacing.s2),
            AppButton(
              label: 'Full Width Button',
              variant: BsButtonVariant.primary,
              fullWidth: true,
              onPressed: () {},
            ),
            const SizedBox(height: BsSpacing.s2),
            AppButton(
              label: 'Full Width Outline',
              variant: BsButtonVariant.outlinePrimary,
              fullWidth: true,
              onPressed: () {},
            ),

            _divider(),
            _sectionTitle('Button Gruppen'),
            _description('Entspricht: btn-group '),
            const SizedBox(height: BsSpacing.s2),
            BsButtonGroup(
              groupSize: BsButtonSize.md,
              children: [
                AppButton(
                  label: 'Left',
                  variant: BsButtonVariant.primary,
                  onPressed: () {},
                ),
                AppButton(
                  label: 'Middle',
                  variant: BsButtonVariant.warning,
                  onPressed: () {},
                ),
                AppButton(
                  label: 'Right',
                  variant: BsButtonVariant.danger,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ─── Helpers ────────────────────────────────────────────────────────────────

  Widget _sectionTitle(String text) => Text(
    text,
    style: BsTypography.body.copyWith(
      fontSize: BsTypography.h5,
      fontWeight: BsTypography.weightBold,
      color: BsColors.body,
    ),
  );

  Widget _description(String text) => Text(
    text,
    style: BsTypography.body.copyWith(
      color: BsColors.mutedText,
      fontSize: BsTypography.fontSizeSm,
    ),
  );

  Widget _divider() => const Padding(
    padding: EdgeInsets.symmetric(vertical: BsSpacing.s4),
    child: Divider(color: BsColors.border),
  );
}

/// Wrap-Widget das Buttons mit gleichmäßigem Abstand umschließt.
/// Entspricht der Flexbox-Darstellung in der Bootstrap Doku.
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

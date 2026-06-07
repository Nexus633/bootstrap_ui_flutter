import 'package:flutter/material.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

class FormShowcase extends StatefulWidget {
  const FormShowcase({super.key});

  @override
  State<FormShowcase> createState() => _FormShowcaseState();
}

class _FormShowcaseState extends State<FormShowcase> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedValue;
  bool _switchValue = false;
  double _rangeValue = 50.0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BsContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Forms', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: BsSpacing.s3),

            _description(
              'Examples and usage guidelines for form control styles, layout options, and custom components.',
            ),

            _sectionTitle('Form Controls'),
            _description('Standard input fields and textareas.'),
            BsInput(placeholder: 'name@example.com').pb3(),
            BsInput(placeholder: 'Password', obscureText: true).pb3(),
            BsInput(placeholder: 'Disabled input', disabled: true).pb3(),
            BsInput(
              initialValue: 'Readonly input here...',
              readonly: true,
            ).pb3(),
            BsInput(initialValue: 'email@example.com', plainText: true).pb4(),

            _sectionTitle('Sizing'),
            _description('Set heights using the size property.'),
            BsInput(
              placeholder: '.form-control-lg',
              size: BsInputSize.lg,
            ).pb3(),
            BsInput(placeholder: 'Default input').pb3(),
            BsInput(
              placeholder: '.form-control-sm',
              size: BsInputSize.sm,
            ).pb4(),

            _sectionTitle('Select'),
            _description('Custom select menus.'),
            BsSelect<String>(
              value: _selectedValue,
              placeholder: const Text('Open this select menu'),
              items: const [
                DropdownMenuItem(value: '1', child: Text('One')),
                DropdownMenuItem(value: '2', child: Text('Two')),
                DropdownMenuItem(value: '3', child: Text('Three')),
              ],
              onChanged: (val) => setState(() => _selectedValue = val),
            ).pb3(),
            BsSelect<String>(
              placeholder: const Text('Small select menu'),
              size: BsInputSize.sm,
              items: const [],
            ).pb4(),

            _sectionTitle('Checks & Radios'),
            _description('Custom checkboxes and switches.'),
            BsCheckbox(
              inline: true,
              label: const Text('Default checkbox'),
            ).pb2(),
            BsCheckbox(
              label: const Text('Checked checkbox'),
              initialValue: true,
            ).pb2(),
            BsCheckbox(
              label: const Text('Disabled checkbox'),
              disabled: true,
            ).pb3(),

            const Text(
              'Switches',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).pb2(),
            BsCheckbox(
              label: const Text('Default switch checkbox input'),
              isSwitch: true,
              initialValue: _switchValue,
              onChanged: (val) => setState(() => _switchValue = val ?? false),
            ).pb2(),
            BsCheckbox(
              label: const Text('Checked switch checkbox input'),
              isSwitch: true,
              initialValue: true,
            ).pb2(),
            BsCheckbox(
              label: const Text('Disabled switch checkbox input'),
              isSwitch: true,
              disabled: true,
            ).pb4(),

            _sectionTitle('Range'),
            _description('Custom range sliders.'),
            BsRange(
              initialValue: _rangeValue,
              onChanged: (val) => setState(() => _rangeValue = val),
            ).pb2(),
            BsRange(disabled: true, initialValue: 75.0).pb4(),

            _sectionTitle('Input Groups'),
            _description(
              'Easily extend form controls by adding text or buttons.',
            ),
            BsInputGroup(
              children: [
                const BsInputGroupText('@'),
                BsInput(placeholder: 'Username').expanded(),
              ],
            ).pb3(),
            BsInputGroup(
              children: [
                BsInput(placeholder: 'Recipient\'s username').expanded(),
                const BsInputGroupText('@example.com'),
              ],
            ).pb3(),
            BsInputGroup(
              children: [
                const BsInputGroupText('\$'),
                BsInput(placeholder: 'Amount').expanded(),
                const BsInputGroupText('.00'),
              ],
            ).pb3(),
            BsInputGroup(
              children: [
                BsButton(
                  label: 'Button',
                  variant: BsButtonVariant.outlineSecondary,
                  onPressed: () {},
                ),
                BsInput(placeholder: '').expanded(),
              ],
            ).pb3(),
            BsInputGroup(
              children: [
                BsSelect<String>(
                  placeholder: const Text('Options'),
                  items: const [
                    DropdownMenuItem(value: '1', child: Text('One')),
                  ],
                ).expanded(),
                BsInput(placeholder: 'Search...').expanded(2),
                BsButton(label: 'Search', onPressed: () {}),
              ],
            ).pb4(),

            _sectionTitle('Validation'),
            _description(
              'Provide valuable, actionable feedback to your users with form validation.',
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BsRow(
                    gutterY: BsSpacing.s3,
                    children: [
                      BsCol(
                        config: const BsColConfig(md: 4),
                        child: BsInput(
                          placeholder: 'First name',
                          initialValue: 'Mark',
                          validationState: BsValidationState.valid,
                        ),
                      ),
                      BsCol(
                        config: const BsColConfig(md: 4),
                        child: BsInput(
                          placeholder: 'Last name',
                          initialValue: 'Otto',
                          validationState: BsValidationState.valid,
                        ),
                      ),
                      BsCol(
                        config: const BsColConfig(md: 4),
                        child: BsInputGroup(
                          children: [
                            const BsInputGroupText('@'),
                            BsInput(
                              placeholder: 'Username',
                              validator: (val) => val == null || val.isEmpty
                                  ? 'Please choose a username.'
                                  : null,
                            ).expanded(),
                          ],
                        ),
                      ),
                      BsCol(
                        config: const BsColConfig(md: 6),
                        child: BsInput(
                          placeholder: 'City',
                          validator: (val) => val == null || val.isEmpty
                              ? 'Please provide a valid city.'
                              : null,
                        ),
                      ),
                      BsCol(
                        config: const BsColConfig(md: 3),
                        child: BsSelect<String>(
                          placeholder: const Text('Choose...'),
                          items: const [
                            DropdownMenuItem(
                              value: '1',
                              child: Text('State 1'),
                            ),
                          ],
                          validator: (val) => val == null
                              ? 'Please select a valid state.'
                              : null,
                        ),
                      ),
                      BsCol(
                        config: const BsColConfig(md: 3),
                        child: BsInput(
                          placeholder: 'Zip',
                          validator: (val) => val == null || val.isEmpty
                              ? 'Please provide a valid zip.'
                              : null,
                        ),
                      ),
                      BsCol(
                        config: const BsColConfig.all(12),
                        child: BsCheckbox(
                          label: const Text('Agree to terms and conditions'),
                          validator: (val) => val == true
                              ? null
                              : 'You must agree before submitting.',
                        ),
                      ),
                      BsCol(
                        config: const BsColConfig.all(12),
                        child: BsButton(
                          label: 'Submit form',
                          onPressed: () {
                            _formKey.currentState!.validate();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: BsSpacing.s5),
          ],
        ).py4(),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: BsSpacing.s2, top: BsSpacing.s3),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _description(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: BsSpacing.s3),
      child: Text(text, style: const TextStyle(color: Colors.grey)),
    );
  }
}

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
  bool _wasValidated = false;

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
                    'Forms',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ).pb2(),
                  Text(
                    'Form controls and layouts. Custom styling for inputs, selects, checks, radios, range sliders, input groups, and built-in state validation feedback.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: 0.9),
                      height: 1.4,
                    ),
                  ),
                ],
              ).p4(),
            ).mb(32),

            // 1. Form Controls
            _Section(
              title: 'Form Controls',
              description: 'Standard text input fields, passwords, readonly and plaintext fields.',
              child: Column(
                children: [
                  BsInput(placeholder: 'name@example.com').pb3(),
                  BsInput(placeholder: 'Password', obscureText: true).pb3(),
                  BsInput(placeholder: 'Disabled input field', disabled: true).pb3(),
                  BsInput(
                    initialValue: 'Readonly input here...',
                    readonly: true,
                  ).pb3(),
                  BsInput(initialValue: 'email@example.com', plainText: true),
                ],
              ),
            ),

            // 2. Sizing
            _Section(
              title: 'Input Sizing',
              description: 'Set heights using custom size settings (sm, md, lg).',
              child: Column(
                children: [
                  BsInput(
                    placeholder: '.form-control-lg',
                    size: BsInputSize.lg,
                  ).pb3(),
                  BsInput(placeholder: 'Default input size').pb3(),
                  BsInput(
                    placeholder: '.form-control-sm',
                    size: BsInputSize.sm,
                  ),
                ],
              ),
            ),

            // 3. Select Options
            _Section(
              title: 'Select Menus',
              description: 'Custom dropdown menus for form selection.',
              child: Column(
                children: [
                  BsSelect<String>(
                    value: _selectedValue,
                    placeholder: const Text('Open this select menu'),
                    items: const [
                      DropdownMenuItem(value: '1', child: Text('Option One')),
                      DropdownMenuItem(value: '2', child: Text('Option Two')),
                      DropdownMenuItem(value: '3', child: Text('Option Three')),
                    ],
                    onChanged: (val) => setState(() => _selectedValue = val),
                  ).pb3(),
                  BsSelect<String>(
                    placeholder: const Text('Small select menu'),
                    size: BsInputSize.sm,
                    items: const [],
                  ),
                ],
              ),
            ),

            // 4. Checks, Radios & Switches
            _Section(
              title: 'Checks, Radios & Switches',
              description: 'Custom checkboxes, radio selections and toggle switches.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BsCheckbox(
                    label: const Text('Default checkbox option'),
                  ).pb2(),
                  BsCheckbox(
                    label: const Text('Checked checkbox option'),
                    initialValue: true,
                  ).pb2(),
                  BsCheckbox(
                    label: const Text('Disabled checkbox option'),
                    disabled: true,
                  ).pb3(),

                  const Text('Switches:').fwBold().fs6().pb2(),
                  BsCheckbox(
                    label: const Text('Default switch checkbox'),
                    isSwitch: true,
                    initialValue: _switchValue,
                    onChanged: (val) => setState(() => _switchValue = val ?? false),
                  ).pb2(),
                  BsCheckbox(
                    label: const Text('Disabled switch checkbox'),
                    isSwitch: true,
                    disabled: true,
                  ),
                ],
              ),
            ),

            // 5. Range Sliders
            _Section(
              title: 'Range Sliders',
              description: 'Horizontal range sliders with support for disabled states.',
              child: Column(
                children: [
                  BsRange(
                    initialValue: _rangeValue,
                    onChanged: (val) => setState(() => _rangeValue = val),
                  ).pb3(),
                  BsRange(disabled: true, initialValue: 75.0),
                ],
              ),
            ),

            // 6. Input Groups
            _Section(
              title: 'Input Groups',
              description: 'Prepend or append text, badges or buttons around form inputs.',
              child: Column(
                children: [
                  BsInputGroup(
                    children: [
                      const BsInputGroupText('@'),
                      BsInput(placeholder: 'Username').expanded(),
                    ],
                  ).pb3(),
                  BsInputGroup(
                    children: [
                      BsInput(placeholder: 'Recipient username').expanded(),
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
                      BsInputGroupText.widget(
                        child: BsCheckbox(
                          initialValue: true,
                          onChanged: (val) {},
                        ),
                      ),
                      BsInput(placeholder: 'Checkbox in input group...').expanded(),
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
                  ),
                ],
              ),
            ),

            // 7. Validation
            _Section(
              title: 'Form Validation',
              description: 'Provide valuable, actionable feedback to users with native form validator flows. Click "Submit form" to trigger the validation.',
              child: BsValidatedForm(
                wasValidated: _wasValidated,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      BsRow(
                        gutterY: BsSpacing.s3,
                        children: [
                          BsCol(
                            config: const BsColConfig(md: 6),
                            child: BsInput(
                              placeholder: 'First name',
                              initialValue: 'Mark',
                              validator: (val) => val == null || val.isEmpty ? 'Please choose a first name.' : null,
                            ),
                          ),
                          BsCol(
                            config: const BsColConfig(md: 6),
                            child: BsInput(
                              placeholder: 'Username',
                              validator: (val) => val == null || val.isEmpty ? 'Please choose a username.' : null,
                            ),
                          ),
                          BsCol(
                            config: const BsColConfig(md: 6),
                            child: BsInput(
                              placeholder: 'City',
                              validator: (val) => val == null || val.isEmpty ? 'Please provide a valid city.' : null,
                            ),
                          ),
                          BsCol(
                            config: const BsColConfig(md: 6),
                            child: BsCheckbox(
                              label: const Text('Agree to terms and conditions'),
                              validator: (val) => val == true ? null : 'You must agree before submitting.',
                            ),
                          ),
                          BsCol(
                            config: const BsColConfig.all(12),
                            child: BsButton(
                              label: 'Submit form',
                              onPressed: () {
                                setState(() {
                                  _wasValidated = true;
                                });
                                _formKey.currentState!.validate();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 8. Floating Labels
            _Section(
              title: 'Floating Labels',
              description: 'Create beautifully simple form labels that float over your input fields.',
              child: Column(
                children: [
                  BsInput(
                    floatingLabel: 'Email address',
                    placeholder: 'name@example.com',
                  ).pb3(),
                  BsInput(
                    floatingLabel: 'Password',
                    placeholder: 'Password',
                    obscureText: true,
                  ).pb3(),
                  BsSelect<String>(
                    floatingLabel: 'Works with selects',
                    placeholder: const Text('Open this select menu'),
                    items: const [
                      DropdownMenuItem(value: '1', child: Text('One')),
                      DropdownMenuItem(value: '2', child: Text('Two')),
                      DropdownMenuItem(value: '3', child: Text('Three')),
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

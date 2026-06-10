import 'package:flutter/material.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

class ListGroupShowcase extends StatefulWidget {
  const ListGroupShowcase({super.key});

  @override
  State<ListGroupShowcase> createState() => _ListGroupShowcaseState();
}

class _ListGroupShowcaseState extends State<ListGroupShowcase> {
  bool _check1 = false;
  bool _check2 = true;
  int _selectedRadio = 1;

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
                    'List Group',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ).pb2(),
                  Text(
                    'List groups are a flexible and powerful component for displaying a series of content. Modify and extend them to support custom content and interactive controls.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: 0.9),
                      height: 1.4,
                    ),
                  ),
                ],
              ).p4(),
            ).mb(32),

            BsRow(
              gutterX: BsSpacing.s4,
              gutterY: BsSpacing.s4,
              children: [
                BsCol(
                  config: const BsColConfig(md: 6, xs: 12),
                  child: Column(
                    children: [
                      // 1. Standard List Group
                      _Section(
                        title: 'Standard List Group',
                        description: 'A basic border-aligned stack of items.',
                        child: const BsListGroup(
                          children: [
                            BsListGroupItem(child: Text('An item')),
                            BsListGroupItem(child: Text('A second item')),
                            BsListGroupItem(child: Text('A third item')),
                            BsListGroupItem(child: Text('A fourth item')),
                          ],
                        ),
                      ),

                      // 2. Interactive Items
                      _Section(
                        title: 'Links & Buttons (Actionable)',
                        description: 'Actionable items with hover states and active/disabled feedback.',
                        child: BsListGroup(
                          children: [
                            BsListGroupItem(
                              onPressed: () => _showMessage(context, 'Clicked Item 1'),
                              child: const Text('Clickable item 1 (Button hover)'),
                            ),
                            BsListGroupItem(
                              onPressed: () => _showMessage(context, 'Clicked Item 2'),
                              child: const Text('Clickable item 2'),
                            ),
                            BsListGroupItem(
                              active: true,
                              onPressed: () => _showMessage(context, 'Clicked Active Item'),
                              child: const Text('Clickable active item'),
                            ),
                            BsListGroupItem(
                              disabled: true,
                              onPressed: () => _showMessage(context, 'Should not fire'),
                              child: const Text('Clickable disabled item'),
                            ),
                          ],
                        ),
                      ),

                      // 3. Numbered & Horizontal
                      _Section(
                        title: 'Numbered & Horizontal Layouts',
                        description: 'Choose between standard numbered listing or row-aligned layouts.',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Numbered:').fwBold().fs6().pb2(),
                            const BsListGroup(
                              numbered: true,
                              children: [
                                BsListGroupItem(child: Text('First numbered item')),
                                BsListGroupItem(child: Text('Second numbered item')),
                                BsListGroupItem(child: Text('Third numbered item')),
                              ],
                            ).pb4(),

                            const Text('Horizontal:').fwBold().fs6().pb2(),
                            const BsListGroup(
                              horizontal: true,
                              children: [
                                BsListGroupItem(child: Text('Left Column')),
                                BsListGroupItem(child: Text('Center Column')),
                                BsListGroupItem(child: Text('Right Column')),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                BsCol(
                  config: const BsColConfig(md: 6, xs: 12),
                  child: Column(
                    children: [
                      // 4. Badges & Checklist
                      _Section(
                        title: 'Badges & Interactive Checkbox List',
                        description: 'Embed checkboxes or badges inside list items to construct complex menus.',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const BsListGroup(
                              children: [
                                BsListGroupItem(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Inbox'),
                                      BsBadge(label: '14', variant: BsVariant.primary, isPill: true),
                                    ],
                                  ),
                                ),
                                BsListGroupItem(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Sent Messages'),
                                      BsBadge(label: '2', variant: BsVariant.secondary, isPill: true),
                                    ],
                                  ),
                                ),
                              ],
                            ).pb3(),

                            const Text('Interactive Checklist:').fwBold().fs6().pb2(),
                            BsListGroup(
                              children: [
                                BsListGroupItem(
                                  onPressed: () => setState(() => _check1 = !_check1),
                                  child: BsCheckbox(
                                    key: ValueKey('check1_$_check1'),
                                    initialValue: _check1,
                                    onChanged: (val) => setState(() => _check1 = val ?? false),
                                    label: Text(
                                      'Checkbox item 1',
                                      style: TextStyle(
                                        decoration: _check1 ? TextDecoration.lineThrough : null,
                                        color: _check1 ? theme.bodyTextSecondary : theme.bodyText,
                                      ),
                                    ),
                                  ),
                                ),
                                BsListGroupItem(
                                  onPressed: () => setState(() => _check2 = !_check2),
                                  child: BsCheckbox(
                                    key: ValueKey('check2_$_check2'),
                                    initialValue: _check2,
                                    onChanged: (val) => setState(() => _check2 = val ?? false),
                                    label: Text(
                                      'Checkbox item 2',
                                      style: TextStyle(
                                        decoration: _check2 ? TextDecoration.lineThrough : null,
                                        color: _check2 ? theme.bodyTextSecondary : theme.bodyText,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // 5. Radio buttons & Card Flush
                      _Section(
                        title: 'Radios & Card Flush integration',
                        description: 'Incorporate list groups inside cards using borderless flush modes.',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BsCard(
                              header: const BsCardHeader(child: Text('Card with Flush List Group')),
                              body: BsCardBody(
                                padding: EdgeInsets.zero,
                                child: const BsListGroup(
                                  flush: true,
                                  children: [
                                    BsListGroupItem(child: Text('Flush item 1')),
                                    BsListGroupItem(child: Text('Flush item 2')),
                                  ],
                                ),
                              ),
                            ).pb4(),

                            const Text('Radio Select list:').fwBold().fs6().pb2(),
                            BsListGroup(
                              children: [
                                BsListGroupItem(
                                  onPressed: () => setState(() => _selectedRadio = 1),
                                  child: BsRadio<int>(
                                    value: 1,
                                    groupValue: _selectedRadio,
                                    onChanged: (val) => setState(() => _selectedRadio = val ?? 1),
                                    label: const Text('Radio Option 1'),
                                  ),
                                ),
                                BsListGroupItem(
                                  onPressed: () => setState(() => _selectedRadio = 2),
                                  child: BsRadio<int>(
                                    value: 2,
                                    groupValue: _selectedRadio,
                                    onChanged: (val) => setState(() => _selectedRadio = val ?? 2),
                                    label: const Text('Radio Option 2'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // 6. Contextual Variants
                      _Section(
                        title: 'Contextual Color Variants',
                        description: 'Style list items using Bootstrap theme colors.',
                        child: BsListGroup(
                          children: [
                            const BsListGroupItem(child: Text('Default background list item')),
                            const BsListGroupItem(variant: BsVariant.primary, child: Text('Primary list item')),
                            const BsListGroupItem(variant: BsVariant.success, child: Text('Success list item')),
                            const BsListGroupItem(variant: BsVariant.danger, child: Text('Danger list item')),
                            const BsListGroupItem(variant: BsVariant.warning, child: Text('Warning list item')),
                            const BsListGroupItem(variant: BsVariant.info, child: Text('Info list item')),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showMessage(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: const Duration(seconds: 1),
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

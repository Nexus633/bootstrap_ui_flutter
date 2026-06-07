// ignore_for_file: deprecated_member_use
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';
import 'package:flutter/material.dart';

class ListGroupShowcase extends StatefulWidget {
  const ListGroupShowcase({super.key});

  @override
  State<ListGroupShowcase> createState() => _ListGroupShowcaseState();
}

class _ListGroupShowcaseState extends State<ListGroupShowcase> {
  // Stateful states for the custom content showcase
  bool _check1 = false;
  bool _check2 = true;
  bool _check3 = false;
  int _selectedRadio = 1;

  @override
  Widget build(BuildContext context) {
    final theme = context.bs;

    return Scaffold(
      backgroundColor: theme.bodyBg,
      appBar: AppBar(
        title: const Text('List Group Showcase'),
        backgroundColor: theme.bodyBg,
        foregroundColor: theme.bodyText,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: theme.border, height: 1.0),
        ),
      ),
      body: SingleChildScrollView(
        child: BsContainer(
          padding: const EdgeInsets.all(24),
          child: BsRow(
            gutterX: BsSpacing.s4,
            gutterY: BsSpacing.s4,
            children: [
              // ─── COLUMN 1 ──────────────────────────────────────────────────
              BsCol(
                config: const BsColConfig(md: 6, xs: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ─── Standard List Group ──────────────────────────────────
                    _sectionTitle(theme, 'Standard List Group'),
                    const SizedBox(height: 12),
                    const BsListGroup(
                      children: [
                        BsListGroupItem(child: Text('An item')),
                        BsListGroupItem(child: Text('A second item')),
                        BsListGroupItem(child: Text('A third item')),
                        BsListGroupItem(child: Text('A fourth item')),
                      ],
                    ),
                    const SizedBox(height: 40),

                    // ─── Links and Buttons (Interactive) ────────────────────────
                    _sectionTitle(theme, 'Links and Buttons (Interactive)'),
                    const SizedBox(height: 12),
                    BsListGroup(
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
                    const SizedBox(height: 40),

                    // ─── Numbered List Group ──────────────────────────────────
                    _sectionTitle(theme, 'Numbered List Group'),
                    const SizedBox(height: 12),
                    const BsListGroup(
                      numbered: true,
                      children: [
                        BsListGroupItem(child: Text('First numbered item')),
                        BsListGroupItem(child: Text('Second numbered item')),
                        BsListGroupItem(child: Text('Third numbered item')),
                      ],
                    ),
                    const SizedBox(height: 40),

                    // ─── Custom Content (Badges & Checklists) ──────────────────
                    _sectionTitle(theme, 'Custom Content (Badges & Checklists)'),
                    const SizedBox(height: 12),
                    
                    // List item with Badge
                    BsListGroup(
                      children: [
                        BsListGroupItem(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Inbox'),
                              BsBadge(
                                label: '14',
                                variant: BsBadgeVariant.primary,
                                isPill: true,
                              ),
                            ],
                          ),
                        ),
                        BsListGroupItem(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Sent Messages'),
                              BsBadge(
                                label: '2',
                                variant: BsBadgeVariant.secondary,
                                isPill: true,
                              ),
                            ],
                          ),
                        ),
                        BsListGroupItem(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Spam'),
                              BsBadge(
                                label: '99+',
                                variant: BsBadgeVariant.danger,
                                isPill: true,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    // Checklist (Interactive Checkboxes inside List Group Item)
                    const Text(
                      'Interactive Checklist (BsCheckbox)',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ).mb2(),
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
                        BsListGroupItem(
                          onPressed: () => setState(() => _check3 = !_check3),
                          child: BsCheckbox(
                            key: ValueKey('check3_$_check3'),
                            initialValue: _check3,
                            onChanged: (val) => setState(() => _check3 = val ?? false),
                            label: Text(
                              'Checkbox item 3',
                              style: TextStyle(
                                decoration: _check3 ? TextDecoration.lineThrough : null,
                                color: _check3 ? theme.bodyTextSecondary : theme.bodyText,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),

              // ─── COLUMN 2 ──────────────────────────────────────────────────
              BsCol(
                config: const BsColConfig(md: 6, xs: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ─── Active and Disabled ──────────────────────────────────
                    _sectionTitle(theme, 'Active & Disabled Items'),
                    const SizedBox(height: 12),
                    const BsListGroup(
                      children: [
                        BsListGroupItem(
                          active: true,
                          child: Text('An active item'),
                        ),
                        BsListGroupItem(child: Text('A standard item')),
                        BsListGroupItem(
                          disabled: true,
                          child: Text('A disabled item'),
                        ),
                        BsListGroupItem(child: Text('Another standard item')),
                      ],
                    ),
                    const SizedBox(height: 40),

                    // ─── Flush List Group ─────────────────────────────────────
                    _sectionTitle(theme, 'Flush List Group (Borderless & Edges)'),
                    const SizedBox(height: 12),
                    BsCard(
                      header: const BsCardHeader(child: Text('Card with Flush List Group')),
                      body: BsCardBody(
                        padding: EdgeInsets.zero,
                        child: const BsListGroup(
                          flush: true,
                          children: [
                            BsListGroupItem(child: Text('Flush item 1')),
                            BsListGroupItem(child: Text('Flush item 2')),
                            BsListGroupItem(child: Text('Flush item 3')),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // ─── Horizontal List Group ────────────────────────────────
                    _sectionTitle(theme, 'Horizontal List Group'),
                    const SizedBox(height: 12),
                    const BsListGroup(
                      horizontal: true,
                      children: [
                        BsListGroupItem(child: Text('Left Column')),
                        BsListGroupItem(child: Text('Center Column')),
                        BsListGroupItem(child: Text('Right Column')),
                      ],
                    ),
                    const SizedBox(height: 40),

                    // ─── Contextual Variants ──────────────────────────────────
                    _sectionTitle(theme, 'Contextual Variants'),
                    const SizedBox(height: 12),
                    BsListGroup(
                      children: [
                        const BsListGroupItem(child: Text('A simple default list group item')),
                        const BsListGroupItem(
                          variant: BsListGroupItemVariant.primary,
                          child: Text('A simple primary list group item'),
                        ),
                        const BsListGroupItem(
                          variant: BsListGroupItemVariant.secondary,
                          child: Text('A simple secondary list group item'),
                        ),
                        const BsListGroupItem(
                          variant: BsListGroupItemVariant.success,
                          child: Text('A simple success list group item'),
                        ),
                        const BsListGroupItem(
                          variant: BsListGroupItemVariant.danger,
                          child: Text('A simple danger list group item'),
                        ),
                        const BsListGroupItem(
                          variant: BsListGroupItemVariant.warning,
                          child: Text('A simple warning list group item'),
                        ),
                        const BsListGroupItem(
                          variant: BsListGroupItemVariant.info,
                          child: Text('A simple info list group item'),
                        ),
                        BsListGroupItem(
                          variant: BsListGroupItemVariant.light,
                          onPressed: () {},
                          child: const Text('A simple light list group item (Actionable)'),
                        ),
                        BsListGroupItem(
                          variant: BsListGroupItemVariant.dark,
                          onPressed: () {},
                          child: const Text('A simple dark list group item (Actionable)'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),

                    // Radio Button List Group
                    const Text(
                      'Radio Button List Group (BsRadio)',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ).mb2(),
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
                        BsListGroupItem(
                          onPressed: () => setState(() => _selectedRadio = 3),
                          child: BsRadio<int>(
                            value: 3,
                            groupValue: _selectedRadio,
                            onChanged: (val) => setState(() => _selectedRadio = val ?? 3),
                            label: const Text('Radio Option 3'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(BsThemeData theme, String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: theme.bodyText,
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

import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';
import 'package:flutter/material.dart';

class AccordionShowcase extends StatelessWidget {
  const AccordionShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Get the theme for the current mode (Light/Dark)
    final bsTheme = context.bs;

    return Scaffold(
      // 2. Adapt Scaffold and AppBar to the theme
      backgroundColor: bsTheme.bodyBg,
      appBar: AppBar(
        title: const Text('Accordion Showcase'),
        backgroundColor: bsTheme.bodyBg,
        foregroundColor: bsTheme.bodyText,
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
            Text(
              'Standard Accordion',
              // 3. Make text color dynamic (no longer "const")
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: bsTheme.bodyText,
              ),
            ),
            const SizedBox(height: 16),
            BsAccordion(
              flush: false,
              items: [
                BsAccordionItem(
                  title: 'Accordion Item #1',
                  initiallyExpanded: true,
                  body: Text(
                    'This is the first body. You can place any widgets here.',
                    style: TextStyle(color: bsTheme.bodyTextSecondary),
                  ),
                ),
                BsAccordionItem(
                  title: 'Accordion Item #2',
                  body: Text(
                    'This is the second body. It is closed by default.',
                    style: TextStyle(color: bsTheme.bodyTextSecondary),
                  ),
                ),
                BsAccordionItem(
                  title: 'Accordion Item #3',
                  body: Text(
                    'And this is the third one in the group.',
                    style: TextStyle(color: bsTheme.bodyTextSecondary),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 48),

            Text(
              'Accordion with Custom Cursor',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: bsTheme.bodyText,
              ),
            ),
            const SizedBox(height: 16),
            BsAccordion(
              mouseCursor: SystemMouseCursors.click,
              flush: false,
              items: [
                BsAccordionItem(
                  title: 'Accordion Item #1',
                  initiallyExpanded: true,
                  body: Text(
                    'This is the first body. You can place any widgets here.',
                    style: TextStyle(color: bsTheme.bodyTextSecondary),
                  ),
                ),
                BsAccordionItem(
                  title: 'Accordion Item #2',
                  body: Text(
                    'This is the second body. It is closed by default.',
                    style: TextStyle(color: bsTheme.bodyTextSecondary),
                  ),
                ),
                BsAccordionItem(
                  title: 'Accordion Item #3',
                  body: Text(
                    'And this is the third one in the group.',
                    style: TextStyle(color: bsTheme.bodyTextSecondary),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 48),

            Text(
              'Always Open Accordion',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: bsTheme.bodyText,
              ),
            ),
            const SizedBox(height: 16),
            BsAccordion(
              alwaysOpen: true,
              items: [
                BsAccordionItem(
                  title: 'Item A (Can be opened independently)',
                  body: Text(
                    'Body A',
                    style: TextStyle(color: bsTheme.bodyTextSecondary),
                  ),
                ),
                BsAccordionItem(
                  title: 'Item B (Can be opened independently)',
                  body: Text(
                    'Body B',
                    style: TextStyle(color: bsTheme.bodyTextSecondary),
                  ),
                ),
              ],
            ),
          ],
        ).p(24),
      ),
    );
  }
}

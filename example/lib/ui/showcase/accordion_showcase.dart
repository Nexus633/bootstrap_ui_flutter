import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';
import 'package:flutter/material.dart';

class AccordionShowcase extends StatelessWidget {
  const AccordionShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Das Theme für den aktuellen Modus (Hell/Dunkel) abgreifen
    final bsTheme = context.bs;

    return Scaffold(
      // 2. Scaffold und AppBar an das Theme anpassen
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
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Standard Accordion',
              // 3. Textfarbe dynamisch machen (kein "const" mehr)
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
                    'Das ist der erste Body. Man kann hier beliebige Widgets reinlegen.',
                    style: TextStyle(
                      color: bsTheme.bodyTextSecondary,
                    ), // Für Fließtext oft Secondary besser lesbar
                  ),
                ),
                BsAccordionItem(
                  title: 'Accordion Item #2',
                  body: Text(
                    'Das ist der zweite Body. Er ist standardmäßig zu.',
                    style: TextStyle(color: bsTheme.bodyTextSecondary),
                  ),
                ),
                BsAccordionItem(
                  title: 'Accordion Item #3',
                  body: Text(
                    'Und das ist der dritte im Bunde.',
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
                  title: 'Item A (Kann unabhängig geöffnet werden)',
                  body: Text(
                    'Body A',
                    style: TextStyle(color: bsTheme.bodyTextSecondary),
                  ),
                ),
                BsAccordionItem(
                  title: 'Item B (Kann unabhängig geöffnet werden)',
                  body: Text(
                    'Body B',
                    style: TextStyle(color: bsTheme.bodyTextSecondary),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../components/accordion/bs_accordion.dart';

class AccordionShowcase extends StatelessWidget {
  const AccordionShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Accordion Showcase')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Standard Accordion',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            BsAccordion(
              mouseCursor: SystemMouseCursors.click,
              flush: false, // Zeige den Klick-Cursor über dem Header
              items: [
                BsAccordionItem(
                  title: 'Accordion Item #1',
                  initiallyExpanded: true,
                  body: const Text(
                    'Das ist der erste Body. Man kann hier beliebige Widgets reinlegen.',
                  ),
                ),
                BsAccordionItem(
                  title: 'Accordion Item #2',
                  body: const Text(
                    'Das ist der zweite Body. Er ist standardmäßig zu.',
                  ),
                ),
                BsAccordionItem(
                  title: 'Accordion Item #3',
                  body: const Text('Und das ist der dritte im Bunde.'),
                ),
              ],
            ),

            const SizedBox(height: 48),

            const Text(
              'Always Open Accordion',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            BsAccordion(
              alwaysOpen: true,
              items: [
                BsAccordionItem(
                  title: 'Item A (Kann unabhängig geöffnet werden)',
                  body: const Text('Body A'),
                ),
                BsAccordionItem(
                  title: 'Item B (Kann unabhängig geöffnet werden)',
                  body: const Text('Body B'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

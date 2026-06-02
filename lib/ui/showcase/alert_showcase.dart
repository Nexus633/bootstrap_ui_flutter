import 'package:flutter/material.dart';
import '../components/alert/bs_alert.dart';

class AlertShowcase extends StatefulWidget {
  const AlertShowcase({super.key});

  @override
  State<AlertShowcase> createState() => _AlertShowcaseState();
}

class _AlertShowcaseState extends State<AlertShowcase> {
  // Liste zur Verwaltung der sichtbaren Alerts
  List<String> activeAlerts = [
    'Erster Hinweis',
    'Zweiter Hinweis',
    'Dritter Hinweis',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alert Showcase')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Animierte dynamische Liste',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            if (activeAlerts.isEmpty)
              const Text(
                'Alle Alerts geschlossen!',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),

            for (final alertName in activeAlerts)
              BsAlert(
                key: ValueKey(
                  alertName,
                ), // WICHTIG: Key für Animation beim Löschen
                variant: BsAlertVariant.info,
                icon: Icons.info_outline,
                dismissible: true,
                onClose: () {
                  setState(() {
                    activeAlerts.remove(alertName);
                  });
                },
                child: Text(alertName),
              ),

            const SizedBox(height: 32),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  activeAlerts = [
                    'Erster Hinweis',
                    'Zweiter Hinweis',
                    'Dritter Hinweis',
                  ];
                });
              },
              child: const Text('Alle Alerts wiederherstellen'),
            ),

            const SizedBox(height: 48),
            const Divider(),
            const SizedBox(height: 24),

            const Text(
              'Statische Alerts',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            const BsAlert(
              variant: BsAlertVariant.success,
              icon: Icons.check_circle_outline,
              child: Text(
                'Erfolgreich gespeichert! Der Datensatz wurde angelegt.',
              ),
            ),

            const BsAlert(
              variant: BsAlertVariant.danger,
              icon: Icons.error_outline,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ein Fehler ist aufgetreten',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Die Verbindung zum Server konnte nicht hergestellt werden.',
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

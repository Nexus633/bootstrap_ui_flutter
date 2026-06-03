import 'package:flutter/material.dart';
import '../components/alert/bs_alert.dart';
import '../tokens/bs_theme.dart'; // <--- WICHTIG: Theme Import

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
    // Theme abgreifen
    final bsTheme = context.bs;

    return Scaffold(
      backgroundColor: bsTheme.bodyBg, // Scaffold Hintergrund anpassen
      appBar: AppBar(
        title: const Text('Alert Showcase'),
        backgroundColor: bsTheme.bodyBg,
        foregroundColor: bsTheme.bodyText, // Text & Back-Button anpassen
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
              'Animierte dynamische Liste',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: bsTheme.bodyText,
              ),
            ),
            const SizedBox(height: 16),

            if (activeAlerts.isEmpty)
              Text(
                'Alle Alerts geschlossen!',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: bsTheme.bodyTextSecondary,
                ),
              ),

            for (final alertName in activeAlerts)
              BsAlert(
                key: ValueKey(alertName),
                variant: BsAlertVariant.info,
                icon: Icons.info_outline,
                dismissible: true,
                onClose: () {
                  setState(() {
                    activeAlerts.remove(alertName);
                  });
                },
                child: Text(
                  alertName,
                ), // Textfarbe wird vom Alert automatisch gemanagt!
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
            Divider(color: bsTheme.border),
            const SizedBox(height: 24),

            Text(
              'Statische Alerts',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: bsTheme.bodyText,
              ),
            ),
            const SizedBox(height: 16),

            const BsAlert(
              variant: BsAlertVariant.success,
              icon: Icons.check_circle_outline,
              child: Text(
                'Erfolgreich gespeichert! Der Datensatz wurde angelegt.',
              ),
            ),

            const SizedBox(height: 16),

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

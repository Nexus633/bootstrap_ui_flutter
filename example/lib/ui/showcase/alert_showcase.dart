import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';
import 'package:flutter/material.dart';

class AlertShowcase extends StatefulWidget {
  const AlertShowcase({super.key});

  @override
  State<AlertShowcase> createState() => _AlertShowcaseState();
}

class _AlertShowcaseState extends State<AlertShowcase> {
  // List to manage visible alerts
  List<String> activeAlerts = [
    'First hint',
    'Second hint',
    'Third hint',
  ];

  @override
  Widget build(BuildContext context) {
    // Get theme
    final bsTheme = context.bs;

    return Scaffold(
      backgroundColor: bsTheme.bodyBg, // Adjust Scaffold background
      appBar: AppBar(
        title: const Text('Alert Showcase'),
        backgroundColor: bsTheme.bodyBg,
        foregroundColor: bsTheme.bodyText, // Adjust text & back button
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
              'Animated dynamic list',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: bsTheme.bodyText,
              ),
            ),
            const SizedBox(height: 16),

            if (activeAlerts.isEmpty)
              Text(
                'All alerts closed!',
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
                child: Text(alertName),
              ),

            const SizedBox(height: 32),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  activeAlerts = ['First hint', 'Second hint', 'Third hint'];
                });
              },
              child: const Text('Restore all alerts'),
            ),

            Divider(color: bsTheme.border).py3(),

            Text(
              'Animations',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: bsTheme.bodyText,
              ),
            ),
            const SizedBox(height: 16),

            const BsAlert(
              variant: BsAlertVariant.primary,
              animation: BsAlertAnimation.slideLeft,
              dismissible: true,
              child: Text('Sliding in from left (slideLeft)'),
            ),

            const BsAlert(
              variant: BsAlertVariant.secondary,
              animation: BsAlertAnimation.slideRight,
              dismissible: true,
              child: Text('Sliding in from right (slideRight)'),
            ),

            const BsAlert(
              variant: BsAlertVariant.warning,
              animation: BsAlertAnimation.slideTop,
              dismissible: true,
              child: Text('Sliding in from top (slideTop)'),
            ),

            const BsAlert(
              variant: BsAlertVariant.danger,
              animation: BsAlertAnimation.slideBottom,
              dismissible: true,
              child: Text('Sliding in from bottom (slideBottom)'),
            ),

            const BsAlert(
              variant: BsAlertVariant.info,
              animation: BsAlertAnimation.none,
              dismissible: true,
              child: Text('No animation (none)'),
            ),

            const BsAlert(
              variant: BsAlertVariant.warning,
              icon: Icons.timer_outlined,
              dismissible: true,
              autoCloseDuration: Duration(seconds: 5),
              child: Text('This alert closes automatically after 5 seconds.'),
            ),

            const SizedBox(height: 48),
            Divider(color: bsTheme.border).py3(),

            Text(
              'Static alerts',
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
              child: Text('Successfully saved! The record has been created.'),
            ),

            const SizedBox(height: 16),

            const BsAlert(
              variant: BsAlertVariant.danger,
              icon: Icons.error_outline,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'An error occurred',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'The connection to the server could not be established.',
                  ),
                ],
              ),
            ),
          ],
        ).p(24),
      ),
    );
  }
}

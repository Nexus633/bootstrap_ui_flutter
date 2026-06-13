import 'package:flutter/material.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

class AlertShowcase extends StatefulWidget {
  const AlertShowcase({super.key});

  @override
  State<AlertShowcase> createState() => _AlertShowcaseState();
}

class _AlertShowcaseState extends State<AlertShowcase> {
  List<String> activeAlerts = [
    'First dynamic warning message',
    'Second dynamic warning message',
    'Third dynamic warning message',
  ];

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
                    'Alerts',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ).pb2(),
                  Text(
                    'Provide contextual feedback messages for typical user actions with handful of available and flexible alert messages.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: 0.9),
                      height: 1.4,
                    ),
                  ),
                ],
              ).p4(),
            ).mb(32),

            // 1. Dynamic Dismissible Alerts
            _Section(
              title: 'Dynamic & Dismissible Alerts',
              description:
                  'Dismiss alerts using fade animations and restore them dynamically.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (activeAlerts.isEmpty)
                    Text(
                      'All alerts closed!',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: theme.bodyTextSecondary,
                      ),
                    ).pb3()
                  else
                    Column(
                      children: [
                        for (final alertName in activeAlerts)
                          BsAlert(
                            key: ValueKey(alertName),
                            variant: .info,
                            icon: BsIcons.infoCircleFill,
                            dismissible: true,
                            onClose: () {
                              setState(() {
                                activeAlerts.remove(alertName);
                              });
                            },
                            child: Text(alertName),
                          ).mb3(),
                      ],
                    ),
                  BsButton(
                    label: 'Restore all alerts',
                    variant: .primary,
                    onPressed: () {
                      setState(() {
                        activeAlerts = [
                          'First dynamic warning message',
                          'Second dynamic warning message',
                          'Third dynamic warning message',
                        ];
                      });
                    },
                  ),
                ],
              ),
            ),

            // 2. Animations
            _Section(
              title: 'Entrance Animations',
              description:
                  'Choose between different direction-based slide animations or no animation.',
              child: Column(
                children: const [
                  BsAlert(
                    variant: .primary,
                    animation: .slideLeft,
                    dismissible: true,
                    child: Text('Sliding in from left (slideLeft)'),
                  ),
                  SizedBox(height: 12),
                  BsAlert(
                    variant: .secondary,
                    animation: .slideRight,
                    dismissible: true,
                    child: Text('Sliding in from right (slideRight)'),
                  ),
                  SizedBox(height: 12),
                  BsAlert(
                    variant: .warning,
                    animation: .slideTop,
                    dismissible: true,
                    child: Text('Sliding in from top (slideTop)'),
                  ),
                  SizedBox(height: 12),
                  BsAlert(
                    variant: .danger,
                    animation: .slideBottom,
                    dismissible: true,
                    child: Text('Sliding in from bottom (slideBottom)'),
                  ),
                  SizedBox(height: 12),
                  BsAlert(
                    variant: .info,
                    animation: .none,
                    dismissible: true,
                    child: Text('No animation (none)'),
                  ),
                ],
              ),
            ),

            // 3. Auto Close Alert
            _Section(
              title: 'Auto-Closing Alert',
              description:
                  'Set a duration to automatically close the alert after a specific time.',
              child: const BsAlert(
                variant: .warning,
                icon: BsIcons.exclamationTriangleFill,
                dismissible: true,
                autoCloseDuration: Duration(seconds: 5),
                child: Text('This alert closes automatically after 5 seconds.'),
              ),
            ),

            // 4. Static alerts with complex contents
            _Section(
              title: 'Static & Complex Alerts',
              description:
                  'Render full widget structures like columns, titles and rich descriptions inside alerts.',
              child: Column(
                children: [
                  const BsAlert(
                    variant: .success,
                    icon: BsIcons.checkCircleFill,
                    child: Text(
                      'Successfully saved! The database record has been created.',
                    ),
                  ),
                  const SizedBox(height: 16),
                  BsAlert(
                    variant: .danger,
                    icon: BsIcons.xCircleFill,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('An error occurred').fwBold().fs5().pb1(),
                        Text(
                          'The connection to the secure server could not be established. Please check your network credentials.',
                          style: TextStyle(
                            color: theme.dangerTextEmphasis.withValues(
                              alpha: 0.9,
                            ),
                          ),
                        ),
                      ],
                    ),
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
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
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

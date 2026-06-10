import 'package:flutter/material.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

class ToastShowcase extends StatelessWidget {
  const ToastShowcase({super.key});

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
                    'Toasts',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ).pb2(),
                  Text(
                    'Push notifications to your visitors with a toast, a lightweight and easily customizable alert message.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: 0.9),
                      height: 1.4,
                    ),
                  ),
                ],
              ).p4(),
            ).mb(32),

            _Section(
              title: 'Basic Example',
              child: BsToast(
                header: BsToastHeader(
                  icon: const BsIcon(BsIcons.bootstrap, color: Colors.blue),
                  title: const Text('Bootstrap'),
                  subtitle: const Text('11 mins ago'),
                ),
                child: const Text('Hello, world! This is a toast message.'),
              ),
            ),
            _Section(
              title: 'Color Schemes',
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                children: BsVariant.values.map((variant) {
                  return BsToast(
                    variant: variant,
                    header: BsToastHeader(
                      title: Text(variant.name.toUpperCase()),
                    ),
                    child: const Text('This is a custom color toast message.'),
                  );
                }).toList(),
              ),
            ),
            _Section(
              title: 'Interactive (BsToastManager)',
              description:
                  'Use BsToastManager to show floating notifications dynamically.',
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  BsButton(
                    label: 'Top Left',
                    variant: BsButtonVariant.danger,
                    onPressed: () {
                      BsToastManager.show(
                        context,
                        alignment: Alignment.topLeft,
                        duration: const Duration(seconds: 4),
                        toast: const BsToast(
                          header: BsToastHeader(
                            title: Text('Top Left'),
                          ),
                          child: Text(
                            'This toast appears at the top left.',
                          ),
                        ),
                      );
                    },
                  ),
                  BsButton(
                    label: 'Top Center',
                    variant: BsButtonVariant.primary,
                    onPressed: () {
                      BsToastManager.show(
                        context,
                        alignment: Alignment.topCenter,
                        duration: const Duration(seconds: 4),
                        toast: const BsToast(
                          header: BsToastHeader(
                            title: Text('Top Center'),
                          ),
                          child: Text(
                            'This toast appears at the top center.',
                          ),
                        ),
                      );
                    },
                  ),
                  BsButton(
                    label: 'Top Right',
                    variant: BsButtonVariant.success,
                    onPressed: () {
                      BsToastManager.show(
                        context,
                        alignment: Alignment.topRight,
                        duration: const Duration(seconds: 4),
                        toast: const BsToast(
                          header: BsToastHeader(
                            title: Text('Top Right'),
                          ),
                          child: Text(
                            'This toast appears at the top right.',
                          ),
                        ),
                      );
                    },
                  ),
                  BsButton(
                    label: 'Bottom Left',
                    variant: BsButtonVariant.warning,
                    onPressed: () {
                      BsToastManager.show(
                        context,
                        alignment: Alignment.bottomLeft,
                        duration: const Duration(seconds: 4),
                        toast: const BsToast(
                          header: BsToastHeader(
                            title: Text('Bottom Left'),
                          ),
                          child: Text(
                            'This toast appears at the bottom left.',
                          ),
                        ),
                      );
                    },
                  ),
                  BsButton(
                    label: 'Bottom Center',
                    variant: BsButtonVariant.info,
                    onPressed: () {
                      BsToastManager.show(
                        context,
                        alignment: Alignment.bottomCenter,
                        duration: const Duration(seconds: 4),
                        toast: const BsToast(
                          header: BsToastHeader(
                            title: Text('Bottom Center'),
                          ),
                          child: Text(
                            'This toast appears at the bottom center.',
                          ),
                        ),
                      );
                    },
                  ),
                  BsButton(
                    label: 'Bottom Right',
                    variant: BsButtonVariant.secondary,
                    onPressed: () {
                      BsToastManager.show(
                        context,
                        alignment: Alignment.bottomRight,
                        duration: const Duration(seconds: 4),
                        toast: const BsToast(
                          header: BsToastHeader(
                            title: Text('Bottom Right'),
                          ),
                          child: Text(
                            'This toast appears at the bottom right.',
                          ),
                        ),
                      );
                    },
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
  const _Section({required this.title, required this.child, this.description});

  final String title;
  final Widget child;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ).pb(8),
        if (description != null) Text(description!).pb(16),
        Container(
          width: double.infinity,
          alignment: Alignment.topLeft,
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

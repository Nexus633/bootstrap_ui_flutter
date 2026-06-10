import 'package:flutter/material.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

class PlaceholderShowcase extends StatefulWidget {
  const PlaceholderShowcase({super.key});

  @override
  State<PlaceholderShowcase> createState() => _PlaceholderShowcaseState();
}

class _PlaceholderShowcaseState extends State<PlaceholderShowcase> {
  bool _isLoading = true;

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
                    'Placeholders',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ).pb2(),
                  Text(
                    'Use placeholders to temporarily display skeleton states before content loads, improving the perceived performance of your application.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: 0.9),
                      height: 1.4,
                    ),
                  ),
                ],
              ).p4(),
            ).mb(32),

            // 1. Basic Skeleton Loader Card vs Real Card
            _Section(
              title: 'Basic Example',
              description: 'Compare a loading card (skeleton screen) using placeholders with the real content card once loaded.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BsButton(
                    label: _isLoading ? 'Switch to Loaded State' : 'Switch to Loading State',
                    variant: BsButtonVariant.primary,
                    onPressed: () {
                      setState(() {
                        _isLoading = !_isLoading;
                      });
                    },
                  ).mb4(),
                  BsRow(
                    gutterX: 16,
                    children: [
                      BsCol(
                        config: const BsColConfig(xs: 12, md: 6),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: _isLoading ? const _CardLoadingSkeleton() : const _CardRealContent(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 2. Animations (Glow and Wave Shimmer)
            _Section(
              title: 'Animations',
              description: 'Bootstrap placeholders support glow (pulse opacity) and wave (sliding linear gradient shimmer) animations.',
              child: BsRow(
                gutterX: 16,
                gutterY: 16,
                children: [
                  BsCol(
                    config: const BsColConfig(xs: 12, md: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Wave (Shimmer)').fwBold().fs5().pb3(),
                        const BsPlaceholderContainer(
                          animation: BsPlaceholderAnimation.wave,
                          child: _SkeletonList(),
                        ),
                      ],
                    ),
                  ),
                  BsCol(
                    config: const BsColConfig(xs: 12, md: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Glow (Pulse)').fwBold().fs5().pb3(),
                        const BsPlaceholderContainer(
                          animation: BsPlaceholderAnimation.glow,
                          child: _SkeletonList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 3. Width Utility & Column Spans
            _Section(
              title: 'Sizing & Widths',
              description: 'Customize placeholder widths using fixed values, fractional percentages, or 12-column grid spans. Adjust thickness using sizes.',
              child: BsRow(
                gutterX: 16,
                children: [
                  BsCol(
                    config: const BsColConfig(xs: 12, md: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Width Sizing (colSpan & widthFactor)').fwBold().fs5().pb3(),
                        const BsPlaceholder(widthFactor: 1.0).pb2(),
                        const BsPlaceholder(widthFactor: 0.75).pb2(),
                        const BsPlaceholder(colSpan: 6).pb2(),
                        const BsPlaceholder(colSpan: 4).pb4(),

                        const Text('Standard Height Sizes').fwBold().fs5().pb3(),
                        const Text('Large (-lg):').fs6().pb1(),
                        const BsPlaceholder(size: BsSize.lg).pb2(),
                        const Text('Medium (default):').fs6().pb1(),
                        const BsPlaceholder(size: BsSize.md).pb2(),
                        const Text('Small (-sm):').fs6().pb1(),
                        const BsPlaceholder(size: BsSize.sm),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 4. Color Variants
            _Section(
              title: 'Colors',
              description: 'Apply theme colors to placeholders using Bootstrap semantic variants.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BsPlaceholder(variant: BsVariant.primary, widthFactor: 1.0).pb2(),
                  const BsPlaceholder(variant: BsVariant.secondary, widthFactor: 0.9).pb2(),
                  const BsPlaceholder(variant: BsVariant.success, widthFactor: 0.8).pb2(),
                  const BsPlaceholder(variant: BsVariant.danger, widthFactor: 0.7).pb2(),
                  const BsPlaceholder(variant: BsVariant.warning, widthFactor: 0.6).pb2(),
                  const BsPlaceholder(variant: BsVariant.info, widthFactor: 0.5).pb2(),
                  const BsPlaceholder(variant: BsVariant.light, widthFactor: 0.4).pb2(),
                  const BsPlaceholder(variant: BsVariant.dark, widthFactor: 0.3),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Auxiliary Widgets ───────────────────────────────────────────────────────

class _SkeletonList extends StatelessWidget {
  const _SkeletonList();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BsPlaceholder(widthFactor: 0.9).pb2(),
        BsPlaceholder(widthFactor: 0.75).pb2(),
        BsPlaceholder(widthFactor: 0.6).pb2(),
        const BsPlaceholder(widthFactor: 0.8),
      ],
    );
  }
}

class _CardLoadingSkeleton extends StatelessWidget {
  const _CardLoadingSkeleton();

  @override
  Widget build(BuildContext context) {
    final theme = context.bs;
    return BsPlaceholderContainer(
      animation: BsPlaceholderAnimation.wave,
      child: BsCard(
        header: const BsPlaceholder(height: 20.0, widthFactor: 0.4),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Skeleton for image
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.bodyText.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Center(
                child: Icon(Icons.image, size: 48, color: Colors.grey),
              ),
            ).mb3(),
            // Skeleton for Title
            const BsPlaceholder(height: 24.0, size: BsSize.lg, widthFactor: 0.6).mb2(),
            // Skeleton for body text
            const BsPlaceholder(widthFactor: 0.9).mb2(),
            const BsPlaceholder(widthFactor: 0.75).mb3(),
            // Skeleton for button
            const BsPlaceholder(height: 38.0, width: 100.0, borderRadius: BorderRadius.all(Radius.circular(6))),
          ],
        ),
      ),
    );
  }
}

class _CardRealContent extends StatelessWidget {
  const _CardRealContent();

  @override
  Widget build(BuildContext context) {
    return BsCard(
      header: const Text('Loaded Component'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Center(
              child: Icon(Icons.check_circle_outline, size: 64, color: Colors.white),
            ),
          ).mb3(),
          const Text('Card Title').fs4().fwBold().pb2(),
          const Text('Some quick example text to build on the card title and make up the bulk of the card\'s content.').fs6().pb3(),
          BsButton(
            label: 'Go somewhere',
            variant: BsButtonVariant.primary,
            onPressed: () {},
          ),
        ],
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

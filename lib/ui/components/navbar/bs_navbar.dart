import 'package:flutter/material.dart';
import '../../tokens/bootstrap_theme.dart';
import '../../tokens/breakpoints.dart';
import '../../tokens/enums.dart';
import '../collapse/bs_collapse.dart';


/// Helper function to resolve the Color of a variant using the active theme.
Color? _resolveVariantColor(BuildContext context, BsNavbarLinkVariant? variant) {
  if (variant == null) return null;
  final theme = context.bs;
  switch (variant) {
    case BsNavbarLinkVariant.primary:
      return theme.primary;
    case BsNavbarLinkVariant.secondary:
      return theme.secondary;
    case BsNavbarLinkVariant.success:
      return theme.success;
    case BsNavbarLinkVariant.danger:
      return theme.danger;
    case BsNavbarLinkVariant.warning:
      return theme.warning;
    case BsNavbarLinkVariant.info:
      return theme.info;
    case BsNavbarLinkVariant.light:
      return theme.light;
    case BsNavbarLinkVariant.dark:
      return theme.dark;
  }
}

/// Inherited scope to pass navbar state down to children components.
class _BsNavbarScope extends InheritedWidget {
  const _BsNavbarScope({
    required this.isExpanded,
    required this.isDark,
    required this.isCollapsedOpen,
    required this.toggleCollapse,
    required super.child,
  });

  final bool isExpanded;
  final bool isDark;
  final bool isCollapsedOpen;
  final VoidCallback toggleCollapse;

  static _BsNavbarScope? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_BsNavbarScope>();
  }

  @override
  bool updateShouldNotify(_BsNavbarScope oldWidget) {
    return isExpanded != oldWidget.isExpanded ||
        isDark != oldWidget.isDark ||
        isCollapsedOpen != oldWidget.isCollapsedOpen;
  }
}

/// A Bootstrap-style navbar component (`BsNavbar`).
///
/// Navbars are responsive meta-components that serve as navigation headers.
/// They support branding, navigation links, togglers, forms, and custom text.
///
/// See: <https://getbootstrap.com/docs/5.3/components/navbar/>
class BsNavbar extends StatefulWidget {
  /// Creates a [BsNavbar] container.
  const BsNavbar({
    super.key,
    this.brand,
    this.collapse,
    this.expand = BsNavbarExpand.lg,
    this.dark = false,
    this.background,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  });

  /// The branding widget (typically a [BsNavbarBrand]).
  final Widget? brand;

  /// The collapsible content of the navbar (typically a [BsNavbarCollapse]).
  final BsNavbarCollapse? collapse;

  /// The breakpoint configuration for when the navbar should expand horizontally.
  /// Defaults to [BsNavbarExpand.lg].
  final BsNavbarExpand expand;

  /// Whether the navbar uses a dark color scheme.
  final bool dark;

  /// Custom background color. If null, it defaults to light or dark background depending on theme.
  final Color? background;

  /// The padding inside the navbar container.
  final EdgeInsetsGeometry padding;

  @override
  State<BsNavbar> createState() => _BsNavbarState();
}

class _BsNavbarState extends State<BsNavbar> {
  bool _isCollapsedOpen = false;

  void _toggleCollapse() {
    setState(() {
      _isCollapsedOpen = !_isCollapsedOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.bs;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;

        // Resolve active expansion state based on layout width
        bool isExpanded = false;
        switch (widget.expand) {
          case BsNavbarExpand.always:
            isExpanded = true;
            break;
          case BsNavbarExpand.sm:
            isExpanded = width >= BsBreakpoints.sm;
            break;
          case BsNavbarExpand.md:
            isExpanded = width >= BsBreakpoints.md;
            break;
          case BsNavbarExpand.lg:
            isExpanded = width >= BsBreakpoints.lg;
            break;
          case BsNavbarExpand.xl:
            isExpanded = width >= BsBreakpoints.xl;
            break;
          case BsNavbarExpand.xxl:
            isExpanded = width >= BsBreakpoints.xxl;
            break;
          case BsNavbarExpand.never:
            isExpanded = false;
            break;
        }

        final Color bgColor = widget.background ?? (widget.dark ? theme.dark : theme.light);

        final decoration = BoxDecoration(
          color: bgColor,
          border: Border(
            bottom: BorderSide(
              color: theme.border,
              width: 1.0,
            ),
          ),
        );

        Widget content;
        if (isExpanded) {
          // Desktop horizontal layout
          content = Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.brand != null) widget.brand!,
              if (widget.collapse != null) Expanded(child: widget.collapse!),
            ],
          );
        } else {
          // Mobile vertical layout
          content = Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (widget.brand != null) widget.brand! else const SizedBox.shrink(),
                  if (widget.collapse != null)
                    BsNavbarToggler(
                      onPressed: _toggleCollapse,
                      isOpen: _isCollapsedOpen,
                      isDark: widget.dark,
                    ),
                ],
              ),
              if (widget.collapse != null) widget.collapse!,
            ],
          );
        }

        return _BsNavbarScope(
          isExpanded: isExpanded,
          isDark: widget.dark,
          isCollapsedOpen: _isCollapsedOpen,
          toggleCollapse: _toggleCollapse,
          child: Container(
            decoration: decoration,
            padding: widget.padding,
            child: SafeArea(
              top: false,
              bottom: false,
              child: content,
            ),
          ),
        );
      },
    );
  }
}

/// A branding wrapper component for the brand/logo in the navbar (`BsNavbarBrand`).
class BsNavbarBrand extends StatelessWidget {
  /// Creates a [BsNavbarBrand] widget.
  const BsNavbarBrand({
    super.key,
    required this.child,
    this.onPressed,
    this.variant,
    this.color,
  });

  /// The branding content (logo, image, or text).
  final Widget child;

  /// Callback when the brand is tapped.
  final VoidCallback? onPressed;

  /// The color variant for the brand text.
  final BsNavbarLinkVariant? variant;

  /// Custom color for the brand text.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final scope = _BsNavbarScope.of(context);
    final isDark = scope?.isDark ?? false;

    final theme = context.bs;

    Color brandColor;
    if (color != null) {
      brandColor = color!;
    } else if (variant != null) {
      brandColor = _resolveVariantColor(context, variant!)!;
    } else {
      brandColor = isDark ? Colors.white : theme.bodyText;
    }

    Widget content = DefaultTextStyle.merge(
      style: TextStyle(
        fontSize: 20.0, // 1.25rem
        fontWeight: FontWeight.bold,
        color: brandColor,
        decoration: TextDecoration.none,
      ),
      child: child,
    );

    if (onPressed != null) {
      content = MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onPressed,
          child: content,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0), // .3125rem
      child: content,
    );
  }
}

/// A Bootstrap-style navbar icon brand component (`BsNavbarIconBrand`).
///
/// Typically displays a small logo or icon in the navbar.
/// Can be positioned next to a [BsNavbarBrand] inside a layout row.
class BsNavbarIconBrand extends StatelessWidget {
  /// Creates a [BsNavbarIconBrand] widget.
  const BsNavbarIconBrand({
    super.key,
    required this.child,
    this.onPressed,
    this.color,
    this.size = 24.0,
    this.padding = const EdgeInsets.only(right: 8.0),
  });

  /// Creates an icon branding image from a network URL.
  BsNavbarIconBrand.network(
    String src, {
    super.key,
    this.onPressed,
    this.color,
    this.size = 24.0,
    this.padding = const EdgeInsets.only(right: 8.0),
    double? width,
    double? height,
    BoxFit? fit,
    String? semanticLabel,
    ImageErrorWidgetBuilder? errorBuilder,
  })  : child = Image.network(
          src,
          width: width ?? size,
          height: height ?? size,
          fit: fit,
          semanticLabel: semanticLabel,
          errorBuilder: errorBuilder ??
              (context, error, stackTrace) => const Icon(
                    Icons.broken_image,
                  ),
        );

  /// The icon or image widget.
  final Widget child;

  /// Callback when the icon is tapped.
  final VoidCallback? onPressed;

  /// Custom color override for the icon (only applies if child is or contains an Icon).
  final Color? color;

  /// Size of the icon. Defaults to 24.0.
  final double size;

  /// Padding around the icon brand. Defaults to `only(right: 8.0)` to separate it from the text brand.
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final scope = _BsNavbarScope.of(context);
    final isDark = scope?.isDark ?? false;
    final theme = context.bs;

    final Color iconColor = color ?? (isDark ? Colors.white : theme.bodyText);

    Widget content = IconTheme.merge(
      data: IconThemeData(
        color: iconColor,
        size: size,
      ),
      child: child,
    );

    if (onPressed != null) {
      content = MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onPressed,
          child: content,
        ),
      );
    }

    return Padding(
      padding: padding,
      child: content,
    );
  }
}

/// A responsive toggler button for collapsing/expanding navbar content (`BsNavbarToggler`).
class BsNavbarToggler extends StatelessWidget {
  /// Creates a [BsNavbarToggler] widget.
  const BsNavbarToggler({
    super.key,
    this.onPressed,
    this.isOpen,
    this.isDark,
  });

  /// Optional custom callback when toggler is tapped.
  final VoidCallback? onPressed;

  /// Visual state override indicating if the toggler is expanded.
  final bool? isOpen;

  /// Color scheme override indicating if the toggler should styling for dark navbar.
  final bool? isDark;

  @override
  Widget build(BuildContext context) {
    final scope = _BsNavbarScope.of(context);
    final isDarkNavbar = isDark ?? scope?.isDark ?? false;
    final activeOnPressed = onPressed ?? scope?.toggleCollapse;

    final theme = context.bs;
    final Color togglerBorderColor = isDarkNavbar
        ? Colors.white.withValues(alpha: 0.1)
        : theme.bodyText.withValues(alpha: 0.1);
    final Color togglerIconColor = isDarkNavbar
        ? Colors.white.withValues(alpha: 0.55)
        : theme.bodyText.withValues(alpha: 0.55);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: activeOnPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: togglerBorderColor, width: 1.0),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 20, height: 2, color: togglerIconColor),
              const SizedBox(height: 4),
              Container(width: 20, height: 2, color: togglerIconColor),
              const SizedBox(height: 4),
              Container(width: 20, height: 2, color: togglerIconColor),
            ],
          ),
        ),
      ),
    );
  }
}

/// The collapsible wrapper inside the navbar (`BsNavbarCollapse`).
///
/// Integrates seamlessly with [BsCollapse] to animate opening/closing on small screens.
class BsNavbarCollapse extends StatelessWidget {
  /// Creates a [BsNavbarCollapse] widget.
  const BsNavbarCollapse({
    super.key,
    required this.children,
  });

  /// The list of items within the collapsed panel (typically [BsNavbarNav]).
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final scope = _BsNavbarScope.of(context);
    if (scope == null) return const SizedBox.shrink();

    final isExpanded = scope.isExpanded;
    final isCollapsedOpen = scope.isCollapsedOpen;

    if (isExpanded) {
      // Find the first spacer index if any
      int spacerIndex = -1;
      for (int i = 0; i < children.length; i++) {
        if (children[i] is BsNavbarSpacer) {
          spacerIndex = i;
          break;
        }
      }

      final Widget rowContent;
      if (spacerIndex != -1) {
        final leftElements = children.sublist(0, spacerIndex);
        final rightElements = children.sublist(spacerIndex + 1);

        rowContent = Row(
          children: [
            ...leftElements,
            Flexible(
              child: Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: rightElements,
                ),
              ),
            ),
          ],
        );
      } else {
        rowContent = Row(
          children: children,
        );
      }

      return Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: rowContent,
      );
    } else {
      return BsCollapse(
        isExpanded: isCollapsedOpen,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: children,
          ),
        ),
      );
    }
  }
}

/// Wrapper for nav items in the navbar (`BsNavbarNav`).
///
/// Changes layout dynamically between Row (desktop) and Column (mobile).
class BsNavbarNav extends StatelessWidget {
  /// Creates a [BsNavbarNav] widget.
  const BsNavbarNav({
    super.key,
    required this.children,
    this.alignment = MainAxisAlignment.start,
  });

  /// The collection of navbar links (typically [BsNavbarLink]).
  final List<Widget> children;

  /// Alignment of children inside expanded (Row) layout.
  final MainAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    final scope = _BsNavbarScope.of(context);
    final isExpanded = scope?.isExpanded ?? true;

    if (isExpanded) {
      return Row(
        mainAxisAlignment: alignment,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: children,
      );
    }
  }
}

/// A standard navbar text link component (`BsNavbarLink`).
class BsNavbarLink extends StatefulWidget {
  /// Creates a [BsNavbarLink] widget.
  const BsNavbarLink({
    super.key,
    required this.label,
    this.onPressed,
    this.active = false,
    this.disabled = false,
    this.variant,
    this.color,
  });

  /// The text label of the link.
  final String label;

  /// Callback when link is clicked.
  final VoidCallback? onPressed;

  /// Whether the link is active.
  final bool active;

  /// Whether the link is disabled.
  final bool disabled;

  /// The color variant for the link text.
  final BsNavbarLinkVariant? variant;

  /// Custom color for the link text.
  final Color? color;

  @override
  State<BsNavbarLink> createState() => _BsNavbarLinkState();
}

class _BsNavbarLinkState extends State<BsNavbarLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final scope = _BsNavbarScope.of(context);
    final isDark = scope?.isDark ?? false;
    final isExpanded = scope?.isExpanded ?? true;

    final theme = context.bs;

    // Determine Base Color
    Color baseColor;
    final bool hasCustomColor = widget.color != null || widget.variant != null;

    if (widget.color != null) {
      baseColor = widget.color!;
    } else if (widget.variant != null) {
      baseColor = _resolveVariantColor(context, widget.variant!)!;
    } else {
      baseColor = isDark ? Colors.white : theme.bodyText;
    }

    // Resolve color state matching Bootstrap 5 specs
    Color textColor;
    if (widget.disabled) {
      textColor = baseColor.withValues(alpha: isDark ? 0.25 : 0.3);
    } else if (widget.active) {
      textColor = baseColor;
    } else if (_isHovered) {
      textColor = hasCustomColor
          ? baseColor.withValues(alpha: 0.8)
          : baseColor.withValues(alpha: isDark ? 0.75 : 0.7);
    } else {
      textColor = hasCustomColor
          ? baseColor
          : baseColor.withValues(alpha: 0.55);
    }

    Widget content = Padding(
      padding: isExpanded
          ? const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0)
          : const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        widget.label,
        style: TextStyle(
          color: textColor,
          fontSize: 16.0, // 1rem
          fontWeight: widget.active ? FontWeight.w500 : FontWeight.normal,
        ),
      ),
    );

    if (!widget.disabled && widget.onPressed != null) {
      content = MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.onPressed,
          child: content,
        ),
      );
    }

    return content;
  }
}

/// Standard secondary text inside a navbar (`BsNavbarText`).
class BsNavbarText extends StatelessWidget {
  /// Creates a [BsNavbarText] widget.
  const BsNavbarText({
    super.key,
    required this.child,
  });

  /// The inner text widget.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scope = _BsNavbarScope.of(context);
    final isDark = scope?.isDark ?? false;

    final theme = context.bs;
    final Color textColor = isDark
        ? Colors.white.withValues(alpha: 0.55)
        : theme.bodyText.withValues(alpha: 0.55);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DefaultTextStyle.merge(
        style: TextStyle(
          color: textColor,
          fontSize: 16.0,
        ),
        child: child,
      ),
    );
  }
}

/// A responsive spacer for the navbar (`BsNavbarSpacer`).
///
/// Behaves as a [Spacer] when the navbar is expanded (desktop Row layout),
/// and collapses to [SizedBox.shrink] when the navbar is collapsed (mobile Column layout).
class BsNavbarSpacer extends StatelessWidget {
  /// Creates a [BsNavbarSpacer] widget.
  const BsNavbarSpacer({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = _BsNavbarScope.of(context);
    final isExpanded = scope?.isExpanded ?? false;

    if (isExpanded) {
      return const Spacer();
    } else {
      return const SizedBox.shrink();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import '../../tokens/bootstrap_theme.dart';
import '../../tokens/shadows.dart';
import '../../tokens/enums.dart';
import '../../tokens/z_index.dart';
import '../button/bs_close_button.dart';
import 'bs_toast_manager.dart';

/// A Bootstrap-style Toast component.
///
/// Push notifications to your visitors with a toast, a lightweight and easily
/// customizable alert message.
class BsToast extends StatelessWidget {
  /// Creates a Bootstrap toast.
  const BsToast({
    super.key,
    this.header,
    required this.child,
    this.variant,
    this.width = 350.0,
  });

  /// The header widget of the toast. Typically a [BsToastHeader].
  final Widget? header;

  /// The main content of the toast (the body).
  final Widget child;

  /// Optional color variant to apply to the entire toast (like text-bg-*).
  final BsVariant? variant;

  /// The maximum width of the toast. Default is 350px (Bootstrap CSS default).
  final double width;

  @override
  Widget build(BuildContext context) {
    final theme = context.bs;
    
    // Default colors for light/dark mode (non-variant)
    Color bgColor = theme.bodyBg.withValues(alpha: 0.85);
    Color textColor = theme.bodyText;
    Color borderColor = theme.borderTranslucent;
    Color headerBorderColor = theme.borderTranslucent;
    Color closeIconColor = theme.bodyText;

    if (variant != null) {
      // Color variant applied (text-bg-*)
      final bool isLightVariant = variant == .light || variant == .warning || variant == .info;
      
      bgColor = switch (variant!) {
        .primary => theme.primary,
        .secondary => theme.secondary,
        .success => theme.success,
        .danger => theme.danger,
        .warning => theme.warning,
        .info => theme.info,
        .light => theme.light,
        .dark => theme.dark,
      };

      textColor = isLightVariant ? const Color(0xFF000000) : const Color(0xFFFFFFFF);
      
      // Borders in color variants are slightly lighter/darker semi-transparent
      borderColor = textColor.withValues(alpha: 0.2);
      headerBorderColor = textColor.withValues(alpha: 0.2);
      closeIconColor = textColor;
    }

    const double borderRadius = 8.0; // Bootstrap var(--bs-toast-border-radius) is usually .375rem (6px) or .5rem (8px)

    final Widget bodyWidget = Padding(
      padding: const EdgeInsets.all(12.0), // .75rem
      child: DefaultTextStyle(
        style: TextStyle(
          color: textColor,
          fontSize: 14.0, // .875rem
        ),
        child: child,
      ),
    );

    return Semantics(
      sortKey: const OrdinalSortKey(BsZIndex.toast * 1.0),
      child: Container(
      width: width,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor, width: 1.0),
        boxShadow: BsShadows.regular,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (header != null)
            _BsToastHeaderInherited(
              textColor: textColor,
              borderColor: headerBorderColor,
              closeIconColor: closeIconColor,
              child: header!,
            ),
          bodyWidget,
        ],
      ),
    ));
  }
}

/// Inherited widget to pass coloring down to [BsToastHeader].
class _BsToastHeaderInherited extends InheritedWidget {
  const _BsToastHeaderInherited({
    required this.textColor,
    required this.borderColor,
    required this.closeIconColor,
    required super.child,
  });

  final Color textColor;
  final Color borderColor;
  final Color closeIconColor;

  static _BsToastHeaderInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_BsToastHeaderInherited>();
  }

  @override
  bool updateShouldNotify(_BsToastHeaderInherited oldWidget) {
    return textColor != oldWidget.textColor ||
           borderColor != oldWidget.borderColor ||
           closeIconColor != oldWidget.closeIconColor;
  }
}

/// The header component for a [BsToast].
class BsToastHeader extends StatelessWidget {
  /// Creates a Bootstrap toast header.
  const BsToastHeader({
    super.key,
    this.icon,
    required this.title,
    this.subtitle,
    this.onClose,
    this.showCloseButton = true,
  });

  /// Optional icon or widget to display before the title.
  final Widget? icon;

  /// The main title of the toast. Often a [Text] widget.
  final Widget title;

  /// Optional subtitle, usually displaying time (e.g. "11 mins ago").
  final Widget? subtitle;

  /// Callback when the close button is pressed. If null, and the toast is not managed by [BsToastManager], no action occurs.
  final VoidCallback? onClose;

  /// Whether to show the close button. Default is true.
  final bool showCloseButton;

  @override
  Widget build(BuildContext context) {
    final theme = context.bs;
    final inherited = _BsToastHeaderInherited.of(context);
    
    // Fallback colors if used outside a BsToast (unlikely but possible)
    final Color textColor = inherited?.textColor ?? theme.bodyTextSecondary;
    final Color borderColor = inherited?.borderColor ?? theme.borderTranslucent;
    final Color closeColor = inherited?.closeIconColor ?? theme.bodyText;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0), // .75rem horizontal, .5rem vertical
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: borderColor, width: 1.0),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null) ...[
            icon!,
            const SizedBox(width: 8),
          ],
          Expanded(
            child: DefaultTextStyle(
              style: TextStyle(
                color: textColor,
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
              ),
              child: title,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(width: 8),
            DefaultTextStyle(
              style: TextStyle(
                color: textColor.withValues(alpha: 0.75), // smaller and muted
                fontSize: 12.0, // .875em of .875rem
              ),
              child: subtitle!,
            ),
          ],
          if (showCloseButton || onClose != null) ...[
            const SizedBox(width: 12),
            BsCloseButton(
              onPressed: () {
                onClose?.call();
                // Try to dismiss if managed by BsToastManager
                BsToastManager.dismissOf(context);
              },
              color: closeColor,
            ),
          ],
        ],
      ),
    );
  }
}

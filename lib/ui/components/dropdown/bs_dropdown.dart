import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import '../../tokens/bootstrap_theme.dart';
import '../../tokens/colors.dart';
import '../../tokens/enums.dart';
import '../../tokens/shadows.dart';
import '../../tokens/spacing.dart';
import '../../tokens/typography.dart';
import '../../tokens/z_index.dart';

// ─── Inherited Contexts ───────────────────────────────────────────────────────

class _BsDropdownContext extends InheritedWidget {
  const _BsDropdownContext({
    required this.state,
    required super.child,
  });

  final _BsDropdownState state;

  static _BsDropdownState? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_BsDropdownContext>()?.state;
  }

  @override
  bool updateShouldNotify(_BsDropdownContext oldWidget) => state != oldWidget.state;
}

class _BsDropdownMenuContext extends InheritedWidget {
  const _BsDropdownMenuContext({
    required this.isDark,
    required this.textCol,
    required this.dividerCol,
    required this.bg,
    required super.child,
  });

  final bool isDark;
  final Color textCol;
  final Color dividerCol;
  final Color bg;

  static _BsDropdownMenuContext? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_BsDropdownMenuContext>();
  }

  @override
  bool updateShouldNotify(_BsDropdownMenuContext oldWidget) {
    return isDark != oldWidget.isDark ||
        textCol != oldWidget.textCol ||
        dividerCol != oldWidget.dividerCol ||
        bg != oldWidget.bg;
  }
}

// ─── Dropdown Wrapper ─────────────────────────────────────────────────────────

/// A Bootstrap-style Dropdown wrapper.
///
/// Manages the overlay context, placement direction, alignment, and auto-close
/// behaviors.
class BsDropdown extends StatefulWidget {
  /// Creates a [BsDropdown] widget.
  const BsDropdown({
    super.key,
    this.label,
    this.toggle,
    this.toggleBuilder,
    required this.menu,
    this.direction = BsDropdownDirection.down,
    this.alignment = BsDropdownAlignment.start,
    this.autoClose = BsDropdownAutoClose.always,
    this.toggleVariant = BsButtonVariant.primary,
    this.toggleSize = BsButtonSize.md,
    this.showCaret = true,
    this.disabled = false,
  }) : assert(toggle != null || toggleBuilder != null || label != null,
            'Either toggle, toggleBuilder, or label must be provided');

  /// A static label to display on the default trigger button.
  final String? label;

  /// A static widget to act as the dropdown toggle trigger.
  final Widget? toggle;

  /// A builder providing a toggle callback and open status to wire up
  /// interactive triggers (e.g. split buttons or custom chevrons).
  final Widget Function(
      BuildContext context, VoidCallback toggleMenu, bool isOpen)? toggleBuilder;

  /// The dropdown menu containing the list of items.
  final BsDropdownMenu menu;

  /// Open direction of the menu relative to the toggle.
  final BsDropdownDirection direction;

  /// Alignment of the menu relative to the toggle edges.
  final BsDropdownAlignment alignment;

  /// How the dropdown menu closes automatically.
  final BsDropdownAutoClose autoClose;

  /// The variant of the default trigger button (used if label is provided).
  final BsButtonVariant toggleVariant;

  /// The size of the default trigger button (used if label is provided).
  final BsButtonSize toggleSize;

  /// Whether to show the caret arrow icon on the default trigger button (defaults to true).
  final bool showCaret;

  /// Whether the dropdown interaction is disabled.
  final bool disabled;

  @override
  State<BsDropdown> createState() => _BsDropdownState();
}

class _BsDropdownState extends State<BsDropdown> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  bool get isOpen => _isOpen;

  void _toggleMenu() {
    if (widget.disabled) return;
    if (_isOpen) {
      close();
    } else {
      open();
    }
  }

  void open() {
    if (widget.disabled || _isOpen) return;

    // Resolve screen dimensions
    final screenSize = MediaQuery.sizeOf(context);
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    Alignment targetAnchor = Alignment.bottomLeft;
    Alignment followerAnchor = Alignment.topLeft;
    Offset offset = const Offset(0, 2);
    double maxMenuHeight = screenHeight - 32.0;

    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox != null && renderBox.hasSize) {
      final triggerSize = renderBox.size;
      final triggerOffset = renderBox.localToGlobal(Offset.zero);

      final double spaceBelow = screenHeight - (triggerOffset.dy + triggerSize.height);
      final double spaceAbove = triggerOffset.dy;
      final double spaceRight = screenWidth - (triggerOffset.dx + triggerSize.width);
      final double spaceLeft = triggerOffset.dx;

      // Sensible thresholds for collision detection
      const double minRequiredHeight = 260.0;
      const double minRequiredWidth = 180.0;

      BsDropdownDirection effectiveDirection = widget.direction;

      // Collision detection & auto-flip
      if (widget.direction == BsDropdownDirection.down) {
        if (spaceBelow < minRequiredHeight && spaceAbove > spaceBelow) {
          effectiveDirection = BsDropdownDirection.up;
        }
      } else if (widget.direction == BsDropdownDirection.up) {
        if (spaceAbove < minRequiredHeight && spaceBelow > spaceAbove) {
          effectiveDirection = BsDropdownDirection.down;
        }
      } else if (widget.direction == BsDropdownDirection.end) {
        if (spaceRight < minRequiredWidth && spaceLeft > spaceRight) {
          effectiveDirection = BsDropdownDirection.start;
        }
      } else if (widget.direction == BsDropdownDirection.start) {
        if (spaceLeft < minRequiredWidth && spaceRight > spaceLeft) {
          effectiveDirection = BsDropdownDirection.end;
        }
      }

      // Configure anchors, offsets, and maximum height based on resolved direction
      switch (effectiveDirection) {
        case BsDropdownDirection.down:
          if (widget.alignment == BsDropdownAlignment.start) {
            targetAnchor = Alignment.bottomLeft;
            followerAnchor = Alignment.topLeft;
            offset = const Offset(0, 2);
          } else {
            targetAnchor = Alignment.bottomRight;
            followerAnchor = Alignment.topRight;
            offset = const Offset(0, 2);
          }
          maxMenuHeight = spaceBelow - 16.0;
          break;
        case BsDropdownDirection.up:
          if (widget.alignment == BsDropdownAlignment.start) {
            targetAnchor = Alignment.topLeft;
            followerAnchor = Alignment.bottomLeft;
            offset = const Offset(0, -2);
          } else {
            targetAnchor = Alignment.topRight;
            followerAnchor = Alignment.bottomRight;
            offset = const Offset(0, -2);
          }
          maxMenuHeight = spaceAbove - 16.0;
          break;
        case BsDropdownDirection.end:
          if (widget.alignment == BsDropdownAlignment.start) {
            targetAnchor = Alignment.topRight;
            followerAnchor = Alignment.topLeft;
            offset = const Offset(2, 0);
          } else {
            targetAnchor = Alignment.bottomRight;
            followerAnchor = Alignment.bottomLeft;
            offset = const Offset(2, 0);
          }
          maxMenuHeight = screenHeight - 32.0;
          break;
        case BsDropdownDirection.start:
          if (widget.alignment == BsDropdownAlignment.start) {
            targetAnchor = Alignment.topLeft;
            followerAnchor = Alignment.topRight;
            offset = const Offset(-2, 0);
          } else {
            targetAnchor = Alignment.bottomLeft;
            followerAnchor = Alignment.bottomRight;
            offset = const Offset(-2, 0);
          }
          maxMenuHeight = screenHeight - 32.0;
          break;
      }
    }

    // Ensure maxMenuHeight is at least 150.0 so the menu is always readable
    if (maxMenuHeight < 150.0) {
      maxMenuHeight = 150.0;
    }

    _overlayEntry = OverlayEntry(
      builder: (context) {
        final menuWidget = CompositedTransformFollower(
          link: _layerLink,
          targetAnchor: targetAnchor,
          followerAnchor: followerAnchor,
          offset: offset,
          child: Align(
            alignment: followerAnchor,
            child: Material(
              color: Colors.transparent,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: maxMenuHeight,
                ),
                child: _BsDropdownContext(
                  state: this,
                  child: widget.menu,
                ),
              ),
            ),
          ),
        );

        if (widget.autoClose == BsDropdownAutoClose.always ||
            widget.autoClose == BsDropdownAutoClose.outside) {
          return Stack(
            children: [
              // Tap detector barrier for outside click detection
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTapDown: (_) => close(),
                child: const SizedBox.expand(),
              ),
              menuWidget,
            ],
          );
        }

        return menuWidget;
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _isOpen = true;
    });
  }

  void close() {
    if (!_isOpen) return;
    _isOpen = false;
    Future.microtask(() {
      _overlayEntry?.remove();
      _overlayEntry = null;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    if (_isOpen) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.toggleBuilder != null) {
      return CompositedTransformTarget(
        link: _layerLink,
        child: widget.toggleBuilder!(context, _toggleMenu, _isOpen),
      );
    }

    if (widget.toggle != null) {
      return MouseRegion(
        cursor: widget.disabled ? SystemMouseCursors.forbidden : SystemMouseCursors.click,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.disabled ? null : _toggleMenu,
          child: CompositedTransformTarget(
            link: _layerLink,
            child: AbsorbPointer(
              absorbing: !widget.disabled,
              child: widget.toggle!,
            ),
          ),
        ),
      );
    }

    // Default button trigger using label and optional caret
    return CompositedTransformTarget(
      link: _layerLink,
      child: _DefaultToggle(
        label: widget.label ?? 'Dropdown',
        variant: widget.toggleVariant,
        size: widget.toggleSize,
        showCaret: widget.showCaret,
        isOpen: _isOpen,
        direction: widget.direction,
        disabled: widget.disabled,
        onTap: _toggleMenu,
      ),
    );
  }
}

// ─── Dropdown Menu ───────────────────────────────────────────────────────────

/// A Bootstrap-style dropdown menu overlay.
///
/// Contains [BsDropdownItem], [BsDropdownHeader], [BsDropdownDivider], or [BsDropdownText].
class BsDropdownMenu extends StatelessWidget {
  /// Creates a [BsDropdownMenu].
  const BsDropdownMenu({
    super.key,
    required this.children,
    this.dark,
    this.variant,
    this.color,
    this.minWidth = 160.0,
    this.maxWidth = 320.0,
    this.padding = const EdgeInsets.symmetric(vertical: 8.0),
  });

  /// The list of items inside the dropdown.
  final List<Widget> children;

  /// Forces the dark theme behavior if true, light theme if false,
  /// or auto-detects from the context if null (default).
  final bool? dark;

  /// A semantic variant (reusing [BsVariant]) to style the background and text color.
  final BsVariant? variant;

  /// Custom background color override. If provided, overrides variant and dark properties.
  final Color? color;

  /// Minimum width of the dropdown menu container.
  final double minWidth;

  /// Maximum width of the dropdown menu container.
  final double maxWidth;

  /// Internal padding of the dropdown menu.
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final bsTheme = context.bs;

    // Auto-detect dark mode from theme if not overridden
    final bool isDark = dark ?? (Theme.of(context).brightness == Brightness.dark);

    Color bg;
    Color borderCol;
    Color textCol;
    Color dividerCol;

    if (color != null) {
      bg = color!;
      final double luminance = bg.computeLuminance();
      textCol = luminance > 0.5 ? Colors.black : Colors.white;
      borderCol = textCol.withValues(alpha: 0.15);
      dividerCol = textCol.withValues(alpha: 0.15);
    } else if (variant != null) {
      switch (variant!) {
        case BsVariant.primary:
          bg = bsTheme.primary;
          textCol = BsColors.onPrimary;
          break;
        case BsVariant.secondary:
          bg = bsTheme.secondary;
          textCol = BsColors.onSecondary;
          break;
        case BsVariant.success:
          bg = bsTheme.success;
          textCol = BsColors.onSuccess;
          break;
        case BsVariant.danger:
          bg = bsTheme.danger;
          textCol = BsColors.onDanger;
          break;
        case BsVariant.warning:
          bg = bsTheme.warning;
          textCol = BsColors.onWarning;
          break;
        case BsVariant.info:
          bg = bsTheme.info;
          textCol = BsColors.onInfo;
          break;
        case BsVariant.light:
          bg = bsTheme.light;
          textCol = bsTheme.onLight;
          break;
        case BsVariant.dark:
          bg = bsTheme.dark;
          textCol = bsTheme.onDark;
          break;
      }
      borderCol = textCol.withValues(alpha: 0.15);
      dividerCol = textCol.withValues(alpha: 0.15);
    } else {
      if (isDark) {
        bg = const Color(0xFF2B3035); // Bootstrap dark menu bg
        textCol = const Color(0xFFDEE2E6); // Bootstrap dark menu text
        borderCol = const Color(0x2BFFFFFF);
        dividerCol = const Color(0x2BFFFFFF);
      } else {
        bg = Colors.white;
        textCol = bsTheme.bodyText;
        borderCol = bsTheme.borderTranslucent;
        dividerCol = bsTheme.borderTranslucent;
      }
    }

    return _BsDropdownMenuContext(
      isDark: isDark,
      textCol: textCol,
      dividerCol: dividerCol,
      bg: bg,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: minWidth,
          maxWidth: maxWidth,
        ),
        child: IntrinsicWidth(
          child: Semantics(
            sortKey: const OrdinalSortKey(BsZIndex.dropdown * 1.0),
            child: Container(
              padding: padding,
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: borderCol, width: 1.0),
                boxShadow: BsShadows.regular,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: children,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Dropdown Item ───────────────────────────────────────────────────────────

/// A selectable action or link inside a [BsDropdownMenu].
class BsDropdownItem extends StatefulWidget {
  /// Creates a [BsDropdownItem].
  const BsDropdownItem({
    super.key,
    required this.child,
    this.onPressed,
    this.active = false,
    this.disabled = false,
    this.icon,
  });

  /// The label/content of the item.
  final Widget child;

  /// Callback when item is pressed. If null, behaves as disabled.
  final VoidCallback? onPressed;

  /// Whether the item is in active state (.active).
  final bool active;

  /// Whether the item is disabled (.disabled).
  final bool disabled;

  /// Optional leading icon for the item.
  final Widget? icon;

  @override
  State<BsDropdownItem> createState() => _BsDropdownItemState();
}

class _BsDropdownItemState extends State<BsDropdownItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final menuCtx = _BsDropdownMenuContext.of(context);
    final bsTheme = context.bs;

    final bool isDark = menuCtx?.isDark ?? false;
    final Color menuTextCol = menuCtx?.textCol ?? bsTheme.bodyText;

    Color itemBg = Colors.transparent;
    Color itemTextCol = menuTextCol;

    if (widget.active) {
      itemBg = bsTheme.primary;
      itemTextCol = BsColors.onPrimary;
    } else if (widget.disabled) {
      itemTextCol = menuTextCol.withValues(alpha: 0.5);
    } else if (_isHovered) {
      if (isDark) {
        itemBg = const Color(0x15FFFFFF); // Translucent hover in dark mode
        itemTextCol = const Color(0xFFFFFFFF);
      } else {
        itemBg = BsColors.gray[100]!; // Standard hover in light mode
        itemTextCol = menuTextCol;
      }
    }

    final Widget content = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.icon != null) ...[
            IconTheme(
              data: IconThemeData(
                color: itemTextCol,
                size: 16.0,
              ),
              child: widget.icon!,
            ),
            const SizedBox(width: 8.0),
          ],
          Flexible(
            child: DefaultTextStyle(
              style: TextStyle(
                color: itemTextCol,
                fontSize: 14.0,
                fontWeight: FontWeight.normal,
              ),
              softWrap: true,
              child: widget.child,
            ),
          ),
        ],
      ),
    );

    return MouseRegion(
      cursor: widget.disabled ? SystemMouseCursors.forbidden : SystemMouseCursors.click,
      onEnter: (_) {
        if (!widget.disabled) {
          setState(() => _isHovered = true);
        }
      },
      onExit: (_) {
        setState(() => _isHovered = false);
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.disabled
            ? null
            : () {
                widget.onPressed?.call();
                final dropdownState = _BsDropdownContext.of(context);
                if (dropdownState != null) {
                  if (dropdownState.widget.autoClose == BsDropdownAutoClose.always ||
                      dropdownState.widget.autoClose == BsDropdownAutoClose.inside) {
                    dropdownState.close();
                  }
                }
              },
        child: Container(
          color: itemBg,
          width: double.infinity,
          child: content,
        ),
      ),
    );
  }
}

// ─── Dropdown Header ─────────────────────────────────────────────────────────

/// A header label inside a [BsDropdownMenu] to separate item groups.
class BsDropdownHeader extends StatelessWidget {
  /// Creates a [BsDropdownHeader].
  const BsDropdownHeader({
    super.key,
    required this.child,
  });

  /// The header widget (usually a [Text]).
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final menuCtx = _BsDropdownMenuContext.of(context);
    final bsTheme = context.bs;

    final Color textCol = menuCtx != null
        ? (menuCtx.isDark ? const Color(0xFFADB5BD) : bsTheme.bodyTextSecondary)
        : bsTheme.bodyTextSecondary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: DefaultTextStyle(
        style: TextStyle(
          color: textCol,
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
        ),
        softWrap: true,
        child: child,
      ),
    );
  }
}

// ─── Dropdown Divider ────────────────────────────────────────────────────────

/// A horizontal thin line separating items inside a [BsDropdownMenu].
class BsDropdownDivider extends StatelessWidget {
  /// Creates a [BsDropdownDivider].
  const BsDropdownDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final menuCtx = _BsDropdownMenuContext.of(context);
    final bsTheme = context.bs;

    final Color dividerCol = menuCtx?.dividerCol ?? bsTheme.borderTranslucent;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Divider(
        height: 1.0,
        thickness: 1.0,
        color: dividerCol,
      ),
    );
  }
}

// ─── Dropdown Text ───────────────────────────────────────────────────────────

/// Plain descriptive text inside a [BsDropdownMenu].
class BsDropdownText extends StatelessWidget {
  /// Creates a [BsDropdownText].
  const BsDropdownText({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
  });

  /// The text content.
  final Widget child;

  /// Padding around the text.
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final menuCtx = _BsDropdownMenuContext.of(context);
    final bsTheme = context.bs;

    final Color textCol = menuCtx?.textCol ?? bsTheme.bodyText;

    return Padding(
      padding: padding,
      child: DefaultTextStyle(
        style: TextStyle(
          color: textCol.withValues(alpha: 0.8),
          fontSize: 14.0,
        ),
        softWrap: true,
        child: child,
      ),
    );
  }
}

// ─── Default Button Toggle ───────────────────────────────────────────────────

class _DefaultToggle extends StatefulWidget {
  const _DefaultToggle({
    required this.label,
    required this.variant,
    required this.size,
    required this.showCaret,
    required this.isOpen,
    required this.direction,
    required this.disabled,
    required this.onTap,
  });

  final String label;
  final BsButtonVariant variant;
  final BsButtonSize size;
  final bool showCaret;
  final bool isOpen;
  final BsDropdownDirection direction;
  final bool disabled;
  final VoidCallback onTap;

  @override
  State<_DefaultToggle> createState() => _DefaultToggleState();
}

class _DefaultToggleState extends State<_DefaultToggle> {
  bool _isPressed = false;
  bool _isHovered = false;

  Color _darken(Color color, double amount) {
    final hsl = HSLColor.fromColor(color);
    return hsl
        .withLightness((hsl.lightness - amount).clamp(0.0, 1.0))
        .toColor();
  }

  @override
  Widget build(BuildContext context) {
    final bsTheme = context.bs;
    final style = _resolveStyle(widget.variant, widget.size, bsTheme);

    final Color bgColor = _resolveBackgroundColor(style, bsTheme);
    final Color fgColor = _resolveForegroundColor(style, bsTheme);

    final IconData caretIcon = _getCaretIcon(widget.direction, widget.isOpen);

    return MouseRegion(
      cursor: widget.disabled
          ? SystemMouseCursors.forbidden
          : SystemMouseCursors.click,
      onEnter: (_) {
        if (!widget.disabled) setState(() => _isHovered = true);
      },
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: widget.disabled
            ? null
            : (_) => setState(() => _isPressed = true),
        onTapUp: widget.disabled
            ? null
            : (_) {
                setState(() => _isPressed = false);
                widget.onTap();
              },
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          padding: style.padding,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: style.borderRadius,
            border: _resolveBorder(style, bsTheme),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.label,
                style: style.textStyle.copyWith(color: fgColor),
              ),
              if (widget.showCaret) ...[
                const SizedBox(width: 6.0),
                Icon(
                  caretIcon,
                  size: style.textStyle.fontSize! * 0.9,
                  color: fgColor,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  IconData _getCaretIcon(BsDropdownDirection direction, bool isOpen) {
    if (isOpen) {
      return switch (direction) {
        BsDropdownDirection.down => Icons.arrow_drop_up_rounded,
        BsDropdownDirection.up => Icons.arrow_drop_down_rounded,
        BsDropdownDirection.end => Icons.arrow_left_rounded,
        BsDropdownDirection.start => Icons.arrow_right_rounded,
      };
    }
    return switch (direction) {
      BsDropdownDirection.down => Icons.arrow_drop_down_rounded,
      BsDropdownDirection.up => Icons.arrow_drop_up_rounded,
      BsDropdownDirection.end => Icons.arrow_right_rounded,
      BsDropdownDirection.start => Icons.arrow_left_rounded,
    };
  }

  Color _resolveBackgroundColor(_ButtonStyle style, BsThemeData bsTheme) {
    if (widget.disabled) {
      return bsTheme.bodyBgSecondary;
    }
    if (widget.variant == BsButtonVariant.link) {
      return Colors.transparent;
    }
    final bool isOutline = widget.variant.name.startsWith('outline');
    if (_isPressed) {
      return isOutline
          ? style.foregroundColor.withValues(alpha: 0.85)
          : _darken(style.backgroundColor, 0.15);
    }
    if (_isHovered) {
      return isOutline
          ? style.foregroundColor.withValues(alpha: 0.15)
          : _darken(style.backgroundColor, 0.08);
    }
    return style.backgroundColor;
  }

  Color _resolveForegroundColor(_ButtonStyle style, BsThemeData bsTheme) {
    if (widget.disabled) {
      return bsTheme.bodyTextTertiary;
    }
    final bool isOutline = widget.variant.name.startsWith('outline');
    if (_isPressed && isOutline) {
      return Colors.white;
    }
    return style.foregroundColor;
  }

  Border? _resolveBorder(_ButtonStyle style, BsThemeData bsTheme) {
    if (style.border == null) return null;
    final Color borderColor = widget.disabled
        ? bsTheme.bodyBgSecondary
        : _isPressed
            ? _darken(style.border!, 0.1)
            : style.border!;
    return Border.all(color: borderColor, width: 1.0);
  }

  _ButtonStyle _resolveStyle(
    BsButtonVariant variant,
    BsButtonSize size,
    BsThemeData bs,
  ) {
    final EdgeInsets padding = switch (size) {
      BsButtonSize.sm => BsSpacing.btnPaddingSm,
      BsButtonSize.md => BsSpacing.btnPaddingMd,
      BsButtonSize.lg => BsSpacing.btnPaddingLg,
    };
    final TextStyle textStyle = switch (size) {
      BsButtonSize.sm => BsTypography.btnSm,
      BsButtonSize.md => BsTypography.btnMd,
      BsButtonSize.lg => BsTypography.btnLg,
    };
    final double baseRadius = size == BsButtonSize.sm ? 4.0 : (size == BsButtonSize.lg ? 8.0 : 6.0);
    final BorderRadius borderRadius = BorderRadius.all(Radius.circular(baseRadius));

    return switch (variant) {
      BsButtonVariant.primary => _ButtonStyle(
          backgroundColor: bs.primary,
          foregroundColor: BsColors.onPrimary,
          border: bs.primary,
          padding: padding,
          textStyle: textStyle,
          borderRadius: borderRadius,
        ),
      BsButtonVariant.secondary => _ButtonStyle(
          backgroundColor: bs.secondary,
          foregroundColor: BsColors.onSecondary,
          border: bs.secondary,
          padding: padding,
          textStyle: textStyle,
          borderRadius: borderRadius,
        ),
      BsButtonVariant.success => _ButtonStyle(
          backgroundColor: bs.success,
          foregroundColor: BsColors.onSuccess,
          border: bs.success,
          padding: padding,
          textStyle: textStyle,
          borderRadius: borderRadius,
        ),
      BsButtonVariant.danger => _ButtonStyle(
          backgroundColor: bs.danger,
          foregroundColor: BsColors.onDanger,
          border: bs.danger,
          padding: padding,
          textStyle: textStyle,
          borderRadius: borderRadius,
        ),
      BsButtonVariant.warning => _ButtonStyle(
          backgroundColor: bs.warning,
          foregroundColor: BsColors.onWarning,
          border: bs.warning,
          padding: padding,
          textStyle: textStyle,
          borderRadius: borderRadius,
        ),
      BsButtonVariant.info => _ButtonStyle(
          backgroundColor: bs.info,
          foregroundColor: BsColors.onInfo,
          border: bs.info,
          padding: padding,
          textStyle: textStyle,
          borderRadius: borderRadius,
        ),
      BsButtonVariant.light => _ButtonStyle(
          backgroundColor: bs.light,
          foregroundColor: bs.onLight,
          border: bs.light,
          padding: padding,
          textStyle: textStyle,
          borderRadius: borderRadius,
        ),
      BsButtonVariant.dark => _ButtonStyle(
          backgroundColor: bs.dark,
          foregroundColor: bs.onDark,
          border: bs.dark,
          padding: padding,
          textStyle: textStyle,
          borderRadius: borderRadius,
        ),
      BsButtonVariant.outlinePrimary => _ButtonStyle(
          backgroundColor: Colors.transparent,
          foregroundColor: bs.primary,
          border: bs.primary,
          padding: padding,
          textStyle: textStyle,
          borderRadius: borderRadius,
        ),
      BsButtonVariant.outlineSecondary => _ButtonStyle(
          backgroundColor: Colors.transparent,
          foregroundColor: bs.secondary,
          border: bs.secondary,
          padding: padding,
          textStyle: textStyle,
          borderRadius: borderRadius,
        ),
      BsButtonVariant.outlineSuccess => _ButtonStyle(
          backgroundColor: Colors.transparent,
          foregroundColor: bs.success,
          border: bs.success,
          padding: padding,
          textStyle: textStyle,
          borderRadius: borderRadius,
        ),
      BsButtonVariant.outlineDanger => _ButtonStyle(
          backgroundColor: Colors.transparent,
          foregroundColor: bs.danger,
          border: bs.danger,
          padding: padding,
          textStyle: textStyle,
          borderRadius: borderRadius,
        ),
      BsButtonVariant.outlineWarning => _ButtonStyle(
          backgroundColor: Colors.transparent,
          foregroundColor: bs.warning,
          border: bs.warning,
          padding: padding,
          textStyle: textStyle,
          borderRadius: borderRadius,
        ),
      BsButtonVariant.outlineInfo => _ButtonStyle(
          backgroundColor: Colors.transparent,
          foregroundColor: bs.info,
          border: bs.info,
          padding: padding,
          textStyle: textStyle,
          borderRadius: borderRadius,
        ),
      BsButtonVariant.outlineDark => _ButtonStyle(
          backgroundColor: Colors.transparent,
          foregroundColor: bs.bodyText,
          border: bs.bodyText,
          padding: padding,
          textStyle: textStyle,
          borderRadius: borderRadius,
        ),
      BsButtonVariant.link => _ButtonStyle(
          backgroundColor: Colors.transparent,
          foregroundColor: bs.linkColor,
          padding: padding,
          textStyle: textStyle,
          borderRadius: borderRadius,
        ),
    };
  }
}

class _ButtonStyle {
  const _ButtonStyle({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.padding,
    required this.textStyle,
    required this.borderRadius,
    this.border,
  });
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? border;
  final EdgeInsets padding;
  final TextStyle textStyle;
  final BorderRadius borderRadius;
}

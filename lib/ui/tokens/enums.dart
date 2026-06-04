/// Variant types for [BsButton].
enum BsButtonVariant {
  /// The primary button variant.
  primary,

  /// The secondary button variant.
  secondary,

  /// The success button variant.
  success,

  /// The danger button variant.
  danger,

  /// The warning button variant.
  warning,

  /// The info button variant.
  info,

  /// The light button variant.
  light,

  /// The dark button variant.
  dark,

  /// Outline version of the primary variant.
  outlinePrimary,

  /// Outline version of the secondary variant.
  outlineSecondary,

  /// Outline version of the success variant.
  outlineSuccess,

  /// Outline version of the danger variant.
  outlineDanger,

  /// Outline version of the warning variant.
  outlineWarning,

  /// Outline version of the info variant.
  outlineInfo,

  /// Outline version of the dark variant.
  outlineDark,

  /// A text-only link variant.
  link,
}

/// Color variants for icons.
enum BsIconVariant {
  /// Primary icon color.
  primary,

  /// Secondary icon color.
  secondary,

  /// Success icon color.
  success,

  /// Danger icon color.
  danger,

  /// Warning icon color.
  warning,

  /// Info icon color.
  info,

  /// Light icon color.
  light,

  /// Dark icon color.
  dark,
}

/// Variant types for [BsAlert].
enum BsAlertVariant {
  /// Primary alert variant.
  primary,

  /// Secondary alert variant.
  secondary,

  /// Success alert variant.
  success,

  /// Danger alert variant.
  danger,

  /// Warning alert variant.
  warning,

  /// Info alert variant.
  info,

  /// Light alert variant.
  light,

  /// Dark alert variant.
  dark,
}

/// Animation types for showing/hiding [BsAlert].
enum BsAlertAnimation {
  /// No animation.
  none,

  /// Fade in/out.
  fade,

  /// Slide from top.
  slideTop,

  /// Slide from bottom.
  slideBottom,

  /// Slide from left.
  slideLeft,

  /// Slide from right.
  slideRight,
}

/// Variant types for [BsBadge].
enum BsBadgeVariant {
  /// Primary badge variant.
  primary,

  /// Secondary badge variant.
  secondary,

  /// Success badge variant.
  success,

  /// Danger badge variant.
  danger,

  /// Warning badge variant.
  warning,

  /// Info badge variant.
  info,

  /// Light badge variant.
  light,

  /// Dark badge variant.
  dark,
}

/// Types of [BsContainer].
enum BsContainerType {
  /// Fixed width container that changes at breakpoints.
  fixed,

  /// 100% wide container at all breakpoints.
  fluid,

  /// 100% wide until 'sm' breakpoint.
  sm,

  /// 100% wide until 'md' breakpoint.
  md,

  /// 100% wide until 'lg' breakpoint.
  lg,

  /// 100% wide until 'xl' breakpoint.
  xl,

  /// 100% wide until 'xxl' breakpoint.
  xxl,
}

/// Size variants for buttons.
enum BsButtonSize {
  /// Small button.
  sm,

  /// Medium (default) button.
  md,

  /// Large button.
  lg,
}

/// Position options for badges when used as overlays.
enum BsBadgePosition {
  /// Positioned at the start of the content.
  leading,

  /// Positioned at the end of the content.
  trailing,

  /// Positioned at the top left corner.
  topLeft,

  /// Positioned at the top right corner.
  topRight,

  /// Positioned at the bottom left corner.
  bottomLeft,

  /// Positioned at the bottom right corner.
  bottomRight,
}

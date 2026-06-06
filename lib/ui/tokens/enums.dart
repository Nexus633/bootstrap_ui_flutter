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

/// Variant types for [BsTable].
enum BsTableVariant {
  /// Primary table variant.
  primary,

  /// Secondary table variant.
  secondary,

  /// Success table variant.
  success,

  /// Danger table variant.
  danger,

  /// Warning table variant.
  warning,

  /// Info table variant.
  info,

  /// Light table variant.
  light,

  /// Dark table variant.
  dark,
}

/// Vertical alignment options for [BsTable] cells.
enum BsTableVerticalAlign {
  /// Align to the top.
  top,

  /// Align to the middle.
  middle,

  /// Align to the bottom.
  bottom,
}

/// Responsive behavior options for [BsTable].
enum BsTableResponsive {
  /// Always responsive (horizontally scrollable).
  always,

  /// Responsive until 'sm' breakpoint.
  sm,

  /// Responsive until 'md' breakpoint.
  md,

  /// Responsive until 'lg' breakpoint.
  lg,

  /// Responsive until 'xl' breakpoint.
  xl,

  /// Responsive until 'xxl' breakpoint.
  xxl,
}

/// Sizing options for Bootstrap form controls.
enum BsInputSize {
  /// Small input size (`.form-control-sm`).
  sm,

  /// Default input size (`.form-control`).
  md,

  /// Large input size (`.form-control-lg`).
  lg,
}

/// Validation states for Bootstrap form controls.
enum BsValidationState {
  /// No validation state applied.
  none,

  /// Valid state (`.is-valid`), typically renders green feedback.
  valid,

  /// Invalid state (`.is-invalid`), typically renders red feedback.
  invalid,
}

/// Heading levels corresponding to Bootstrap's `<h1>` through `<h6>` tags.
enum BsHeadingLevel {
  /// Heading 1 (`<h1>`) level.
  h1,

  /// Heading 2 (`<h2>`) level.
  h2,

  /// Heading 3 (`<h3>`) level.
  h3,

  /// Heading 4 (`<h4>`) level.
  h4,

  /// Heading 5 (`<h5>`) level.
  h5,

  /// Heading 6 (`<h6>`) level.
  h6,
}

/// Color variants for [BsCard].
enum BsCardVariant {
  /// Primary variant.
  primary,

  /// Secondary variant.
  secondary,

  /// Success variant.
  success,

  /// Danger variant.
  danger,

  /// Warning variant.
  warning,

  /// Info variant.
  info,

  /// Light variant.
  light,

  /// Dark variant.
  dark,
}

/// Image positions for [BsCard].
enum BsCardImagePosition {
  /// Image at the top of the card.
  top,

  /// Image at the bottom of the card.
  bottom,

  /// Image as background overlay.
  overlay,

  /// Image on the left side of the card.
  left,

  /// Image on the right side of the card.
  right,
}

/// Direction in which the dropdown menu opens.
enum BsDropdownDirection {
  /// Opens below the trigger (default).
  down,

  /// Opens above the trigger (.dropup).
  up,

  /// Opens to the right of the trigger (.dropend).
  end,

  /// Opens to the left of the trigger (.dropstart).
  start,
}

/// Alignment of the dropdown menu relative to its trigger.
enum BsDropdownAlignment {
  /// Aligns the start edge of the menu with the start of the trigger (default).
  start,

  /// Aligns the end edge of the menu with the end of the trigger.
  end,
}

/// Auto-close behavior of the dropdown when clicking inside or outside.
enum BsDropdownAutoClose {
  /// Closes when clicking outside the dropdown or on a menu item (default).
  always,

  /// Closes only when clicking on a menu item.
  inside,

  /// Closes only when clicking outside the dropdown.
  outside,

  /// Only closes programmatically or by clicking the toggle again.
  none,
}


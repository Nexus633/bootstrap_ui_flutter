## 0.6.0
 * **Localization (JSON-based)**:
   - Migrated from hardcoded `BsLocalizationConfig` to a dynamic, asset-based JSON localization system using `BsLocalizations` and `BsLocalizations.delegate`.
   - Added translations for **10 languages**: English, German, French, Spanish, Italian, Portuguese, Dutch, Polish, Russian, and Turkish.
   - Designed for zero-configuration: `isSupported` returns `true` for all locales, enabling developers to drop in new JSON files (e.g., `zh.json`) without modifying or re-compiling the library.
   - Built-in graceful fallback to English (`en.json`) if file loading fails or a language is not supported.
 * **Semantics & Accessibility (100% Scope)**:
   - Achieved comprehensive accessibility coverage across all components.
   - Added custom semantics support for `BsSelect` (linking floating label and error validation).
   - Added progress bar role and value mapping to `BsProgress` & `BsProgressBar`.
   - Added status role and loading announcements to `BsSpinner` (utilizing `liveRegion`).
   - Added full navigation controls, indicator selection, and carousel role semantics to `BsCarousel`.
   - Added custom screen reader labels (`semanticsLabel`) to `BsBadge` and interactive role overlays (`link`/`button`) to `BsCard`.
 * **Design Tokens & Refactoring**:
   - Added shadow, transition, and z-index design tokens, form validation state, and typography components.
   - Refactored all enums across the codebase to use modern Dart short-dot syntax for a cleaner API.
   - Relocated icon assets to `assets/fonts/` for unified packaging.
 * **Showcase & Platform Support**:
   - Initialized cross-platform project structures for the example application.
   - Added missing platform directories (`ios`, `macos`, `linux`) to the showcase app.
   - Registered `BsLocalizations.delegate` in the showcase MaterialApp.
 * **Testing & Quality**:
   - Expanded test suite to **255 tests** (adding new widget tests for accessibility and localizations).
   - Introduced a robust localization mock delegate pattern for widget testing to avoid filesystem and asset-loading latency on CI pipelines.
   - Verified 100% clean static analysis (`flutter analyze`) and all tests green.

## 0.5.0 (Beta Release)
 * **New Components**:
   - `BsListGroup` (Flexible and powerful list groups, items, and action states)
   - `BsModal` (Dialog prompts with headers, footers, sizes, and backdrop options)
   - `BsNav` & `BsTab` (Navigation menus, pills, underlines, and tabbed content panes)
   - `BsNavbar` (Responsive navigation header with togglers and collapsible branding)
   - `BsOffcanvas` (Hidden sidebars for navigation or contextual content)
   - `BsPagination` (Page navigation with active and disabled states)
   - `BsPlaceholder` (Loading skeletons mimicking layout components)
   - `BsPopover` (Advanced tooltips with title, body, and customizable placement)
   - `BsProgress` & `BsProgressBar` (Progress indicators with labels, stripes, and animation)
   - `BsScrollspy` (Automatically update navigation based on scroll position)
   - `BsSpinner` (Loading indicators with border, grow, sizes, and colors)
   - `BsToast` & `BsToastManager` (Lightweight push notifications with multi-alignment stack logic and automatic dismiss)
   - `BsTooltip` (Custom tooltips with auto-flip logic and variants)
 * **New Utilities & Extensions**:
   - Added massive improvements to typography and layout utility extensions (e.g. `BsTextExtension`, `BsBorderExtension`, `BsSizeExtension`).
 * **Component Updates**:
   - `BsButton`: Added `color` property for custom color overrides with automatic smart contrast calculation for text colors.
   - `BsTooltip`: Added `variant` and `color` property for customized tooltip styles.
 * **Showcase Updates**:
   - Redesigned all component showcases to use a beautiful, unified gradient header for a premium look and feel.
   - Re-organized showcase code to be cleaner and more consistent.
 * **Documentation**: Added comprehensive English and German documentation files for all new components (List Group, Modal, Nav, Navbar, Offcanvas, Pagination, Placeholder, Popover, Progress, Scrollspy, Spinners, Toasts, Tooltips).
 * **Status**: Officially promoting the library to BETA.

## 0.1.4
 * **New Components**:
   - `BsCloseButton` (Dismiss buttons for modals/alerts)
   - `BsCollapse` (Collapsible containers with smooth transitions)
   - `BsCard` & `BsCardGroup` (Flexible Bootstrap Cards)
   - `BsCarousel` & `BsCarouselItem` (Slideshow/Carousel with dark mode & autoplay support)
   - `BsDropdown`, `BsDropdownMenu` & `BsDropdownItem` (Highly flexible popup menus)
   - `BsBreadcrumb` & `BsBreadcrumbItem` (Navigation hierarchy)
   - `BsInput` & `BsSelect` (Form text inputs & dropdown select inputs)
   - `BsCheckbox` & `BsRange` (Checkboxes/Switches & custom range sliders)
   - `BsInputGroup` & `BsInputGroupText` (Combined form group controls)
   - `BsImage` & `BsFigure` (Responsive images, thumbnails & captioned figures)
   - `BsTable` (Fully styled, responsive, zebra-striped, and hoverable data tables)
   - `BsHeading` (Bootstrap-compatible heading typography H1 to H6)
 * **New Helpers**:
   - `BsVStack` & `BsHStack` (Vertical/Horizontal layout stacks with gap spacing)
   - `BsRatio` (Aspect ratio utility)
   - `BsVerticalRule` (Vertical divider rules)
   - `BsLink` & `BsIconLink` (Colored links and action link components)
 * **New Extensions & Utilities**:
   - `.truncate()` extension on `Text` to truncate text with ellipsis
   - `BsDisplayExtension` (`visible()`, `gone()`, `dNone()`, `opacity()`)
   - `BsAlignmentExtension` (`align()`, `center()`, `alignStart()`, `alignEnd()`, `alignTop()`, `alignBottom()`)
   - `BsSizeExtension` (`w()`, `h()`, `w100()`, `w75()`, `w50()`, `w25()`, `h100()`, `h75()`, `h50()`, `h25()`, `size100()`, `expanded()`)
 * **Documentation**: Complete revamp of all English and German documentation, including screenshot previews for every single component and utility.
 * **README Overhaul**: Redesigned root `README.md` and `README.de.md` with shields.io badges, side-by-side theme previews, and corrected grid system code examples.

## 0.1.3
 * Removed example/ from .pubignore to improve example detection

## 0.1.2
 * **Pub.dev Optimization**: Improved example detection by adding a primary example entry point.
 * **Documentation**: Achieved 100% dartdoc coverage for the public API.
 * **Localization**: Translated all documentation and internal comments from German to English.
 * **Breaking Change/Refactoring**: Renamed `AppButton` to `BsButton` to align with the `Bs` prefix convention.
 * **Consistency**: Standardized naming across the library, examples, and tests.

## 0.1.1
 * Fixed typo in README

## 0.1.0

* Initial release
* BsButton, BsButtonGroup
* BsAlert, BsBadge, BsAccordion
* BsGrid (BsContainer, BsRow, BsCol)
* Bootstrap tokens: colors, spacing, typography, breakpoints
* Dark/Light theme support

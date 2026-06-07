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

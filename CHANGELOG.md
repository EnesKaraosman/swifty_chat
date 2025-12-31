
## 2.0.0

* **BREAKING**: `MessageKind` is now a `sealed class`
  * Enables exhaustive pattern matching with switch expressions
  * Type-safe message handling without null checks
  * Subclasses: `TextMessageKind`, `ImageMessageKind`, `HtmlMessageKind`, `QuickReplyMessageKind`, `CarouselMessageKind`, `CustomMessageKind`
  * Legacy getters preserved for backward compatibility

* **BREAKING**: Models consolidated into main package
  * `swifty_chat_data` package removed - models now in `lib/src/models/`
  * All exports still available from `package:swifty_chat/swifty_chat.dart`
  * No external dependency changes required

* **NEW**: Material 3 Design System Integration
  * Added `Material3ChatTheme` class with full ColorScheme integration
  * Automatic light/dark mode adaptation based on system theme
  * Semantic color tokens for consistent theming
  * Factory constructor `Material3ChatTheme.fromContext(context)` for easy setup

* **NEW**: Responsive Design System
  * Added `ResponsiveBreakpoints` utility class
  * Breakpoints: mobile (<600dp), tablet (600-900dp), desktop (>900dp), largeDesktop (>1200dp)
  * Adaptive padding, spacing, and avatar sizes
  * `MessageCellSizeConfigurator.responsiveConfiguration(context)` for adaptive layouts

* **NEW**: Accessibility Enhancements
  * Added `AccessibilityHelpers` utility class
  * WCAG AA/AAA contrast ratio checking and validation
  * `ensureWCAGAA()` for automatic color adjustment
  * Text scaling support with `getScaledFontSize()`
  * Reduce motion detection with `shouldReduceMotion()`
  * High contrast mode detection

* **NEW**: Animation System
  * Added `ChatAnimations` utility class with flutter_animate integration
  * Motion-aware animations that respect reduce motion settings
  * Entrance animations for incoming/outgoing messages
  * Loading shimmer effects and quick reply pulse animations

* **NEW**: Modern Chat Input Field
  * Completely redesigned `MessageInputField` with Material 3 support
  * Added `ChatInputFieldConfig` for full customization
  * Dark mode compatible with ColorScheme integration
  * Animated send button with scale and opacity transitions
  * Multiline input support
  * Haptic feedback on send
  * Optional attachment button

* **Improved**: Performance Optimizations
  * Added `RepaintBoundary` to all message widgets
  * Added `@immutable` annotations for better tree-shaking
  * Optimized widget rebuilds

* **Improved**: Example Project
  * Added Material 3 Chat demo with color picker
  * Added Accessibility demo with WCAG contrast visualization
  * Added Responsive demo with breakpoint indicators
  * Theme toggle (light/dark/system) support
  * Section headers and feature cards

* **Docs**: Added comprehensive Material3Design.md documentation

* **Platform**: Updated macOS minimum deployment target to 10.15

* **BREAKING**: `swifty_chat_data` package merged into monorepo
  * Data models now included in `packages/swifty_chat_data/`
  * No longer depends on external pub.dev package
  * Version 2.0.0+ uses local path dependency
  * Previous pub.dev package (swifty_chat_data ^0.1.1) is now deprecated

## 1.9.0

* **Fixed**: Critical memory leaks
  * Added proper disposal for TextEditingController in ChatInputField
  * Added proper disposal for FocusNode in ChatInputField
  * Added proper disposal for ScrollController in Chat widget
  * Moved FocusNode from inline creation to class field to prevent recreation on every build
* **Added**: Comprehensive accessibility support
  * Added Semantics wrappers to all message widgets (Text, Image, HTML, QuickReply, Carousel)
  * Implemented screen reader labels with user names and timestamps
  * Added semantic labels for interactive elements (buttons, input fields)
  * Added semantic labels for ListView with "Chat messages"
* **Improved**: Image message handling
  * Added loading states with CircularProgressIndicator for images
  * Added error handling with fallback UI for failed image loads
  * Implemented progress tracking during image loading
* **Improved**: ListView performance
  * Added cacheExtent parameter for better scrolling performance
* **Fixed**: Test suite updated for API changes
  * Updated tests to work with new scrollToBottom() state method
  * Fixed hit-testing warnings in message tap tests

## 1.8.0

* chore(deps): upgrade dependencies
 	* carousel_slider to ^5.1.1
 	* jiffy to ^6.4.3
 	* url_launcher to ^6.3.2
* chore: Removed CocoaPods files from example/ios (Podfile, Podfile.lock)

## 1.7.1

* chore(deps): upgrade deps

## 1.7.0

* chore(deps): upgrade flutter and android gradle deps

## 1.6.5

* fix: resolve flutter 3.22.1 issues

## 1.6.5

* ci: add auto tag workflow
* chore: upgrade internal dependencies

## 1.6.4

* chore: resolve several lint issues

## 1.6.3

* chore: resolve several lint issues

## 1.6.2

* chore: upgrade internal dependencies

## 1.6.1

* fix: remove .md extension from LICENSE file to allow pub.dev publishing

## 1.6.0

* refactor: replace timeago package with jiffy
* feat: upgrade to dart 3 syntax
* chore: improve internal dart code based on best practices
* fix: resolve several lint issues

## 1.5.0

* Feat: integrate timeago package to present message dates

## 1.4.1

* Update swifty_chat_data package and dart version
* Fix several lint issues

## 1.4.0

* Fix several lint issues

## 1.3.0

* Update dart version to 2.17
* Update carousel_slider version to 4.1.1
* Update flutter_lints version to 2.0.1

## 1.2.0

* [ADD] macOS & web support added (to example project)
* [UPG] Internal dependency packages updated.

## 1.1.0

* Some new theming options added & Carousel UI updated a bit.
* Internal dependency packages updated.

## 1.0.0

* Initial version, see what this package can do for you in [README.md](README.md)

# Material 3 Design Integration

This document describes the Material 3 design integration and modernization features in swifty_chat.

## Overview

Starting from version 2.0.0, swifty_chat fully supports Material 3 (Material You) design principles, including:

- **ColorScheme Integration**: Automatic color adaptation based on Flutter's Material 3 color system
- **Dynamic Theming**: Support for platform brightness detection (light/dark mode)
- **Responsive Design**: Built-in breakpoint system for mobile, tablet, and desktop layouts
- **Accessibility Enhancements**: WCAG compliance helpers and text scaling support
- **Performance Optimizations**: RepaintBoundary, const constructors, and optimized list rendering

## Material 3 Chat Theme

### Basic Usage

The easiest way to use Material 3 theming is with the context-based factory:

```dart
import 'package:swifty_chat/swifty_chat.dart';

Chat(
  messages: messages,
  theme: Material3ChatTheme.fromContext(context),
  chatMessageInputField: MessageInputField(...),
)
```

This automatically picks up the `ColorScheme` and `TextTheme` from your app's `ThemeData`.

### Custom Material 3 Theme

For more control, create a custom theme:

```dart
final customTheme = Material3ChatTheme(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.purple,
    brightness: Brightness.light,
  ),
  textTheme: Theme.of(context).textTheme,
  messageBorderRadiusValue: 16.0,
  textMessagePaddingValue: 16.0,
  messageInsetValue: const EdgeInsets.symmetric(vertical: 12),
);

Chat(
  messages: messages,
  theme: customTheme,
  chatMessageInputField: MessageInputField(...),
)
```

### Theme Properties

| Property | Description |
|----------|-------------|
| `colorScheme` | Material 3 ColorScheme for semantic colors |
| `textTheme` | Typography scale from ThemeData |
| `messageBorderRadiusValue` | Border radius for message bubbles |
| `textMessagePaddingValue` | Padding inside text messages |
| `messageInsetValue` | Vertical spacing between messages |

### Color Mapping

The Material 3 theme maps colors as follows:

| Chat Element | ColorScheme Property |
|--------------|---------------------|
| Background | `surface` |
| Outgoing message bubble | `primaryContainer` |
| Outgoing message text | `onPrimaryContainer` |
| Incoming message bubble | `secondaryContainer` |
| Incoming message text | `onSecondaryContainer` |
| Quick reply buttons | `tertiaryContainer` |
| Carousel background | `surfaceContainerHighest` |

## Responsive Design

### Breakpoint System

Use the `ResponsiveBreakpoints` utility for adaptive layouts:

```dart
import 'package:swifty_chat/swifty_chat.dart';

// Check screen size category
if (ResponsiveBreakpoints.isMobile(context)) {
  // Mobile layout
} else if (ResponsiveBreakpoints.isTablet(context)) {
  // Tablet layout
} else if (ResponsiveBreakpoints.isDesktop(context)) {
  // Desktop layout
}

// Get adaptive values
final padding = ResponsiveBreakpoints.getAdaptivePadding(context);
final spacing = ResponsiveBreakpoints.getAdaptiveSpacing(context);
final avatarSize = ResponsiveBreakpoints.getAdaptiveAvatarSize(context);
```

### Breakpoint Values

| Category | Width Range |
|----------|------------|
| Mobile | < 600dp |
| Tablet | 600dp - 900dp |
| Desktop | 900dp - 1200dp |
| Large Desktop | >= 1200dp |

### Responsive Size Configuration

Use responsive message sizing:

```dart
Chat(
  messages: messages,
  messageCellSizeConfigurator: 
      MessageCellSizeConfigurator.responsiveConfiguration(context),
  chatMessageInputField: MessageInputField(...),
)
```

This automatically adjusts image and carousel sizes based on screen size:

| Screen Size | Image Width | Carousel Height |
|-------------|------------|-----------------|
| Mobile | 85% | 50% |
| Tablet | 75% | 45% |
| Desktop | 60% | 40% |

## Accessibility

### Text Scaling

The library respects user text size preferences:

```dart
// Get the current text scaler
final textScaler = AccessibilityHelpers.getTextScaler(context);

// Scale a font size
final scaledSize = AccessibilityHelpers.getScaledFontSize(context, 16.0);
```

### WCAG Contrast Checking

Validate color contrast for accessibility compliance:

```dart
// Check if colors meet WCAG AA standard (4.5:1 ratio)
final meetsAA = AccessibilityHelpers.meetsWCAGAA(foreground, background);

// Check WCAG AAA standard (7:1 ratio)
final meetsAAA = AccessibilityHelpers.meetsWCAGAAA(foreground, background);

// Get the exact contrast ratio
final ratio = AccessibilityHelpers.getContrastRatio(foreground, background);

// Auto-adjust a color to meet WCAG AA
final adjustedColor = AccessibilityHelpers.ensureWCAGAA(foreground, background);
```

### Accessibility Detection

Detect user accessibility preferences:

```dart
// Check if high contrast mode is enabled
final highContrast = AccessibilityHelpers.isHighContrastMode(context);

// Check if reduce motion is enabled
final reduceMotion = AccessibilityHelpers.shouldReduceMotion(context);

// Check if bold text is enabled
final boldText = AccessibilityHelpers.isBoldTextEnabled(context);
```

### Semantic Labels

All message widgets include proper semantic labels for screen readers:

- Text messages: "Sent/Received message from [user] at [time]: [message]"
- Image messages: "Image message from [user] at [time]"
- Quick reply buttons: "Quick reply: [text]. Double tap to send."
- Carousel: "Carousel with [n] items"

## Performance Optimizations

### RepaintBoundary

All message widgets are wrapped in `RepaintBoundary` to isolate repaints and improve scrolling performance.

### Const Constructors

Message widgets use `const` constructors and are marked with `@immutable` for better tree-shaking and rebuild optimization.

### List Performance

The message list uses:
- `cacheExtent` for pre-rendering off-screen items
- Efficient keys for item identification
- Optimized scroll physics

## Animation System

### Motion-Aware Animations

Animations automatically respect the user's "reduce motion" preference:

```dart
import 'package:swifty_chat/swifty_chat.dart';

// Get entrance animations (simplified if reduce motion is enabled)
final animations = ChatAnimations.incomingMessageAnimation(context);

// Apply with flutter_animate
child.animate(effects: animations);
```

### Available Animations

| Animation | Description |
|-----------|-------------|
| `incomingMessageAnimation` | Slide from left with fade |
| `outgoingMessageAnimation` | Slide from right with fade |
| `loadingShimmerAnimation` | Shimmer effect for loading states |
| `quickReplyPulseAnimation` | Subtle pulse for quick reply buttons |
| `imageLoadAnimation` | Fade and scale for image loading |

## Migration from DefaultChatTheme

To migrate from the legacy theme system:

### Before (Legacy)
```dart
Chat(
  messages: messages,
  theme: const DefaultChatTheme(),
  chatMessageInputField: MessageInputField(...),
)
```

### After (Material 3)
```dart
Chat(
  messages: messages,
  theme: Material3ChatTheme.fromContext(context),
  chatMessageInputField: MessageInputField(...),
)
```

The legacy `DefaultChatTheme` and `DarkChatTheme` continue to work for backward compatibility.

## Best Practices

1. **Use Material 3 Theme**: Prefer `Material3ChatTheme.fromContext(context)` for automatic theming
2. **Enable useMaterial3**: Set `useMaterial3: true` in your `ThemeData`
3. **Use Responsive Configuration**: Use `MessageCellSizeConfigurator.responsiveConfiguration(context)` for adaptive layouts
4. **Test Accessibility**: Use `AccessibilityHelpers` to validate contrast ratios
5. **Respect User Preferences**: The library automatically handles text scaling and reduce motion preferences

## Example

See [example/lib/material3_example.dart](example/lib/material3_example.dart) for a complete working example demonstrating all these features.

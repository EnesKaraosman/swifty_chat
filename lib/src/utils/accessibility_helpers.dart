import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Accessibility utilities for WCAG compliance and improved user experience
final class AccessibilityHelpers {
  const AccessibilityHelpers._();

  /// Returns text scaler from context for responsive text sizing
  /// This respects user's accessibility text size preferences
  static TextScaler getTextScaler(BuildContext context) {
    return MediaQuery.textScalerOf(context);
  }

  /// Applies text scaling to a font size
  static double getScaledFontSize(BuildContext context, double fontSize) {
    return MediaQuery.textScalerOf(context).scale(fontSize);
  }

  /// Calculates relative luminance of a color (0.0 - 1.0)
  /// Used for contrast ratio calculations
  static double getRelativeLuminance(Color color) {
    return color.computeLuminance();
  }

  /// Calculates contrast ratio between two colors
  /// Returns a value between 1 and 21
  /// WCAG AA requires 4.5:1 for normal text, 3:1 for large text
  /// WCAG AAA requires 7:1 for normal text, 4.5:1 for large text
  static double getContrastRatio(Color foreground, Color background) {
    final l1 = getRelativeLuminance(foreground);
    final l2 = getRelativeLuminance(background);
    final lighter = math.max(l1, l2);
    final darker = math.min(l1, l2);
    return (lighter + 0.05) / (darker + 0.05);
  }

  /// Checks if color combination meets WCAG AA standard (4.5:1)
  static bool meetsWCAGAA(Color foreground, Color background) {
    return getContrastRatio(foreground, background) >= 4.5;
  }

  /// Checks if color combination meets WCAG AAA standard (7:1)
  static bool meetsWCAGAAA(Color foreground, Color background) {
    return getContrastRatio(foreground, background) >= 7.0;
  }

  /// Checks if color combination meets WCAG AA standard for large text (3:1)
  static bool meetsWCAGAALargeText(Color foreground, Color background) {
    return getContrastRatio(foreground, background) >= 3.0;
  }

  /// Adjusts foreground color to meet WCAG AA contrast requirements
  /// Returns a darker or lighter version of the color if needed
  static Color ensureWCAGAA(Color foreground, Color background) {
    if (meetsWCAGAA(foreground, background)) {
      return foreground;
    }

    // Try darkening or lightening the foreground color
    final bgLuminance = getRelativeLuminance(background);
    final HSLColor hsl = HSLColor.fromColor(foreground);

    // If background is dark, lighten foreground; if light, darken foreground
    final step = bgLuminance > 0.5 ? -0.05 : 0.05;
    HSLColor adjusted = hsl;

    for (int i = 0; i < 20; i++) {
      adjusted = adjusted.withLightness(
        (adjusted.lightness + step).clamp(0.0, 1.0),
      );
      if (meetsWCAGAA(adjusted.toColor(), background)) {
        return adjusted.toColor();
      }
    }

    // Fallback to black or white
    return bgLuminance > 0.5 ? Colors.black : Colors.white;
  }

  /// Returns whether high contrast mode is enabled
  static bool isHighContrastMode(BuildContext context) {
    return MediaQuery.highContrastOf(context);
  }

  /// Returns whether reduce motion is enabled (for accessibility)
  static bool shouldReduceMotion(BuildContext context) {
    return MediaQuery.disableAnimationsOf(context);
  }

  /// Returns whether bold text is enabled
  static bool isBoldTextEnabled(BuildContext context) {
    return MediaQuery.boldTextOf(context);
  }

  /// Returns minimum touch target size (48x48 dp for Material Design)
  static const double minimumTouchTargetSize = 48.0;

  /// Ensures a widget meets minimum touch target size
  static Widget ensureTouchTarget({
    required Widget child,
    double minSize = minimumTouchTargetSize,
  }) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: minSize,
        minHeight: minSize,
      ),
      child: child,
    );
  }

  /// Creates a semantics label for a message with timestamp
  static String createMessageSemanticLabel({
    required String userName,
    required String message,
    required String timestamp,
    required bool isOutgoing,
  }) {
    final direction = isOutgoing ? 'Sent' : 'Received';
    return '$direction message from $userName at $timestamp: $message';
  }

  /// Creates a semantics label for a quick reply button
  static String createQuickReplySemanticLabel(String text) {
    return 'Quick reply: $text. Double tap to send.';
  }

  /// Creates a semantics label for an image message
  static String createImageSemanticLabel({
    required String userName,
    required String timestamp,
    String? caption,
  }) {
    final baseLabel = 'Image message from $userName at $timestamp';
    return caption != null ? '$baseLabel. Caption: $caption' : baseLabel;
  }
}

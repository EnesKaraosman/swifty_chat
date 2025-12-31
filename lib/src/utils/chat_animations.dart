import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'accessibility_helpers.dart';

/// Animation configurations and helpers for chat UI
final class ChatAnimations {
  const ChatAnimations._();

  /// Default animation duration for message entrance
  static const Duration messageEntranceDuration = Duration(milliseconds: 300);

  /// Default animation curve
  static const Curve messageEntranceCurve = Curves.easeOutCubic;

  /// Stagger delay between messages
  static const Duration messageStaggerDelay = Duration(milliseconds: 50);

  /// Creates an entrance animation for incoming messages
  /// Respects reduce motion accessibility setting
  static List<Effect> incomingMessageAnimation(BuildContext context) {
    if (AccessibilityHelpers.shouldReduceMotion(context)) {
      return [
        const FadeEffect(
          duration: Duration(milliseconds: 150),
          curve: Curves.easeOut,
        ),
      ];
    }

    return [
      const FadeEffect(
        duration: messageEntranceDuration,
        curve: messageEntranceCurve,
      ),
      const SlideEffect(
        begin: Offset(-0.1, 0),
        end: Offset.zero,
        duration: messageEntranceDuration,
        curve: messageEntranceCurve,
      ),
      const ScaleEffect(
        begin: Offset(0.95, 0.95),
        end: Offset(1.0, 1.0),
        duration: messageEntranceDuration,
        curve: messageEntranceCurve,
      ),
    ];
  }

  /// Creates an entrance animation for outgoing messages
  /// Respects reduce motion accessibility setting
  static List<Effect> outgoingMessageAnimation(BuildContext context) {
    if (AccessibilityHelpers.shouldReduceMotion(context)) {
      return [
        const FadeEffect(
          duration: Duration(milliseconds: 150),
          curve: Curves.easeOut,
        ),
      ];
    }

    return [
      const FadeEffect(
        duration: messageEntranceDuration,
        curve: messageEntranceCurve,
      ),
      const SlideEffect(
        begin: Offset(0.1, 0),
        end: Offset.zero,
        duration: messageEntranceDuration,
        curve: messageEntranceCurve,
      ),
      const ScaleEffect(
        begin: Offset(0.95, 0.95),
        end: Offset(1.0, 1.0),
        duration: messageEntranceDuration,
        curve: messageEntranceCurve,
      ),
    ];
  }

  /// Creates a shimmer effect for loading states
  static List<Effect> loadingShimmerAnimation(BuildContext context) {
    if (AccessibilityHelpers.shouldReduceMotion(context)) {
      return const [];
    }

    return [
      const ShimmerEffect(
        duration: Duration(milliseconds: 1500),
        color: Colors.white54,
      ),
    ];
  }

  /// Creates a subtle pulse animation for quick reply buttons
  static List<Effect> quickReplyPulseAnimation(BuildContext context) {
    if (AccessibilityHelpers.shouldReduceMotion(context)) {
      return const [];
    }

    return [
      const ScaleEffect(
        begin: Offset(1.0, 1.0),
        end: Offset(1.02, 1.02),
        duration: Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      ),
    ];
  }

  /// Creates a smooth transition for image loading
  static List<Effect> imageLoadAnimation(BuildContext context) {
    if (AccessibilityHelpers.shouldReduceMotion(context)) {
      return [
        const FadeEffect(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeOut,
        ),
      ];
    }

    return [
      const FadeEffect(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      ),
      const ScaleEffect(
        begin: Offset(0.98, 0.98),
        end: Offset(1.0, 1.0),
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      ),
    ];
  }

  /// Creates a smooth scroll animation controller
  static AnimationController createScrollController(
    TickerProvider vsync, {
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return AnimationController(
      vsync: vsync,
      duration: duration,
    );
  }

  /// Applies staggered animation delay based on index
  static Duration getStaggerDelay(int index) {
    return messageStaggerDelay * index;
  }
}

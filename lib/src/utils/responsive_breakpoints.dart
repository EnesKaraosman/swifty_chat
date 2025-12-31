import 'package:flutter/material.dart';

/// Responsive breakpoints for adaptive layouts
/// Follows common breakpoint standards for mobile, tablet, and desktop
final class ResponsiveBreakpoints {
  const ResponsiveBreakpoints._();

  /// Mobile breakpoint (< 600dp)
  static const double mobile = 600.0;

  /// Tablet breakpoint (600dp - 900dp)
  static const double tablet = 900.0;

  /// Desktop breakpoint (>= 900dp)
  static const double desktop = 1200.0;

  /// Returns true if the screen width is in mobile range (< 600dp)
  static bool isMobile(BuildContext context) {
    return MediaQuery.sizeOf(context).width < mobile;
  }

  /// Returns true if the screen width is in tablet range (600dp - 900dp)
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= mobile && width < tablet;
  }

  /// Returns true if the screen width is in desktop range (>= 900dp)
  static bool isDesktop(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= tablet;
  }

  /// Returns true if the screen width is in large desktop range (>= 1200dp)
  static bool isLargeDesktop(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= desktop;
  }

  /// Returns the current screen size category
  static ScreenSize getScreenSize(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < mobile) return ScreenSize.mobile;
    if (width < tablet) return ScreenSize.tablet;
    if (width < desktop) return ScreenSize.desktop;
    return ScreenSize.largeDesktop;
  }

  /// Returns responsive padding based on screen size
  static EdgeInsets getAdaptivePadding(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.all(8.0);
    } else if (isTablet(context)) {
      return const EdgeInsets.all(12.0);
    } else {
      return const EdgeInsets.all(16.0);
    }
  }

  /// Returns responsive spacing value based on screen size
  static double getAdaptiveSpacing(BuildContext context) {
    if (isMobile(context)) {
      return 8.0;
    } else if (isTablet(context)) {
      return 12.0;
    } else {
      return 16.0;
    }
  }

  /// Returns responsive avatar size based on screen size
  static double getAdaptiveAvatarSize(BuildContext context) {
    if (isMobile(context)) {
      return 36.0;
    } else if (isTablet(context)) {
      return 40.0;
    } else {
      return 44.0;
    }
  }

  /// Returns responsive font size multiplier based on screen size
  static double getFontSizeMultiplier(BuildContext context) {
    if (isMobile(context)) {
      return 1.0;
    } else if (isTablet(context)) {
      return 1.1;
    } else {
      return 1.15;
    }
  }
}

/// Screen size categories
enum ScreenSize {
  mobile,
  tablet,
  desktop,
  largeDesktop,
}

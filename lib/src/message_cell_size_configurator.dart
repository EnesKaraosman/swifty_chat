import 'package:flutter/material.dart';
import 'utils/responsive_breakpoints.dart';

typedef MaxWidthConfiguration = double Function(double parentWidth);
typedef MaxHeightConfiguration = double Function(double parentHeight);

/// Configures the maximum width and height for different message cell types
/// with support for responsive breakpoints.
final class MessageCellSizeConfigurator {
  const MessageCellSizeConfigurator({
    required this.imageCellMaxWidthConfiguration,
    required this.carouselCellMaxHeightConfiguration,
  });

  final MaxWidthConfiguration imageCellMaxWidthConfiguration;

  final MaxHeightConfiguration carouselCellMaxHeightConfiguration;

  /// Creates a default configuration with responsive breakpoints
  factory MessageCellSizeConfigurator.defaultConfiguration() {
    return MessageCellSizeConfigurator(
      imageCellMaxWidthConfiguration: (parentWidth) => parentWidth * 0.7,
      carouselCellMaxHeightConfiguration: (parentHeight) => parentHeight * 0.5,
    );
  }

  /// Creates a responsive configuration that adapts to screen size
  /// Mobile: 85% width, Tablet: 75% width, Desktop: 60% width
  factory MessageCellSizeConfigurator.responsiveConfiguration(
    BuildContext context,
  ) {
    final screenSize = ResponsiveBreakpoints.getScreenSize(context);

    double imageWidthMultiplier;
    double carouselHeightMultiplier;

    switch (screenSize) {
      case ScreenSize.mobile:
        imageWidthMultiplier = 0.85;
        carouselHeightMultiplier = 0.5;
        break;
      case ScreenSize.tablet:
        imageWidthMultiplier = 0.75;
        carouselHeightMultiplier = 0.45;
        break;
      case ScreenSize.desktop:
      case ScreenSize.largeDesktop:
        imageWidthMultiplier = 0.60;
        carouselHeightMultiplier = 0.40;
        break;
    }

    return MessageCellSizeConfigurator(
      imageCellMaxWidthConfiguration: (parentWidth) =>
          parentWidth * imageWidthMultiplier,
      carouselCellMaxHeightConfiguration: (parentHeight) =>
          parentHeight * carouselHeightMultiplier,
    );
  }
}

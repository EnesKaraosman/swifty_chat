import 'dart:ui';

typedef MaxWidthConfiguration = double Function(double parentWidth);
typedef MaxHeightConfiguration = double Function(double parentHeight);
typedef SizeConfiguration = Size Function(Size parentSize);

class MessageCellSizeConfigurator {

  final MaxWidthConfiguration imageCellMaxWidthConfiguration;
  final MaxHeightConfiguration carouselCellMaxHeightConfiguration;

  MessageCellSizeConfigurator({
    required this.imageCellMaxWidthConfiguration,
    required this.carouselCellMaxHeightConfiguration,
  });

  static MessageCellSizeConfigurator defaultConfiguration = MessageCellSizeConfigurator(
    imageCellMaxWidthConfiguration: (parentWidth) => parentWidth * 0.7,
    carouselCellMaxHeightConfiguration: (parentHeight) => parentHeight * 0.5
  );
}
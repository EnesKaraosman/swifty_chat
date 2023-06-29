typedef MaxWidthConfiguration = double Function(double parentWidth);
typedef MaxHeightConfiguration = double Function(double parentHeight);

final class MessageCellSizeConfigurator {
  const MessageCellSizeConfigurator({
    required this.imageCellMaxWidthConfiguration,
    required this.carouselCellMaxHeightConfiguration,
  });

  final MaxWidthConfiguration imageCellMaxWidthConfiguration;

  final MaxHeightConfiguration carouselCellMaxHeightConfiguration;

  factory MessageCellSizeConfigurator.defaultConfiguration() {
    return MessageCellSizeConfigurator(
      imageCellMaxWidthConfiguration: (parentWidth) => parentWidth * 0.7,
      carouselCellMaxHeightConfiguration: (parentHeight) => parentHeight * 0.5,
    );
  }
}

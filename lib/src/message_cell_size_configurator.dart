typedef ImageCellMaxWidthConfiguration = double Function(double parentSize);

class MessageCellSizeConfigurator {

  final ImageCellMaxWidthConfiguration imageCellMaxWidthConfiguration;

  MessageCellSizeConfigurator({
    required this.imageCellMaxWidthConfiguration
  });

  static MessageCellSizeConfigurator defaultConfiguration = MessageCellSizeConfigurator(
    imageCellMaxWidthConfiguration: (parentWidth) => parentWidth * 0.7
  );
}
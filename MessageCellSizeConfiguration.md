# swifty_chat

### Message Cell Size Configuration

Visit the `MessageCellSizeConfiguration` [class](lib/src/message_cell_size_configurator.dart) file. 

#### ImageCell
Here below you see an example of how you can configure the maximum width of message type MessageKind.image & MessageKind.carousel (item) cell.
`parentWidth` is the availableWidth it's given by the package itself, so you can do customization here.

```dart
MessageCellSizeConfigurator(
    imageCellMaxWidthConfiguration: (parentWidth) => parentWidth * 0.7,
    carouselCellMaxHeightConfiguration: (parentHeight) => parentWidth * 0.5
);
```

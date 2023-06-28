import 'package:swifty_chat_data/swifty_chat_data.dart';

class MockCarouselItem extends CarouselItem {
  const MockCarouselItem({
    required super.title,
    required super.subtitle,
    super.imageProvider,
    super.buttons,
  });
}

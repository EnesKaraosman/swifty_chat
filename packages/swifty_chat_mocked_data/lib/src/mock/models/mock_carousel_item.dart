import 'package:swifty_chat/swifty_chat.dart';

class MockCarouselItem extends CarouselItem {
  const MockCarouselItem({
    required super.title,
    required super.subtitle,
    super.imageProvider,
    super.buttons,
  });
}

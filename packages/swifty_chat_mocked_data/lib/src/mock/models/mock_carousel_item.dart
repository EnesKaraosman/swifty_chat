import 'package:flutter/cupertino.dart';
import 'package:swifty_chat_data/swifty_chat_data.dart';

class MockCarouselItem extends CarouselItem {
  final String title;
  final String subtitle;
  final ImageProvider? imageProvider;
  final List<CarouselButtonItem> buttons;

  const MockCarouselItem({
    required this.title,
    required this.subtitle,
    this.imageProvider,
    this.buttons = const [],
  }) : super(
          title: title,
          subtitle: subtitle,
          buttons: buttons,
          imageProvider: imageProvider,
        );
}

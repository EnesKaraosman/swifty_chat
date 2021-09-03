import 'package:swifty_chat/swifty_chat.dart';

class EKCarouselItem extends CarouselItem {
  final String title;
  final String subtitle;
  final String? imageURL;
  final List<CarouselButtonItem> buttons;

  const EKCarouselItem({
    required this.title,
    required this.subtitle,
    this.imageURL,
    this.buttons = const [],
  }) : super(
            title: title,
            subtitle: subtitle,
            buttons: buttons,
            imageURL: imageURL);
}

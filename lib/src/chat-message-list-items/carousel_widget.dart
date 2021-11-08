import 'package:carousel_slider/carousel_slider.dart';
import 'package:dart_extensions/dart_extensions.dart' hide Message;
import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:swifty_chat_data/swifty_chat_data.dart';

import '../chat.dart';
import '../extensions/theme_context.dart';
import '../protocols/has_avatar.dart';

class CarouselWidget extends StatelessWidget with HasAvatar {
  final Message chatMessage;

  const CarouselWidget(this.chatMessage);

  List<CarouselItem> get items => message.messageKind.carouselItems;

  @override
  Message get message => chatMessage;

  @override
  Widget build(BuildContext context) => CarouselSlider.builder(
        itemCount: items.length,
        itemBuilder: (context, index, _) =>
            _carouselItem(context, items[index]),
        options: CarouselOptions(
          height: _carouselItemHeight(context),
          disableCenter: true,
          enableInfiniteScroll: false,
        ),
      );

  Widget _carouselItem(BuildContext context, CarouselItem item) => Container(
        decoration: context.theme.carouselBoxDecoration,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (item.imageProvider != null)
              Flexible(
                child: Image(
                  image: item.imageProvider!,
                ),
              ),
            Text(
              item.title,
              style: context.theme.carouselTitleTextStyle,
            ).padding(all: context.theme.textMessagePadding),
            Text(
              item.subtitle,
              style: context.theme.carouselSubtitleTextStyle,
              textAlign: TextAlign.center,
            ).padding(all: context.theme.textMessagePadding),
            Wrap(
              children: item.buttons
                  .map(
                    (button) => ElevatedButton(
                      onPressed: () => ChatStateContainer.of(context)
                          .onCarouselButtonItemPressed
                          ?.call(button),
                      style: context.theme.carouselButtonStyle,
                      child: Text(button.title),
                    ),
                  )
                  .toList(),
            ).padding(all: 8),
          ],
        ),
      );

  double _carouselItemHeight(BuildContext context) {
    final height = ChatStateContainer.of(context)
        .messageCellSizeConfigurator
        .carouselCellMaxHeightConfiguration(context.mq.size.height);
    return height;
  }
}

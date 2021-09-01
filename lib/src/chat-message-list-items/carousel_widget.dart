import 'dart:math';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dart_extensions/dart_extensions.dart' hide Message;
import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../chat.dart';
import '../models/carousel_item.dart';
import '../models/message.dart';
import '../protocols/has_avatar.dart';

class CarouselWidget extends StatelessWidget with HasAvatar {
  final Message chatMessage;

  const CarouselWidget({
    required this.chatMessage,
  });

  List<CarouselItem> get items => chatMessage.messageKind.carouselItems;

  @override
  Message get message => chatMessage;

  @override
  Widget build(BuildContext context) =>
      CarouselSlider.builder(
        itemCount: items.length,
        itemBuilder: (context, index, _) => _carouselItem(context, items[index]),
        options: CarouselOptions(
          height: _carouselItemHeight(context),
          disableCenter: true,
          enableInfiniteScroll: false,
        ),
      );

  Widget _carouselItem(BuildContext context, CarouselItem item) =>
      Container(
        color: Colors.grey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (item.imageURL != null)
              Image.network(
                item.imageURL!,
              ).flexible(),
            Text(
              item.title,
              style: Theme
                  .of(context)
                  .textTheme
                  .headline6,
            ).padding(all: 8),
            Text(
              item.subtitle,
              style: Theme
                  .of(context)
                  .textTheme
                  .subtitle2,
            ).padding(all: 8),
            Wrap(
              children: item.buttons
                  .map(
                    (button) =>
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(button.title),
                    ),
              )
                  .toList(),
            ).padding(all: 8),
          ],
        ),
      );

  double _carouselItemHeight(BuildContext context) {
    final height = ChatStateContainer
        .of(context)
        .messageCellSizeConfigurator
        .carouselCellMaxHeightConfiguration(context.mq.size.height);
    return height;
  }
}

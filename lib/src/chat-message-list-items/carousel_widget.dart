import 'dart:math';

import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

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
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270,
      child: ListView(
        // This next line does the trick.
        scrollDirection: Axis.horizontal,
        children: items.map(carouselItem).toList(),
      ),
    );
  }

  Widget carouselItem(CarouselItem item) => Container(
        width: 200.0,
        color: Colors.redAccent.withOpacity(Random().nextDouble()),
        child: Column(
          children: [
            if (item.imageURL != null) Image.network(item.imageURL!).flexible(),
            Text(item.title),
            Text(item.subtitle),
            Wrap(
              children: item.buttons
                  .map(
                    (button) => ElevatedButton(
                      onPressed: () {},
                      child: Text(button.title),
                    ),
                  )
                  .toList(),
            )
          ],
        ),
      );
}

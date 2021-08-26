import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/flutter_chat.dart';
import 'package:styled_widget/styled_widget.dart';

import '../models/message.dart';

class CarouselWidget extends StatelessWidget {
  final Message chatMessage;

  const CarouselWidget({
    required this.chatMessage,
  });

  List<CarouselItem> get items => chatMessage.messageKind.carouselItems;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      child: ListView(
        // This next line does the trick.
        scrollDirection: Axis.horizontal,
        children: items
            .map(
              (item) => Container(
                width: 200.0,
                color: Colors.redAccent.withOpacity(Random().nextDouble()),
                child: Column(
                  children: [
                    if (item.imageURL != null)
                      Image.network(item.imageURL!).flexible(),
                    Text(item.title),
                    Text(item.subtitle),
                    Wrap(
                      children: item.buttons.map(
                        (button) => ElevatedButton(
                          onPressed: () {},
                          child: Text(button.title),
                        ),
                      ).toList(),
                    )
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

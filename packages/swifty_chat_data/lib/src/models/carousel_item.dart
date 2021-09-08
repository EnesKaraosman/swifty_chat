import 'package:flutter/cupertino.dart';

/// Represents the data for a carousel.
abstract class CarouselItem {
  final String title;
  final String subtitle;
  final String? imageURL;
  final List<CarouselButtonItem> buttons;

  const CarouselItem({
    required this.title,
    required this.subtitle,
    this.imageURL,
    this.buttons = const [],
  });
}

class CarouselButtonItem {
  final id = UniqueKey();
  final String title;
  final String? url;
  final String? payload;

  CarouselButtonItem({
    required this.title,
    required this.url,
    required this.payload,
  });
}
import 'package:flutter/material.dart';

/// Represents the data for a carousel.
abstract class CarouselItem {
  final String title;
  final String subtitle;
  final ImageProvider? imageProvider;
  final List<CarouselButtonItem> buttons;

  const CarouselItem({
    required this.title,
    required this.subtitle,
    this.imageProvider,
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
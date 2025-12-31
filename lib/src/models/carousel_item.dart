import 'package:flutter/material.dart';

/// Represents the data for a carousel item
abstract class CarouselItem {
  const CarouselItem({
    required this.title,
    required this.subtitle,
    this.imageProvider,
    this.buttons = const [],
  });

  /// Title text of the carousel item
  final String title;

  /// Subtitle text of the carousel item
  final String subtitle;

  /// Optional image for the carousel item
  final ImageProvider? imageProvider;

  /// Action buttons for the carousel item
  final List<CarouselButtonItem> buttons;
}

/// Represents a button within a carousel item
class CarouselButtonItem {
  CarouselButtonItem({
    required this.title,
    required this.url,
    required this.payload,
  });

  /// Unique identifier for the button
  final id = UniqueKey();

  /// Display text of the button
  final String title;

  /// Optional URL to open when button is tapped
  final String? url;

  /// Optional payload data for the button action
  final String? payload;
}

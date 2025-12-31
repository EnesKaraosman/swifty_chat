import 'package:flutter/material.dart';

import 'carousel_item.dart';
import 'quick_reply_item.dart';

/// Represents different types of chat messages using sealed class pattern.
/// This enables exhaustive pattern matching with switch expressions.
///
/// Example usage:
/// ```dart
/// final widget = switch (messageKind) {
///   TextMessageKind(:final text) => Text(text),
///   ImageMessageKind(:final imageProvider) => Image(image: imageProvider),
///   HtmlMessageKind(:final htmlData) => HtmlWidget(htmlData),
///   QuickReplyMessageKind(:final quickReplies) => QuickReplyWidget(quickReplies),
///   CarouselMessageKind(:final carouselItems) => CarouselWidget(carouselItems),
///   CustomMessageKind(:final custom) => CustomWidget(custom),
/// };
/// ```
sealed class MessageKind {
  const MessageKind();

  /// Creates a text message
  factory MessageKind.text(String text) = TextMessageKind;

  /// Creates an image message with an ImageProvider
  factory MessageKind.imageProvider(ImageProvider imageProvider) =
      ImageMessageKind;

  /// Creates an HTML message
  factory MessageKind.html(String htmlData) = HtmlMessageKind;

  /// Creates a quick reply message with options
  factory MessageKind.quickReply(List<QuickReplyItem> quickReplies) =
      QuickReplyMessageKind;

  /// Creates a carousel message with items
  factory MessageKind.carousel(List<CarouselItem> carouselItems) =
      CarouselMessageKind;

  /// Creates a custom message with user-defined content
  factory MessageKind.custom(dynamic custom) = CustomMessageKind;

  // Legacy getters for backward compatibility
  // These allow existing code using messageKind.text to continue working

  /// Text content (only available for TextMessageKind)
  String? get text => null;

  /// Image provider (only available for ImageMessageKind)
  ImageProvider? get imageProvider => null;

  /// HTML data (only available for HtmlMessageKind)
  String? get htmlData => null;

  /// Quick replies (empty list if not QuickReplyMessageKind)
  List<QuickReplyItem> get quickReplies => const [];

  /// Carousel items (empty list if not CarouselMessageKind)
  List<CarouselItem> get carouselItems => const [];

  /// Custom data (only available for CustomMessageKind)
  dynamic get custom => null;
}

/// Text message kind
final class TextMessageKind extends MessageKind {
  const TextMessageKind(this._text);

  final String _text;

  @override
  String get text => _text;

  @override
  String toString() => 'MessageKind.text($_text)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TextMessageKind &&
          runtimeType == other.runtimeType &&
          _text == other._text;

  @override
  int get hashCode => _text.hashCode;
}

/// Image message kind
final class ImageMessageKind extends MessageKind {
  const ImageMessageKind(this._imageProvider);

  final ImageProvider _imageProvider;

  @override
  ImageProvider get imageProvider => _imageProvider;

  @override
  String toString() => 'MessageKind.imageProvider($_imageProvider)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageMessageKind &&
          runtimeType == other.runtimeType &&
          _imageProvider == other._imageProvider;

  @override
  int get hashCode => _imageProvider.hashCode;
}

/// HTML message kind
final class HtmlMessageKind extends MessageKind {
  const HtmlMessageKind(this._htmlData);

  final String _htmlData;

  @override
  String get htmlData => _htmlData;

  @override
  String toString() => 'MessageKind.html($_htmlData)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HtmlMessageKind &&
          runtimeType == other.runtimeType &&
          _htmlData == other._htmlData;

  @override
  int get hashCode => _htmlData.hashCode;
}

/// Quick reply message kind
final class QuickReplyMessageKind extends MessageKind {
  const QuickReplyMessageKind(this._quickReplies);

  final List<QuickReplyItem> _quickReplies;

  @override
  List<QuickReplyItem> get quickReplies => _quickReplies;

  @override
  String toString() => 'MessageKind.quickReply($_quickReplies)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuickReplyMessageKind &&
          runtimeType == other.runtimeType &&
          _quickReplies == other._quickReplies;

  @override
  int get hashCode => _quickReplies.hashCode;
}

/// Carousel message kind
final class CarouselMessageKind extends MessageKind {
  const CarouselMessageKind(this._carouselItems);

  final List<CarouselItem> _carouselItems;

  @override
  List<CarouselItem> get carouselItems => _carouselItems;

  @override
  String toString() => 'MessageKind.carousel($_carouselItems)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CarouselMessageKind &&
          runtimeType == other.runtimeType &&
          _carouselItems == other._carouselItems;

  @override
  int get hashCode => _carouselItems.hashCode;
}

/// Custom message kind for user-defined content
final class CustomMessageKind extends MessageKind {
  const CustomMessageKind(this._custom);

  final dynamic _custom;

  @override
  dynamic get custom => _custom;

  @override
  String toString() => 'MessageKind.custom($_custom)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomMessageKind &&
          runtimeType == other.runtimeType &&
          _custom == other._custom;

  @override
  int get hashCode => _custom.hashCode;
}

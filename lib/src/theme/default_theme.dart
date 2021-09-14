import 'package:flutter/material.dart';
import '../theme/chat_theme.dart';

/// Default chat theme which extends [ChatTheme]
@immutable
class DefaultChatTheme extends ChatTheme {
  const DefaultChatTheme() : super();

  @override
  Color get backgroundColor => NEUTRAL_7;

  @override
  double get messageBorderRadius => 20;

  @override
  double get textMessagePadding => 12;

  @override
  Color get primaryColor => PRIMARY;

  @override
  TextStyle get incomingMessageBodyTextStyle => const TextStyle(
        color: NEUTRAL_0,
        fontFamily: 'Avenir',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.5,
      );

  @override
  TextStyle get outgoingMessageBodyTextStyle => const TextStyle(
        color: NEUTRAL_7,
        fontFamily: 'Avenir',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.5,
      );

  @override
  Color get secondaryColor => SECONDARY;

  @override
  EdgeInsets get messageInset => const EdgeInsets.symmetric(vertical: 8);

  @override
  TextStyle get carouselTitleTextStyle => const TextStyle(
        color: NEUTRAL_0,
        fontSize: 19,
        fontFamily: 'Avenir',
        fontWeight: FontWeight.bold,
      );

  @override
  TextStyle get carouselSubtitleTextStyle => const TextStyle(
        color: NEUTRAL_0,
        fontSize: 16,
        fontFamily: 'Avenir',
      );

  @override
  ButtonStyle get carouselButtonStyle => const ButtonStyle();

  @override
  ButtonStyle get quickReplyButtonStyle => ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(NEUTRAL_2),
        foregroundColor: MaterialStateProperty.all<Color>(NEUTRAL_0),
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(fontWeight: FontWeight.bold),
        ),
      );

  @override
  Color get htmlTextColor => NEUTRAL_0;

  @override
  String? get htmlTextFontFamily => 'Avenir';
}

/// Dark chat theme which extends [ChatTheme]
@immutable
class DarkChatTheme extends ChatTheme {
  const DarkChatTheme() : super();

  @override
  Color get backgroundColor => DARK;

  @override
  double get messageBorderRadius => 20;

  @override
  double get textMessagePadding => 12;

  @override
  Color get primaryColor => PRIMARY;

  @override
  TextStyle get incomingMessageBodyTextStyle => const TextStyle(
        color: NEUTRAL_7,
        fontFamily: 'Avenir',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.5,
      );

  @override
  TextStyle get outgoingMessageBodyTextStyle => const TextStyle(
        color: NEUTRAL_7,
        fontFamily: 'Avenir',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.5,
      );

  @override
  Color get secondaryColor => SECONDARY_DARK;

  @override
  EdgeInsets get messageInset => const EdgeInsets.symmetric(vertical: 8);

  @override
  TextStyle get carouselTitleTextStyle => const TextStyle(
        color: NEUTRAL_7,
        fontSize: 19,
        fontFamily: 'Avenir',
        fontWeight: FontWeight.bold,
      );

  @override
  TextStyle get carouselSubtitleTextStyle => const TextStyle(
        color: NEUTRAL_7,
        fontSize: 19,
        fontFamily: 'Avenir',
      );

  @override
  ButtonStyle get carouselButtonStyle => const ButtonStyle();

  @override
  ButtonStyle get quickReplyButtonStyle => ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(SECONDARY_DARK),
        foregroundColor: MaterialStateProperty.all<Color>(SECONDARY),
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(fontWeight: FontWeight.bold),
        ),
      );

  @override
  Color get htmlTextColor => NEUTRAL_7;

  @override
  String? get htmlTextFontFamily => 'Avenir';
}

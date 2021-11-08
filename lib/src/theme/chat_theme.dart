import 'package:flutter/material.dart';

/// Dark
const dark = Color(0xff1f1c38);

/// N0
const neutral0 = Color(0xff1d1c21);

/// N2
const neutral2 = Color(0xff9e9cab);

/// N7
const neutral7 = Color(0xffffffff);

/// N7 with opacity
const neutral7WithOpacity = Color(0x80ffffff);

/// Primary
const primary = Color(0xff6f61e8);

/// Secondary
const secondary = Color(0xfff5f5f7);

/// Secondary dark
const secondaryDark = Color(0xff2b4250);

/// Base chat theme containing all required properties to make a theme.
/// Extend this class if you want to create a custom theme.
@immutable
abstract class ChatTheme {
  /// Creates a new chat theme based on provided colors and text styles.
  const ChatTheme();

  /// Text padding to it's container
  double get textMessagePadding;

  /// Message inset, can be used to have padding between messages
  EdgeInsets get messageInset;

  /// Used as a background color of a chat widget
  Color get backgroundColor;

  /// Border radius of message container
  double get messageBorderRadius;

  /// Primary color, used as a background of outgoing messages
  Color get primaryColor;

  /// Body text style used for displaying text on different types
  /// of received messages
  TextStyle get incomingMessageBodyTextStyle;

  /// Secondary color, used as a background of incoming messages
  Color get secondaryColor;

  /// Body text style used for displaying text on different types
  /// of sent messages
  TextStyle get outgoingMessageBodyTextStyle;

  // Image Message Styles
  /// Image borderRadius
  BorderRadius get imageBorderRadius;

  // Carousel Message Styles
  /// Carousel container decoration
  BoxDecoration get carouselBoxDecoration;

  /// Title text style used for displaying text on Carousel widget
  TextStyle get carouselTitleTextStyle;

  /// Subtitle text style used for displaying text on Carousel widget
  TextStyle get carouselSubtitleTextStyle;

  /// Button style used on Carousel widget
  ButtonStyle get carouselButtonStyle;

  // Quick Reply Message Style
  /// Button style used on QuickReply widget
  ButtonStyle get quickReplyButtonStyle;

  // HTML Message Style
  /// Color on p, h1, h2, h3, h4, h5 elements.
  Color get htmlTextColor;

  /// FontFamily on p, h1, h2, h3, h4, h5 elements.
  String? get htmlTextFontFamily;
}
import 'package:flutter/material.dart';
import 'package:swifty_chat/src/chat.dart';
import 'package:swifty_chat/src/extensions/theme_context.dart';
import 'package:swifty_chat/src/extensions/timeago_message_context.dart';
import 'package:swifty_chat/src/protocols/has_avatar.dart';
import 'package:swifty_chat/src/protocols/incoming_outgoing_message_widgets.dart';
import 'package:swifty_chat/src/protocols/timeago_settings.dart';
import 'package:swifty_chat_data/swifty_chat_data.dart';

class ImageMessageWidget extends StatelessWidget
    with HasAvatar, IncomingOutgoingMessageWidgets {
  final Message _chatMessage;
  final LocaleType? locale;

  const ImageMessageWidget(this._chatMessage, this.locale);

  @override
  Widget incomingMessageWidget(BuildContext context) => Row(
        crossAxisAlignment: avatarPosition.alignment,
        children: [
          ...avatarWithPadding(),
          imageContainer(context),
        ],
      );

  @override
  Widget outgoingMessageWidget(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: avatarPosition.alignment,
        children: [
          imageContainer(context),
          ...avatarWithPadding(),
        ],
      );

  Widget imageContainer(BuildContext context) {
    final theme = context.theme;
    final lookupMessage = context.lookupMessages;

    final time = timeSettings(message.date, locale, lookupMessage);

    return ClipRRect(
      borderRadius: context.theme.imageBorderRadius,
      child: Stack(
        children: [
          Image(
            width: _imageWidth(context),
            image: message.messageKind.imageProvider!,
          ),
          Positioned(
            right: 10,
            bottom: 2,
            child: Text(
              time,
              style: theme.imageWidgetTextTime,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => message.isMe
      ? outgoingMessageWidget(context)
      : incomingMessageWidget(context);

  double _imageWidth(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return ChatStateContainer.of(context)
        .messageCellSizeConfigurator
        .imageCellMaxWidthConfiguration(screenHeight);
  }

  @override
  Message get message => _chatMessage;
}

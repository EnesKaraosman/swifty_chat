import 'package:flutter/material.dart';
import 'package:swifty_chat/src/chat.dart';
import 'package:swifty_chat/src/extensions/date_extensions.dart';
import 'package:swifty_chat/src/extensions/theme_context.dart';
import 'package:swifty_chat/src/protocols/has_avatar.dart';
import 'package:swifty_chat/src/protocols/incoming_outgoing_message_widgets.dart';
import 'package:swifty_chat_data/swifty_chat_data.dart';

final class ImageMessageWidget extends StatelessWidget
    with HasAvatar, IncomingOutgoingMessageWidgets {
  const ImageMessageWidget(this._chatMessage);

  final Message _chatMessage;

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

    return ClipRRect(
      borderRadius: theme.imageBorderRadius,
      child: Stack(
        children: [
          Image(
            width: _imageWidth(context),
            image: message.messageKind.imageProvider!,
          ),
          Positioned(
            right: 12,
            bottom: 6,
            child: Text(
              message.date.relativeTimeFromNow(),
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
    final screenHeight = MediaQuery.sizeOf(context).width;
    return ChatStateContainer.of(context)
        .messageCellSizeConfigurator
        .imageCellMaxWidthConfiguration(screenHeight);
  }

  @override
  Message get message => _chatMessage;
}

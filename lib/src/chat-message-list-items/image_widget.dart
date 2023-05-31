import 'package:dart_extensions/dart_extensions.dart' hide Message;
import 'package:flutter/material.dart';
import 'package:swifty_chat/src/chat.dart';
import 'package:swifty_chat/src/extensions/theme_context.dart';
import 'package:swifty_chat/src/protocols/has_avatar.dart';
import 'package:swifty_chat/src/protocols/incoming_outgoing_message_widgets.dart';
import 'package:swifty_chat_data/swifty_chat_data.dart';

class ImageMessageWidget extends StatelessWidget
    with HasAvatar, IncomingOutgoingMessageWidgets {
  final Message _chatMessage;

  const ImageMessageWidget(this._chatMessage);

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
    final _theme = context.theme;
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
              "${message.time!.hour}:${message.time!.minute}",
              style: _theme.imageWidgetTextTime,
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
    return ChatStateContainer.of(context)
        .messageCellSizeConfigurator
        .imageCellMaxWidthConfiguration(context.mq.size.width);
  }

  @override
  Message get message => _chatMessage;
}

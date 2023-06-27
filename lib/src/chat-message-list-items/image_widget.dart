import 'package:dart_extensions/dart_extensions.dart' hide Message;
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
    final _theme = context.theme;
    final _lookupmessage = context.lookupMessages;

    final String time = message.time != null
        ? timeSettings(message.time!, locale, _lookupmessage)
        : "";

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

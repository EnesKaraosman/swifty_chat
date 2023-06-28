import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:swifty_chat/src/extensions/date_extensions.dart';
import 'package:swifty_chat/src/extensions/theme_context.dart';
import 'package:swifty_chat/src/protocols/has_avatar.dart';
import 'package:swifty_chat/src/protocols/incoming_outgoing_message_widgets.dart';
import 'package:swifty_chat_data/swifty_chat_data.dart';

class TextMessageWidget extends StatelessWidget
    with HasAvatar, IncomingOutgoingMessageWidgets {
  TextMessageWidget(this._chatMessage);

  final Message _chatMessage;

  @override
  Widget incomingMessageWidget(BuildContext context) => Row(
        crossAxisAlignment: avatarPosition.alignment,
        children: [
          ...avatarWithPadding(),
          textContainer(context),
          const SizedBox(width: 24)
        ],
      );

  @override
  Widget outgoingMessageWidget(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: avatarPosition.alignment,
        children: [
          const SizedBox(width: 24),
          textContainer(context),
          ...avatarWithPadding(),
        ],
      );

  Widget textContainer(BuildContext context) {
    final theme = context.theme;

    final messageBorderRadius = theme.messageBorderRadius;

    final borderRadius = BorderRadius.only(
      bottomLeft: Radius.circular(message.isMe ? messageBorderRadius : 0),
      bottomRight: Radius.circular(message.isMe ? 0 : messageBorderRadius),
      topLeft: Radius.circular(messageBorderRadius),
      topRight: Radius.circular(messageBorderRadius),
    );

    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: message.isMe ? theme.primaryColor : theme.secondaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ClipRRect(
            borderRadius: borderRadius,
            child: Text(
              message.messageKind.text!,
              softWrap: true,
              style: message.isMe
                  ? theme.outgoingMessageBodyTextStyle
                  : theme.incomingMessageBodyTextStyle,
            ).padding(all: theme.textMessagePadding),
          ),
          Padding(
            padding: message.isMe
                ? const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: 5,
                  )
                : const EdgeInsets.only(
                    left: 10,
                    right: 15,
                    bottom: 5,
                  ),
            child: Text(
              message.date.relativeTimeFromNow(),
              style: message.isMe
                  ? theme.outgoingChatTextTime
                  : theme.incomingChatTextTime,
            ),
          ),
        ],
      ),
    ).flexible();
  }

  @override
  Widget build(BuildContext context) => message.isMe
      ? outgoingMessageWidget(context)
      : incomingMessageWidget(context);

  @override
  Message get message => _chatMessage;
}

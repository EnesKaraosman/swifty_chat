import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:swifty_chat/src/extensions/theme_context.dart';
import 'package:swifty_chat/src/protocols/has_avatar.dart';
import 'package:swifty_chat/src/protocols/incoming_outgoing_message_widgets.dart';
import 'package:swifty_chat/src/protocols/timeago_settings.dart';
import 'package:swifty_chat_data/swifty_chat_data.dart';

class TextMessageWidget extends StatelessWidget
    with HasAvatar, IncomingOutgoingMessageWidgets {
  final Message _chatMessage;

  TextMessageWidget(this._chatMessage);

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
    final _theme = context.theme;
    final _messageBorderRadius = _theme.messageBorderRadius;
    final String time = timeSettings(message.time!);

    final _borderRadius = BorderRadius.only(
      bottomLeft: Radius.circular(message.isMe ? _messageBorderRadius : 0),
      bottomRight: Radius.circular(message.isMe ? 0 : _messageBorderRadius),
      topLeft: Radius.circular(_messageBorderRadius),
      topRight: Radius.circular(_messageBorderRadius),
    );
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: _borderRadius,
        color: message.isMe ? _theme.primaryColor : _theme.secondaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ClipRRect(
            borderRadius: _borderRadius,
            child: Text(
              message.messageKind.text!,
              softWrap: true,
              style: message.isMe
                  ? _theme.outgoingMessageBodyTextStyle
                  : _theme.incomingMessageBodyTextStyle,
            ).padding(all: _theme.textMessagePadding),
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
              time,
              style: message.isMe
                  ? _theme.outgoingChatTextTime
                  : _theme.incomingChatTextTime,
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

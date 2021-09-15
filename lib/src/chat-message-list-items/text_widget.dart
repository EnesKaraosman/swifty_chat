import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:swifty_chat_data/swifty_chat_data.dart';

import '../extensions/theme_context.dart';
import '../protocols/has_avatar.dart';
import '../protocols/incoming_outgoing_message_widgets.dart';

class TextMessageWidget extends StatelessWidget
    with HasAvatar, IncomingOutgoingMessageWidgets {
  final Message _chatMessage;

  const TextMessageWidget(this._chatMessage);

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
      child: ClipRRect(
        borderRadius: _borderRadius,
        child: Text(
          message.messageKind.text!,
          softWrap: true,
          style: message.isMe
              ? _theme.outgoingMessageBodyTextStyle
              : _theme.incomingMessageBodyTextStyle,
        ).padding(all: _theme.textMessagePadding),
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

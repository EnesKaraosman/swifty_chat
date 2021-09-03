import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../models/message.dart';
import '../models/user_avatar.dart';
import '../protocols/has_avatar.dart';
import '../protocols/incoming_outgoing_message_widgets.dart';

class TextMessageWidget extends StatelessWidget with HasAvatar, IncomingOutgoingMessageWidgets {
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
    final cardTheme = Theme.of(context).cardTheme;
    return Container(
      padding: EdgeInsets.zero,
      child: Text(
        _chatMessage.messageKind.text!,
        softWrap: true,
        style: Theme.of(context).textTheme.bodyText1,
      ).padding(all: 8).card(color: cardTheme.color, margin: cardTheme.margin),
    ).flexible();
  }

  @override
  Widget build(BuildContext context) =>
      _chatMessage.isMe ? outgoingMessageWidget(context) : incomingMessageWidget(context);

  @override
  Message get message => _chatMessage;
}

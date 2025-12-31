import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import 'chat-message-list-items/carousel_widget.dart';
import 'chat-message-list-items/html_widget.dart';
import 'chat-message-list-items/image_widget.dart';
import 'chat-message-list-items/quick_reply_widget.dart';
import 'chat-message-list-items/text_widget.dart';
import 'chat.dart';
import 'extensions/theme_context.dart';
import 'models/message.dart';
import 'models/message_kind.dart';

final class ChatListItem extends StatelessWidget {
  const ChatListItem({required this.chatMessage});

  final Message chatMessage;

  @override
  Widget build(BuildContext context) => Semantics(
        label: 'Message',
        child: _messageWidget(context).padding(
          top: context.theme.messageInset.top,
          left: context.theme.messageInset.left,
          right: context.theme.messageInset.right,
          bottom: context.theme.messageInset.bottom,
        ),
      );

  Widget _messageWidget(BuildContext context) {
    return switch (chatMessage.messageKind) {
      TextMessageKind() => TextMessageWidget(chatMessage),
      ImageMessageKind() => ImageMessageWidget(chatMessage),
      QuickReplyMessageKind() => QuickReplyWidget(chatMessage),
      HtmlMessageKind() => HTMLWidget(chatMessage),
      CarouselMessageKind() => CarouselWidget(chatMessage),
      CustomMessageKind() =>
        ChatStateContainer.of(context).customMessageWidget?.call(chatMessage) ??
            const Text(
              'You must implement customMessageWidget parameter in case you want to use MessageKind.custom',
            ),
    };
  }
}

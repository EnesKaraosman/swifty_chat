import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:swifty_chat/src/chat-message-list-items/carousel_widget.dart';
import 'package:swifty_chat/src/chat-message-list-items/html_widget.dart';
import 'package:swifty_chat/src/chat-message-list-items/image_widget.dart';
import 'package:swifty_chat/src/chat-message-list-items/quick_reply_widget.dart';
import 'package:swifty_chat/src/chat-message-list-items/text_widget.dart';
import 'package:swifty_chat/src/chat.dart';
import 'package:swifty_chat/src/extensions/theme_context.dart';
import 'package:swifty_chat_data/swifty_chat_data.dart';

class ChatListItem extends StatelessWidget {
  final Message chatMessage;

  const ChatListItem({
    required this.chatMessage,
  });

  @override
  Widget build(BuildContext context) => _messageWidget(context).padding(
        top: context.theme.messageInset.top,
        left: context.theme.messageInset.left,
        right: context.theme.messageInset.right,
        bottom: context.theme.messageInset.bottom,
      );

  Widget _messageWidget(BuildContext context) {
    if (chatMessage.messageKind.text != null) {
      return TextMessageWidget(chatMessage);
    } else if (chatMessage.messageKind.imageProvider != null) {
      return ImageMessageWidget(chatMessage);
    } else if (chatMessage.messageKind.quickReplies.isNotEmpty) {
      return QuickReplyWidget(chatMessage);
    } else if (chatMessage.messageKind.htmlData != null) {
      return HTMLWidget(chatMessage);
    } else if (chatMessage.messageKind.carouselItems.isNotEmpty) {
      return CarouselWidget(chatMessage);
    } else if (chatMessage.messageKind.custom != null) {
      return ChatStateContainer.of(context)
              .customMessageWidget
              ?.call(chatMessage) ??
          // TODO: Throw here!
          const Text(
            'You must implement customMessageWidget parameter in case you want to you MessageKind.custom',
          );
    }
    return const Text('Undetermined MessageKind');
  }
}

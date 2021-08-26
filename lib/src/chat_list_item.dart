import 'package:flutter/material.dart';

import '../src/chat-message-list-items/carousel_widget.dart';
import '../src/chat-message-list-items/html_widget.dart';
import '../src/chat-message-list-items/image_widget.dart';
import '../src/chat-message-list-items/quick_reply_widget.dart';
import '../src/chat-message-list-items/text_widget.dart';
import '../src/models/message.dart';

class ChatListItem extends StatelessWidget {
  final Message chatMessage;

  const ChatListItem({
    required this.chatMessage,
  });

  @override
  Widget build(BuildContext context) => _messageWidget;

  Widget get _messageWidget {
    if (chatMessage.messageKind.text != null) {
      return TextMessageWidget(chatMessage);
    } else if (chatMessage.messageKind.imageURL != null) {
      return ImageMessageWidget(chatMessage);
    } else if (chatMessage.messageKind.quickReplies.isNotEmpty) {
      return QuickReplyWidget(
        chatMessage: chatMessage,
      );
    } else if (chatMessage.messageKind.htmlData != null) {
      return HTMLWidget(
        chatMessage: chatMessage,
      );
    } else if (chatMessage.messageKind.carouselItems.isNotEmpty) {
      return CarouselWidget(
        chatMessage: chatMessage,
      );
    }
    return const Text('Undetermined MessageKind');
  }
}

import 'package:flutter/material.dart';

import '../src/models/message.dart';
import '../src/models/quick_reply_item.dart';
import '../src/chat-message-list-items/text_widget.dart';
import '../src/chat-message-list-items/image_widget.dart';
import '../src/chat-message-list-items/quick_reply_widget.dart';
import '../src/chat-message-list-items/html_widget.dart';

class ChatListItem extends StatelessWidget {
  final Message chatMessage;

  void Function(QuickReplyItem)? _onQuickReplyItemPressed;

  ChatListItem setOnQuickReplyItemPressed(void Function(QuickReplyItem)? fn) {
    _onQuickReplyItemPressed = fn;
    return this;
  }

  ChatListItem({required this.chatMessage});

  @override
  Widget build(BuildContext context) {
    return _messageWidget;
  }

  Widget get _messageWidget {
    if (chatMessage.messageKind.text != null) {
      return TextMessageWidget(chatMessage);
    } else if (chatMessage.messageKind.imageURL != null) {
      return ImageMessageWidget(chatMessage);
    } else if (chatMessage.messageKind.quickReplies.isNotEmpty) {
      return QuickReplyWidget(
        chatMessage: chatMessage,
        onQuickReplyItemPressed: _onQuickReplyItemPressed,
      );
    }
    return HTMLWidget(chatMessage: chatMessage);
  }
}

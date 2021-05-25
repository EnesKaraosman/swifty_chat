import 'package:flutter/material.dart';
import 'package:flutter_chat/chat-message-list-items/html_widget.dart';
import 'package:flutter_chat/chat-message-list-items/quick_reply_widget.dart';

import 'models/chat_message.dart';
import 'chat-message-list-items/text_widget.dart';
import 'chat-message-list-items/image_widget.dart';

class ChatListItem extends StatelessWidget {
  final ChatMessage chatMessage;

  final Function? onQuickReplyItemPressed;

  ChatListItem({required this.chatMessage, this.onQuickReplyItemPressed});

  @override
  Widget build(BuildContext context) {
    return _messageWidget;
  }

  Widget get _messageWidget {
    if (chatMessage.text != null) {
      return TextMessageWidget(chatMessage);
    } else if (chatMessage.imageURL != null) {
      return ImageMessageWidget(chatMessage);
    } else if (chatMessage.quickReplies.isNotEmpty) {
      return QuickReplyWidget(
        chatMessage: chatMessage,
        onQuickReplyItemPressed: onQuickReplyItemPressed,
      ); // Text("Unknown type");
    }
    return HTMLWidget(chatMessage: chatMessage);
  }
}

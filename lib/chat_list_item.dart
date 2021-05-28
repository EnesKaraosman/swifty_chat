import 'package:flutter/material.dart';
import 'package:flutter_chat/chat-message-list-items/html_widget.dart';
import 'package:flutter_chat/chat-message-list-items/quick_reply_widget.dart';

import 'models/message.dart';
import 'chat-message-list-items/text_widget.dart';
import 'chat-message-list-items/image_widget.dart';

class ChatListItem extends StatelessWidget {
  final Message chatMessage;

  final Function? onQuickReplyItemPressed;

  ChatListItem({required this.chatMessage, this.onQuickReplyItemPressed});

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
        onQuickReplyItemPressed: onQuickReplyItemPressed,
      ); // Text("Unknown type");
    }
    return HTMLWidget(chatMessage: chatMessage);
  }
}

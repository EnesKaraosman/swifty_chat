import 'package:flutter/material.dart';

import '../src/chat-message-list-items/html_widget.dart';
import '../src/chat-message-list-items/image_widget.dart';
import '../src/chat-message-list-items/quick_reply_widget.dart';
import '../src/chat-message-list-items/text_widget.dart';
import '../src/models/message.dart';

class ChatListItem extends StatelessWidget {
  final Message chatMessage;

  // Map<String, OnTap> Function()? _onHtmlWidgetPressed;
  //
  // ChatListItem setOnHtmlWidgetPressed(Map<String, OnTap> Function()? fn) {
  //   _onHtmlWidgetPressed = fn;
  //   return this;
  // }

  const ChatListItem({
    required this.chatMessage,
  });

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
      );
    } else if (chatMessage.messageKind.htmlData != null) {
      return HTMLWidget(
        chatMessage: chatMessage,
        // onHtmlWidgetPressed: _onHtmlWidgetPressed,
      );
    }
    return const Text('Undetermined MessageKind');
  }
}

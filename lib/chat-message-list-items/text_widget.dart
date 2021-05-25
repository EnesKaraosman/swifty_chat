import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import 'package:flutter_chat/models/chat_message.dart';

class TextMessageWidget extends StatelessWidget {
  final ChatMessage _chatMessage;

  TextMessageWidget(this._chatMessage);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(_chatMessage.text!).padding(all: 8).card()
    ],
      mainAxisAlignment:
          _chatMessage.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
    );
  }
}

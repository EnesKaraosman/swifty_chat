import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import 'package:flutter_chat/models/message.dart';

class TextMessageWidget extends StatelessWidget {
  final Message _chatMessage;

  TextMessageWidget(this._chatMessage);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(_chatMessage.messageKind.text!).padding(all: 8).card()
    ],
      mainAxisAlignment:
          _chatMessage.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
    );
  }
}

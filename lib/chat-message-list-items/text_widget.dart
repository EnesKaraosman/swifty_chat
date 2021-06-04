import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import 'package:flutter_chat/models/message.dart';

class TextMessageWidget extends StatelessWidget {
  final Message _chatMessage;

  TextMessageWidget(this._chatMessage);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      if (_chatMessage.isMe)
        SizedBox(width: 20,),

      Flexible( //newly added
          child: Container(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            child: Text(_chatMessage.messageKind.text!, softWrap: true,)
                .padding(all: 8)
                .card(),
          )
      ),

      if (!_chatMessage.isMe)
        SizedBox(width: 20,)
      
    ],
      mainAxisAlignment:
      _chatMessage.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
    );
  }
}

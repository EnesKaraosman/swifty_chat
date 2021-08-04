import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../models/message.dart';

class TextMessageWidget extends StatelessWidget {
  final Message _chatMessage;

  const TextMessageWidget(this._chatMessage);

  @override
  Widget build(BuildContext context) {
    final cardTheme = Theme.of(context).cardTheme;

    return Row(
      mainAxisAlignment:
          _chatMessage.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (_chatMessage.isMe)
          const SizedBox(
            width: 20,
          ),
        Flexible(
            //newly added
            child: Container(
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          child: Text(
            _chatMessage.messageKind.text!,
            softWrap: true,
            style: Theme.of(context).textTheme.bodyText1,
          )
              .padding(all: 8)
              .card(color: cardTheme.color, margin: cardTheme.margin),
        )),
        if (!_chatMessage.isMe)
          const SizedBox(
            width: 20,
          )
      ],
    );
  }
}

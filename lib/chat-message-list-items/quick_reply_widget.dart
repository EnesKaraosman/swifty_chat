import 'package:flutter/material.dart';

import 'package:flutter_chat/models/message.dart';

class QuickReplyWidget extends StatelessWidget {
  final Message chatMessage;
  final Function? onQuickReplyItemPressed;

  const QuickReplyWidget(
      {required this.chatMessage,
      this.onQuickReplyItemPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 44,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            ...chatMessage.messageKind.quickReplies.map((qr) {
              return OutlinedButton(
                child: Text(qr.title),
                onPressed: () => onQuickReplyItemPressed?.call(qr),
              );
            }).toList()
          ],
        ));
  }
}

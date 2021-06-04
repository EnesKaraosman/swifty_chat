import 'package:flutter/material.dart';

import '../models/message.dart';
import '../models/quick_reply_item.dart';

class QuickReplyWidget extends StatelessWidget {
  final Message chatMessage;
  final void Function(QuickReplyItem)? onQuickReplyItemPressed;

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
            ...chatMessage.messageKind.quickReplies.map((qr) =>
              OutlinedButton(
                child: Text(qr.title),
                onPressed: () => onQuickReplyItemPressed?.call(qr),
              )
            ).toList()
          ],
        ));
  }
}

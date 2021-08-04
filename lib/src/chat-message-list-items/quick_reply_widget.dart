import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../chat.dart';
import '../models/message.dart';
import '../models/quick_reply_item.dart';

class QuickReplyWidget extends StatelessWidget {
  final Message chatMessage;

  const QuickReplyWidget({
    required this.chatMessage
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: _buttons(context),).padding(all: 8);
  }

  List<Widget> _buttons(BuildContext context) {
    return chatMessage.messageKind.quickReplies.map((qr) =>
        OutlinedButton(
          onPressed: () => ChatState.of(context).onQuickReplyItemPressed?.call(qr),
          child: Text(qr.title),
        )
    ).toList();
  }
}

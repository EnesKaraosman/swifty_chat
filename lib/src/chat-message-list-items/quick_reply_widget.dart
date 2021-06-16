import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../models/message.dart';
import '../models/quick_reply_item.dart';

class QuickReplyWidget extends StatelessWidget {
  final Message chatMessage;
  final void Function(QuickReplyItem)? onQuickReplyItemPressed;

  const QuickReplyWidget({required this.chatMessage,
    this.onQuickReplyItemPressed});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: _buttons,).padding(all: 8);
  }

  List<Widget> get _buttons {
    return chatMessage.messageKind.quickReplies.map((qr) =>
        OutlinedButton(
          child: Text(qr.title),
          onPressed: () => onQuickReplyItemPressed?.call(qr),
        )
    ).toList();
  }
}

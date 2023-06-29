import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:swifty_chat/src/chat.dart';
import 'package:swifty_chat/src/extensions/theme_context.dart';
import 'package:swifty_chat_data/swifty_chat_data.dart';

final class QuickReplyWidget extends StatelessWidget {
  const QuickReplyWidget(this.chatMessage);

  final Message chatMessage;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: _buttons(context),
    ).padding(all: 8);
  }

  List<Widget> _buttons(BuildContext context) {
    return chatMessage.messageKind.quickReplies
        .map(
          (qr) => OutlinedButton(
            style: context.theme.quickReplyButtonStyle,
            onPressed: () => ChatStateContainer.of(context)
                .onQuickReplyItemPressed
                ?.call(qr),
            child: Text(qr.title),
          ),
        )
        .toList();
  }
}

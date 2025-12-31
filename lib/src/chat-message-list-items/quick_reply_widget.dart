import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../chat.dart';
import '../extensions/theme_context.dart';
import '../models/message.dart';
import '../utils/accessibility_helpers.dart';

@immutable
final class QuickReplyWidget extends StatelessWidget {
  const QuickReplyWidget(this.chatMessage);

  final Message chatMessage;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Semantics(
        label: 'Quick reply options',
        child: Wrap(
          spacing: 8,
          children: _buttons(context),
        ).padding(all: 8),
      ),
    );
  }

  List<Widget> _buttons(BuildContext context) {
    return chatMessage.messageKind.quickReplies
        .map(
          (qr) => Semantics(
            button: true,
            label: AccessibilityHelpers.createQuickReplySemanticLabel(qr.title),
            child: OutlinedButton(
              style: context.theme.quickReplyButtonStyle,
              onPressed: () => ChatStateContainer.of(context)
                  .onQuickReplyItemPressed
                  ?.call(qr),
              child: Text(qr.title),
            ),
          ),
        )
        .toList();
  }
}

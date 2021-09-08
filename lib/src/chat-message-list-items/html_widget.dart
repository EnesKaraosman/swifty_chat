import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:swifty_chat_data/swifty_chat_data.dart';

import '../chat.dart';
import '../extensions/theme_context.dart';

class HTMLWidget extends StatelessWidget {
  final Message chatMessage;

  const HTMLWidget(this.chatMessage);

  @override
  Widget build(BuildContext context) {
    final functions = ChatStateContainer.of(context).onHtmlWidgetPressed?.call();
    final OnTap? onLinkTap = functions?["onLinkTap"];
    final OnTap? onImageTap = functions?["onImageTap"];
    return Container(
      color: context.theme.secondaryColor,
      child: Html(
        data: chatMessage.messageKind.htmlData,
        onLinkTap: onLinkTap,
        onImageTap: onImageTap,
      ).padding(all: context.theme.textMessagePadding),
    );
  }
}

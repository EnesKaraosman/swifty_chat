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
    final functions =
        ChatStateContainer.of(context).onHtmlWidgetPressed?.call();
    final OnTap? onLinkTap = functions?["onLinkTap"];
    final OnTap? onImageTap = functions?["onImageTap"];
    final Color htmlTextColor = context.theme.htmlTextColor;
    final String? htmlTextFontFamily = context.theme.htmlTextFontFamily;
    return Container(
      color: context.theme.secondaryColor,
      child: Html(
        data: chatMessage.messageKind.htmlData,
        onLinkTap: onLinkTap,
        onImageTap: onImageTap,
        style: {
          "p": styleFrom(color: htmlTextColor, fontFamily: htmlTextFontFamily),
          "h1": styleFrom(color: htmlTextColor, fontFamily: htmlTextFontFamily),
          "h2": styleFrom(color: htmlTextColor, fontFamily: htmlTextFontFamily),
          "h3": styleFrom(color: htmlTextColor, fontFamily: htmlTextFontFamily),
          "h4": styleFrom(color: htmlTextColor, fontFamily: htmlTextFontFamily),
          "h5": styleFrom(color: htmlTextColor, fontFamily: htmlTextFontFamily),
        },
      ).padding(all: context.theme.textMessagePadding),
    );
  }

  Style styleFrom({
    required Color color,
    String? fontFamily,
  }) {
    return Style(color: color, fontFamily: fontFamily);
  }
}

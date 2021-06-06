import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:styled_widget/styled_widget.dart';

import '../models/message.dart';

class HTMLWidget extends StatelessWidget {
  final Message chatMessage;

  HTMLWidget({required this.chatMessage, this.onHtmlWidgetPressed}) {
    final functions = onHtmlWidgetPressed?.call();
    onLinkTap = functions?["onLinkTap"];
    onImageTap = functions?["onImageTap"];
  }

  final Map<String, OnTap> Function()? onHtmlWidgetPressed;
  OnTap? onLinkTap;
  OnTap? onImageTap;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Html(
        data: chatMessage.messageKind.htmlData,
        onLinkTap: onLinkTap,
        onImageTap: onImageTap,
      ).padding(all: 8).card(),
    );
  }
}

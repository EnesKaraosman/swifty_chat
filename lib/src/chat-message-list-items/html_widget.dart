import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:styled_widget/styled_widget.dart';

import '../models/message.dart';

class HTMLWidget extends StatelessWidget {
  final Message chatMessage;

  HTMLWidget({
    required this.chatMessage,
    // this.onHtmlWidgetPressed
  }) {
    // final functions = onHtmlWidgetPressed?.call();
    // final functions = ChatState onHtmlWidgetPressed?.call();
    // onLinkTap = functions?["onLinkTap"];
    // onImageTap = functions?["onImageTap"];
  }

  // final Map<String, OnTap> Function()? onHtmlWidgetPressed;
  OnTap? _onLinkTap;
  OnTap? _onImageTap;

  @override
  Widget build(BuildContext context) {
    // Map<String, OnTap> Function()? functions = ChatState.of(context).onHtmlWidgetPressed?.call();
    // _onLinkTap = functions["onLinkTap"];
    // _onImageTap = functions["onImageTap"];
    return Html(
      data: chatMessage.messageKind.htmlData,
      onLinkTap: _onLinkTap,
      onImageTap: _onImageTap,
    ).padding(all: 8).card();
  }
}

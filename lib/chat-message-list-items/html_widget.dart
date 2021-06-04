import 'package:flutter/material.dart';
import 'package:flutter_chat/models/message.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:styled_widget/styled_widget.dart';

class HTMLWidget extends StatelessWidget {
  final Message chatMessage;

  const HTMLWidget({required this.chatMessage});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Html(data: chatMessage.messageKind.htmlData)
          .padding(all: 8)
          .card(),
    );
  }
}

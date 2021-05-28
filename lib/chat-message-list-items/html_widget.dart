import 'package:flutter/material.dart';
import 'package:flutter_chat/models/message.dart';
import 'package:flutter_html/flutter_html.dart';

class HTMLWidget extends StatelessWidget {
  final Message chatMessage;
  const HTMLWidget({required this.chatMessage});

  @override
  Widget build(BuildContext context) {
    return Html(data: chatMessage.messageKind.htmlData);
  }
}

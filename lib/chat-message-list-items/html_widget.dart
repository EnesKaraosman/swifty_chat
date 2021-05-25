import 'package:flutter/material.dart';
import 'package:flutter_chat/models/chat_message.dart';
import 'package:flutter_html/flutter_html.dart';

class HTMLWidget extends StatelessWidget {
  final ChatMessage chatMessage;
  const HTMLWidget({required this.chatMessage});

  @override
  Widget build(BuildContext context) {
    return Html(data: chatMessage.htmlData);
  }
}

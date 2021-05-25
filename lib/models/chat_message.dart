import 'dart:math';

import 'package:flutter_chat/models/IQuickReplyItem.dart';

class ChatMessage {
  String? id;
  bool isMe = Random().nextBool();

  String? text;
  String? imageURL;
  List<IQuickReplyItem> quickReplies = [];
  String? htmlData;

  ChatMessage.text(String text): text = text;
  ChatMessage.image(String imageURL): imageURL = imageURL;
  ChatMessage.quickReply(List<IQuickReplyItem> quickReplies): quickReplies = quickReplies;
  ChatMessage.html(String html): htmlData = html;
}
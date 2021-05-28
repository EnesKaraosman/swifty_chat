import 'dart:math';

import 'package:flutter_chat/models/IQuickReplyItem.dart';

class MessageKind {
  String? text;
  String? imageURL;
  List<IQuickReplyItem> quickReplies = [];
  String? htmlData;

  MessageKind.text(String text): text = text;
  MessageKind.image(String imageURL): imageURL = imageURL;
  MessageKind.quickReply(List<IQuickReplyItem> quickReplies): quickReplies = quickReplies;
  MessageKind.html(String html): htmlData = html;
}
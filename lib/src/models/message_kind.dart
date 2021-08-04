import '../models/quick_reply_item.dart';

class MessageKind {
  String? text;
  String? imageURL;
  List<QuickReplyItem> quickReplies = [];
  String? htmlData;

  MessageKind.text(this.text);
  MessageKind.image(this.imageURL);
  MessageKind.quickReply(this.quickReplies);
  MessageKind.html(this.htmlData);
}
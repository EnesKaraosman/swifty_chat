import '../models/quick_reply_item.dart';

class MessageKind {
  String? text;
  String? imageURL;
  List<QuickReplyItem> quickReplies = [];
  String? htmlData;

  MessageKind.text(String text): text = text;
  MessageKind.image(String imageURL): imageURL = imageURL;
  MessageKind.quickReply(List<QuickReplyItem> quickReplies): quickReplies = quickReplies;
  MessageKind.html(String html): htmlData = html;
}
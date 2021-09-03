import '../models/carousel_item.dart';
import '../models/quick_reply_item.dart';

class MessageKind {
  String? text;
  String? imageURL;
  String? htmlData;
  List<QuickReplyItem> quickReplies = [];
  List<CarouselItem> carouselItems = [];

  MessageKind.text(this.text);
  MessageKind.image(this.imageURL);
  MessageKind.html(this.htmlData);
  MessageKind.quickReply(this.quickReplies);
  MessageKind.carousel(this.carouselItems);
}
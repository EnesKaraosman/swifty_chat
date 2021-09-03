import 'package:swifty_chat/swifty_chat.dart';

class EKQuickReplyItem extends QuickReplyItem {
  String title;
  String? payload;
  String? url;

  EKQuickReplyItem({required this.title, this.payload, this.url}) :
        super(title: title, payload: payload, url: url);
}
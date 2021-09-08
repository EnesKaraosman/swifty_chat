import 'package:swifty_chat_data/swifty_chat_data.dart';

class MockQuickReplyItem extends QuickReplyItem {
  String title;
  String? payload;
  String? url;

  MockQuickReplyItem({
    required this.title,
    this.payload,
    this.url,
  }) : super(
          title: title,
          payload: payload,
          url: url,
        );
}

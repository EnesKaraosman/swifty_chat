import 'package:swifty_chat_data/swifty_chat_data.dart';

class MockQuickReplyItem extends QuickReplyItem {
  const MockQuickReplyItem({
    required super.title,
    super.payload,
    super.url,
  });
}

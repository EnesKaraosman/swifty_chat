import 'package:swifty_chat/swifty_chat.dart';

class MockQuickReplyItem extends QuickReplyItem {
  const MockQuickReplyItem({
    required super.title,
    super.payload,
    super.url,
  });
}

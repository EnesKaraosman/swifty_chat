import 'package:swifty_chat_data/swifty_chat_data.dart';

class MockMessage extends Message {
  const MockMessage({
    required super.user,
    required super.id,
    required super.isMe,
    required super.date,
    required super.messageKind,
  });
}

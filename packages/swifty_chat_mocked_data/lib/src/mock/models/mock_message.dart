import 'package:swifty_chat_data/swifty_chat_data.dart';

import './mock_chat_user.dart';

class MockMessage extends Message {
  final DateTime time;
  final MockChatUser user;
  final String id;
  final bool isMe;
  final MessageKind messageKind;

  const MockMessage({
    required this.time,
    required this.user,
    required this.id,
    required this.isMe,
    required this.messageKind,
  }) : super(
          time: time,
          user: user,
          id: id,
          isMe: isMe,
          messageKind: messageKind,
        );
}

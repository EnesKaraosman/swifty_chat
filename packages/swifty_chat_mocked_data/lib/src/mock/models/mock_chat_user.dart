import 'dart:math';

import 'package:swifty_chat_data/swifty_chat_data.dart';

class MockChatUser extends ChatUser {
  final String userName;
  final UserAvatar? avatar;

  MockChatUser({
    required this.userName,
    this.avatar,
  }) : super(
          userName: userName,
          avatar: avatar,
        );

  static MockChatUser incomingUser = MockChatUser(
    userName: "incoming",
    avatar: UserAvatar(imageURL: Uri.parse('https://picsum.photos/50/50')),
  );
  static MockChatUser outgoingUser = MockChatUser(userName: "outgoing");

  static MockChatUser get randomUser => Random().nextBool() ? incomingUser : outgoingUser;
}

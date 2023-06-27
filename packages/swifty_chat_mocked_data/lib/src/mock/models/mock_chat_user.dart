import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:swifty_chat_data/swifty_chat_data.dart';

class MockChatUser extends ChatUser {
  MockChatUser({
    required super.userName,
    super.avatar,
  });

  static MockChatUser incomingUser = MockChatUser(
    userName: "incoming",
    avatar: UserAvatar(
      imageProvider: const AssetImage(
        'assets/images/mock_image_avatar.png',
        package: 'swifty_chat_mocked_data',
      ),
    ),
  );

  static MockChatUser outgoingUser = MockChatUser(userName: "outgoing");

  static MockChatUser get randomUser =>
      Random().nextBool() ? incomingUser : outgoingUser;
}

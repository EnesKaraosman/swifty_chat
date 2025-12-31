import 'user_avatar.dart';

/// Abstract base class for chat users
abstract class ChatUser {
  ChatUser({
    required this.userName,
    this.avatar,
  });

  /// Username displayed in the chat
  final String userName;

  /// User's avatar options
  UserAvatar? avatar;
}

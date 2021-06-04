import 'dart:core';

abstract class ChatUser {
  /// Username
  final String userName;

  /// User's chat profile image, considered if `avatarURL` is nil
  // Image avatar;

  /// User's chat profile image URL
  final Uri? avatarURL;

  const ChatUser({required this.userName, this.avatarURL});
}
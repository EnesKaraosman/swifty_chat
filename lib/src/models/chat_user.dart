import 'dart:core';
import '../models/user_avatar.dart';

abstract class ChatUser {
  /// Username
  final String userName;

  /// User's avatar options
  UserAvatar? avatar;

  ChatUser({
    required this.userName,
    this.avatar
  });
}

import 'package:flutter_chat/flutter_chat.dart';

class EKChatUser extends ChatUser {

  final String userName;
  final Uri? avatarURL;

  const EKChatUser({required this.userName, this.avatarURL})
      : super(userName: userName, avatarURL: avatarURL);
}
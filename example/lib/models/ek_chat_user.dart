import 'package:swifty_chat/swifty_chat.dart';

class EKChatUser extends ChatUser {

  final String userName;
  final UserAvatar? avatar;

  EKChatUser({required this.userName, this.avatar})
      : super(userName: userName, avatar: avatar);
}
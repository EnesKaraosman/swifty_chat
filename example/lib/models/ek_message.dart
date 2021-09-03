import 'package:swifty_chat/swifty_chat.dart';
import '../models/ek_chat_user.dart';

class EKMessage extends Message {
  final EKChatUser user;
  final String id;
  final bool isMe;
  final MessageKind messageKind;

  const EKMessage({
    required this.user,
    required this.id,
    required this.isMe,
    required this.messageKind
  }): super(user: user, id: id, isMe: isMe, messageKind: messageKind);
}
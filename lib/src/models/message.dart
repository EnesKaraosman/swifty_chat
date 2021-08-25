import '../models/chat_user.dart';
import '../models/message_kind.dart';

abstract class Message {
  final ChatUser user;
  final String id;
  final bool isMe;
  final MessageKind messageKind;

  const Message({
    required this.user,
    required this.id,
    required this.isMe,
    required this.messageKind,
  });
}

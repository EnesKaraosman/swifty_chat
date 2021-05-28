import 'package:flutter_chat/models/message_kind.dart';

abstract class Message {
  final String? id;
  final bool isMe;
  final MessageKind messageKind;

  const Message({
    required this.id,
    required this.isMe,
    required this.messageKind
  });
}
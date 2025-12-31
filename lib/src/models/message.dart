import 'package:equatable/equatable.dart';

import 'chat_user.dart';
import 'message_kind.dart';

/// Abstract base class for chat messages
abstract class Message extends Equatable {
  const Message({
    required this.user,
    required this.id,
    required this.isMe,
    required this.messageKind,
    required this.date,
  });

  /// The user who sent the message
  final ChatUser user;

  /// Unique identifier for the message
  final String id;

  /// Whether the message was sent by the current user
  final bool isMe;

  /// The type and content of the message
  final MessageKind messageKind;

  /// When the message was sent
  final DateTime date;

  @override
  List<Object?> get props => [id];
}

import 'package:flutter/material.dart';

/// Position of the avatar relative to the message bubble
enum AvatarPosition {
  top,
  center,
  bottom,
}

/// Extension for converting AvatarPosition to CrossAxisAlignment
extension AvatarAlignment on AvatarPosition {
  CrossAxisAlignment get alignment {
    switch (this) {
      case AvatarPosition.top:
        return CrossAxisAlignment.start;
      case AvatarPosition.center:
        return CrossAxisAlignment.center;
      case AvatarPosition.bottom:
        return CrossAxisAlignment.end;
    }
  }
}

/// Configuration for user avatars in chat
class UserAvatar {
  UserAvatar({
    required this.imageProvider,
    this.size = 40,
    this.position = AvatarPosition.center,
  });

  /// Profile imageProvider (Network/Asset)
  final ImageProvider imageProvider;

  /// Width & Height (diameter)
  final double size;

  /// AvatarPosition, related with message (top, center, bottom)
  final AvatarPosition position;
}

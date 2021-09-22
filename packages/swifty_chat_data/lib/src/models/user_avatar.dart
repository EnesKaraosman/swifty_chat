import 'package:flutter/material.dart';

enum AvatarPosition {
  top, center, bottom
}

extension AvatarAlignment on AvatarPosition {
  CrossAxisAlignment get alignment {
    switch (this) {
      case AvatarPosition.top: return CrossAxisAlignment.start;
      case AvatarPosition.center: return CrossAxisAlignment.center;
      case AvatarPosition.bottom: return CrossAxisAlignment.end;
      default: return CrossAxisAlignment.center;
    }
  }
}

class UserAvatar {
  /// Profile imageProvider (Network/Asset)
  final ImageProvider imageProvider;

  /// Width & Height (diameter)
  final double size;

  /// AvatarPosition, related with message (top, center, bottom)
  final AvatarPosition position;

  UserAvatar({
    required this.imageProvider,
    this.size = 40,
    this.position = AvatarPosition.center,
  });
}

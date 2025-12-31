import 'package:flutter/material.dart';

import '../models/message.dart';
import '../models/user_avatar.dart';

mixin HasAvatar {
  Message get message;

  UserAvatar? get userAvatar => message.user.avatar;

  AvatarPosition get avatarPosition =>
      userAvatar?.position ?? AvatarPosition.center;

  ImageProvider? get avatarImageProvider => userAvatar?.imageProvider;

  double get _radius => (userAvatar?.size ?? 36) / 2;

  List<Widget> avatarWithPadding([double padding = 8]) => [
        SizedBox(width: padding),
        if (avatarImageProvider != null)
          CircleAvatar(
            radius: _radius,
            backgroundImage: avatarImageProvider,
          ),
        SizedBox(width: padding),
      ].toList();
}

import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../models/message.dart';
import '../models/user_avatar.dart';

abstract class HasAvatar {
  Message get message;

  UserAvatar? get userAvatar => message.user.avatar;

  AvatarPosition get avatarPosition =>
      userAvatar?.position ?? AvatarPosition.center;

  Uri? get avatarUri => userAvatar?.imageURL;

  List<Widget> avatarWithPadding([double padding = 8]) => [
    SizedBox(width: padding),
    if (avatarUri != null)
      CircleAvatar(
        backgroundImage: NetworkImage(avatarUri!.toString()),
      ),
    SizedBox(width: padding),
  ].toList();
}
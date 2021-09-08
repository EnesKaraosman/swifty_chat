import 'package:flutter/material.dart';
import 'package:swifty_chat_data/swifty_chat_data.dart';

abstract class HasAvatar {
  Message get message;

  UserAvatar? get userAvatar => message.user.avatar;

  AvatarPosition get avatarPosition =>
      userAvatar?.position ?? AvatarPosition.center;

  Uri? get avatarUri => userAvatar?.imageURL;

  double get _radius => (userAvatar?.size ?? 36) / 2;

  List<Widget> avatarWithPadding([double padding = 8]) => [
    SizedBox(width: padding),
    if (avatarUri != null)
      CircleAvatar(
        radius: _radius,
        backgroundImage: NetworkImage(avatarUri!.toString()),
      ),
    SizedBox(width: padding),
  ].toList();
}
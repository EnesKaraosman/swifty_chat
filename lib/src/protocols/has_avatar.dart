import '../models/message.dart';
import '../models/user_avatar.dart';

abstract class HasAvatar {
  Message get message;

  UserAvatar? get userAvatar => message.user.avatar;

  AvatarPosition get avatarPosition =>
      userAvatar?.position ?? AvatarPosition.center;

  Uri? get avatarUri => userAvatar?.imageURL;
}
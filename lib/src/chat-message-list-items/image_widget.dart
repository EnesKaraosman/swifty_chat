import 'package:flutter/material.dart';
import 'package:flutter_chat/src/protocols/has_avatar.dart';

import '../chat.dart';
import '../models/message.dart';
import '../models/user_avatar.dart';

class ImageMessageWidget extends StatelessWidget with HasAvatar {
  final Message _chatMessage;

  const ImageMessageWidget(this._chatMessage);

  List<Widget> avatarAndSpacer({required bool isMe, double space = 8}) => [
        SizedBox(width: space),
        if (avatarUri != null)
          CircleAvatar(
            backgroundImage: NetworkImage(avatarUri!.toString()),
          ),
        SizedBox(width: space),
      ].toList();

  Widget incomingMessage(BuildContext context) => Row(
        crossAxisAlignment: avatarPosition.alignment,
        children: [
          ...avatarAndSpacer(isMe: false),
          imageContainer(context),
        ],
      );

  Widget outgoingMessage(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: avatarPosition.alignment,
        children: [
          imageContainer(context),
          ...avatarAndSpacer(isMe: true),
        ],
      );

  Widget imageContainer(BuildContext context) => Image(
        image: NetworkImage(_chatMessage.messageKind.imageURL!),
        width: _imageWidth(context),
      );

  @override
  Widget build(BuildContext context) =>
      _chatMessage.isMe ? outgoingMessage(context) : incomingMessage(context);

  double _availableWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  double _imageWidth(BuildContext context) {
    final availableWidth = _availableWidth(context);
    return ChatStateContainer.of(context)
        .messageCellSizeConfigurator
        .imageCellMaxWidthConfiguration(availableWidth);
  }

  @override
  Message get message => _chatMessage;
}

import 'package:flutter/material.dart';

import '../chat.dart';
import '../models/message.dart';

class ImageMessageWidget extends StatelessWidget {
  final Message _chatMessage;

  const ImageMessageWidget(this._chatMessage);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          _chatMessage.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        // CachedNetworkImage(
        //   imageUrl: _chatMessage.imageURL!,
        //   placeholder: (context, url) => CircularProgressIndicator(),
        //   height: 200,
        // ),
        Image(
          image: NetworkImage(_chatMessage.messageKind.imageURL!),
          // height: 200,
          width: _imageWidth(context),
        )
      ],
    );
  }

  double _availableWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  double _imageWidth(BuildContext context) {
    final availableWidth = _availableWidth(context);
    return ChatState.of(context).messageCellSizeConfigurator.imageCellMaxWidthConfiguration(availableWidth);
  }
}

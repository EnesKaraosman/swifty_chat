import 'package:flutter/material.dart';
import 'package:flutter_chat/models/message.dart';

class ImageMessageWidget extends StatelessWidget {
  final Message _chatMessage;

  ImageMessageWidget(this._chatMessage);

  @override
  Widget build(BuildContext context) {
    return Row(
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
      mainAxisAlignment:
          _chatMessage.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
    );
  }

  double _availableWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  double _imageWidth(BuildContext context) {
    return _availableWidth(context) * 0.6;
  }
}

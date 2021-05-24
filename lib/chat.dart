import 'dart:math';
import 'package:flutter/material.dart';
import 'chat-message-list-items/image_widget.dart';
import 'chat-message-list-items/text_widget.dart';

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

extension RangeExtension on int {
  List<int> to(int maxInclusive) =>
      [for (int i = this; i <= maxInclusive; i++) i];
}

class Chat extends StatelessWidget {
  List<ChatMessage> _items = 1.to(100).map((num) {
    if (num % 7 == 0) {
      return ChatMessage.image('https://picsum.photos/300/200');
    } else {
      return ChatMessage.text(getRandomString(Random().nextInt(40)));
    }
  }).toList();

  @override
  Widget build(BuildContext context) {
    return _chatList;
  }

  Widget get _chatList {
    return ListView.builder(
      itemCount: _items.length,
      itemBuilder: (BuildContext context, int index) {
        return ChatListItem(_items[index]);
      }
    );
  }
}

class ChatMessage {
  String? id;
  bool isMe = Random().nextBool();

  String? text;
  String? imageURL;

  ChatMessage.text(String text): text = text;
  ChatMessage.image(String imageURL): imageURL = imageURL;
}

class ChatListItem extends StatelessWidget {
  final ChatMessage _chatMessage;

  ChatListItem(this._chatMessage);
  
  @override
  Widget build(BuildContext context) {
    return _messageWidget;
  }
  
  Widget get _messageWidget {
    if (_chatMessage.text != null) {
      return TextMessageWidget(_chatMessage);
    } else if (_chatMessage.imageURL != null) {
      return ImageMessageWidget(_chatMessage);
    }
    return Text("Unknown type");
  }
}

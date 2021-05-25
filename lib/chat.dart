import 'dart:math';
import 'package:flutter/material.dart';
import 'chat_list_item.dart';
import 'models/chat_message.dart';

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

extension RangeExtension on int {
  List<int> to(int maxInclusive) =>
      [for (int i = this; i <= maxInclusive; i++) i];
}

class Chat extends StatelessWidget {
  List<ChatMessage> items = [];

  Function? onQuickReplyItemPressed;

  Chat({required this.items, this.onQuickReplyItemPressed});

  @override
  Widget build(BuildContext context) {
    return _chatList;
  }

  Widget get _chatList {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return ChatListItem(
          chatMessage: items[index],
          onQuickReplyItemPressed: onQuickReplyItemPressed,
        );
      }
    );
  }
}


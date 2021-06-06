import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_html/html_parser.dart';

import '../src/chat_list_item.dart';
import '../src/models/message.dart';
import '../src/models/quick_reply_item.dart';

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) =>
    String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

extension RangeExtension on int {
  List<int> to(int maxInclusive) =>
      [for (int i = this; i <= maxInclusive; i++) i];
}

class Chat extends StatelessWidget {
  List<Message> items = [];

  void Function(QuickReplyItem)? _onQuickReplyItemPressed;
  Map<String, OnTap> Function()? _onHtmlWidgetPressed;

  Chat({required this.items});

  Chat setOnQuickReplyItemPressed(void Function(QuickReplyItem)? fn) {
    _onQuickReplyItemPressed = fn;
    return this;
  }

  Chat setOnHTMLWidgetPressed(Map<String, OnTap> Function()? fn) {
    _onHtmlWidgetPressed = fn;
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return _chatList;
  }

  Widget get _chatList {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return ChatListItem(chatMessage: items[index])
            .setOnQuickReplyItemPressed(_onQuickReplyItemPressed)
            .setOnHtmlWidgetPressed(_onHtmlWidgetPressed);
        }
    );
  }
}


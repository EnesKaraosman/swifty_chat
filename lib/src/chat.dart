import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:styled_widget/styled_widget.dart';

import '../src/chat_list_item.dart';
import '../src/message_cell_size_configurator.dart';
import '../src/models/message.dart';
import '../src/models/quick_reply_item.dart';

class ChatState extends InheritedWidget {
  Key? key;
  final MessageCellSizeConfigurator messageCellSizeConfigurator;
  void Function(QuickReplyItem)? onQuickReplyItemPressed;
  Map<String, OnTap> Function()? onHtmlWidgetPressed;
  final Widget child;

  ChatState({
      this.key,
      this.onHtmlWidgetPressed,
      this.onQuickReplyItemPressed,
      required this.messageCellSizeConfigurator,
      required this.child
  }) : super(key: key, child: child);

  static ChatState of(BuildContext context) {
    final ChatState? result =
        context.dependOnInheritedWidgetOfExactType<ChatState>();
    assert(result != null, 'No Chat found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ChatState oldWidget) => false;
}

class Chat extends StatefulWidget {
  List<Message> messages = [];
  ThemeData? theme;
  Widget chatMessageInputField;

  final MessageCellSizeConfigurator messageCellSizeConfigurator;

  void Function(QuickReplyItem)? _onQuickReplyItemPressed;
  Map<String, OnTap> Function()? _onHtmlWidgetPressed;

  Chat({
    required this.messages,
    required this.messageCellSizeConfigurator,
    required this.chatMessageInputField,
    this.theme
  });

  @override
  _ChatState createState() => _ChatState();

  Chat setOnQuickReplyItemPressed(void Function(QuickReplyItem)? fn) {
    _onQuickReplyItemPressed = fn;
    return this;
  }

  Chat setOnHTMLWidgetPressed(Map<String, OnTap> Function()? fn) {
    _onHtmlWidgetPressed = fn;
    return this;
  }
}

class _ChatState extends State<Chat> {

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: widget.theme ?? ThemeData.light(),
      child: Scaffold(
        body: ChatState(
          messageCellSizeConfigurator: widget.messageCellSizeConfigurator,
          onHtmlWidgetPressed: widget._onHtmlWidgetPressed,
          onQuickReplyItemPressed: widget._onQuickReplyItemPressed,
          child: Column(
            children: [
              _chatList(),
              widget.chatMessageInputField
            ],
          ).gestures(onTap: () => FocusScope.of(context).unfocus()),
        ),
      ),
    );
  }

  Widget _chatList() => Expanded(
        child: ListView.builder(
            // (reverse: true) Helps to scroll content automatically when keyboard opens
            reverse: true,
            itemCount: widget.messages.length,
            itemBuilder: (BuildContext context, int index) =>
                ChatListItem(chatMessage: widget.messages[index])),
      );
}

import 'package:flutter/material.dart';
import 'package:flutter_html/html_parser.dart';

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

class Chat extends StatelessWidget {
  List<Message> items = [];
  ThemeData? lightTheme;
  ThemeData? darkTheme;

  final MessageCellSizeConfigurator messageCellSizeConfigurator;
  void Function(QuickReplyItem)? _onQuickReplyItemPressed;
  Map<String, OnTap> Function()? _onHtmlWidgetPressed;

  Chat({
    required this.items,
    required this.messageCellSizeConfigurator,
    this.lightTheme,
    this.darkTheme,
  });

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: Scaffold(
        body: ChatState(
          messageCellSizeConfigurator: messageCellSizeConfigurator,
          onHtmlWidgetPressed: _onHtmlWidgetPressed,
          onQuickReplyItemPressed: _onQuickReplyItemPressed,
          child: _chatList,
        ),
      ),
    );
  }

  Widget get _chatList {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return ChatListItem(chatMessage: items[index]);
              // .setOnHtmlWidgetPressed(_onHtmlWidgetPressed);
        });
  }
}

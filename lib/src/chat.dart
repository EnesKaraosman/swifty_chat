
import 'package:flutter/material.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:styled_widget/styled_widget.dart';

import '../src/chat_list_item.dart';
import '../src/message_cell_size_configurator.dart';
import '../src/models/carousel_item.dart';
import '../src/models/message.dart';
import '../src/models/quick_reply_item.dart';

class ChatStateContainer extends InheritedWidget {
  Key? key;
  final MessageCellSizeConfigurator messageCellSizeConfigurator;
  void Function(QuickReplyItem)? onQuickReplyItemPressed;
  void Function(CarouselButtonItem)? onCarouselButtonItemPressed;
  Map<String, OnTap> Function()? onHtmlWidgetPressed;
  final Widget child;

  ChatStateContainer({
    this.key,
    this.onHtmlWidgetPressed,
    this.onQuickReplyItemPressed,
    this.onCarouselButtonItemPressed,
    required this.messageCellSizeConfigurator,
    required this.child,
  }) : super(key: key, child: child);

  static ChatStateContainer of(BuildContext context) {
    final ChatStateContainer? result =
    context.dependOnInheritedWidgetOfExactType<ChatStateContainer>();
    assert(result != null, 'No Chat found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ChatStateContainer oldWidget) => false;
}

class Chat extends StatefulWidget {
  List<Message> messages = [];
  ThemeData? theme;
  Widget chatMessageInputField;

  final MessageCellSizeConfigurator messageCellSizeConfigurator;

  void Function(QuickReplyItem)? _onQuickReplyItemPressed;
  void Function(CarouselButtonItem)? _onCarouselButtonItemPressed;
  Map<String, OnTap> Function()? _onHtmlWidgetPressed;
  final ScrollController _scrollController = ScrollController();

  Chat({
    required this.messages,
    required this.messageCellSizeConfigurator,
    required this.chatMessageInputField,
    this.theme,
  });

  @override
  _ChatState createState() => _ChatState();

  Chat setOnQuickReplyItemPressed(void Function(QuickReplyItem)? fn) {
    _onQuickReplyItemPressed = fn;
    return this;
  }

  Chat setOnCarouselItemButtonPressed(void Function(CarouselButtonItem)? fn) {
    _onCarouselButtonItemPressed = fn;
    return this;
  }

  Chat setOnHTMLWidgetPressed(Map<String, OnTap> Function()? fn) {
    _onHtmlWidgetPressed = fn;
    return this;
  }

  void scrollToBottom() {
    _scrollController.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) =>
      Theme(
        data: widget.theme ?? ThemeData.light(),
        child: ChatStateContainer(
          messageCellSizeConfigurator: widget.messageCellSizeConfigurator,
          onHtmlWidgetPressed: widget._onHtmlWidgetPressed,
          onQuickReplyItemPressed: widget._onQuickReplyItemPressed,
          onCarouselButtonItemPressed: widget._onCarouselButtonItemPressed,
          child: Column(
            children: [_chatList(), widget.chatMessageInputField],
          ).gestures(
            onTap: () => FocusScope.of(context).unfocus(),
          ),
        ),
      );

  Widget _chatList() =>
      ListView.builder(
        controller: widget._scrollController,
        // (reverse: true) Helps to scroll content automatically when keyboard opens
        reverse: true,
        itemCount: widget.messages.length,
        itemBuilder: (BuildContext context, int index) =>
            ChatListItem(chatMessage: widget.messages[index]),
      ).expanded();
}

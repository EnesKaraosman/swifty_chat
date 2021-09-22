import 'package:flutter/material.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:swifty_chat/src/extensions/keys.dart';
import 'package:swifty_chat/src/inherited_chat_theme.dart';
import 'package:swifty_chat/src/theme/chat_theme.dart';
import 'package:swifty_chat/src/theme/default_theme.dart';
import 'package:swifty_chat_data/swifty_chat_data.dart';

import '../src/chat_list_item.dart';
import '../src/message_cell_size_configurator.dart';

class ChatStateContainer extends InheritedWidget {
  final MessageCellSizeConfigurator messageCellSizeConfigurator;
  final void Function(QuickReplyItem)? onQuickReplyItemPressed;
  final void Function(CarouselButtonItem)? onCarouselButtonItemPressed;
  final Map<String, OnTap> Function()? onHtmlWidgetPressed;

  const ChatStateContainer({
    Key? key,
    this.onHtmlWidgetPressed,
    this.onQuickReplyItemPressed,
    this.onCarouselButtonItemPressed,
    required this.messageCellSizeConfigurator,
    required Widget child,
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
  final ChatTheme theme;
  final Widget chatMessageInputField;

  MessageCellSizeConfigurator? messageCellSizeConfigurator;
  void Function(QuickReplyItem)? _onQuickReplyItemPressed;
  void Function(CarouselButtonItem)? _onCarouselButtonItemPressed;
  Map<String, OnTap> Function()? _onHtmlWidgetPressed;

  final ScrollController _scrollController = ScrollController();

  Chat({
    required this.messages,
    required this.chatMessageInputField,
    this.messageCellSizeConfigurator,
    this.theme = const DefaultChatTheme(),
  }) {
    messageCellSizeConfigurator ??= MessageCellSizeConfigurator.defaultConfiguration;
  }

  @override
  ChatState createState() => ChatState();

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

class ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) =>
      ChatStateContainer(
        messageCellSizeConfigurator: widget.messageCellSizeConfigurator!,
        onHtmlWidgetPressed: widget._onHtmlWidgetPressed,
        onQuickReplyItemPressed: widget._onQuickReplyItemPressed,
        onCarouselButtonItemPressed: widget._onCarouselButtonItemPressed,
        child: InheritedChatTheme(
          theme: widget.theme,
          child: Column(
            children: [_chatList(), widget.chatMessageInputField],
          ).gestures(
            onTap: () => FocusScope.of(context).unfocus(),
          ),
        ),
      );

  Widget _chatList() =>
      Container(
        color: widget.theme.backgroundColor,
        child: ListView.builder(
          key: ChatKeys.chatListView.key,
          controller: widget._scrollController,
          // (reverse: true) Helps to scroll content automatically when keyboard opens
          reverse: true,
          itemCount: widget.messages.length,
          itemBuilder: (BuildContext context, int index) =>
              ChatListItem(chatMessage: widget.messages[index]),
        ),
      ).expanded();
}

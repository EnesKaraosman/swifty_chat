import 'package:flutter/material.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:swifty_chat/src/chat_list_item.dart';
import 'package:swifty_chat/src/extensions/keys.dart';
import 'package:swifty_chat/src/inherited_chat_theme.dart';
import 'package:swifty_chat/src/message_cell_size_configurator.dart';
import 'package:swifty_chat/src/protocols/timeago_settings.dart';
import 'package:swifty_chat/src/theme/chat_theme.dart';
import 'package:swifty_chat/src/theme/default_theme.dart';
import 'package:swifty_chat_data/swifty_chat_data.dart';
import 'package:timeago/timeago.dart';

class ChatStateContainer extends InheritedWidget {
  final MessageCellSizeConfigurator messageCellSizeConfigurator;
  final void Function(QuickReplyItem)? onQuickReplyItemPressed;
  final void Function(CarouselButtonItem)? onCarouselButtonItemPressed;
  final Map<String, OnTap> Function()? onHtmlWidgetPressed;
  final Widget Function(Message)? customMessageWidget;

  const ChatStateContainer({
    Key? key,
    this.onHtmlWidgetPressed,
    this.onQuickReplyItemPressed,
    this.onCarouselButtonItemPressed,
    this.customMessageWidget,
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
  Chat({
    this.messages = const [],
    required this.chatMessageInputField,
    this.customMessageWidget,
    this.messageCellSizeConfigurator,
    this.theme = const DefaultChatTheme(),
    this.locale = LocaleType.tr,
    this.customLookupMessages,
  }) {
    messageCellSizeConfigurator ??=
        MessageCellSizeConfigurator.defaultConfiguration;
  }

  final List<Message> messages;
  final LocaleType locale;
  final ChatTheme theme;
  final Widget chatMessageInputField;
  final LookupMessages? customLookupMessages;

  MessageCellSizeConfigurator? messageCellSizeConfigurator;
  void Function(Message)? _onMessagePressed;
  void Function(QuickReplyItem)? _onQuickReplyItemPressed;
  void Function(CarouselButtonItem)? _onCarouselButtonItemPressed;
  Map<String, OnTap> Function()? _onHtmlWidgetPressed;
  Widget Function(Message)? customMessageWidget;

  final ScrollController _scrollController = ScrollController();

  @override
  ChatState createState() => ChatState();

  /// Triggered when quick reply message widget button is tapped.
  Chat setOnQuickReplyItemPressed(void Function(QuickReplyItem)? fn) {
    _onQuickReplyItemPressed = fn;
    return this;
  }

  /// Triggered when carousel message widget button is tapped.
  Chat setOnCarouselItemButtonPressed(void Function(CarouselButtonItem)? fn) {
    _onCarouselButtonItemPressed = fn;
    return this;
  }

  Chat setOnHTMLWidgetPressed(Map<String, OnTap> Function()? fn) {
    _onHtmlWidgetPressed = fn;
    return this;
  }

  /// Triggered when a message widget is tapped.
  Chat setOnMessagePressed(void Function(Message)? fn) {
    _onMessagePressed = fn;
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
  Widget build(BuildContext context) => ChatStateContainer(
        messageCellSizeConfigurator: widget.messageCellSizeConfigurator!,
        onHtmlWidgetPressed: widget._onHtmlWidgetPressed,
        onQuickReplyItemPressed: widget._onQuickReplyItemPressed,
        onCarouselButtonItemPressed: widget._onCarouselButtonItemPressed,
        customMessageWidget: widget.customMessageWidget,
        child: InheritedChatTheme(
          theme: widget.theme,
          customLookupMessages: widget.customLookupMessages,
          child: Column(
            children: [_chatList(), widget.chatMessageInputField],
          ).gestures(
            onTap: () => FocusScope.of(context).unfocus(),
          ),
        ),
      );

  Widget _chatList() => Container(
        color: widget.theme.backgroundColor,
        child: ListView.builder(
          key: ChatKeys.chatListView.key,
          controller: widget._scrollController,
          // (reverse: true) Helps to scroll content automatically when keyboard opens
          reverse: true,
          itemCount: widget.messages.length,
          itemBuilder: (BuildContext context, int index) => GestureDetector(
            child: ChatListItem(
              chatMessage: widget.messages[index],
              locale: widget.locale,
            ),
            onTap: () => widget._onMessagePressed?.call(widget.messages[index]),
          ),
        ),
      ).expanded();
}

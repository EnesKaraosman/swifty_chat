import 'package:flutter/material.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:swifty_chat/src/chat_list_item.dart';
import 'package:swifty_chat/src/extensions/keys.dart';
import 'package:swifty_chat/src/inherited_chat_theme.dart';
import 'package:swifty_chat/src/message_cell_size_configurator.dart';
import 'package:swifty_chat/src/theme/chat_theme.dart';
import 'package:swifty_chat/src/theme/default_theme.dart';
import 'package:swifty_chat_data/swifty_chat_data.dart';

final class ChatStateContainer extends InheritedWidget {
  const ChatStateContainer({
    required this.messageCellSizeConfigurator,
    required super.child,
    super.key,
    this.onHtmlWidgetPressed,
    this.onQuickReplyItemPressed,
    this.onCarouselButtonItemPressed,
    this.customMessageWidget,
  });

  final MessageCellSizeConfigurator messageCellSizeConfigurator;
  final void Function(QuickReplyItem)? onQuickReplyItemPressed;
  final void Function(CarouselButtonItem)? onCarouselButtonItemPressed;
  final Map<String, OnTap> Function()? onHtmlWidgetPressed;
  final Widget Function(Message)? customMessageWidget;

  static ChatStateContainer of(BuildContext context) {
    final ChatStateContainer? result =
        context.dependOnInheritedWidgetOfExactType<ChatStateContainer>();
    assert(result != null, 'No Chat found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ChatStateContainer oldWidget) => false;
}

final class Chat extends StatefulWidget {
  Chat({
    required this.chatMessageInputField,
    this.messages = const [],
    this.customMessageWidget,
    this.messageCellSizeConfigurator,
    this.theme = const DefaultChatTheme(),
  });

  final Widget chatMessageInputField;
  final List<Message> messages;
  final Widget Function(Message)? customMessageWidget;
  final ChatTheme theme;
  final MessageCellSizeConfigurator? messageCellSizeConfigurator;

  void Function(Message)? _onMessagePressed;
  void Function(QuickReplyItem)? _onQuickReplyItemPressed;
  void Function(CarouselButtonItem)? _onCarouselButtonItemPressed;
  Map<String, OnTap> Function()? _onHtmlWidgetPressed;

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

final class ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) => ChatStateContainer(
        messageCellSizeConfigurator: widget.messageCellSizeConfigurator ??
            MessageCellSizeConfigurator.defaultConfiguration(),
        onHtmlWidgetPressed: widget._onHtmlWidgetPressed,
        onQuickReplyItemPressed: widget._onQuickReplyItemPressed,
        onCarouselButtonItemPressed: widget._onCarouselButtonItemPressed,
        customMessageWidget: widget.customMessageWidget,
        child: InheritedChatTheme(
          theme: widget.theme,
          child: Column(
            children: [
              _ChatMessages(
                backgroundColor: widget.theme.backgroundColor,
                scrollController: widget._scrollController,
                messages: widget.messages,
                onMessagePressed: widget._onMessagePressed,
              ),
              widget.chatMessageInputField,
            ],
          ).gestures(
            onTap: () => FocusScope.of(context).unfocus(),
          ),
        ),
      );
}

final class _ChatMessages extends StatelessWidget {
  const _ChatMessages({
    required this.messages,
    required this.backgroundColor,
    required this.scrollController,
    this.onMessagePressed,
  });

  final List<Message> messages;
  final Color backgroundColor;
  final ScrollController scrollController;
  final void Function(Message)? onMessagePressed;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: backgroundColor,
      child: ListView.builder(
        key: ChatKeys.chatListView.key,
        controller: scrollController,
        // (reverse: true) Helps to scroll content automatically when keyboard opens
        reverse: true,
        itemCount: messages.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          child: ChatListItem(chatMessage: messages[index]),
          onTap: () => onMessagePressed?.call(messages[index]),
        ),
      ),
    ).expanded();
  }
}

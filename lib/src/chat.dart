import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'chat_list_item.dart';
import 'extensions/keys.dart';
import 'inherited_chat_theme.dart';
import 'message_cell_size_configurator.dart';
import 'models/carousel_item.dart';
import 'models/message.dart';
import 'models/quick_reply_item.dart';
import 'theme/chat_theme.dart';
import 'theme/default_theme.dart';

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
  bool updateShouldNotify(ChatStateContainer oldWidget) =>
      messageCellSizeConfigurator != oldWidget.messageCellSizeConfigurator ||
      onHtmlWidgetPressed != oldWidget.onHtmlWidgetPressed ||
      onQuickReplyItemPressed != oldWidget.onQuickReplyItemPressed ||
      onCarouselButtonItemPressed != oldWidget.onCarouselButtonItemPressed ||
      customMessageWidget != oldWidget.customMessageWidget;
}

final class ChatController {
  final Set<ScrollController> _scrollControllers = {};

  void scrollToBottom() {
    for (final controller in _scrollControllers) {
      if (controller.hasClients) {
        controller.animateTo(
          0,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
        );
      }
    }
  }
}

final class Chat extends StatefulWidget {
  Chat({
    super.key,
    required this.chatMessageInputField,
    this.messages = const [],
    this.customMessageWidget,
    this.messageCellSizeConfigurator,
    this.theme = const DefaultChatTheme(),
    this.onMessagePressed,
    this.onQuickReplyItemPressed,
    this.onCarouselButtonItemPressed,
    this.onHtmlWidgetPressed,
    ChatController? controller,
  }) : controller = controller ?? ChatController();

  final Widget chatMessageInputField;
  final List<Message> messages;
  final Widget Function(Message)? customMessageWidget;
  final ChatTheme theme;
  final MessageCellSizeConfigurator? messageCellSizeConfigurator;
  final void Function(Message)? onMessagePressed;
  final void Function(QuickReplyItem)? onQuickReplyItemPressed;
  final void Function(CarouselButtonItem)? onCarouselButtonItemPressed;
  final Map<String, OnTap> Function()? onHtmlWidgetPressed;
  final ChatController controller;

  @override
  ChatState createState() => ChatState();

  /// Triggered when quick reply message widget button is tapped.
  Chat setOnQuickReplyItemPressed(void Function(QuickReplyItem)? fn) =>
      _withCallbacks(
        onMessagePressed: onMessagePressed,
        onQuickReplyItemPressed: fn,
        onCarouselButtonItemPressed: onCarouselButtonItemPressed,
        onHtmlWidgetPressed: onHtmlWidgetPressed,
      );

  /// Triggered when carousel message widget button is tapped.
  Chat setOnCarouselItemButtonPressed(void Function(CarouselButtonItem)? fn) =>
      _withCallbacks(
        onMessagePressed: onMessagePressed,
        onQuickReplyItemPressed: onQuickReplyItemPressed,
        onCarouselButtonItemPressed: fn,
        onHtmlWidgetPressed: onHtmlWidgetPressed,
      );

  Chat setOnHTMLWidgetPressed(Map<String, OnTap> Function()? fn) =>
      _withCallbacks(
        onMessagePressed: onMessagePressed,
        onQuickReplyItemPressed: onQuickReplyItemPressed,
        onCarouselButtonItemPressed: onCarouselButtonItemPressed,
        onHtmlWidgetPressed: fn,
      );

  /// Triggered when a message widget is tapped.
  Chat setOnMessagePressed(void Function(Message)? fn) => _withCallbacks(
        onMessagePressed: fn,
        onQuickReplyItemPressed: onQuickReplyItemPressed,
        onCarouselButtonItemPressed: onCarouselButtonItemPressed,
        onHtmlWidgetPressed: onHtmlWidgetPressed,
      );

  Chat _withCallbacks({
    required void Function(Message)? onMessagePressed,
    required void Function(QuickReplyItem)? onQuickReplyItemPressed,
    required void Function(CarouselButtonItem)? onCarouselButtonItemPressed,
    required Map<String, OnTap> Function()? onHtmlWidgetPressed,
  }) =>
      Chat(
        key: key,
        chatMessageInputField: chatMessageInputField,
        messages: messages,
        customMessageWidget: customMessageWidget,
        messageCellSizeConfigurator: messageCellSizeConfigurator,
        theme: theme,
        onMessagePressed: onMessagePressed,
        onQuickReplyItemPressed: onQuickReplyItemPressed,
        onCarouselButtonItemPressed: onCarouselButtonItemPressed,
        onHtmlWidgetPressed: onHtmlWidgetPressed,
        controller: controller,
      );

  /// Scrolls the chat list to the bottom (most recent message).
  void scrollToBottom() => controller.scrollToBottom();
}

final class ChatState extends State<Chat> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    widget.controller._scrollControllers.add(_scrollController);
  }

  @override
  void didUpdateWidget(Chat oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller._scrollControllers.remove(_scrollController);
      widget.controller._scrollControllers.add(_scrollController);
    }
  }

  @override
  void dispose() {
    widget.controller._scrollControllers.remove(_scrollController);
    _scrollController.dispose();
    super.dispose();
  }

  /// Scrolls the chat list to the bottom (most recent message).
  void scrollToBottom() => widget.controller.scrollToBottom();

  @override
  Widget build(BuildContext context) => ChatStateContainer(
        messageCellSizeConfigurator: widget.messageCellSizeConfigurator ??
            MessageCellSizeConfigurator.defaultConfiguration(),
        onHtmlWidgetPressed: widget.onHtmlWidgetPressed,
        onQuickReplyItemPressed: widget.onQuickReplyItemPressed,
        onCarouselButtonItemPressed: widget.onCarouselButtonItemPressed,
        customMessageWidget: widget.customMessageWidget,
        child: InheritedChatTheme(
          theme: widget.theme,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Column(
              children: [
                _ChatMessages(
                  backgroundColor: widget.theme.backgroundColor,
                  scrollController: _scrollController,
                  messages: widget.messages,
                  onMessagePressed: widget.onMessagePressed,
                ),
                widget.chatMessageInputField,
              ],
            ),
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
    final indices = {
      for (var index = 0; index < messages.length; index++)
        messages[index].id: index,
    };
    return Expanded(
      child: ColoredBox(
        color: backgroundColor,
        child: Semantics(
          label: 'Chat messages',
          child: ListView.builder(
            key: ChatKeys.chatListView.key,
            controller: scrollController,
            // (reverse: true) Helps to scroll content automatically when keyboard opens
            reverse: true,
            itemCount: messages.length,
            findChildIndexCallback: (key) =>
                key is ValueKey<String> ? indices[key.value] : null,
            itemBuilder: (BuildContext context, int index) => GestureDetector(
              key: ValueKey(messages[index].id),
              child: ChatListItem(chatMessage: messages[index]),
              onTap: () => onMessagePressed?.call(messages[index]),
            ),
          ),
        ),
      ),
    );
  }
}

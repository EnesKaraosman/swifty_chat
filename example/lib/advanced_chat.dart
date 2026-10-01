import 'package:flutter/material.dart';
import 'package:swifty_chat/swifty_chat.dart';
import 'package:swifty_chat_mocked_data/swifty_chat_mocked_data.dart';

class AdvancedChat extends StatefulWidget {
  const AdvancedChat({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AdvancedChat createState() => _AdvancedChat();
}

class _AdvancedChat extends State<AdvancedChat> {
  final List<MockMessage> _messages = [];
  final ChatController _chatController = ChatController();

  bool isLightThemeActive = true;

  @override
  void initState() {
    super.initState();
    _messages.addAll(generateRandomMessages());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Chat'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                isLightThemeActive = !isLightThemeActive;
              });
            },
            child: const Text('Change Theme'),
          ),
        ],
      ),
      body: _chatWidget(context),
    );
  }

  Chat _chatWidget(BuildContext context) =>
      Chat(
            controller: _chatController,
            theme: isLightThemeActive
                ? const DefaultChatTheme()
                : const DarkChatTheme(),
            messages: _messages,
            chatMessageInputField: MessageInputField(
              key: const Key('message_input_field'),
              sendButtonTapped: (msg) {
                debugPrint(msg);
                setState(() {
                  final message = MockMessage(
                    date: DateTime.now(),
                    user: MockChatUser.outgoingUser,
                    id: DateTime.now().toString(),
                    isMe: true,
                    messageKind: MessageKind.text(msg),
                  );
                  _messages.insert(0, message);
                });
                _chatController.scrollToBottom();
              },
            ),
          )
          .setOnHTMLWidgetPressed(
            () => {
              "onLinkTap": (url, _, _) => debugPrint("onLinkTapped: $url"),
              "onImageTap": (src, _, _) => debugPrint("onImageTapped: $src"),
            },
          )
          .setOnCarouselItemButtonPressed((item) => debugPrint(item.payload))
          .setOnQuickReplyItemPressed((item) {
            debugPrint(item.title);
            final message = MockMessage(
              date: DateTime.now(),
              user: MockChatUser.outgoingUser,
              id: DateTime.now().toString(),
              isMe: true,
              messageKind: MessageKind.text(item.title),
            );
            setState(() => _messages.insert(0, message));
            _chatController.scrollToBottom();
          })
          .setOnMessagePressed((message) {
            debugPrint(message.messageKind.toString());
          });
}

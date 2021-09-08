import 'package:flutter/material.dart';
import 'package:swifty_chat/swifty_chat.dart';
import 'package:swifty_chat_mocked_data/swifty_chat_mocked_data.dart';

class BasicChat extends StatefulWidget {
  const BasicChat(Key? key) : super(key: key);

  @override
  _BasicChatState createState() => _BasicChatState();
}

class _BasicChatState extends State<BasicChat> {
  final List<MockMessage> _messages = [];

  late Chat chatView;

  @override
  void initState() {
    super.initState();
    setState(() {
      _messages.addAll(generateRandomTextMessages());
    });
  }

  @override
  Widget build(BuildContext context) {
    chatView = _chatWidget(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Basic Chat')),
      body: chatView,
    );
  }

  Chat _chatWidget(BuildContext context) => Chat(
        theme: const DarkChatTheme(),
        messages: _messages,
        messageCellSizeConfigurator:
            MessageCellSizeConfigurator.defaultConfiguration,
        chatMessageInputField: MessageInputField(
          key: const Key('message_input_field'),
          sendButtonTapped: (msg) {
            debugPrint(msg);
            setState(
              () {
                final message = MockMessage(
                  user: MockChatUser.outgoingUser,
                  id: DateTime.now().toString(),
                  isMe: true,
                  messageKind: MessageKind.text(msg),
                );
                _messages.insert(0, message);
                chatView.scrollToBottom();
              },
            );
          },
        ),
      );
}

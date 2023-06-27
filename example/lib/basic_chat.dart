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
        customLookupMessages: Custom1Messages(),
        locale: LocaleType.de,
        theme: const DarkChatTheme(),
        messages: _messages,
        chatMessageInputField: MessageInputField(
          key: const Key('message_input_field'),
          sendButtonTapped: (msg) {
            debugPrint(msg);
            setState(
              () {
                final message = MockMessage(
                  time: DateTime.now(),
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

class Custom1Messages implements LookupMessages {
  const Custom1Messages() : super();
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => 'önce';
  @override
  String suffixFromNow() => 'kaldı';
  @override
  String lessThanOneMinute(int seconds) => 'asd';
  @override
  String aboutAMinute(int minutes) => 'asd';
  @override
  String minutes(int minutes) => '$minutes asd';
  @override
  String aboutAnHour(int minutes) => 'asd';
  @override
  String hours(int hours) => '$hours asd';
  @override
  String aDay(int hours) => 'asd';
  @override
  String days(int days) => '$days ads';
  @override
  String aboutAMonth(int days) => 'asd';
  @override
  String months(int months) => '$months asd';
  @override
  String aboutAYear(int year) => 'bir yıl';
  @override
  String years(int years) => '$years yıl';
  @override
  String wordSeparator() => ' ';
}

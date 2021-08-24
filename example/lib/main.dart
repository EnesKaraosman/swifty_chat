import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chat/flutter_chat.dart';

import 'mock/mock_html.dart';
import 'mock/mock_string.dart';
import 'models/ek_chat_user.dart';
import 'models/ek_message.dart';
import 'models/ek_quick_reply_item.dart';
import 'theme/app_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  EKChatUser incoming = const EKChatUser(userName: "incoming");
  EKChatUser outgoing = const EKChatUser(userName: "outgoing");
  EKChatUser get randomUser => Random().nextBool() ? incoming : outgoing;

  @override
  void initState() {
    super.initState();
    setState(() {
      _messages.addAll(generateRandomMessages());
    });
  }

  late Chat chatView;

  @override
  Widget build(BuildContext context) {
    chatView = _chatWidget(context);
    return MaterialApp(
      title: 'Flutter Chat',
      theme: AppTheme.light(context),
      darkTheme: AppTheme.dark(context),
      debugShowCheckedModeBanner: false,
      home: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Flutter Chat Example'),
          ),
          body: chatView,
        ),
      ),
    );
  }

  Chat _chatWidget(BuildContext context) => Chat(
    lightTheme: AppTheme.light(context),
    darkTheme: AppTheme.dark(context),
    messages: _messages,
    messageCellSizeConfigurator: MessageCellSizeConfigurator.defaultConfiguration,
    chatMessageInputField: MessageInputField(sendButtonTapped: (msg) {
      print(msg);
      setState(() {
        final message = EKMessage(
          user: randomUser,
          id: DateTime.now().toString(),
          isMe: Random().nextBool(),
          messageKind: MessageKind.text(msg),
        );
        // _messages.insert(0, message);
        _messages.add(message);
        // chatView.scrollToBottom();
      });
    },),
  ).setOnHTMLWidgetPressed(() => {
    "onLinkTap": (url, _, __, ___) {
      print("onLinkTapped: $url");
    },
    "onImageTap": (src, _, __, ___) {
      print("onImageTapped: $src");
    }
  }).setOnQuickReplyItemPressed((item) {
      print(item.title);
    },
  );

  final List<EKMessage> _messages = [];

  List<EKMessage> generateRandomMessages() => 1.to(100).map((idx) {
    if (idx % 7 == 0) {
      return EKMessage(
        user: randomUser,
        id: DateTime.now().toString(),
        isMe: Random().nextBool(),
        messageKind: MessageKind.image('https://picsum.photos/300/200'),
      );
    } else if (idx % 9 == 0) {
      return EKMessage(
        user: randomUser,
        id: DateTime.now().toString(),
        isMe: Random().nextBool(),
        messageKind: MessageKind.quickReply(
          List.generate(
            Random().nextInt(7),
                (index) => EKQuickReplyItem(title: "Option $index"),
          ),
        ),
      );
    } else if (idx == 20) {
      return EKMessage(
        user: randomUser,
        id: DateTime.now().toString(),
        isMe: Random().nextBool(),
        messageKind: MessageKind.html(htmlData),
      );
    } else {
      return EKMessage(
        user: randomUser,
        id: DateTime.now().toString(),
        isMe: Random().nextBool(),
        messageKind:
        MessageKind.text(getRandomString(1 + Random().nextInt(40))),
      );
    }
  }).toList();
}

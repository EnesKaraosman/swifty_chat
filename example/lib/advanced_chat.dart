import 'package:flutter/material.dart';
import 'package:flutter_chat/flutter_chat.dart';

import 'mock/mock_messages.dart';
import 'models/ek_message.dart';
import 'theme/app_theme.dart';

class AdvancedChat extends StatefulWidget {
  @override
  _AdvancedChat createState() => _AdvancedChat();
}

class _AdvancedChat extends State<AdvancedChat> {
  final List<EKMessage> _messages = [];

  bool isLightThemeActive = true;

  late Chat chatView;

  @override
  void initState() {
    super.initState();
    setState(() {
      _messages.addAll(generateRandomMessages());
    });
  }

  @override
  Widget build(BuildContext context) {
    chatView = _chatWidget(context);
    return MaterialApp(
      title: 'Flutter Chat',
      theme:
      isLightThemeActive ? AppTheme.light(context) : AppTheme.dark(context),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Advanced Chat'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  isLightThemeActive = !isLightThemeActive;
                });
              },
              child: const Text(
                'Change Theme',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
        body: chatView,
      ),
    );
  }

  Chat _chatWidget(BuildContext context) => Chat(
    theme: isLightThemeActive
        ? AppTheme.light(context)
        : AppTheme.dark(context),
    messages: _messages,
    messageCellSizeConfigurator:
    MessageCellSizeConfigurator.defaultConfiguration,
    chatMessageInputField: MessageInputField(
      sendButtonTapped: (msg) {
        debugPrint(msg);
        setState(
              () {
            final message = EKMessage(
              user: randomUser,
              id: DateTime.now().toString(),
              isMe: randomUser.userName == outgoing.userName,
              messageKind: MessageKind.text(msg),
            );
            _messages.insert(0, message);
          },
        );
      },
    ),
  )
      .setOnHTMLWidgetPressed(
        () => {
      "onLinkTap": (url, _, __, ___) =>
          debugPrint("onLinkTapped: $url"),
      "onImageTap": (src, _, __, ___) =>
          debugPrint("onImageTapped: $src")
    },
  )
      .setOnCarouselItemButtonPressed((item) => debugPrint(item.payload))
      .setOnQuickReplyItemPressed(
        (item) {
      debugPrint(item.title);
      final message = EKMessage(
        user: randomUser,
        id: DateTime.now().toString(),
        isMe: randomUser.userName == outgoing.userName,
        messageKind: MessageKind.text(item.title),
      );
      _messages.insert(0, message);
      chatView.scrollToBottom();
    },
  );
}

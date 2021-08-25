# flutter_chat

### Usage

TLDR;
See the example app in the `example` folder.

This lib requires some abstract classes to be implemented to get started.
`Message`, `ChatUser` & `QuickReplyItem` (if you'll use the `MessageKind.quickReply`)

```dart
class MessageKind {
  MessageKind.text(String text);
  MessageKind.image(String imageURL);
  MessageKind.quickReply(List<IQuickReplyItem> quickReplies);
  MessageKind.html(String html);
}
```

Here below exists an example that covers all the available `MessageKind` usages.
Note that `EK...` prefixed classes are the concrete implementation of the related abstract classes.

```dart
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
  final List<EKMessage> _messages = [];

  EKChatUser incoming = const EKChatUser(userName: "incoming");
  EKChatUser outgoing = const EKChatUser(userName: "outgoing");
  EKChatUser get randomUser => Random().nextBool() ? incoming : outgoing;

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
          title: const Text('Chat'),
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
              isMe: Random().nextBool(),
              messageKind: MessageKind.text(msg),
            );
            _messages.add(message);
          },
        );
      },
    ),
  )
      .setOnHTMLWidgetPressed(
        () => {
      "onLinkTap": (url, _, __, ___) {
        debugPrint("onLinkTapped: $url");
      },
      "onImageTap": (src, _, __, ___) {
        debugPrint("onImageTapped: $src");
      }
    },
  )
      .setOnQuickReplyItemPressed(
        (item) => debugPrint(item.title),
  );

  List<EKMessage> generateRandomMessages() => 1.to(100).map(
        (idx) {
      if (idx % 7 == 0) {
        return EKMessage(
          user: randomUser,
          id: DateTime.now().toString(),
          isMe: Random().nextBool(),
          messageKind: MessageKind.image('https://picsum.photos/300/200'),
        );
      } else if (idx % 13 == 0) {
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
      } else if (idx == 17) {
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
    },
  ).toList();
}
```

### Theming

Visit [Theming.md](Theming.md) for details.

### Message Cell Size Configuration

Visit [MessageCellSizeConfiguration.md](MessageCellSizeConfiguration.md) for details.
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
  EKChatUser incoming = const EKChatUser(userName: "incoming");
  EKChatUser outgoing = const EKChatUser(userName: "outgoing");
  EKChatUser get randomUser => Random().nextBool() ? incoming : outgoing;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Flutter Chat Example'),
          ),
          body: _chatWidget,
        ),
      ),
    );
  }

  Widget get _chatWidget {
    return Chat(
      lightTheme: AppTheme.light,
      darkTheme: AppTheme.dark,
      items: _messages,
      messageCellSizeConfigurator: MessageCellSizeConfigurator.defaultConfiguration,
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
  }

  List<EKMessage> get _messages => 1.to(100).map((idx) {
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
```

### Theming

Visit [Theming.md](Theming.md) for details.

### Message Cell Size Configuration

Visit [MessageCellSizeConfiguration.md](MessageCellSizeConfiguration.md) for details.
# flutter_chat

### Features

Supported Message types;
- Text
- Image
- Html
- QuickReply
- Carousel

Other;

- Scroll to bottom
  + use `scrollToBottom` method on `Chat`

### Usage

TLDR;
See the example app in the `example` folder.

This lib requires some abstract classes to be implemented to get started.
`Message`, `ChatUser` & `QuickReplyItem` (if you'll use the `MessageKind.quickReply`)

```dart
class MessageKind {
  MessageKind.text(String text);
  MessageKind.image(String imageURL);
  MessageKind.quickReply(List<QuickReplyItem> quickReplies);
  MessageKind.carousel(List<CarouselItem> carousel);
  MessageKind.html(String html);
}
```

Here below exists an example that covers all the available `MessageKind` usages.
Note that `EK...` prefixed classes are the concrete implementation of the related abstract classes.

```dart
import 'dart:math';

import 'package:example/models/ek_carousel_item.dart';
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

  EKChatUser incoming = EKChatUser(
    userName: "incoming",
    avatar: UserAvatar(
      imageURL: Uri.parse('https://i.pravatar.cc/240'),
      position: AvatarPosition.bottom,
    ),
  );
  EKChatUser outgoing = EKChatUser(
    userName: "outgoing",
  );

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
              isMe: randomUser.userName == outgoing.userName,
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
      "onLinkTap": (url, _, __, ___) =>
          debugPrint("onLinkTapped: $url"),
      "onImageTap": (src, _, __, ___) =>
          debugPrint("onImageTapped: $src")
    },
  )
      .setOnCarouselItemButtonPressed((item) => debugPrint(item.payload))
      .setOnQuickReplyItemPressed((item) {
        debugPrint(item.title);
        chatView.scrollToBottom();
      });

  List<EKMessage> generateRandomMessages() => 1.to(100).map(
        (idx) {
      final user = randomUser;
      final bool isMe = user.userName == outgoing.userName;
      if (idx % 7 == 0) {
        return EKMessage(
          user: user,
          id: DateTime.now().toString(),
          isMe: isMe,
          messageKind: MessageKind.image('https://picsum.photos/300/200'),
        );
      } else if (idx % 13 == 0) {
        return EKMessage(
          user: user,
          id: DateTime.now().toString(),
          isMe: isMe,
          messageKind: MessageKind.quickReply(
            List.generate(
              Random().nextInt(7),
                  (index) => EKQuickReplyItem(title: "Option $index"),
            ),
          ),
        );
      } else if (idx % 23 == 0) {
        return EKMessage(
          user: user,
          id: DateTime.now().toString(),
          isMe: isMe,
          messageKind: MessageKind.carousel(
            List.generate(
              Random().nextInt(3),
                  (index) => EKCarouselItem(
                title: 'Title $index',
                subtitle:
                'Subtitle $index ${getRandomString(1 + Random().nextInt(80))}',
                imageURL: 'https://picsum.photos/300/200',
                buttons: [
                  CarouselButtonItem(
                    title: 'Select',
                    url: 'url',
                    payload: 'payload',
                  )
                ],
              ),
            ),
          ),
        );
      } else if (idx == 17) {
        return EKMessage(
          user: user,
          id: DateTime.now().toString(),
          isMe: isMe,
          messageKind: MessageKind.html(htmlData),
        );
      } else {
        return EKMessage(
          user: user,
          id: DateTime.now().toString(),
          isMe: isMe,
          messageKind:
          MessageKind.text(getRandomString(1 + Random().nextInt(40))),
        );
      }
    },
  ).toList();
}
```

### Avatar

To set avatar for a `ChatUser`, simply pass `avatar` parameter of the related user.

```dart
UserAvatar({
    required this.imageURL,
    this.size = 40,
    this.position = AvatarPosition.center, // top, center, bottom
});
```

### Theming

Visit [Theming.md](Theming.md) for details.

### Message Cell Size Configuration

Visit [MessageCellSizeConfiguration.md](MessageCellSizeConfiguration.md) for details.
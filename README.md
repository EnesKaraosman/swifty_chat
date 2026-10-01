# swifty_chat

| QuickReply, Text, Image      | Html  | Carousel | Custom |
:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:
<img src="https://github.com/EnesKaraosman/swifty_chat/blob/main/example/assets/screenshots/kind_image_and_quick_reply_and_text.png?raw=true" width="240"/> | <img src="https://github.com/EnesKaraosman/swifty_chat/blob/main/example/assets/screenshots/kind_html.png?raw=true" width="240"/> | <img src="https://github.com/EnesKaraosman/swifty_chat/blob/main/example/assets/screenshots/kind_carousel.png?raw=true" width="240"/> | <img src="https://github.com/EnesKaraosman/swifty_chat/blob/main/example/assets/screenshots/kind_custom.png?raw=true" width="240"/>

### Platforms

- [x] iOS, macOS
- [x] Android
- [x] Web

### Features

Supported Message types;
- Text
- Image
  - An `ImageProvider` is required, so you can use network or asset images.
- Html
  - [flutter_html](https://pub.dev/packages/flutter_html) package is used for displaying HTMLs, so we have support what package supports.
- QuickReply
- Carousel
- Custom
  - See [CustomMessage.md](CustomMessage.md) for details.

Other;

- Scroll to bottom
  + Pass a `ChatController` to `Chat`, then call `controller.scrollToBottom()`.

### Usage

Requires Flutter 3.41.0 or later. This example sends text messages using concrete `Message` and `ChatUser` classes:

```dart
import 'package:flutter/material.dart';
import 'package:swifty_chat/swifty_chat.dart';

void main() => runApp(const MaterialApp(home: ChatExample()));

class AppUser extends ChatUser {
  AppUser(String name) : super(userName: name);
}

class AppMessage extends Message {
  const AppMessage({
    required super.user,
    required super.id,
    required super.isMe,
    required super.messageKind,
    required super.date,
  });
}

class ChatExample extends StatefulWidget {
  const ChatExample({super.key});

  @override
  State<ChatExample> createState() => _ChatExampleState();
}

class _ChatExampleState extends State<ChatExample> {
  final _messages = <Message>[];
  final _controller = ChatController();
  final _me = AppUser('You');

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Chat(
      controller: _controller,
      messages: _messages,
      chatMessageInputField: MessageInputField(
        sendButtonTapped: (text) {
          final now = DateTime.now();
          setState(
            () => _messages.insert(
              0,
              AppMessage(
                user: _me,
                id: now.microsecondsSinceEpoch.toString(),
                isMe: true,
                messageKind: MessageKind.text(text),
                date: now,
              ),
            ),
          );
          _controller.scrollToBottom();
        },
      ),
    ),
  );
}
```

Messages are ordered newest first. For other message kinds, see [MessageKind](lib/src/models/message_kind.dart) and the [BasicChat](example/lib/basic_chat.dart) and [AdvancedChat](example/lib/advanced_chat.dart) demos. `QuickReplyItem` and `CarouselItem` require concrete subclasses when used.

### Message widget tap actions

Pass `onMessagePressed`, `onQuickReplyItemPressed`, `onCarouselButtonItemPressed`, or `onHtmlWidgetPressed` to the `Chat` constructor. See [AdvancedChat](example/lib/advanced_chat.dart) for all four callbacks.

When migrating from 2.x, use the widget returned by `setOn*` methods. Calling one of these methods without using its return value no longer registers the callback.

### Avatar

To set avatar for a `ChatUser`, simply pass `avatar` parameter of the related user.

```dart
UserAvatar({
    required this.imageProvider, // ImageProvider
    this.size = 40,
    this.position = AvatarPosition.center, // top, center, bottom
});
```

### Theming

Visit [Theming.md](Theming.md) for details.

### Custom Message

Visit [CustomMessage.md](CustomMessage.md) for details.

### Message Cell Size Configuration

Visit [MessageCellSizeConfiguration.md](MessageCellSizeConfiguration.md) for details.

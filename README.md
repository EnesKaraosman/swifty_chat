# flutter_chat
 
2 important model class is below;
```dart
abstract class Message {
  final String? id;
  final bool isMe;
  final MessageKind messageKind;
  // ...
}

class MessageKind {
  // ..
  MessageKind.text(String text): text = text;
  MessageKind.image(String imageURL): imageURL = imageURL;
  MessageKind.quickReply(List<IQuickReplyItem> quickReplies): quickReplies = quickReplies;
  MessageKind.html(String html): htmlData = html;
}
```

### Usage

Here below is minimum code required to get started (see up & running)
Note that `EKMessage` is the concrete implementation of the abstract class `Message`.

```dart
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MaterialApp(
        home: Scaffold(
          body: _chatWidget,
        ),
      ),
    );
  }

  Widget get _chatWidget {
    return Chat(
      items: _messages,
      onQuickReplyItemPressed: (EKQuickReplyItem item) {
        print(item.title);
      },
    );
  }

  // Mock message list.
  List<EKMessage> _messages = 1.to(100).map((num) {
    if (num % 7 == 0) {
      return EKMessage(
        id: DateTime.now().toString(),
        isMe: Random().nextBool(),
        messageKind: MessageKind.image('https://picsum.photos/300/200'),
      );
    } else if (num % 13 == 0) {
      return EKMessage(
          id: DateTime.now().toString(),
          isMe: Random().nextBool(),
          messageKind: MessageKind.quickReply([
            EKQuickReplyItem(title: 'Option1'),
            EKQuickReplyItem(title: 'Option2')
          ])
      );
    } else if (num == 20) {
      return EKMessage(
        id: DateTime.now().toString(),
        isMe: Random().nextBool(),
        messageKind: MessageKind.html(htmlData),
      );
    } else {
      return EKMessage(
        id: DateTime.now().toString(),
        isMe: Random().nextBool(),
        messageKind: MessageKind.text(getRandomString(1 + Random().nextInt(40))),
      );
    }
  }).toList();
}
```
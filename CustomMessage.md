# swifty_chat

### Custom Message

To create a custom message (`MessageKind`) and look follow these steps below;

1) Add a message to your dataSource with the `MessageKind.custom(dynamic custom)` option.

Since `.custom` constructor expects a `dynamic` parameter you can pass any type.

```dart
final dynamic messageKind = MessageKind.custom("⚙️ Hey! This is my custom message!!!! ⚙️");

MockMessage(
    user: MockChatUser.incomingUser,
    id: DateTime.now().toString(),
    isMe: false,
    messageKind: messageKind,
)
```

2) Pass `customMessageWidget` parameter while constructing `Chat`.

```dart
Chat(
  customMessageWidget: (message) =>
    MyCustomMessageWidget(message: message),
  ...
);
```

Since `customMessageWidget` has the type `Widget Function(Message)?` you can return any Widget combinations you want.

Be aware that you can grab the `messageKind.custom` parameter from the given `message` to work on it.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:swifty_chat/swifty_chat.dart';
import 'package:swifty_chat_mocked_data/swifty_chat_mocked_data.dart';

import 'util/util.dart';

void main() {
  group("Chat", () {
    testWidgets("Chat view Should be available with the minimum requirements", (tester) async {
      await tester.pumpWidget(
        _appContainer(
          Chat(
            messages: const [],
            chatMessageInputField: _messageInputField((_) {}),
          ),
        ),
      );
    });

    testWidgets("Message Input Field Should Exist", (tester) async {
      await tester.pumpWidget(
        _appContainer(
          Chat(
            messages: const [],
            chatMessageInputField: _messageInputField((_) {}),
          ),
        ),
      );
      await wait(1000);
      expect(find.byKey(ChatKeys.messageInputWidget.key), findsOneWidget);
    });

    testWidgets("ListView Should contain n message widget", (tester) async {
      const messageCount = 20;
      await tester.pumpWidget(
        _appContainer(
          Chat(
            messages: generateRandomTextMessages(count: messageCount),
            chatMessageInputField: _messageInputField((_) {}),
          ),
        ),
      );
      await wait(1000);
      final listView = find.byKey(ChatKeys.chatListView.key);
      expect(listView, findsNWidgets(messageCount));
    });

    testWidgets("ListView Should be scrollable", (tester) async {});

    testWidgets("ListView Should show newly added message", (tester) async {});

    testWidgets("ListView Should scroll to the bottom", (tester) async {});

    testWidgets(
        "Quick Reply Item Should respond to button events", (tester) async {});

    testWidgets(
        "Carousel Item Should respond to button events", (tester) async {});
  });
}

Widget _appContainer(Widget child) => MaterialApp(
      home: Scaffold(
        body: child,
      ),
    );

MessageInputField _messageInputField(Function(String) onSendAction) =>
    MessageInputField(
      key: ChatKeys.messageInputWidget.key,
      sendButtonTapped: onSendAction,
    );
// debugPrint(msg);
// setState(
//       () {
//     final message = EKMessage(
//       user: outgoing,
//       id: DateTime.now().toString(),
//       isMe: true,
//       messageKind: MessageKind.text(msg),
//     );
//     _messages.insert(0, message);
//     chatView.scrollToBottom();
//   },
// );

Chat _chatWidget() => Chat(
      messages: generateRandomTextMessages(count: 20),
      chatMessageInputField: _messageInputField((msg) {}),
    );

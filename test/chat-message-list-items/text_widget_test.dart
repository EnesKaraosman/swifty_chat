import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:swifty_chat/swifty_chat.dart';
import 'package:swifty_chat_mocked_data/swifty_chat_mocked_data.dart';

void main() {
  group('Chat Text Theme', () {
    testWidgets('Should reflect Light Theme', (tester) async {
      await testTextTheme(
        tester: tester,
        isLightMode: true,
        isIncomingMessage: true,
      );
      await testTextTheme(
        tester: tester,
        isLightMode: true,
        isIncomingMessage: false,
      );
    });
    testWidgets('Should reflect Dark Theme', (tester) async {
      await testTextTheme(
        tester: tester,
        isLightMode: false,
        isIncomingMessage: true,
      );
      await testTextTheme(
        tester: tester,
        isLightMode: false,
        isIncomingMessage: false,
      );
    });
  });
}

Future<void> testTextTheme({
  required WidgetTester tester,
  required bool isLightMode,
  required bool isIncomingMessage,
}) async {
  final theme = isLightMode ? const DefaultChatTheme() : const DarkChatTheme();
  final message = isIncomingMessage ? "incomingMessage_1" : "outgoingMessage_1";
  final messageUser =
      isIncomingMessage ? MockChatUser.incomingUser : MockChatUser.outgoingUser;
  await tester.pumpWidget(
    _appContainer(
      Chat(
        theme: theme,
        messages: [
          MockMessage(
            time: DateTime.now(),
            user: messageUser,
            id: DateTime.now().toString(),
            isMe: !isIncomingMessage,
            messageKind: MessageKind.text(message),
          ),
        ],
        chatMessageInputField: _messageInputField((_) {}),
      ),
    ),
  );

  final textStyle = isIncomingMessage
      ? theme.incomingMessageBodyTextStyle
      : theme.outgoingMessageBodyTextStyle;
  final textWidget = tester.widget<Text>(find.text(message));
  expect(
    textWidget.style.toString(),
    textStyle.toString(),
  );
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

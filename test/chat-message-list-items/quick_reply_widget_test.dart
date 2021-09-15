import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:swifty_chat/src/chat.dart';

import 'package:swifty_chat/swifty_chat.dart';
import 'package:swifty_chat_mocked_data/swifty_chat_mocked_data.dart';

import '../util/util.dart';

void main() {
  CustomBindings();
  group('Chat Quick Reply Theme', () {
    testWidgets('Should reflect Light Theme', (tester) async {
      await testQuickReplyTheme(
        tester: tester,
        isLightMode: true,
        isIncomingMessage: true,
      );
      // await testQuickReplyTheme(
      //   tester: tester,
      //   isLightMode: true,
      //   isIncomingMessage: false,
      // );
    });
    testWidgets('Should reflect Dark Theme', (tester) async {
      await testQuickReplyTheme(
        tester: tester,
        isLightMode: false,
        isIncomingMessage: true,
      );
      // await testQuickReplyTheme(
      //   tester: tester,
      //   isLightMode: false,
      //   isIncomingMessage: false,
      // );
    });
  });
}

Future<void> testQuickReplyTheme({
  required WidgetTester tester,
  required bool isLightMode,
  required bool isIncomingMessage,
}) async {
  final theme = isLightMode ? const DefaultChatTheme() : const DarkChatTheme();
  const quickReplyOptionTitle = "Option 1";
  final messageUser =
      isIncomingMessage ? MockChatUser.incomingUser : MockChatUser.outgoingUser;
  await tester.pumpWidget(
    _appContainer(
      Chat(
        theme: theme,
        messages: [
          MockMessage(
            user: messageUser,
            id: DateTime.now().toString(),
            isMe: !isIncomingMessage,
            messageKind: MessageKind.quickReply([
              MockQuickReplyItem(title: quickReplyOptionTitle),
            ]),
          ),
        ],
        chatMessageInputField: _messageInputField((_) {}),
      ),
    ),
  );

  final quickReplyButtonStyle = isIncomingMessage
      ? theme.quickReplyButtonStyle
      : theme.quickReplyButtonStyle;

  // Finds a parent widget of type MyParentWidget.
  final buttonWidget = tester
      .element(find.text(quickReplyOptionTitle))
      .findAncestorWidgetOfExactType<OutlinedButton>();

  // Hacky way to compare styles via toString, comparing object gives wrong result.
  expect(
    buttonWidget?.style?.textStyle.toString(),
    quickReplyButtonStyle.textStyle.toString(),
  );
  expect(
    buttonWidget?.style?.backgroundColor.toString(),
    quickReplyButtonStyle.backgroundColor.toString(),
  );
  expect(
    buttonWidget?.style?.foregroundColor.toString(),
    quickReplyButtonStyle.foregroundColor.toString(),
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

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:swifty_chat/src/chat-message-list-items/text_widget.dart';
import 'package:swifty_chat/src/chat.dart';

import 'package:swifty_chat/swifty_chat.dart';
import 'package:swifty_chat_mocked_data/swifty_chat_mocked_data.dart';

void main() {
  group("Chat", () {
    testWidgets("Chat view Should be available with the minimum requirements",
        (tester) async {
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
      expect(find.byKey(ChatKeys.messageInputWidget.key), findsOneWidget);
    });

    testWidgets("ListView Should contain n message widget", (tester) async {
      const messageCount = 7;
      assert(messageCount > 5 && messageCount < 8);
      final messages = generateRandomTextMessagesWithName(
        (index) => "Item $index",
        count: messageCount,
      ).reversed.toList();
      await tester.pumpWidget(
        _appContainer(
          Chat(
            messages: messages,
            chatMessageInputField: _messageInputField((_) {}),
          ),
        ),
      );
      await tester.pump();
      final textWidgets = tester.widgetList(find.byType(TextMessageWidget));
      expect(textWidgets.length, messages.length);
      expect(find.text("Item ${messageCount - 1}"), findsOneWidget);
    });

    testWidgets("ListView Should be scrollable", (tester) async {
      const messageCount = 100;
      final messages = generateRandomTextMessagesWithName(
        (index) => "Item $index",
        count: messageCount,
      ).reversed.toList();
      await tester.pumpWidget(
        _appContainer(
          Chat(
            messages: messages,
            chatMessageInputField: _messageInputField((_) {}),
          ),
        ),
      );
      await tester.pump();
      expect(find.text('Item ${messageCount - 1}'), findsOneWidget);
      await tester.fling(find.byType(ListView), const Offset(0, 200), 500);
      await tester.pumpAndSettle();
      expect(find.text('Item ${messageCount - 1}'), findsNothing);
    });

    testWidgets("ListView Should show newly added message", (tester) async {
      late final Chat chatView;
      final messages = generateRandomMessages().reversed.toList();
      void messageSendAction(String msg) {
        final message = MockMessage(
          user: MockChatUser.outgoingUser,
          id: DateTime.now().toString(),
          isMe: true,
          messageKind: MessageKind.text(msg),
        );
        messages.insert(0, message);
        chatView.scrollToBottom();
      }

      chatView = Chat(
        messages: messages,
        chatMessageInputField: _messageInputField(messageSendAction),
      );
      await tester.pumpWidget(_appContainer(chatView));
      await tester.pump();

      const newMessage = "What's up";
      await _addMessageToChatList(tester, newMessage);

      final chatState = tester.state(find.byType(Chat)) as ChatState;
      chatState.setState(() {});
      await tester.pump(const Duration(milliseconds: 500));

      // Check if message displayed on List.
      expect(
        find.text(newMessage),
        findsOneWidget,
        reason: '⚠️ Make sure to implement sendButton press action',
      );
    });

    testWidgets("ListView Should scroll to the bottom", (tester) async {
      final messages = generateRandomMessages().reversed.toList();
      final chatView = Chat(
        messages: messages,
        chatMessageInputField: _messageInputField((_) {}),
      );
      await tester.pumpWidget(_appContainer(chatView));
      await tester.pump();

      final listView = find.byType(ListView);
      final listViewWidget = tester.widget<ListView>(listView);
      final scrollController = listViewWidget.controller;
      final currentOffset = scrollController?.offset ?? 0;
      expect(
        currentOffset == 0,
        true,
        reason:
            "ListView's position is not initially bottom. Make sure list has reverse=true",
      );

      await tester.fling(listView, const Offset(0, 200), 500);
      await tester.pumpAndSettle(const Duration(seconds: 10));

      // Bottom of the listView
      expect(
        (scrollController?.offset ?? 0) ==
            (scrollController?.position.minScrollExtent ?? 0),
        false,
        reason: 'List could not scrolled properly.',
      );

      chatView.scrollToBottom(); // Does the trick.
      await tester.pumpAndSettle(const Duration(seconds: 10));
      expect(
        (scrollController?.offset ?? 0) ==
            (scrollController?.position.minScrollExtent ?? 0),
        true,
        reason:
            'List could not scrolled to bottom properly, check Chat.scrollToBottom method.',
      );
    });

    testWidgets(
      "Should close keyboard when tapped outside.",
      (tester) async {
        await tester.pumpWidget(
          _appContainer(
            Chat(
              messages: const [],
              chatMessageInputField: _messageInputField((_) {}),
            ),
          ),
        );

        final textField = tester.firstWidget<TextField>(find.byType(TextField));

        final messageInputFieldWidget = find.byType(TextField);
        expect(
          textField.focusNode?.hasFocus,
          false,
          reason: 'Should have no initial focus',
        );
        await tester.tap(messageInputFieldWidget);
        await tester.showKeyboard(messageInputFieldWidget);

        expect(textField.focusNode?.hasFocus, true);

        const msg = 'New message';
        await tester.enterText(messageInputFieldWidget, msg);
        expect(
          find.text(msg),
          findsOneWidget,
          reason: 'Input widget does not contain the entered text',
        );

        await tester.tap(find.byType(Chat));
        expect(
          textField.focusNode?.hasFocus,
          false,
          reason: 'Should lose focus after Chat tapped',
        );
      },
    );

    testWidgets(
      "Keyboard Should respond Send button.",
      (tester) async {
        await tester.pumpWidget(
          _appContainer(
            Chat(
              messages: const [],
              chatMessageInputField: _messageInputField((_) {}),
            ),
          ),
        );

        final textField = tester.firstWidget<TextField>(find.byType(TextField));

        final messageInputFieldWidget = find.byType(TextField);
        await tester.tap(messageInputFieldWidget);
        await tester.showKeyboard(messageInputFieldWidget);

        const msg = 'New message';
        await tester.enterText(messageInputFieldWidget, msg);
        expect(textField.controller?.text.isEmpty, false);

        await tester.testTextInput.receiveAction(TextInputAction.send);
        await tester.pump();

        expect(textField.controller?.text.isEmpty, true);
      },
    );

    testWidgets('HTML MessageKind should contain link & image', (tester) async {
      late final Chat chatView;
      final messages = generateRandomTextMessages().reversed.toList()
        ..insert(
          0,
          MockMessage(
            user: MockChatUser.incomingUser,
            id: DateTime.now().toString(),
            isMe: false,
            messageKind: MessageKind.html(htmlData),
          ),
        );

      chatView = Chat(
        messages: messages,
        chatMessageInputField: _messageInputField((_) {}),
      ).setOnHTMLWidgetPressed(() => {
            "onLinkTap": (url, _, __, ___) => debugPrint("onLinkTap: $url"),
            "onImageTap": (src, _, __, ___) => debugPrint("onImageTapped: $src")
          });

      await tester.pumpWidget(_appContainer(chatView));

      final html = tester.widget<Html>(find.byType(Html));
      final parsedHTML = HtmlParser.parseHTML(html.data!);
      final aNode = parsedHTML.getElementsByTagName("a")[1];
      expect(aNode.attributes.values.first == htmlDataMockLinkPayload, true);

      final imageNode = parsedHTML.getElementsByTagName("img").last;
      expect(
        imageNode.attributes.values.first == "Flutter",
        true,
      ); // alt="Flutter"
      // TODO: Tap elements inside HTML widget, test setOnHTMLWidgetPressed flow.
    });
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

Future<void> _addMessageToChatList(WidgetTester tester, String message) async {
  // Get textField
  final messageInput = find.byKey(ChatKeys.messageInputWidget.key);
  expect(
    messageInput,
    findsOneWidget,
    reason: '⚠️ Make sure to add message input widget',
  );
  tester.printToConsole("Message input field found..");

  // Fill textField
  final messageTextField = find.byKey(ChatKeys.messageTextField.key);
  await tester.enterText(messageTextField, message);
  tester.printToConsole('$message entered to the textField');
  await tester.pump();

  // Send message written in textField
  final messageSendButton = find.byKey(ChatKeys.messageSendButton.key);
  await tester.tap(messageSendButton);
  await tester.pump();
  tester.printToConsole('messageSendButton tapped');
}

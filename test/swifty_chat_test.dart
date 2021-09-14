import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:swifty_chat/src/chat.dart';

import 'package:swifty_chat/swifty_chat.dart';
import 'package:swifty_chat_mocked_data/swifty_chat_mocked_data.dart';

class CustomBindings extends AutomatedTestWidgetsFlutterBinding {
  @override
  bool get overrideHttpClient => false;
}

void main() {
  // TestWidgetsFlutterBinding.ensureInitialized();
  CustomBindings();
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
      const messageCount = 10;
      assert(messageCount > 5);
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
      expect(find.text("Item 0"), findsNothing);
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
        (scrollController?.offset ?? 0) == (scrollController?.position.minScrollExtent ?? 0),
        false,
        reason: 'List could not scrolled properly.',
      );

      chatView.scrollToBottom(); // Does the trick.
      await tester.pumpAndSettle(const Duration(seconds: 10));
      expect(
        (scrollController?.offset ?? 0) == (scrollController?.position.minScrollExtent ?? 0),
        true,
        reason:
            'List could not scrolled to bottom properly, check Chat.scrollToBottom method.',
      );
    });

    testWidgets("Quick Reply Item Should respond to button events",
        (tester) async {
      const quickReplyOption1Title = "MyOption 1";
      const quickReplyOption2Title = "MyOption 2";
      late final Chat chatView;
      final messages = generateRandomTextMessages().reversed.toList()
        ..insert(
          0,
          MockMessage(
            user: MockChatUser.incomingUser,
            id: DateTime.now().toString(),
            isMe: true,
            messageKind: MessageKind.quickReply([
              MockQuickReplyItem(title: quickReplyOption1Title),
              MockQuickReplyItem(title: quickReplyOption2Title),
            ]),
          ),
        );
      void quickReplyItemPressedAction(QuickReplyItem item) {
        final message = MockMessage(
          user: MockChatUser.outgoingUser,
          id: DateTime.now().toString(),
          isMe: false,
          messageKind: MessageKind.text("${item.title}_pressed"),
        );
        messages.insert(0, message);
        chatView.scrollToBottom();
      }

      chatView = Chat(
        messages: messages,
        chatMessageInputField: _messageInputField((_) {}),
      ).setOnQuickReplyItemPressed(quickReplyItemPressedAction);

      await tester.pumpWidget(_appContainer(chatView));

      final quickReplyOption1 = find.text(quickReplyOption1Title);
      await tester.tap(quickReplyOption1);
      await tester.pump();

      final chatState = tester.state(find.byType(Chat)) as ChatState;
      chatState.setState(() {});
      await tester.pump(const Duration(milliseconds: 500));

      expect(
        find.text("${quickReplyOption1Title}_pressed"),
        findsOneWidget,
        reason: 'setOnQuickReplyItemPressed not implemented properly in Chat',
      );
    });

    testWidgets("Carousel Item Should respond to button events",
        (tester) async {
      const carouselOption1Title = "MyOption 1";
      const carouselOption2Title = "MyOption 2";
      late final Chat chatView;
      final messages = generateRandomTextMessages().reversed.toList()
        ..insert(
          0,
          MockMessage(
            user: MockChatUser.incomingUser,
            id: DateTime.now().toString(),
            isMe: false,
            messageKind: MessageKind.carousel([
              MockCarouselItem(
                  title: 'title1',
                  subtitle: 'subtitle1',
                  buttons: [
                    CarouselButtonItem(
                        title: carouselOption1Title,
                        url: 'url1',
                        payload: 'payload2')
                  ]),
              MockCarouselItem(
                  title: 'title2',
                  subtitle: 'subtitle2',
                  buttons: [
                    CarouselButtonItem(
                        title: carouselOption2Title,
                        url: 'url2',
                        payload: 'payload2')
                  ]),
            ]),
          ),
        );
      void carouselItemPressedAction(CarouselButtonItem item) {
        final message = MockMessage(
          user: MockChatUser.outgoingUser,
          id: DateTime.now().toString(),
          isMe: true,
          messageKind: MessageKind.text("${item.title}_pressed"),
        );
        messages.insert(0, message);
        chatView.scrollToBottom();
      }

      chatView = Chat(
        messages: messages,
        chatMessageInputField: _messageInputField((_) {}),
      ).setOnCarouselItemButtonPressed(carouselItemPressedAction);

      await tester.pumpWidget(_appContainer(chatView));

      final carouselOption1 = find.text(carouselOption1Title);
      await tester.tap(carouselOption1);
      await tester.pump();

      final chatState = tester.state(find.byType(Chat)) as ChatState;
      chatState.setState(() {});
      await tester.pump(const Duration(milliseconds: 500));

      expect(
        find.text("${carouselOption1Title}_pressed"),
        findsOneWidget,
        reason: 'setOnQuickReplyItemPressed not implemented properly in Chat',
      );
    });

    testWidgets('HTML MessageKind should respond some events', (tester) async {
      late final Chat chatView;
      final messages = generateRandomTextMessages().reversed.toList()
        ..insert(
          0,
          generateRandomMessage(MockMessageKind.html),
        );

      chatView = Chat(
        messages: messages,
        chatMessageInputField: _messageInputField((_) {}),
      ).setOnHTMLWidgetPressed(() => {
            "onLinkTap": (url, _, __, ___) {
              expect(url == htmlDataMockLinkPayload, true);
            },
            "onImageTap": (src, _, __, ___) => debugPrint("onImageTapped: $src")
          });

      await tester.pumpWidget(_appContainer(chatView));
      // TODO: Can't get the text inside HTML widget.
      final websiteLink = find.text(htmlDataMockLinkTitle);
      await tester.tap(websiteLink);
      await tester.pump();
    });
  });

  group('Chat Theme', () {
    testWidgets('Should reflect Light Theme', (tester) async {
      await tester.pumpWidget(
        _appContainer(
          Chat(
            theme: const DefaultChatTheme(),
            messages: generateRandomMessages(),
            chatMessageInputField: _messageInputField((_) {}),
          ),
        ),
      );
    });
    testWidgets('Should reflect Dark Theme', (tester) async {
      await tester.pumpWidget(
        _appContainer(
          Chat(
            theme: const DarkChatTheme(),
            messages: generateRandomMessages(),
            chatMessageInputField: _messageInputField((_) {}),
          ),
        ),
      );
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

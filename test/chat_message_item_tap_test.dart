// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:swifty_chat/src/chat.dart';
import 'package:swifty_chat/src/chat_list_item.dart';
import 'package:swifty_chat/swifty_chat.dart';
import 'package:swifty_chat_mocked_data/swifty_chat_mocked_data.dart';

void main() {
  group("Chat shall notify when MessageKind widgets tapped", () {
    testWidgets(
      "TextMessageWidget shall emit tap events with it's message",
      (tester) async {
        await tester.pumpWidget(
          _appContainer(
            Chat(
              messages: [generateRandomMessage(MockMessageKind.text)],
              chatMessageInputField: _messageInputField((_) {}),
            ).setOnMessagePressed(
              (message) => expect(
                message.messageKind.text == null,
                false,
                reason: 'Could not tap text message widget',
              ),
            ),
          ),
        );
        await tester.ensureVisible(find.byType(ChatListItem));
        await tester.pumpAndSettle();
        await tester.tap(find.byType(ChatListItem));
      },
    );

    testWidgets(
      "ImageMessageWidget shall emit tap events with it's message",
      (tester) async {
        await tester.pumpWidget(
          _appContainer(
            Chat(
              messages: [
                generateRandomMessage(MockMessageKind.image),
              ],
              chatMessageInputField: _messageInputField((_) {}),
            ).setOnMessagePressed(
              (message) => expect(
                message.messageKind.imageProvider == null,
                false,
                reason: 'Could not tap image message widget',
              ),
            ),
          ),
        );
        await tester.ensureVisible(find.byType(ChatListItem));
        await tester.pumpAndSettle();
        await tester.tap(find.byType(ChatListItem));
      },
    );

    testWidgets("Quick Reply Item Should respond to button events",
        (tester) async {
      const quickReplyOption1Title = "MyOption 1";
      const quickReplyOption2Title = "MyOption 2";
      late final Chat chatView;
      final messages = generateRandomTextMessages().reversed.toList()
        ..insert(
          0,
          MockMessage(
            date: DateTime.now(),
            user: MockChatUser.incomingUser,
            id: DateTime.now().toString(),
            isMe: true,
            messageKind: MessageKind.quickReply([
              const MockQuickReplyItem(title: quickReplyOption1Title),
              const MockQuickReplyItem(title: quickReplyOption2Title),
            ]),
          ),
        );
      void quickReplyItemPressedAction(QuickReplyItem item) {
        final message = MockMessage(
          date: DateTime.now(),
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
            date: DateTime.now(),
            user: MockChatUser.incomingUser,
            id: DateTime.now().toString(),
            isMe: false,
            messageKind: MessageKind.carousel(
              [
                MockCarouselItem(
                  title: 'title1',
                  subtitle: 'subtitle1',
                  buttons: [
                    CarouselButtonItem(
                      title: carouselOption1Title,
                      url: 'url1',
                      payload: 'payload2',
                    ),
                  ],
                ),
                MockCarouselItem(
                  title: 'title2',
                  subtitle: 'subtitle2',
                  buttons: [
                    CarouselButtonItem(
                      title: carouselOption2Title,
                      url: 'url2',
                      payload: 'payload2',
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      void carouselItemPressedAction(CarouselButtonItem item) {
        final message = MockMessage(
          date: DateTime.now(),
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

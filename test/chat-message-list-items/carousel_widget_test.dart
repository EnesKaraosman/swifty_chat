import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:swifty_chat/src/chat.dart';

import 'package:swifty_chat/swifty_chat.dart';
import 'package:swifty_chat_mocked_data/swifty_chat_mocked_data.dart';

import '../util/util.dart';

void main() {
  CustomBindings();
  group('Chat Carousel Theme', () {
    testWidgets('Should reflect Light Theme', (tester) async {
      await testCarouselTheme(
        tester: tester,
        isLightMode: true,
        isIncomingMessage: true,
      );
      // await testCarouselTheme(
      //   tester: tester,
      //   isLightMode: true,
      //   isIncomingMessage: false,
      // );
    });
    testWidgets('Should reflect Dark Theme', (tester) async {
      await testCarouselTheme(
        tester: tester,
        isLightMode: false,
        isIncomingMessage: true,
      );
      // await testCarouselTheme(
      //   tester: tester,
      //   isLightMode: false,
      //   isIncomingMessage: false,
      // );
    });
  });
}

Future<void> testCarouselTheme({
  required WidgetTester tester,
  required bool isLightMode,
  required bool isIncomingMessage,
}) async {
  final theme = isLightMode ? const DefaultChatTheme() : const DarkChatTheme();
  const carouselMessageTitle = "Carousel_Title";
  const carouselMessageSubtitle = "Carousel_Subtitle";
  const carouselButtonTitle = "Carousel_Button_Title";
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
            messageKind: MessageKind.carousel([
              MockCarouselItem(
                title: carouselMessageTitle,
                subtitle: carouselMessageSubtitle,
                buttons: [
                  CarouselButtonItem(
                    title: carouselButtonTitle,
                    url: "url",
                    payload: "payload",
                  )
                ],
              )
            ]),
          ),
        ],
        chatMessageInputField: _messageInputField((_) {}),
      ),
    ),
  );

  final titleTextStyle = theme.carouselTitleTextStyle;
  final subtitleTextStyle = theme.carouselSubtitleTextStyle;
  final buttonStyle = theme.carouselButtonStyle;

  final titleTextWidget = tester.widget<Text>(find.text(carouselMessageTitle));
  final subtitleTextWidget =
      tester.widget<Text>(find.text(carouselMessageSubtitle));
  final buttonWidget = tester
      .element(find.text(carouselButtonTitle))
      .findAncestorWidgetOfExactType<ElevatedButton>();

  expect(
    titleTextStyle.toString(),
    titleTextWidget.style.toString(),
  );
  expect(
    subtitleTextStyle.toString(),
    subtitleTextWidget.style.toString(),
  );
  expect(
    buttonStyle.toString(),
    buttonWidget?.style.toString(),
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

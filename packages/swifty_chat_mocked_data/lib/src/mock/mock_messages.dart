import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:swifty_chat_data/swifty_chat_data.dart';

import './mock_message_kind.dart';
import './models/mock_carousel_item.dart';
import './models/mock_chat_user.dart';
import './models/mock_message.dart';
import './models/mock_quick_reply_item.dart';
import 'mock_html.dart';

extension RangeExtension on int {
  List<int> to(int maxInclusive) =>
      [for (int i = this; i <= maxInclusive; i++) i];
}

List<MockMessage> generateRandomTextMessagesWithName(
  String Function(int index) nameGenerator, {
  int count = 20,
}) {
  final user = MockChatUser.randomUser;
  final bool isMe = user.userName == MockChatUser.outgoingUser.userName;
  final time = DateTime.now();

  return 1
      .to(count)
      .map(
        (idx) => MockMessage(
          date: time,
          user: user,
          id: DateTime.now().toString(),
          isMe: isMe,
          messageKind: MessageKind.text(nameGenerator(idx)),
        ),
      )
      .toList();
}

List<MockMessage> generateRandomTextMessages({int count = 60}) => 1
    .to(count)
    .map((e) => generateRandomMessage(MockMessageKind.text, index: e))
    .toList();

MockMessage generateRandomMessage(
  MockMessageKind ofMessageKind, {
  int? index,
}) {
  final user = MockChatUser.randomUser;

  final bool isMe = user.userName == MockChatUser.outgoingUser.userName;
  final indexOffset = (index ?? 0) - 2;
  final dayOffset = max(0, indexOffset);
  final time = index == null
      ? DateTime.now()
      : DateTime.now().subtract(Duration(days: dayOffset));

  switch (ofMessageKind) {
    case MockMessageKind.image:
      final mockId = 1 + Random().nextInt(100);
      return MockMessage(
        date: time,
        user: user,
        id: DateTime.now().toString(),
        isMe: isMe,
        messageKind: MessageKind.imageProvider(
          NetworkImage(
            'https://picsum.photos/id/$mockId/300',
          ),
        ),
      );
    case MockMessageKind.quickReply:
      return MockMessage(
        date: time,
        user: user,
        id: DateTime.now().toString(),
        isMe: isMe,
        messageKind: MessageKind.quickReply(
          List.generate(
            Random().nextInt(7),
            (index) => MockQuickReplyItem(title: "Option $index"),
          ),
        ),
      );
    case MockMessageKind.carousel:
      return MockMessage(
        date: time,
        user: user,
        id: DateTime.now().toString(),
        isMe: isMe,
        messageKind: MessageKind.carousel(
          List.generate(
            1 + Random().nextInt(3),
            (index) => MockCarouselItem(
              title: 'Title $index',
              subtitle: faker.lorem.sentence(),
              imageProvider: const AssetImage(
                "assets/images/mock_image_1.jpg",
                package: 'swifty_chat_mocked_data',
              ),
              buttons: [
                CarouselButtonItem(
                  title: 'Select',
                  url: 'url',
                  payload: 'payload',
                )
              ],
            ),
          ),
        ),
      );
    case MockMessageKind.html:
      return MockMessage(
        date: time,
        user: user,
        id: DateTime.now().toString(),
        isMe: isMe,
        messageKind: MessageKind.html(htmlData),
      );
    case MockMessageKind.text:
      return MockMessage(
        date: time,
        user: user,
        id: DateTime.now().toString(),
        isMe: isMe,
        messageKind: MessageKind.text(faker.lorem.sentence()),
      );
  }
}

List<MockMessage> generateRandomMessages({int count = 80}) => 1.to(count).map(
      (idx) {
        if (idx % 7 == 0) {
          return generateRandomMessage(
            MockMessageKind.image,
            index: idx,
          );
        } else if (idx % 13 == 0) {
          return generateRandomMessage(
            MockMessageKind.quickReply,
            index: idx,
          );
        } else if (idx % 23 == 0) {
          return generateRandomMessage(
            MockMessageKind.carousel,
            index: idx,
          );
        } else if (idx == 17) {
          return generateRandomMessage(
            MockMessageKind.html,
            index: idx,
          );
        } else {
          return generateRandomMessage(
            MockMessageKind.text,
            index: idx,
          );
        }
      },
    ).toList();

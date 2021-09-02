import 'dart:math';

import 'package:flutter_chat/flutter_chat.dart';
import 'package:faker/faker.dart';

import '../mock/mock_html.dart';
import '../models/ek_carousel_item.dart';
import '../models/ek_chat_user.dart';
import '../models/ek_message.dart';
import '../models/ek_quick_reply_item.dart';

extension RangeExtension on int {
  List<int> to(int maxInclusive) =>
      [for (int i = this; i <= maxInclusive; i++) i];
}

enum MockMessageKind { text, image, quickReply, carousel, html }

EKChatUser incoming = EKChatUser(
  userName: "incoming",
  avatar: UserAvatar(imageURL: Uri.parse('https://picsum.photos/50/50')),
);
EKChatUser outgoing = EKChatUser(userName: "outgoing");

EKChatUser get randomUser => Random().nextBool() ? incoming : outgoing;

List<EKMessage> generateRandomTextMessages({int count = 60}) => 1
    .to(count)
    .map((e) => generateRandomMessage(MockMessageKind.text))
    .toList();

EKMessage generateRandomMessage(MockMessageKind ofMessageKind) {
  final user = randomUser;
  final bool isMe = user.userName == outgoing.userName;
  switch (ofMessageKind) {
    case MockMessageKind.image:
      return EKMessage(
        user: user,
        id: DateTime.now().toString(),
        isMe: isMe,
        messageKind: MessageKind.image('https://picsum.photos/300/200'),
      );
    case MockMessageKind.quickReply:
      return EKMessage(
        user: user,
        id: DateTime.now().toString(),
        isMe: isMe,
        messageKind: MessageKind.quickReply(
          List.generate(
            Random().nextInt(7),
            (index) => EKQuickReplyItem(title: "Option $index"),
          ),
        ),
      );
    case MockMessageKind.carousel:
      return EKMessage(
        user: user,
        id: DateTime.now().toString(),
        isMe: isMe,
        messageKind: MessageKind.carousel(
          List.generate(
            Random().nextInt(3),
            (index) => EKCarouselItem(
              title: 'Title $index',
              subtitle: faker.lorem.sentence(),
              imageURL: 'https://picsum.photos/300/200',
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
      return EKMessage(
        user: user,
        id: DateTime.now().toString(),
        isMe: isMe,
        messageKind: MessageKind.html(htmlData),
      );
    case MockMessageKind.text:
      return EKMessage(
        user: user,
        id: DateTime.now().toString(),
        isMe: isMe,
        messageKind:
            // MessageKind.text(getRandomString(1 + Random().nextInt(40))),
            MessageKind.text(faker.lorem.sentence()),
      );
  }
}

List<EKMessage> generateRandomMessages({int count = 80}) => 1.to(count).map(
      (idx) {
        if (idx % 7 == 0) {
          return generateRandomMessage(MockMessageKind.image);
        } else if (idx % 13 == 0) {
          return generateRandomMessage(MockMessageKind.quickReply);
        } else if (idx % 23 == 0) {
          return generateRandomMessage(MockMessageKind.carousel);
        } else if (idx == 17) {
          return generateRandomMessage(MockMessageKind.html);
        } else {
          return generateRandomMessage(MockMessageKind.text);
        }
      },
    ).toList();

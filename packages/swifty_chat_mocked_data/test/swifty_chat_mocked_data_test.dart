import 'package:flutter_test/flutter_test.dart';
import 'package:swifty_chat_mocked_data/swifty_chat_mocked_data.dart';

void main() {
  test('generates the requested text messages', () {
    final messages = generateRandomTextMessagesWithName(
      (index) => 'Message $index',
      count: 3,
    );

    expect(messages.map((message) => message.messageKind.text), [
      'Message 1',
      'Message 2',
      'Message 3',
    ]);
  });

  test('image generator uses both available assets', () {
    final paths = List.generate(
      100,
      (_) => generateRandomMessage(MockMessageKind.image)
          .messageKind
          .imageProvider
          .toString(),
    );

    expect(paths.any((path) => path.contains('mock_image_1.jpg')), isTrue);
    expect(paths.any((path) => path.contains('mock_image_2.jpg')), isTrue);
  });
}

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
}

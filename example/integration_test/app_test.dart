import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:example/main.dart' as app;
import 'package:swifty_chat/swifty_chat.dart';

Future wait(int milliseconds) {
  return Future.delayed(Duration(milliseconds: milliseconds), () {});
}

void main() {
  group('App Test', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets('Basic Chat Test', (tester) async {
      app.main();

      await tester.pumpAndSettle();

      final basicChatItem = find.byKey(const Key('basic_chat_item'));
      await tester.tap(basicChatItem);

      await wait(1000);

      final messageInput = find.byKey(const Key('message_input_field'));
      expect(messageInput, findsOneWidget);

      const testMessage = 'Test message';
      final messageTextField = find.byKey(ChatKeys.messageTextField.key);
      await tester.enterText(messageTextField, testMessage);

      await wait(1000);

      final messageSendButton = find.byKey(ChatKeys.messageSendButton.key);
      await tester.tap(messageSendButton);

      // Check if message displayed on List.
      await wait(1000);
      expect(find.text(testMessage), findsOneWidget);
    });
  });
}
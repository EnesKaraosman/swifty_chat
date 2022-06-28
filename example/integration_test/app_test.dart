import 'package:example/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:swifty_chat/swifty_chat.dart';

Future wait(int milliseconds) {
  return Future.delayed(Duration(milliseconds: milliseconds), () {});
}

Future<void> addMessageToChatList(WidgetTester tester, String message) async {
  // Get textField
  final messageInput = find.byKey('message_input_field'.key);
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
  await wait(1000);

  // Send message written in textField
  final messageSendButton = find.byKey(ChatKeys.messageSendButton.key);
  await tester.tap(messageSendButton);
  await tester.pump();
  tester.printToConsole('messageSendButton tapped');
}

void main() {
  group('App Test', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets('Basic Chat Test', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      tester.printToConsole("App is starting..");

      final basicChatItem = find.byKey('basic_chat_item'.key);
      await tester.tap(basicChatItem);
      await tester.pump();
      await wait(1000);
      tester.printToConsole("Basic Chat Screen is opened..");

      const testMessage = 'Test message';
      await addMessageToChatList(tester, testMessage);

      // Check if message displayed on List.
      await wait(1000);
      expect(
        find.text(testMessage),
        findsOneWidget,
        reason: '⚠️ Make sure to implement sendButton press action',
      );
      tester.printToConsole("✅ Basic Chat Test completed..");
    });

    testWidgets('Advanced Chat Test', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      tester.printToConsole("App is starting..");

      final advancedChatItem = find.byKey('advanced_chat_item'.key);
      await tester.tap(advancedChatItem);
      await tester.pump();
      await wait(1000);
      tester.printToConsole("Advanced Chat Screen is opened..");

      // Scroll List to the up
      final listView = find.byKey(ChatKeys.chatListView.key);
      await tester.drag(listView, const Offset(0, 400));
      await tester.pump();
      tester.printToConsole('ListView scrolled up');

      await wait(1000);
      const testMessage = 'Test message';
      addMessageToChatList(tester, testMessage);

      // Check if message displayed on List.
      await wait(1000);
      expect(
        find.text(testMessage),
        findsOneWidget,
        reason:
            '⚠️ Make sure to implement sendButton press action or make sure list scrolled to the bottom',
      );
      tester.printToConsole(
          "Message is added and scroll to bottom works as expected.");
      tester.printToConsole("✅ Advanced Chat Test completed..");
    });
  });
}

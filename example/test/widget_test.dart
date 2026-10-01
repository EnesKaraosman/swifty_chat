import 'package:example/advanced_chat.dart';
import 'package:example/main.dart';
import 'package:example/material3_example.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:swifty_chat/swifty_chat.dart';

void main() {
  testWidgets('opens the basic chat example', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Basic Chat'), findsOneWidget);
    await tester.tap(find.byKey(const Key('basic_chat_item')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('message_input_field')), findsOneWidget);
  });

  testWidgets('quick reply adds a message in the advanced example', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: AdvancedChat()));
    expect(tester.widget<Chat>(find.byType(Chat)).messages.length, 80);

    await tester.scrollUntilVisible(
      find.text('Option 0'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.ensureVisible(find.text('Option 0').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Option 0').first);
    await tester.pump();

    expect(tester.widget<Chat>(find.byType(Chat)).messages.length, 81);
  });

  testWidgets('standalone Material 3 chat shows a sent message', (
    tester,
  ) async {
    await tester.pumpWidget(const Material3ChatExample());
    await tester.enterText(
      find.byKey(ChatKeys.messageTextField.key),
      'Standalone send',
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(ChatKeys.messageSendButton.key));
    await tester.pumpAndSettle();

    expect(find.text('Standalone send'), findsOneWidget);
  });

  testWidgets('custom Material 3 chat shows a sent message', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: CustomMaterial3ChatExample()),
    );
    await tester.enterText(
      find.byKey(ChatKeys.messageTextField.key),
      'Custom send',
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(ChatKeys.messageSendButton.key));
    await tester.pumpAndSettle();

    expect(find.text('Custom send'), findsOneWidget);
  });
}

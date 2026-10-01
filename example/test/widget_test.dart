import 'package:example/advanced_chat.dart';
import 'package:example/main.dart';
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
}

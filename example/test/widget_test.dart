import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('opens the basic chat example', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Basic Chat'), findsOneWidget);
    await tester.tap(find.byKey(const Key('basic_chat_item')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('message_input_field')), findsOneWidget);
  });
}

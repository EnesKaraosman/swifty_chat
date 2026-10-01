import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:swifty_chat/src/extensions/date_extensions.dart';
import 'package:swifty_chat/swifty_chat.dart';
import 'package:swifty_chat_mocked_data/swifty_chat_mocked_data.dart';

void main() {
  testWidgets('public Chat scrolls to the latest message', (tester) async {
    final chatController = ChatController();
    final chat = Chat(
      controller: chatController,
      messages: List.generate(40, (index) => _message('$index')),
      chatMessageInputField: const SizedBox.shrink(),
    );
    await tester.pumpWidget(_app(chat));

    final list = find.byType(ListView);
    await tester.fling(list, const Offset(0, 200), 500);
    await tester.pumpAndSettle();
    final controller = tester.widget<ListView>(list).controller!;
    expect(controller.offset, greaterThan(0));

    chat.scrollToBottom();
    await tester.pumpAndSettle();
    expect(controller.offset, 0);

    await tester.fling(list, const Offset(0, 200), 500);
    await tester.pumpAndSettle();
    chatController.scrollToBottom();
    await tester.pumpAndSettle();
    expect(controller.offset, 0);
  });

  testWidgets('changing a Chat callback leaves the old widget unchanged',
      (tester) async {
    var oldCalls = 0;
    var newCalls = 0;
    final original = Chat(
      messages: [_message('hello')],
      chatMessageInputField: const SizedBox.shrink(),
    ).setOnMessagePressed((_) => oldCalls++);
    final updated = original.setOnMessagePressed((_) => newCalls++);

    await tester.pumpWidget(_app(original));
    await tester.tap(find.text('hello'));
    expect(oldCalls, 1);
    expect(newCalls, 0);

    await tester.pumpWidget(_app(updated));
    await tester.tap(find.text('hello'));
    expect(oldCalls, 1);
    expect(newCalls, 1);
  });

  testWidgets('inserted messages retain the state of existing rows',
      (tester) async {
    final messages = [_message('a', custom: true), _message('b', custom: true)];
    Widget chat() => Chat(
          messages: messages,
          chatMessageInputField: const SizedBox.shrink(),
          customMessageWidget: (message) => _RememberMessage(message.id),
        );

    await tester.pumpWidget(_app(chat()));
    messages.insert(0, _message('c', custom: true));
    await tester.pumpWidget(_app(chat()));

    for (final id in ['a', 'b', 'c']) {
      expect(find.text('$id/$id'), findsOneWidget);
    }
  });

  test('previous calendar day uses relative date text', () {
    final now = DateTime.now();
    final previousDay = DateTime(now.year, now.month, now.day)
        .subtract(const Duration(milliseconds: 1));
    expect(previousDay.relativeTimeFromNow(), isNot(previousDay.hourMinute()));
  });

  testWidgets('HTML messages fit inside a narrow chat panel', (tester) async {
    await tester.pumpWidget(_app(Center(
      child: SizedBox(
        width: 220,
        child: Chat(
          messages: [_message('html', html: true)],
          chatMessageInputField: const SizedBox.shrink(),
        ),
      ),
    )));
    expect(tester.takeException(), isNull);
  });

  testWidgets('HTML image taps reach the configured callback', (tester) async {
    String? tappedSource;
    final chat = Chat(
      messages: [
        MockMessage(
          id: 'html-image',
          date: DateTime.now(),
          user: MockChatUser.incomingUser,
          isMe: false,
          messageKind: MessageKind.html(
            '<img width="32" height="32" src="https://example.com/image.png">',
          ),
        ),
      ],
      chatMessageInputField: const SizedBox.shrink(),
    ).setOnHTMLWidgetPressed(() => {
          'onImageTap': (source, _, __) => tappedSource = source,
        });

    await tester.pumpWidget(_app(chat));
    final image = find.descendant(
      of: find.byType(Html),
      matching: find.byType(Image),
    );
    expect(image, findsOneWidget);
    await tester.tap(image);
    expect(tappedSource, 'https://example.com/image.png');
  });

  testWidgets('image messages fit inside a narrow chat panel', (tester) async {
    await tester.pumpWidget(_app(Center(
      child: SizedBox(
        width: 220,
        child: Chat(
          messages: [
            MockMessage(
              id: 'image',
              date: DateTime.now(),
              user: MockChatUser.incomingUser,
              isMe: false,
              messageKind: MessageKind.imageProvider(
                const AssetImage(
                  'assets/images/mock_image_1.jpg',
                  package: 'swifty_chat_mocked_data',
                ),
              ),
            ),
          ],
          chatMessageInputField: const SizedBox.shrink(),
        ),
      ),
    )));
    expect(tester.takeException(), isNull);
  });

  testWidgets('send button has a 48 dp hit target', (tester) async {
    await tester.pumpWidget(_app(MessageInputField(sendButtonTapped: (_) {})));
    final size = tester.getSize(find.byKey(ChatKeys.messageSendButton.key));
    expect(size.width, greaterThanOrEqualTo(48));
    expect(size.height, greaterThanOrEqualTo(48));
  });

  testWidgets('input border responds to focus changes', (tester) async {
    await tester.pumpWidget(_app(MessageInputField(sendButtonTapped: (_) {})));
    final textField = find.byType(TextField);

    Color borderColor() {
      final decoration = tester
          .widgetList<DecoratedBox>(
            find.ancestor(of: textField, matching: find.byType(DecoratedBox)),
          )
          .map((box) => box.decoration)
          .whereType<BoxDecoration>()
          .firstWhere((box) => box.border != null);
      return (decoration.border! as Border).top.color;
    }

    final unfocusedColor = borderColor();
    await tester.tap(textField);
    await tester.pump();
    expect(borderColor(), isNot(unfocusedColor));
  });
}

MockMessage _message(String id, {bool custom = false, bool html = false}) =>
    MockMessage(
      id: id,
      date: DateTime.now(),
      user: MockChatUser.incomingUser,
      isMe: false,
      messageKind: custom
          ? MessageKind.custom(id)
          : html
              ? MessageKind.html('<p>hello</p>')
              : MessageKind.text(id),
    );

Widget _app(Widget child) => MaterialApp(home: Scaffold(body: child));

class _RememberMessage extends StatefulWidget {
  const _RememberMessage(this.id);

  final String id;

  @override
  State<_RememberMessage> createState() => _RememberMessageState();
}

class _RememberMessageState extends State<_RememberMessage> {
  late final String originalId = widget.id;

  @override
  Widget build(BuildContext context) => Text('${widget.id}/$originalId');
}

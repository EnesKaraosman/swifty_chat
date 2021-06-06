# flutter_chat

This lib requires some abstract classes to be implemented to get started.
`Message`, `ChatUser` & `QuickReplyItem` (if you'll use the `MessageKind.quickReply`)

```dart
class MessageKind {
  MessageKind.text(String text);
  MessageKind.image(String imageURL);
  MessageKind.quickReply(List<IQuickReplyItem> quickReplies);
  MessageKind.html(String html);
}
```

### Usage

Here below exists an example that covers all the available `MessageKind` usages.
Note that `EK...` prefixed classes are the concrete implementation of the related abstract classes.

```dart
import 'package:chat_app/models/EKChatUser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/flutter_chat.dart';
import 'models/EKQuickReplyItem.dart';
import 'models/EKMessage.dart';
import 'models/EKChatUser.dart';

import 'dart:math';

void main() {
  runApp(MyApp());
}

const htmlData = r"""
<p id='top'><a href='#bottom'>Scroll to bottom</a></p>
      <h1>Header 1</h1>
      <h2>Header 2</h2>
      <h3>Header 3</h3>
      <h4>Header 4</h4>
      <h5>Header 5</h5>
      <h6>Header 6</h6>
      <h3>Ruby Support:</h3>
      <h3>Support for maxLines:</h3>
      <h5>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec vestibulum sapien feugiat lorem tempor, id porta orci elementum. Fusce sed justo id arcu egestas congue. Fusce tincidunt lacus ipsum, in imperdiet felis ultricies eu. In ullamcorper risus felis, ac maximus dui bibendum vel. Integer ligula tortor, facilisis eu mauris ut, ultrices hendrerit ex. Donec scelerisque massa consequat, eleifend mauris eu, mollis dui. Donec placerat augue tortor, et tincidunt quam tempus non. Quisque sagittis enim nisi, eu condimentum lacus egestas ac. Nam facilisis luctus ipsum, at aliquam urna fermentum a. Quisque tortor dui, faucibus in ante eget, pellentesque mattis nibh. In augue dolor, euismod vitae eleifend nec, tempus vel urna. Donec vitae augue accumsan ligula fringilla ultrices et vel ex.</h5>
      <h3>Support for <code>sub</code>/<code>sup</code></h3>
      Solve for <var>x<sub>n</sub></var>: log<sub>2</sub>(<var>x</var><sup>2</sup>+<var>n</var>) = 9<sup>3</sup>
      <p>One of the most <span>common</span> equations in all of physics is <br /><var>E</var>=<var>m</var><var>c</var><sup>2</sup>.</p>
      <h3>Inline Styles:</h3>
      <p>The should be <span style='background-color: red; color: rgb(0, 97, 0);'>GREEN style='color: rgb(0, 97, 0);</span></p>
      <h3>Table support (with custom styling!):</h3>
      <p>
      <q>Famous quote...</q>
      </p>
      <h3>Custom Element Support (inline: <bird></bird> and as block):</h3>
      <flutter></flutter>
      <flutter horizontal></flutter>
      <p>
        Linking to <a href='https://github.com'>websites</a> has never been easier.
      </p>
      <h3>Image support:</h3>
      <h3>Network png</h3>
      <img alt='Google' src='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' />
      <h3>Network svg</h3>
      <img src='https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/android.svg' />
      <p id='bottom'><a href='#top'>Scroll to top</a></p>
""";

class MyApp extends StatelessWidget {
  EKChatUser incoming = EKChatUser(userName: "incoming");
  EKChatUser outgoing = EKChatUser(userName: "outgoing");

  EKChatUser get randomUser => Random().nextBool() ? incoming : outgoing;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MaterialApp(
        home: Scaffold(
          body: _chatWidget,
        ),
      ),
    );
  }

  Widget get _chatWidget {
    return Chat(items: _messages)
    .setOnHTMLWidgetPressed(() {
      return {
        "onLinkTap": (url, _, __, ___) {
          print("onLinkTapped: $url");
        },
        "onImageTap": (src, _, __, ___) {
          print("onImageTapped: $src");
        }
      };
    })
    .setOnQuickReplyItemPressed((item) {
        print(item.title);
      },
    );
  }

  List<EKMessage> get _messages => 1.to(100).map((num) {
    if (num % 7 == 0) {
      return EKMessage(
        user: randomUser,
        id: DateTime.now().toString(),
        isMe: Random().nextBool(),
        messageKind: MessageKind.image('https://picsum.photos/300/200'),
      );
    } else if (num % 13 == 0) {
      return EKMessage(
          user: randomUser,
          id: DateTime.now().toString(),
          isMe: Random().nextBool(),
          messageKind: MessageKind.quickReply([
            EKQuickReplyItem(title: 'Option1'),
            EKQuickReplyItem(title: 'Option2')
          ])
      );
    } else if (num == 20) {
      return EKMessage(
        user: randomUser,
        id: DateTime.now().toString(),
        isMe: Random().nextBool(),
        messageKind: MessageKind.html(htmlData),
      );
    } else {
      return EKMessage(
        user: randomUser,
        id: DateTime.now().toString(),
        isMe: Random().nextBool(),
        messageKind: MessageKind.text(getRandomString(1 + Random().nextInt(40))),
      );
    }
  }).toList();
}
```
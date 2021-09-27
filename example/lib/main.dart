import 'package:example/advanced_chat.dart';
import 'package:example/basic_chat.dart';
import 'package:example/custom_message_kind_chat.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (_) => const Home(),
        '/basic-chat': (_) => const BasicChat(Key('basic_chat')),
        '/advanced-chat': (_) => const AdvancedChat(Key('advanced_chat')),
        '/custom-message-kind-chat': (_) => CustomMessageKindChat(Key('custom_message_kind_chat')),
      },
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const Divider(color: Colors.white70),
          ListTile(
            key: const Key('basic_chat_item'),
            title: const Text('Basic Chat'),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),
            onTap: () => Navigator.of(context).pushNamed('/basic-chat'),
          ),
          const Divider(color: Colors.white70),
          ListTile(
            key: const Key('advanced_chat_item'),
            title: const Text('Advanced Chat'),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),
            onTap: () => Navigator.of(context).pushNamed('/advanced-chat'),
          ),
          const Divider(color: Colors.white70),
          ListTile(
            key: const Key('custom_message_chat_item'),
            title: const Text('Custom Message Chat'),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),
            onTap: () => Navigator.of(context).pushNamed('/custom-message-kind-chat'),
          ),
        ],
      ),
    );
  }
}

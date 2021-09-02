import 'package:example/advanced_chat.dart';
import 'package:example/basic_chat.dart';
import 'package:flutter/material.dart';
import 'theme/app_theme.dart';

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
      theme: AppTheme.light(context),
      darkTheme: AppTheme.dark(context),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (_) => const Home(),
        '/basic-chat': (_) => BasicChat(),
        '/advanced-chat': (_) => AdvancedChat(),
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
            title: const Text('Basic Chat'),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),
            onTap: () => Navigator.of(context).pushNamed('/basic-chat'),
          ),
          const Divider(color: Colors.white70),
          ListTile(
            title: const Text('Advanced Chat'),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),
            onTap: () => Navigator.of(context).pushNamed('/advanced-chat'),
          ),
          const Divider(color: Colors.white70),
        ],
      ),
    );
  }
}

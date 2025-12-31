import 'package:example/advanced_chat.dart';
import 'package:example/basic_chat.dart';
import 'package:example/custom_message_kind_chat.dart';
import 'package:example/material3_example.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme() {
    setState(() {
      _themeMode = switch (_themeMode) {
        ThemeMode.light => ThemeMode.dark,
        ThemeMode.dark => ThemeMode.system,
        ThemeMode.system => ThemeMode.light,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swifty Chat Demo',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      // Material 3 Light Theme
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.light,
        ),
      ),
      // Material 3 Dark Theme
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
      ),
      routes: {
        '/': (_) => Home(
              themeMode: _themeMode,
              onThemeToggle: _toggleTheme,
            ),
        '/basic-chat': (_) => const BasicChat(key: Key('basic_chat')),
        '/advanced-chat': (_) => const AdvancedChat(key: Key('advanced_chat')),
        '/custom-message-kind-chat': (_) =>
            const CustomMessageKindChat(key: Key('custom_message_kind_chat')),
        '/material3-chat': (_) =>
            const Material3ChatDemo(key: Key('material3_chat')),
        '/accessibility-demo': (_) =>
            const AccessibilityDemo(key: Key('accessibility_demo')),
        '/responsive-demo': (_) =>
            const ResponsiveDemo(key: Key('responsive_demo')),
      },
    );
  }
}

final class Home extends StatelessWidget {
  const Home({
    super.key,
    required this.themeMode,
    required this.onThemeToggle,
  });

  final ThemeMode themeMode;
  final VoidCallback onThemeToggle;

  String get _themeModeLabel => switch (themeMode) {
        ThemeMode.light => 'Light',
        ThemeMode.dark => 'Dark',
        ThemeMode.system => 'System',
      };

  IconData get _themeModeIcon => switch (themeMode) {
        ThemeMode.light => Icons.light_mode,
        ThemeMode.dark => Icons.dark_mode,
        ThemeMode.system => Icons.brightness_auto,
      };

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Swifty Chat Examples'),
        actions: [
          IconButton(
            icon: Icon(_themeModeIcon),
            tooltip: 'Theme: $_themeModeLabel',
            onPressed: onThemeToggle,
          ),
        ],
      ),
      body: ListView(
        children: [
          // Section: Basic Examples
          _SectionHeader(
            title: 'Basic Examples',
            icon: Icons.chat_bubble_outline,
            color: colorScheme.primary,
          ),
          _ExampleTile(
            key: const Key('basic_chat_item'),
            title: 'Basic Chat',
            subtitle: 'Simple text messaging with DarkChatTheme',
            icon: Icons.message,
            route: '/basic-chat',
          ),
          _ExampleTile(
            key: const Key('advanced_chat_item'),
            title: 'Advanced Chat',
            subtitle: 'Images, carousel, quick replies, HTML messages',
            icon: Icons.auto_awesome,
            route: '/advanced-chat',
          ),
          _ExampleTile(
            key: const Key('custom_message_chat_item'),
            title: 'Custom Message Chat',
            subtitle: 'Custom message types with your own widgets',
            icon: Icons.widgets,
            route: '/custom-message-kind-chat',
          ),

          // Section: Material 3 & Modern Features
          _SectionHeader(
            title: 'Material 3 & Modern Features',
            icon: Icons.palette,
            color: colorScheme.tertiary,
          ),
          _ExampleTile(
            key: const Key('material3_chat_item'),
            title: 'Material 3 Chat',
            subtitle: 'ColorScheme integration, dynamic theming',
            icon: Icons.color_lens,
            route: '/material3-chat',
            badge: 'NEW',
          ),
          _ExampleTile(
            key: const Key('accessibility_demo_item'),
            title: 'Accessibility Demo',
            subtitle: 'WCAG contrast, text scaling, reduce motion',
            icon: Icons.accessibility_new,
            route: '/accessibility-demo',
            badge: 'NEW',
          ),
          _ExampleTile(
            key: const Key('responsive_demo_item'),
            title: 'Responsive Design',
            subtitle: 'Adaptive layouts for mobile, tablet, desktop',
            icon: Icons.devices,
            route: '/responsive-demo',
            badge: 'NEW',
          ),

          const SizedBox(height: 24),

          // Package Info Card
          _PackageInfoCard(),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.icon,
    required this.color,
  });

  final String title;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}

class _ExampleTile extends StatelessWidget {
  const _ExampleTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.route,
    this.badge,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final String route;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: colorScheme.primaryContainer,
        child: Icon(icon, color: colorScheme.onPrimaryContainer),
      ),
      title: Row(
        children: [
          Text(title),
          if (badge != null) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: colorScheme.tertiaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                badge!,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onTertiaryContainer,
                ),
              ),
            ),
          ],
        ],
      ),
      subtitle: Text(subtitle),
      trailing: Icon(
        Icons.keyboard_arrow_right_rounded,
        color: colorScheme.onSurfaceVariant,
      ),
      onTap: () => Navigator.of(context).pushNamed(route),
    );
  }
}

class _PackageInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info_outline, color: colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'swifty_chat',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'A customizable Flutter chat UI package with Material 3 support, '
              'responsive design, accessibility features, and rich message types.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _FeatureChip(label: 'Material 3', icon: Icons.palette),
                _FeatureChip(label: 'Responsive', icon: Icons.devices),
                _FeatureChip(label: 'Accessible', icon: Icons.accessibility),
                _FeatureChip(label: 'Animations', icon: Icons.animation),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureChip extends StatelessWidget {
  const _FeatureChip({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 16),
      label: Text(label),
      visualDensity: VisualDensity.compact,
    );
  }
}

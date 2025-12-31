import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swifty_chat/swifty_chat.dart';
import 'package:swifty_chat_mocked_data/swifty_chat_mocked_data.dart';

/// Material 3 Chat Demo - showcases dynamic theming with ColorScheme
class Material3ChatDemo extends StatefulWidget {
  const Material3ChatDemo({super.key});

  @override
  State<Material3ChatDemo> createState() => _Material3ChatDemoState();
}

class _Material3ChatDemoState extends State<Material3ChatDemo> {
  final List<MockMessage> _messages = [];
  Color _seedColor = Colors.indigo;

  final List<Color> _colorOptions = [
    Colors.indigo,
    Colors.blue,
    Colors.teal,
    Colors.green,
    Colors.orange,
    Colors.pink,
    Colors.purple,
    Colors.red,
  ];

  @override
  void initState() {
    super.initState();
    _messages.addAll(generateRandomTextMessages());
  }

  void _onSendMessage(String message) {
    HapticFeedback.lightImpact();
    setState(() {
      _messages.add(
        MockMessage(
          id: '${_messages.length}',
          date: DateTime.now(),
          user: MockChatUser.outgoingUser,
          isMe: true,
          messageKind: MessageKind.text(message),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Create theme with selected seed color
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Theme.of(context).brightness,
    );

    return Theme(
      data: Theme.of(context).copyWith(colorScheme: colorScheme),
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Material 3 Chat'),
            actions: [
              // Color picker popup
              PopupMenuButton<Color>(
                icon: Icon(Icons.palette, color: colorScheme.primary),
                tooltip: 'Change theme color',
                onSelected: (color) => setState(() => _seedColor = color),
                itemBuilder: (context) => _colorOptions
                    .map(
                      (color) => PopupMenuItem(
                        value: color,
                        child: Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: color,
                                shape: BoxShape.circle,
                                border: _seedColor == color
                                    ? Border.all(
                                        color: colorScheme.outline,
                                        width: 2,
                                      )
                                    : null,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(_getColorName(color)),
                            if (_seedColor == color)
                              const Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Icon(Icons.check, size: 18),
                              ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
          body: Chat(
            messages: _messages,
            theme: Material3ChatTheme.fromContext(context),
            messageCellSizeConfigurator:
                MessageCellSizeConfigurator.responsiveConfiguration(context),
            chatMessageInputField: MessageInputField(
              sendButtonTapped: _onSendMessage,
            ),
          ),
        ),
      ),
    );
  }

  String _getColorName(Color color) {
    if (color == Colors.indigo) return 'Indigo';
    if (color == Colors.blue) return 'Blue';
    if (color == Colors.teal) return 'Teal';
    if (color == Colors.green) return 'Green';
    if (color == Colors.orange) return 'Orange';
    if (color == Colors.pink) return 'Pink';
    if (color == Colors.purple) return 'Purple';
    if (color == Colors.red) return 'Red';
    return 'Custom';
  }
}

/// Accessibility Demo - showcases WCAG contrast, text scaling, motion
class AccessibilityDemo extends StatefulWidget {
  const AccessibilityDemo({super.key});

  @override
  State<AccessibilityDemo> createState() => _AccessibilityDemoState();
}

class _AccessibilityDemoState extends State<AccessibilityDemo> {
  final List<MockMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _messages.addAll(generateRandomTextMessages());
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textScaler = AccessibilityHelpers.getTextScaler(context);
    final highContrast = AccessibilityHelpers.isHighContrastMode(context);
    final reduceMotion = AccessibilityHelpers.shouldReduceMotion(context);
    final boldText = AccessibilityHelpers.isBoldTextEnabled(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Accessibility Demo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'Accessibility Info',
            onPressed: () => _showAccessibilitySheet(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // Accessibility status bar
          Container(
            padding: const EdgeInsets.all(12),
            color: colorScheme.surfaceContainerHighest,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _StatusChip(
                  icon: Icons.text_fields,
                  label: '${(textScaler.scale(1.0) * 100).round()}%',
                  tooltip: 'Text Scale',
                ),
                _StatusChip(
                  icon: Icons.contrast,
                  label: highContrast ? 'ON' : 'OFF',
                  tooltip: 'High Contrast',
                  isActive: highContrast,
                ),
                _StatusChip(
                  icon: Icons.animation,
                  label: reduceMotion ? 'OFF' : 'ON',
                  tooltip: 'Animations',
                  isActive: !reduceMotion,
                ),
                _StatusChip(
                  icon: Icons.format_bold,
                  label: boldText ? 'ON' : 'OFF',
                  tooltip: 'Bold Text',
                  isActive: boldText,
                ),
              ],
            ),
          ),

          // Contrast checker section
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: _MiniContrastCard(
                    title: 'Outgoing',
                    foreground: colorScheme.onPrimaryContainer,
                    background: colorScheme.primaryContainer,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _MiniContrastCard(
                    title: 'Incoming',
                    foreground: colorScheme.onSecondaryContainer,
                    background: colorScheme.secondaryContainer,
                  ),
                ),
              ],
            ),
          ),

          // Chat
          Expanded(
            child: Chat(
              messages: _messages,
              theme: Material3ChatTheme.fromContext(context),
              messageCellSizeConfigurator:
                  MessageCellSizeConfigurator.responsiveConfiguration(context),
              chatMessageInputField: MessageInputField(
                sendButtonTapped: (message) {
                  HapticFeedback.lightImpact();
                  setState(() {
                    _messages.add(
                      MockMessage(
                        id: '${_messages.length}',
                        date: DateTime.now(),
                        user: MockChatUser.outgoingUser,
                        isMe: true,
                        messageKind: MessageKind.text(message),
                      ),
                    );
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAccessibilitySheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const _AccessibilityInfoSheet(),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({
    required this.icon,
    required this.label,
    required this.tooltip,
    this.isActive = true,
  });

  final IconData icon;
  final String label;
  final String tooltip;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Tooltip(
      message: tooltip,
      child: Chip(
        avatar: Icon(
          icon,
          size: 16,
          color: isActive ? colorScheme.primary : colorScheme.outline,
        ),
        label: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? colorScheme.onSurface : colorScheme.outline,
          ),
        ),
        visualDensity: VisualDensity.compact,
        padding: EdgeInsets.zero,
      ),
    );
  }
}

class _MiniContrastCard extends StatelessWidget {
  const _MiniContrastCard({
    required this.title,
    required this.foreground,
    required this.background,
  });

  final String title;
  final Color foreground;
  final Color background;

  @override
  Widget build(BuildContext context) {
    final ratio = AccessibilityHelpers.getContrastRatio(foreground, background);
    final meetsAA = AccessibilityHelpers.meetsWCAGAA(foreground, background);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: foreground,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                meetsAA ? Icons.check_circle : Icons.warning,
                size: 14,
                color: foreground,
              ),
              const SizedBox(width: 4),
              Text(
                '${ratio.toStringAsFixed(1)}:1',
                style: TextStyle(color: foreground, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AccessibilityInfoSheet extends StatelessWidget {
  const _AccessibilityInfoSheet();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Accessibility Features',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          const _InfoRow(
            icon: Icons.text_fields,
            title: 'Text Scaling',
            description:
                'Respects system text size preferences via MediaQuery.textScalerOf',
          ),
          const _InfoRow(
            icon: Icons.contrast,
            title: 'WCAG Contrast',
            description:
                'Validates color contrast ratios meet WCAG AA (4.5:1) and AAA (7:1) standards',
          ),
          const _InfoRow(
            icon: Icons.animation,
            title: 'Reduce Motion',
            description:
                'Animations are simplified or disabled when reduce motion is enabled',
          ),
          const _InfoRow(
            icon: Icons.record_voice_over,
            title: 'Screen Reader',
            description:
                'All messages include semantic labels for VoiceOver and TalkBack',
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Responsive Demo - showcases breakpoint system and adaptive layouts
class ResponsiveDemo extends StatefulWidget {
  const ResponsiveDemo({super.key});

  @override
  State<ResponsiveDemo> createState() => _ResponsiveDemoState();
}

class _ResponsiveDemoState extends State<ResponsiveDemo> {
  final List<MockMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _messages.addAll(generateRandomTextMessages());
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = ResponsiveBreakpoints.getScreenSize(context);
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsive Design'),
        actions: [
          Chip(
            avatar: Icon(_getDeviceIcon(screenSize), size: 16),
            label: Text(screenSize.name.toUpperCase()),
            visualDensity: VisualDensity.compact,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Responsive info bar
          Container(
            padding: const EdgeInsets.all(12),
            color: colorScheme.surfaceContainerHighest,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ResponsiveInfoChip(
                  label: '${size.width.round()}×${size.height.round()}',
                  icon: Icons.crop_square,
                ),
                _ResponsiveInfoChip(
                  label:
                      'Padding: ${ResponsiveBreakpoints.getAdaptiveSpacing(context).round()}',
                  icon: Icons.space_bar,
                ),
                _ResponsiveInfoChip(
                  label:
                      'Avatar: ${ResponsiveBreakpoints.getAdaptiveAvatarSize(context).round()}',
                  icon: Icons.account_circle,
                ),
              ],
            ),
          ),

          // Chat area
          Expanded(
            child: Chat(
              messages: _messages,
              theme: Material3ChatTheme.fromContext(context),
              messageCellSizeConfigurator:
                  MessageCellSizeConfigurator.responsiveConfiguration(context),
              chatMessageInputField: MessageInputField(
                sendButtonTapped: (message) {
                  setState(() {
                    _messages.add(
                      MockMessage(
                        id: '${_messages.length}',
                        date: DateTime.now(),
                        user: MockChatUser.outgoingUser,
                        isMe: true,
                        messageKind: MessageKind.text(message),
                      ),
                    );
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getDeviceIcon(ScreenSize size) {
    return switch (size) {
      ScreenSize.mobile => Icons.phone_android,
      ScreenSize.tablet => Icons.tablet_android,
      ScreenSize.desktop => Icons.desktop_windows,
      ScreenSize.largeDesktop => Icons.tv,
    };
  }
}

class _ResponsiveInfoChip extends StatelessWidget {
  const _ResponsiveInfoChip({
    required this.label,
    required this.icon,
  });

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

// Keep backward compatibility with original example names
/// Example demonstrating Material 3 theme integration with swifty_chat
///
/// This example shows:
/// - Material 3 ColorScheme integration
/// - Automatic light/dark mode support
/// - Responsive design with breakpoints
/// - Enhanced accessibility features
/// - Performance optimizations
class Material3ChatExample extends StatefulWidget {
  const Material3ChatExample({super.key});

  @override
  State<Material3ChatExample> createState() => _Material3ChatExampleState();
}

class _Material3ChatExampleState extends State<Material3ChatExample> {
  final List<MockMessage> _messages = [];
  ThemeMode _themeMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    _messages.addAll(generateRandomTextMessages());
  }

  void _onSendMessage(String message) {
    setState(() {
      _messages.add(
        MockMessage(
          id: '${_messages.length}',
          date: DateTime.now(),
          user: MockChatUser.outgoingUser,
          isMe: true,
          messageKind: MessageKind.text(message),
        ),
      );
    });
  }

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material 3 Chat Demo',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,

      // Light theme with Material 3
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
      ),

      // Dark theme with Material 3
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),

      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material 3 Chat'),
          actions: [
            // Theme toggle button
            IconButton(
              icon: Icon(
                _themeMode == ThemeMode.light
                    ? Icons.dark_mode
                    : Icons.light_mode,
              ),
              onPressed: _toggleTheme,
              tooltip: 'Toggle theme',
            ),
            // Accessibility info
            IconButton(
              icon: const Icon(Icons.accessibility_new),
              onPressed: () => _showAccessibilityInfo(context),
              tooltip: 'Accessibility info',
            ),
          ],
        ),
        body: Chat(
          messages: _messages,
          // Use Material 3 theme created from context
          theme: Material3ChatTheme.fromContext(context),
          // Use responsive size configuration
          messageCellSizeConfigurator:
              MessageCellSizeConfigurator.responsiveConfiguration(context),
          chatMessageInputField: MessageInputField(
            sendButtonTapped: _onSendMessage,
          ),
        ),
      ),
    );
  }

  void _showAccessibilityInfo(BuildContext context) {
    final textScaler = AccessibilityHelpers.getTextScaler(context);
    final highContrast = AccessibilityHelpers.isHighContrastMode(context);
    final reduceMotion = AccessibilityHelpers.shouldReduceMotion(context);
    final boldText = AccessibilityHelpers.isBoldTextEnabled(context);
    final screenSize = ResponsiveBreakpoints.getScreenSize(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Accessibility & Responsive Info'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Text Scale Factor: ${textScaler.scale(1.0).toStringAsFixed(2)}'),
            Text('High Contrast: ${highContrast ? "Enabled" : "Disabled"}'),
            Text('Reduce Motion: ${reduceMotion ? "Enabled" : "Disabled"}'),
            Text('Bold Text: ${boldText ? "Enabled" : "Disabled"}'),
            Text('Screen Size: ${screenSize.name}'),
            const SizedBox(height: 16),
            const Text(
              'The chat UI automatically adapts to all these settings!',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

/// Example demonstrating custom Material 3 theme
class CustomMaterial3ChatExample extends StatefulWidget {
  const CustomMaterial3ChatExample({super.key});

  @override
  State<CustomMaterial3ChatExample> createState() =>
      _CustomMaterial3ChatExampleState();
}

class _CustomMaterial3ChatExampleState
    extends State<CustomMaterial3ChatExample> {
  final List<MockMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _messages.addAll(generateRandomTextMessages());
  }

  @override
  Widget build(BuildContext context) {
    // Create a custom Material 3 theme with specific colors
    final customTheme = Material3ChatTheme(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.purple,
        brightness: Theme.of(context).brightness,
      ),
      textTheme: Theme.of(context).textTheme,
      messageBorderRadiusValue: 16.0,
      textMessagePaddingValue: 16.0,
      messageInsetValue: const EdgeInsets.symmetric(vertical: 12),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Material 3 Chat'),
      ),
      body: Chat(
        messages: _messages,
        theme: customTheme,
        messageCellSizeConfigurator:
            MessageCellSizeConfigurator.responsiveConfiguration(context),
        chatMessageInputField: MessageInputField(
          sendButtonTapped: (message) {
            // Handle message
          },
        ),
      ),
    );
  }
}

/// Example demonstrating WCAG contrast checking
class AccessibilityContrastExample extends StatelessWidget {
  const AccessibilityContrastExample({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contrast Checker'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _ContrastCard(
            title: 'Primary Container',
            foreground: colorScheme.onPrimaryContainer,
            background: colorScheme.primaryContainer,
          ),
          _ContrastCard(
            title: 'Secondary Container',
            foreground: colorScheme.onSecondaryContainer,
            background: colorScheme.secondaryContainer,
          ),
          _ContrastCard(
            title: 'Tertiary Container',
            foreground: colorScheme.onTertiaryContainer,
            background: colorScheme.tertiaryContainer,
          ),
        ],
      ),
    );
  }
}

class _ContrastCard extends StatelessWidget {
  const _ContrastCard({
    required this.title,
    required this.foreground,
    required this.background,
  });

  final String title;
  final Color foreground;
  final Color background;

  @override
  Widget build(BuildContext context) {
    final ratio = AccessibilityHelpers.getContrastRatio(foreground, background);
    final meetsAA = AccessibilityHelpers.meetsWCAGAA(foreground, background);
    final meetsAAA = AccessibilityHelpers.meetsWCAGAAA(foreground, background);

    return Card(
      color: background,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: foreground,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Contrast Ratio: ${ratio.toStringAsFixed(2)}:1',
              style: TextStyle(color: foreground),
            ),
            Text(
              'WCAG AA: ${meetsAA ? "✓ Pass" : "✗ Fail"}',
              style: TextStyle(color: foreground),
            ),
            Text(
              'WCAG AAA: ${meetsAAA ? "✓ Pass" : "✗ Fail"}',
              style: TextStyle(color: foreground),
            ),
          ],
        ),
      ),
    );
  }
}

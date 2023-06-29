import 'package:flutter/widgets.dart';
import 'package:swifty_chat/src/theme/chat_theme.dart';

/// Used to make provided [ChatTheme] class available through the whole package
final class InheritedChatTheme extends InheritedWidget {
  /// Creates [InheritedWidget] from a provided [ChatTheme] class
  const InheritedChatTheme({
    required super.child,
    super.key,
    required this.theme,
  });

  /// Represents chat theme
  final ChatTheme theme;

  static InheritedChatTheme of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedChatTheme>()!;
  }

  @override
  bool updateShouldNotify(InheritedChatTheme oldWidget) =>
      theme.hashCode != oldWidget.theme.hashCode;
}

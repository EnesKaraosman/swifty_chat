import 'package:flutter/widgets.dart';
import 'package:swifty_chat/src/theme/chat_theme.dart';
import 'package:timeago/timeago.dart';

/// Used to make provided [ChatTheme] class available through the whole package
class InheritedChatTheme extends InheritedWidget {
  /// Creates [InheritedWidget] from a provided [ChatTheme] class
  const InheritedChatTheme({
    Key? key,
    required this.theme,
    this.customLookupMessages,
    required Widget child,
  }) : super(key: key, child: child);

  /// Represents chat theme
  final ChatTheme theme;
  final LookupMessages? customLookupMessages;

  static InheritedChatTheme of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedChatTheme>()!;
  }

  @override
  bool updateShouldNotify(InheritedChatTheme oldWidget) =>
      theme.hashCode != oldWidget.theme.hashCode;
}

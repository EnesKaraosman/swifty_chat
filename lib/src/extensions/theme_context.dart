import 'package:flutter/material.dart';

import '../inherited_chat_theme.dart';
import '../theme/chat_theme.dart';

extension ChatThemeContext on BuildContext {
  ChatTheme get theme => InheritedChatTheme.of(this).theme;
}
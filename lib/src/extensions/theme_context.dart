import 'package:flutter/material.dart';

import 'package:swifty_chat/src/inherited_chat_theme.dart';
import 'package:swifty_chat/src/theme/chat_theme.dart';

extension ChatThemeContext on BuildContext {
  ChatTheme get theme => InheritedChatTheme.of(this).theme;
}

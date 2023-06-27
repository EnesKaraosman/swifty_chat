import 'package:flutter/material.dart';

import 'package:swifty_chat/src/inherited_chat_theme.dart';
import 'package:swifty_chat/swifty_chat.dart';

extension TimeagoMessagesContext on BuildContext {
  LookupMessages? get lookupMessages =>
      InheritedChatTheme.of(this).customLookupMessages;
}

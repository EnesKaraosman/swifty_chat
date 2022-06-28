import 'package:flutter/cupertino.dart';

mixin ChatKeys {
  static const messageInputWidget = 'message_input_widget';
  static const messageTextField = 'message_text_field';
  static const messageSendButton = 'message_send_button';

  static const chatListView = 'chat_list_view';
}

extension StringToKey on String {
  Key get key => Key(this);
}

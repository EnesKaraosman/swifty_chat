import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:swifty_chat/swifty_chat.dart';

class MessageInputField extends StatelessWidget {
  MessageInputField({
    Key? key,
    required this.sendButtonTapped,
    this.theme,
  }) : super(key: key);

  final textEditingController = TextEditingController();

  final Function(String) sendButtonTapped;
  final ChatTheme? theme;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 2,
            offset: Offset(2, -2),
          )
        ],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              key: ChatKeys.messageTextField.key,
              controller: textEditingController,
              focusNode: FocusNode(),
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration.collapsed(
                hintText: 'Write your reply...',
                hintStyle: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xffAEA4A3),
                ),
              ),
              textInputAction: TextInputAction.send,
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
              onSubmitted: (_) {
                sendButtonTapped(textEditingController.text);
                textEditingController.text = "";
              },
            ),
          ),
          Container(
            key: ChatKeys.messageSendButton.key,
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.blueAccent,
            ),
            child: theme?.sendMessageIcon,
          ).rotate(angle: 150).gestures(
            onTap: () {
              sendButtonTapped(textEditingController.text);
              textEditingController.text = "";
            },
          )
        ],
      ),
    );
  }
}

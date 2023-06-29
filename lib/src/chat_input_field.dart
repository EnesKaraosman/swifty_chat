import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import 'package:swifty_chat/src/extensions/keys.dart';

final class MessageInputField extends StatefulWidget {
  const MessageInputField({
    required this.sendButtonTapped,
    super.key,
  });

  final Function(String) sendButtonTapped;

  @override
  State<MessageInputField> createState() => _MessageInputFieldState();
}

final class _MessageInputFieldState extends State<MessageInputField> {
  final textEditingController = TextEditingController();

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
                widget.sendButtonTapped(textEditingController.text);
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
            child: const Icon(
              Icons.send_outlined,
              color: Colors.white70,
            ),
          ).rotate(angle: 150).gestures(
            onTap: () {
              widget.sendButtonTapped(textEditingController.text);
              textEditingController.text = "";
            },
          )
        ],
      ),
    );
  }
}

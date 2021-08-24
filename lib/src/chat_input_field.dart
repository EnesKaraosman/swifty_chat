import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

class MessageInputField extends StatelessWidget {
  MessageInputField({Key? key, required this.sendButtonTapped}) : super(key: key);

  final textEditingController = TextEditingController();

  final Function(String) sendButtonTapped;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: textEditingController,
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
              sendButtonTapped(textEditingController.text);
              textEditingController.text = "";
            },
          )
        ],
      ),
    );
  }
}

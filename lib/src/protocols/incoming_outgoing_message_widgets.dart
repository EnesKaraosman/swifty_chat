import 'package:flutter/material.dart';

abstract class IncomingOutgoingMessageWidgets {
  Widget incomingMessageWidget(BuildContext context) {
    throw UnimplementedError("Implement incomingMessageWidget");
  }

  Widget outgoingMessageWidget(BuildContext context) {
    throw UnimplementedError("Implement incomingMessageWidget");
  }
}
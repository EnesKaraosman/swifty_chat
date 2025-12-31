import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

import '../chat.dart';
import '../extensions/date_extensions.dart';
import '../extensions/theme_context.dart';
import '../models/message.dart';
import '../models/user_avatar.dart';
import '../protocols/has_avatar.dart';
import '../protocols/incoming_outgoing_message_widgets.dart';
import '../utils/accessibility_helpers.dart';

@immutable
final class ImageMessageWidget extends StatelessWidget
    with HasAvatar, IncomingOutgoingMessageWidgets {
  const ImageMessageWidget(this._chatMessage);

  final Message _chatMessage;

  @override
  Widget incomingMessageWidget(BuildContext context) => RepaintBoundary(
        child: Semantics(
          label: AccessibilityHelpers.createImageSemanticLabel(
            userName: message.user.userName,
            timestamp: Jiffy.parseFromDateTime(message.date).fromNow(),
          ),
          image: true,
          child: Row(
            crossAxisAlignment: avatarPosition.alignment,
            children: [
              ...avatarWithPadding(),
              imageContainer(context),
            ],
          ),
        ),
      );

  @override
  Widget outgoingMessageWidget(BuildContext context) => RepaintBoundary(
        child: Semantics(
          label: AccessibilityHelpers.createImageSemanticLabel(
            userName: 'You',
            timestamp: Jiffy.parseFromDateTime(message.date).fromNow(),
          ),
          image: true,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: avatarPosition.alignment,
            children: [
              imageContainer(context),
              ...avatarWithPadding(),
            ],
          ),
        ),
      );

  Widget imageContainer(BuildContext context) {
    final theme = context.theme;

    return ClipRRect(
      borderRadius: theme.imageBorderRadius,
      child: Stack(
        children: [
          Image(
            width: _imageWidth(context),
            image: message.messageKind.imageProvider!,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                width: _imageWidth(context),
                height: 200,
                color: Colors.grey[200],
                child: Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: _imageWidth(context),
                height: 200,
                color: Colors.grey[200],
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.broken_image, size: 48, color: Colors.grey),
                    SizedBox(height: 8),
                    Text(
                      'Failed to load image',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            right: 12,
            bottom: 6,
            child: Text(
              message.date.relativeTimeFromNow(),
              style: theme.imageWidgetTextTime,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => message.isMe
      ? outgoingMessageWidget(context)
      : incomingMessageWidget(context);

  double _imageWidth(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return ChatStateContainer.of(context)
        .messageCellSizeConfigurator
        .imageCellMaxWidthConfiguration(screenWidth);
  }

  @override
  Message get message => _chatMessage;
}

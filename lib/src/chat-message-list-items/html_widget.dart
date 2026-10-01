import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:jiffy/jiffy.dart';
import 'package:url_launcher/url_launcher.dart';

import '../chat.dart';
import '../extensions/date_extensions.dart';
import '../extensions/theme_context.dart';
import '../models/message.dart';
import '../models/user_avatar.dart';
import '../protocols/has_avatar.dart';

final class HTMLWidget extends StatelessWidget with HasAvatar {
  const HTMLWidget(this.chatMessage, {super.key});

  final Message chatMessage;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final functions =
        ChatStateContainer.of(context).onHtmlWidgetPressed?.call();
    final OnTap? onLinkTap = functions?["onLinkTap"];
    final OnTap? onImageTap = functions?["onImageTap"];
    final Color htmlTextColor = context.theme.htmlTextColor;
    final String? htmlTextFontFamily = context.theme.htmlTextFontFamily;
    final htmlStyle = {
      "body": Style(
        fontWeight: FontWeight.w400,
        color: htmlTextColor,
        fontFamily: htmlTextFontFamily,
        fontSize: FontSize(16),
      ),
      "a": Style(
        fontWeight: FontWeight.bold,
        fontFamily: htmlTextFontFamily,
        color: htmlTextColor,
      ),
    };

    return Semantics(
      label:
          'HTML message from ${chatMessage.user.userName} sent ${Jiffy.parseFromDateTime(chatMessage.date).fromNow()}',
      child: Row(
        crossAxisAlignment: avatarPosition.alignment,
        children: [
          ...avatarWithPadding(),
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: context.theme.secondaryColor,
                    borderRadius: BorderRadius.only(
                      bottomRight:
                          Radius.circular(context.theme.messageBorderRadius),
                      topLeft:
                          Radius.circular(context.theme.messageBorderRadius),
                      topRight:
                          Radius.circular(context.theme.messageBorderRadius),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(context.theme.textMessagePadding),
                    child: Html(
                      data: chatMessage.messageKind.htmlData,
                      style: htmlStyle,
                      extensions: [
                        if (onImageTap != null)
                          OnImageTapExtension(onImageTap: onImageTap),
                      ],
                      onLinkTap: onLinkTap ??
                          (link, _, __) async {
                            final uri = Uri.tryParse(link ?? '');
                            if (uri != null && uri.hasScheme) {
                              await launchUrl(uri);
                            }
                          },
                    ),
                  ),
                ),
                Positioned(
                  right: 12,
                  bottom: 6,
                  child: Text(
                    chatMessage.date.relativeTimeFromNow(),
                    style: theme.htmlWidgetTextTime,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }

  @override
  Message get message => chatMessage;
}

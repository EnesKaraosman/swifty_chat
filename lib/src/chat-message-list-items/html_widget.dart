import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:swifty_chat/src/chat.dart';
import 'package:swifty_chat/src/extensions/date_extensions.dart';
import 'package:swifty_chat/src/extensions/theme_context.dart';
import 'package:swifty_chat/src/protocols/has_avatar.dart';
import 'package:swifty_chat_data/swifty_chat_data.dart';
import 'package:url_launcher/url_launcher.dart';

final class HTMLWidget extends StatelessWidget with HasAvatar {
  const HTMLWidget(this.chatMessage);

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

    return Row(
      crossAxisAlignment: avatarPosition.alignment,
      children: [
        ...avatarWithPadding(),
        Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 76,
              decoration: BoxDecoration(
                color: context.theme.secondaryColor,
                borderRadius: BorderRadius.only(
                  bottomRight:
                      Radius.circular(context.theme.messageBorderRadius),
                  topLeft: Radius.circular(context.theme.messageBorderRadius),
                  topRight: Radius.circular(context.theme.messageBorderRadius),
                ),
              ),
              child: Html(
                data: chatMessage.messageKind.htmlData,
                onImageTap: onImageTap,
                style: htmlStyle,
                onLinkTap: onLinkTap ??
                    (link, _, __, ___) async {
                      if (await canLaunchUrl(Uri.parse(link!))) {
                        await launchUrl(
                          Uri.parse(link),
                        );
                      }
                    },
              ).padding(all: context.theme.textMessagePadding),
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
        const SizedBox(width: 20),
      ],
    );
  }

  @override
  Message get message => chatMessage;
}

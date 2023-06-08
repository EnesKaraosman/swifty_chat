import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:swifty_chat/src/chat.dart';
import 'package:swifty_chat/src/extensions/theme_context.dart';
import 'package:swifty_chat/src/theme/chat_theme.dart';
import 'package:swifty_chat_data/swifty_chat_data.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:swifty_chat/src/protocols/has_avatar.dart';

class HTMLWidget extends StatelessWidget with HasAvatar {
  final Message chatMessage;
  final VoidCallback? onLinkTap;

  const HTMLWidget(this.chatMessage, this.onLinkTap);

  @override
  Widget build(BuildContext context) {
    final functions =
        ChatStateContainer.of(context).onHtmlWidgetPressed?.call();
    final OnTap? onLinkTap = functions?["onLinkTap"];
    final OnTap? onImageTap = functions?["onImageTap"];
    final Color htmlTextColor = context.theme.htmlTextColor;
    final String? htmlTextFontFamily = context.theme.htmlTextFontFamily;
    final htmlStyle = {
      "body": Style(
        fontWeight: FontWeight.w400,
        color: neutral0,
        fontSize: const FontSize(16),
      ),
      "a": Style(
        fontWeight: FontWeight.bold,
        color: const Color.fromARGB(255, 0, 40, 87),
      )
    };

    return Row(
      crossAxisAlignment: avatarPosition.alignment,
      children: [
        ...avatarWithPadding(),
        Container(
          width: MediaQuery.of(context).size.width - 80,
          decoration: BoxDecoration(
            color: context.theme.secondaryColor,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(context.theme.messageBorderRadius),
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
        const SizedBox(width: 24),
      ],
    );
  }

  Style styleFrom({
    required Color color,
    String? fontFamily,
  }) {
    return Style(color: color, fontFamily: fontFamily);
  }

  @override
  Message get message => chatMessage;
}

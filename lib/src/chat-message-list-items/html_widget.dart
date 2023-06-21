import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:swifty_chat/src/chat.dart';
import 'package:swifty_chat/src/extensions/theme_context.dart';
import 'package:swifty_chat/src/extensions/timeago_message_context.dart';
import 'package:swifty_chat/src/protocols/has_avatar.dart';
import 'package:swifty_chat/src/protocols/timeago_settings.dart';
import 'package:swifty_chat_data/swifty_chat_data.dart';
import 'package:url_launcher/url_launcher.dart';

class HTMLWidget extends StatelessWidget with HasAvatar {
  final Message chatMessage;
  final LocaleType? locale;

  const HTMLWidget(this.chatMessage, this.locale);

  @override
  Widget build(BuildContext context) {
    final _theme = context.theme;
    final _lookupmessage = context.lookupMessages;
    final String time = message.time != null
        ? timeSettings(message.time!, locale, _lookupmessage)
        : "";
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
        fontSize: const FontSize(16),
      ),
      "a": Style(
        fontWeight: FontWeight.bold,
        fontFamily: htmlTextFontFamily,
        color: htmlTextColor,
      )
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
              right: 10,
              bottom: 2,
              child: Text(
                time,
                style: _theme.htmlWidgetTextTime,
              ),
            ),
          ],
        ),
        const SizedBox(width: 20),
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

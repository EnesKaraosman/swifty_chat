import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
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
    final onLinkTap = functions?["onLinkTap"];
    final onImageTap = functions?["onImageTap"];
    final Color htmlTextColor = context.theme.htmlTextColor;
    final String? htmlTextFontFamily = context.theme.htmlTextFontFamily;

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
                    child: HtmlWidget(
                      chatMessage.messageKind.htmlData ?? '',
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: htmlTextColor,
                        fontFamily: htmlTextFontFamily,
                        fontSize: 16,
                      ),
                      customStylesBuilder: (element) => element.localName == 'a'
                          ? {
                              'font-weight': 'bold',
                              'color': _cssColor(htmlTextColor),
                            }
                          : null,
                      onTapImage: onImageTap == null
                          ? null
                          : (image) => onImageTap(image.sources.first.url),
                      onTapUrl: (url) async {
                        if (onLinkTap != null) {
                          onLinkTap(url);
                          return true;
                        }
                        final uri = Uri.tryParse(url);
                        return uri != null &&
                            uri.hasScheme &&
                            await launchUrl(uri);
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

String _cssColor(Color color) =>
    'rgba(${(color.r * 255).round()}, ${(color.g * 255).round()}, '
    '${(color.b * 255).round()}, ${color.a})';

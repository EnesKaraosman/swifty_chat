import 'package:flutter/material.dart';
import 'package:swifty_chat/swifty_chat.dart';
import 'package:timeago/timeago.dart' as timeago;

String timeSettings(
  DateTime time,
  LocaleType? locale,
  LookupMessages? lookupMessagesContext,
) {
  final timeago.LookupMessages lookupMessages =
      lookupMessagesContext ?? setLocale(locale) as timeago.LookupMessages;
  timeago.setLocaleMessages(locale.toString(), lookupMessages);
  final now = DateTime.now();
  final difference = now.difference(time);
  final String date;
  final clock = TimeOfDay(hour: time.hour, minute: time.minute);
  if (difference.inDays == 0) {
    date = clock.to24hours();
  } else {
    date = timeago.format(
      now.subtract(difference),
      locale: locale?.toString(),
    );
  }
  return date;
}

extension TimeOfDayConverter on TimeOfDay {
  String to24hours() {
    final hour = this.hour.toString().padLeft(2, "0");
    final min = minute.toString().padLeft(2, "0");
    return "$hour:$min";
  }
}

timeago.LookupMessages? setLocale(LocaleType? locale) {
  switch (locale) {
    case LocaleType.en:
      return timeago.EnMessages();
    case LocaleType.tr:
      return timeago.TrMessages();
    case LocaleType.de:
      return timeago.DeMessages();
    case LocaleType.enshort:
      return timeago.EnShortMessages();
    case LocaleType.deshort:
      return timeago.DeShortMessages();
    default:
      return timeago.TrMessages();
  }
}

enum LocaleType { en, tr, de, enshort, deshort }

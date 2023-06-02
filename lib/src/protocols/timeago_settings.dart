import 'package:flutter/material.dart';
import 'package:swifty_chat/src/protocols/timeago_tr_messages.dart';
import 'package:timeago/timeago.dart' as timeago;

String timeSettings(DateTime time) {
  timeago.setLocaleMessages('tr', CustomMessages());
  final now = DateTime.now();
  final difference = now.difference(time);
  final String date;
  final clock = TimeOfDay(hour: time.hour, minute: time.minute);
  if (difference.inDays == 0) {
    date = clock.to24hours();
  } else {
    date = timeago.format(now.subtract(difference), locale: "tr");
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

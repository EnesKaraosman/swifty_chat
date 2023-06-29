import 'package:jiffy/jiffy.dart';

extension DateX on DateTime {
  String relativeTimeFromNow() {
    final now = DateTime.now();
    if (now.difference(this).inDays == 0) {
      return hourMinute();
    }

    return Jiffy.parseFromDateTime(this).fromNow();
  }

  String hourMinute() {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    final String hours = twoDigits(hour);
    final String minutes = twoDigits(minute);

    return "$hours:$minutes";
  }
}

String convertSecondsToHMSFormat(int seconds) {
  // used to represent amount of time not time of day
  if (seconds < 0) {
    throw FormatException('The value of seconds must be a positive integer, but a negative value was provided: $seconds');
  }

  int hours = seconds ~/ 3600;
  int minutes = (seconds % 3600) ~/ 60;
  int secs = seconds % 60;

  String hoursStr = (hours < 10) ? '0$hours' : '$hours';
  String minutesStr = (minutes < 10) ? '0$minutes' : '$minutes';
  String secondsStr = (secs < 10) ? '0$secs' : '$secs';

  return '$hoursStr:$minutesStr:$secondsStr';
}

String convertHMSToShortFormat(String time) {
  // required format: HH:mm:ss of H:mm:ss

  final RegExp timeFormatRegExp = RegExp(r'^\d+:\d{2}:\d{2}$');

  if (!timeFormatRegExp.hasMatch(time)) {
    throw FormatException('Invalid time format. The correct format is H:MM:SS or HH:MM:SS. Provided time: $time');
  }

  List<String> parts = time.split(':');

  int hours = int.parse(parts[0]);
  int minutes = int.parse(parts[1]);
  int seconds = int.parse(parts[2]);

  String shortenedTime = '';

  if (hours != 0) {
    shortenedTime += '${hours.toString()}:';
  }

  if (minutes != 0 && hours == 0) {
    shortenedTime += '${minutes.toString()}:';
  } else if (hours != 0) {
    shortenedTime += '${minutes.toString().padLeft(2, '0')}:';
  }

  if (minutes == 0 && hours == 0) {
    shortenedTime += seconds.toString();
  } else {
    shortenedTime += seconds.toString().padLeft(2, '0');
  }

  return shortenedTime;
}

String convertSecondsToShortFormat(int seconds) {
  String timeFormat = '';
  try {
    timeFormat = convertHMSToShortFormat(convertSecondsToHMSFormat(seconds));
  } on FormatException {
    rethrow;
  }
  return timeFormat;
}

String convertDateTimetoYYYYMMDDFormat(DateTime date) {
  return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
}

String calculateDaysBetween(DateTime start, DateTime end) {
  if (start.isAtSameMomentAs(end)) {
    return '1';
  }
  return '${end.difference(start).inDays}';
}

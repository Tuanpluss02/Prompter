// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateTimeUtils {
  // Date Formats
  static const String _ddMMyyyyHHmm = 'dd/MM/yyyy, HH:mm';
  static const String _ddMMyyyyhhmm = 'dd/MM/yyyy, hh:mm';
  static const String _ddMMyyyy = 'dd/MM/yyyy';
  static const String _ddMM = 'dd/MM';
  static const String _HHmm = 'HH:mm';
  static const String _yyyyMMddTHHmmssZZ = 'yyyy-MM-ddTHH:mm:ssZZ';
  static const String _yyyyMMddTHHmmssmmm = 'yyyy-MM-ddTHH:mm:ss.mmm';

  // Formatted Date Strings
  static const String dateFormatDDMMYYYYHHMM = _ddMMyyyyHHmm;
  static const String dateFormatDDMMYYYYHHMM12 = _ddMMyyyyhhmm;
  static const String dateFormatDDMMYYYY = _ddMMyyyy;
  static const String dateFormatDDMM = _ddMM;
  static const String dateFormatHHMM = _HHmm;

  static String formatTime(
    String dateTime, {
    String format = dateFormatHHMM,
    bool isConvert = true,
  }) {
    if (dateTime.isEmpty) return '';
    var inputFormat = DateFormat(_yyyyMMddTHHmmssZZ);
    var inputDate = inputFormat.parse(dateTime).add(Duration(hours: (isConvert) ? 7 : 0));
    var outputFormat = DateFormat(format);
    if (format == _yyyyMMddTHHmmssZZ) {
      return _formatISOTime(inputDate);
    }
    return outputFormat.format(inputDate);
  }

  static String formatTimeSecond({required int time}) {
    int sec = time % 60;
    int min = (time / 60).floor();
    String minute = min.toString().padLeft(2, '0');
    String second = sec.toString().padLeft(2, '0');
    return ' $minute:$second';
  }

  static String formatSecondsToDate(int time) {
    var date = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    return DateFormat('HH:mm - $_ddMMyyyy').format(date);
  }

  static String formatToDate(int time) {
    var date = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    return DateFormat(dateFormatDDMMYYYY).format(date);
  }

  static DateTime stringToDatetime(
    String dateTime, {
    String format = _yyyyMMddTHHmmssZZ,
  }) {
    try {
      return DateFormat(format).parse(dateTime);
    } on Exception catch (_) {
      rethrow;
    }
  }

  static String _formatISOTime(DateTime date) {
    var duration = date.timeZoneOffset;
    String formattedDate = DateFormat(_yyyyMMddTHHmmssmmm).format(date);
    String formattedOffset = duration.isNegative
        ? "-${duration.inHours.toString().padLeft(2, '0')}${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}"
        : "+${duration.inHours.toString().padLeft(2, '0')}${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}";
    return '$formattedDate$formattedOffset';
  }

  static String formatTimeString(String dateTime, {String dateConvert = dateFormatDDMMYYYY, String format = _yyyyMMddTHHmmssZZ}) {
    if (dateTime.isEmpty) return '';
    var inputFormat = DateFormat(dateConvert);
    var inputDate = inputFormat.parse(dateTime);
    var outputFormat = DateFormat(format);
    if (format == _yyyyMMddTHHmmssZZ) {
      return _formatISOTime(inputDate);
    }
    return outputFormat.format(inputDate);
  }

  static String subTrackDateTimeStr30(String dateTime, {int timeSubTrack = 30}) {
    var date = stringToDatetime(dateTime);
    var dateTimeSubTrack = date.subtract(Duration(days: timeSubTrack));
    return _formatISOTime(dateTimeSubTrack);
  }

  static String subTrackDateTime30(DateTime dateTime) {
    var dateTimeSubTrack = DateTime(dateTime.year, dateTime.month - 1, dateTime.day);
    return _formatISOTime(dateTimeSubTrack);
  }

  static String subTrackDateTime14(DateTime dateTime) {
    var dateTimeSubTrack = DateTime(dateTime.year, dateTime.month, dateTime.day - 14);
    return _formatISOTime(dateTimeSubTrack);
  }

  static Future<String> selectedDateTime({DateTime? initialDate}) async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      locale: Localizations.localeOf(Get.context!),
      initialDate: initialDate ?? DateTime.now(),
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year + 100),
      fieldHintText: 'dd/mm/yyyy',
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.yellow,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    return picked != null ? _formatISOTime(picked) : '';
  }

  static int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return to.difference(from).inDays;
  }

  static int checkDifferenceToDateFromDate({required DateTime from, required DateTime to}) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (from.difference(to).inHours / 24).round();
  }

  static String convertLongToStringTime(int? millis, {String formatTime = dateFormatDDMMYYYY}) {
    if (millis == null) {
      return '';
    } else {
      var date = DateTime.fromMillisecondsSinceEpoch(millis);
      return DateFormat(formatTime).format(date.toLocal());
    }
  }

  static String convertToAgo(DateTime dateTime) {
    var outputDateFormat = DateFormat('dd/MM/yyyy HH:mm');
    DateTime now = DateFormat('dd/MM/yyyy HH:mm:ss')
        .parse('${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}')
        .toLocal();
    Duration diff = now.difference(dateTime);

    if (diff.inDays >= 1) {
      return outputDateFormat.format(dateTime);
    } else if (diff.inHours >= 1) {
      return '${diff.inHours}h${diff.inMinutes - diff.inHours * 60}p trước';
    } else if (diff.inMinutes >= 1) {
      return '${diff.inMinutes}p trước';
    } else if (diff.inSeconds >= 1) {
      return '${diff.inSeconds} giây trước';
    } else {
      return 'Vừa xong';
    }
  }

  static int? converStringtoInt(String date, {String format = dateFormatDDMMYYYY}) {
    return DateFormat(format).parse(date).millisecondsSinceEpoch;
  }

  static String getDayOfWeek2(DateTime dateTime) {
    if (dateTime.day == DateTime.now().day && dateTime.month == DateTime.now().month && dateTime.year == DateTime.now().year) {
      return 'Hôm nay';
    } else {
      switch (dateTime.weekday) {
        case 1:
          return 'Thứ Hai';
        case 2:
          return 'Thứ Ba';
        case 3:
          return 'Thứ Tư';
        case 4:
          return 'Thứ Năm';
        case 5:
          return 'Thứ Sáu';
        case 6:
          return 'Thứ Bảy';
        case 7:
          return 'Chủ Nhật';
        default:
          return '';
      }
    }
  }
}

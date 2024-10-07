import 'dart:math';

import 'package:get/get.dart';

class ValidatorUtils {
  static bool isPhoneNumber(String phoneNo) {
    final regExp = RegExp(r'(^(?:\+84|0)(?:3[2-9]|5[25689]|7[06-9]|8[1-9]|9\d)\d{7}$)');
    return regExp.hasMatch(phoneNo);
  }

  static String normalizePhoneNumber(String phoneNo) {
    String number = phoneNo.replaceAll(' ', '').replaceAll('.', '').replaceAll('(', '').replaceAll(')', '').replaceAll('+84', '0');
    if (number.startsWith('84')) {
      number = number.replaceFirst('84', '0');
    }
    if (number.isNotEmpty) {
      if (number[0] != '0') number = '0$number';
    }

    return number;
  }

  static String getFileSizeString({required int bytes, int decimals = 0}) {
    const suffixes = [' B', ' KB', ' MB', ' GB', ' TB'];
    if (bytes == 0) return '0${suffixes[0]}';
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
  }

  static bool isValidEmai(String email) {
    return GetUtils.isEmail(email);
  }

  static bool validateOtp(String? value) {
    // 6 kí tự là được
    if (value == null || value.isEmpty) {
      return false;
    }
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return false;
    }
    if (value.length != 6) {
      return false;
    }
    return true;
  }

  static bool validateHasSpecialCharacter(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    // phải có kí tự khác chữ và số
    return RegExp(r'[^A-Za-z0-9]').hasMatch(value);
  }

  static bool validateHasUpperAndLowerCaseAndDigit(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    // Regex kiểm tra có ít nhất 1 chữ hoa, 1 chữ thường và 1 chữ số
    final regex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).+$');
    return regex.hasMatch(value);
  }

  static bool validateLengthPassword(String? value) {
    if (value == null) {
      return false;
    }
    // Kiểm tra nếu độ dài của chuỗi từ 8 trở lên
    return value.length >= 8;
  }
}

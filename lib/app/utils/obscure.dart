String obscureEmail(String email) {
  // Tách phần tên và phần domain của email
  final parts = email.split('@');
  final name = parts[0];
  final domain = parts[1];

  // Giữ lại ký tự đầu tiên của phần tên và thêm **** cho phần còn lại
  final obscuredName = '${name[0]}****';

  // Kết hợp lại thành email đã được che
  return '$obscuredName@$domain';
}

String obscurePhoneNumber(String phoneNumber) {
  // Lấy 4 số cuối của số điện thoại
  final lastFourDigits = phoneNumber.substring(phoneNumber.length - 4);

  // Thay thế phần đầu bằng ***
  final obscuredPhoneNumber = '****$lastFourDigits';

  return obscuredPhoneNumber;
}

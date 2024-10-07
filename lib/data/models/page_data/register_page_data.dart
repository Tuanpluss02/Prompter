enum RegisterPageType {
  phone(0),
  email(1);
  // username bổ xung sau khi bên đăng nhập có thể dùng được
  // username(2);

  final int value;
  const RegisterPageType(this.value);
}

class RegisterPageData {
  final RegisterPageType type;
  String? phoneNumber;
  String? email;

  RegisterPageData({
    required this.type,
    this.phoneNumber,
    this.email,
  });
}

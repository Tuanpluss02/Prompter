enum ForgotPageType {
  phone(0),
  email(1);

  final int value;
  const ForgotPageType(this.value);
}

class ForgotPageData {
  final ForgotPageType type;
  String? avatarLink;
  String? phoneNumber;
  String? email;

  ForgotPageData({
    required this.type,
    this.avatarLink,
    this.phoneNumber,
    this.email,
  });
}

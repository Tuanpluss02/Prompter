class AppProvider {
  static final AppProvider _instance = AppProvider._internal();

  factory AppProvider() {
    return _instance;
  }

  AppProvider._internal();
}

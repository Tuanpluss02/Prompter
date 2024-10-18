class AppProvider {
  static final AppProvider _instance = AppProvider._internal();

  factory AppProvider() => _instance;

  AppProvider._internal();
}

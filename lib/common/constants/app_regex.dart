class AppRegex {
  static const String email = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const String url = r"[(http(s)?):\/\/(www\.)?a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@%_\+~#?&//=]*)";
  static const String mentionUser = r'<@(\d+)>';
  static const String hashtag = r'#([a-zA-Z0-9_]+)';
}

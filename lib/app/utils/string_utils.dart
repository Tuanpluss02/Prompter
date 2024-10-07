class StringUtils {
  static bool containLink(String input) {
    final matcher = RegExp(r'(http(s)?:\/\/.)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)');
    return matcher.hasMatch(input);
  }

  static List<String> getLinkFromText(String input) {
    final urlRegExp = RegExp(r'((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?');
    final urlMatches = urlRegExp.allMatches(input);
    List<String> urls = urlMatches.map((urlMatch) => input.substring(urlMatch.start, urlMatch.end)).toList();

    return urls;
  }

  /// NGUYEN VAN A -> Nguyen Van A
  static nomalizeName(String name) {
    return name.split(' ').map((e) => e[0].toUpperCase() + e.substring(1).toLowerCase()).join(' ');
  }
}

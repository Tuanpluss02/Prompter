import 'package:base/common/constants/app_regex.dart';

List<String> getLinkText(String text) {
  final List<String> links = [];
  final RegExp linkRegExp = RegExp(AppRegex.url);
  final Iterable<Match> matches = linkRegExp.allMatches(text);
  for (final Match match in matches) {
    links.add(match.group(0)!);
  }
  return links;
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A widget that displays text with highlighted portions.
///
/// The `HighlightedText` widget is used to display text with specific portions
/// highlighted. It takes in a `text` string and a list `highlights`, and
/// applies a `highlightStyle` to the matching portions of the text. The
/// non-matching portions of the text are styled using the `normalTextStyle`.
///
/// The widget uses regular expressions to find the matching portions of the
/// text. Each string in the `highlights` list is escaped using
/// `RegExp.escape` to ensure that it is treated as a literal string,
/// even if it contains special characters used in regular expressions.
///
/// If the `highlights` list is empty, the entire text is displayed using the
/// `normalTextStyle`.
///
/// Example usage:
/// ```dart
/// HighlightedText(
///   text: 'Hello World, Flutter is awesome!',
///   highlights: ['Hello', 'Flutter'],
///   highlightStyle: TextStyle(color: Colors.red),
///   normalTextStyle: TextStyle(color: Colors.black),
/// )
/// ```
///
/// This will display the text "Hello World, Flutter is awesome!" with
/// the words "Hello" and "Flutter" highlighted in red.
class HighlightedText extends StatelessWidget {
  /// The text to be displayed.
  final String text;

  /// The portions of the text to be highlighted.
  final List<String> highlights;

  /// The style to be applied to the non-highlighted portions of the text.
  final TextStyle? normalTextStyle;

  /// The style to be applied to the highlighted portions of the text.
  final TextStyle? highlightStyle;

  final double? height;

  final double? width;

  final Function()? onTapHighlight;

  final TextAlign textAlign;

  /// Creates a new HighlightedText widget.
  const HighlightedText({
    super.key,
    required this.text,
    required this.highlights,
    this.highlightStyle,
    this.normalTextStyle,
    // Sorry for the hardcoding, but I don't have time to make it dynamic @@
    this.height = 40,
    this.width,
    this.onTapHighlight,
    this.textAlign = TextAlign.start,
  });

  /// The default text style for the non-highlighted portions of the text.
  static TextStyle normalTextStyleDefault = GoogleFonts.manrope(
    color: const Color(0xFF99909B),
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  /// The default text style for the highlighted portions of the text.
  static TextStyle highlightedTextStyleDefault = GoogleFonts.manrope(
    color: const Color(0xFF4F4950),
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  @override
  Widget build(BuildContext context) {
    if (highlights.isEmpty) {
      return Text(
        text,
        style: normalTextStyle ?? normalTextStyleDefault,
      );
    }

    final List<TextSpan> spans = [];
    final List<Match> allMatches = [];

    // Find all matches for each highlight
    for (var highlight in highlights) {
      final RegExp regex = RegExp(RegExp.escape(highlight), caseSensitive: false);
      allMatches.addAll(regex.allMatches(text));
    }

    // Sort the matches by their starting position
    allMatches.sort((a, b) => a.start.compareTo(b.start));

    int start = 0;
    for (final Match match in allMatches) {
      // Add the normal text span before the highlight.
      if (match.start != start) {
        spans.add(TextSpan(text: text.substring(start, match.start), style: normalTextStyle ?? normalTextStyleDefault));
      }

      // Add the highlighted text span.
      spans.add(TextSpan(
        text: match.group(0)!,
        recognizer: onTapHighlight != null ? (TapGestureRecognizer()..onTap = () => onTapHighlight?.call()) : null,
        style: highlightStyle ?? highlightedTextStyleDefault,
      ));

      start = match.end;
    }

    // Add the remaining normal text after the last highlight.
    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start), style: normalTextStyle ?? normalTextStyleDefault));
    }

    return SizedBox(height: height, width: width, child: RichText(
        textAlign: textAlign,
        text: TextSpan(children: spans)));
  }
}

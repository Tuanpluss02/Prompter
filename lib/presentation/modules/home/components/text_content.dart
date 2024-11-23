import 'package:base/common/constants/app_regex.dart';
import 'package:base/common/utils/log.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

class TextContent extends StatelessWidget {
  const TextContent({
    super.key,
    this.content,
    this.hasMedia = false,
  });

  final String? content;
  final bool hasMedia;

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      content ?? '',
      trimMode: TrimMode.Line,
      trimLines: hasMedia ? 3 : 5,
      annotations: [
        Annotation(
          regExp: RegExp(AppRegex.hashtag),
          spanBuilder: ({required String text, TextStyle? textStyle}) => TextSpan(
            text: text,
            style: textStyle?.copyWith(color: Colors.blue),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Log.console('Hashtag tapped');
              },
          ),
        ),
        Annotation(
          regExp: RegExp(AppRegex.mentionUser),
          spanBuilder: ({required String text, TextStyle? textStyle}) => TextSpan(
            text: '@User123',
            style: textStyle?.copyWith(color: Colors.green),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Log.console('User123 tapped');
              },
          ),
        ),
        Annotation(
          regExp: RegExp(AppRegex.url),
          spanBuilder: ({required String text, TextStyle? textStyle}) => TextSpan(
            text: text,
            style: textStyle?.copyWith(color: Colors.blue),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                launchUrl(Uri.parse(text));
              },
          ),
        ),
      ],
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w300,
      ),
      textAlign: TextAlign.left,
      lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    );
  }
}

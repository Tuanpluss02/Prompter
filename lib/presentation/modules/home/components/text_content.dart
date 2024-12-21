import 'package:base/common/constants/app_regex.dart';
import 'package:base/common/utils/log.dart';
import 'package:base/presentation/modules/root/root_controller.dart';
import 'package:base/presentation/modules/search/search_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide SearchController;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

class TextContent extends StatelessWidget {
  final String? content;

  final bool hasMedia;
  const TextContent({
    super.key,
    this.content,
    this.hasMedia = false,
  });

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      trimExpandedText: ' show less',
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
                Get.find<SearchController>().textSearchController.text = text;
                Get.find<SearchController>().onSearchChanged(text);
                Get.find<RootController>().onNavItemTaped(1);
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

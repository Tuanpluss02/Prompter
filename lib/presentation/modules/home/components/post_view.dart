import 'package:base/common/constants/app_assets_path.dart';
import 'package:base/common/constants/app_strings.dart';
import 'package:base/common/constants/app_text_styles.dart';
import 'package:base/common/utils/extension.dart';
import 'package:base/common/utils/log.dart';
import 'package:base/domain/data/entities/post_entity.dart';
import 'package:base/presentation/modules/home/home_controller.dart';
import 'package:base/presentation/shared/animated/animated_scale_button.dart';
import 'package:base/presentation/shared/global/app_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

class PostView extends GetView<HomeController> {
  const PostView({super.key, required this.post});

  final PostEntity post;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPostAuthor(),
        const SizedBox(height: 10),
        _buildPostText(),
        _buildPostMedia(),
        const SizedBox(height: 10),
        _buildPostReact(),
        Divider(),
      ],
    );
  }

  _buildPostMedia() {
    return Visibility(
      visible: (post.images?.isNotEmpty ?? false),
      child: Container(
        padding: const EdgeInsets.only(top: 10),
        height: Get.width * 0.5,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: post.images?.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: AppImage(image: NetworkImage(post.images![index])),
              ),
            );
          },
        ),
      ),
    );
  }

  _buildPostAuthor() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAvatarName(),
          Spacer(),
          GestureDetector(onTap: () {}, child: SvgPicture.asset(SvgPath.icMore)),
        ],
      ),
    );
  }

  _buildPostReact() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ScaleButton(
            onTap: () {},
            child: Row(
              children: [
                SvgPicture.asset(SvgPath.icHeart),
                const SizedBox(width: 5),
                Text(post.likes?.length.toShortString() ?? '', style: AppTextStyles.s14w600),
              ],
            ),
          ),
          SizedBox(width: 15),
          ScaleButton(
            onTap: () {},
            child: Row(
              children: [
                SvgPicture.asset(SvgPath.icComment),
                const SizedBox(width: 5),
                Text(post.comments?.length.toShortString() ?? '', style: AppTextStyles.s14w600),
              ],
            ),
          ),
          SizedBox(width: 15),
          ScaleButton(
            onTap: () {},
            child: SvgPicture.asset(SvgPath.icShare),
          ),
        ],
      ),
    );
  }

  _buildPostText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ReadMoreText(
        post.content ?? '',
        trimMode: TrimMode.Line,
        trimLines: (post.images?.isNotEmpty ?? false) ? 3 : 5,
        annotations: [
          Annotation(
            regExp: RegExp(r'#([a-zA-Z0-9_]+)'),
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
            regExp: RegExp(r'<@(\d+)>'),
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
            regExp: RegExp(r"[(http(s)?):\/\/(www\.)?a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@%_\+~#?&//=]*)"),
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
      ),
    );
  }

  _buildAvatarName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
            color: const Color(0xff7c94b6),
            image: DecorationImage(
              image: NetworkImage(AppStrings.defaultNetworkAvatar),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
            border: Border.all(
              color: Colors.white,
              width: 2.0,
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.authorDisplayName ?? '',
              style: AppTextStyles.s16w700,
            ),
            Text(
              '@${post.authorUsername}',
              style: AppTextStyles.s12w400.copyWith(color: Colors.grey),
            ),
            Text(
              timeago.format(post.createdAt ?? DateTime.now()),
              style: AppTextStyles.s12w400.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}

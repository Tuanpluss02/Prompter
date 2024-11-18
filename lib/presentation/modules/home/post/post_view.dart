import 'package:base/common/constants/app_assets_path.dart';
import 'package:base/common/constants/app_color.dart';
import 'package:base/common/constants/app_regex.dart';
import 'package:base/common/constants/app_text_styles.dart';
import 'package:base/common/utils/extension.dart';
import 'package:base/common/utils/log.dart';
import 'package:base/presentation/modules/home/comment/comment_section.dart';
import 'package:base/presentation/modules/home/components/user_section.dart';
import 'package:base/presentation/modules/home/home_controller.dart';
import 'package:base/presentation/shared/animated/animated_scale_button.dart';
import 'package:base/presentation/shared/global/app_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

class PostView extends GetView<HomeController> {
  const PostView({super.key, required this.news, this.isDetailView = false});

  final PostNewsFeed news;
  final bool isDetailView;

  @override
  Widget build(BuildContext context) {
    var content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPostAuthor(),
        const SizedBox(height: 10),
        _buildPostText(),
        _buildPostMedia(),
        const SizedBox(height: 10),
        _buildPostReact(),
        Divider(),
        if (isDetailView) ...[
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Comments',
              style: AppTextStyles.s16w700,
            ),
          ),
          Divider(),
          const SizedBox(height: 10),
          CommentSection(postId: news.post.id!),
        ],
      ],
    );
    return isDetailView
        ? Scaffold(
            backgroundColor: AppColors.backgroundColor,
            body: SafeArea(
              child: SingleChildScrollView(
                child: content,
              ),
            ),
            appBar: AppBar(
              title: Text('Post Detail'),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
          )
        : GestureDetector(
            onTap: () {
              Get.to(() => PostView(news: news, isDetailView: true));
            },
            child: content,
          );
  }

  _buildPostMedia() {
    return Visibility(
      visible: (news.post.images?.isNotEmpty ?? false),
      child: Container(
        padding: const EdgeInsets.only(top: 10),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: Get.width * 0.6,
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: news.post.images?.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: AppImage(image: NetworkImage(news.post.images![index])),
                ),
              );
            },
          ),
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
          UserSection(user: news.author, timeAgo: news.post.createdAt),
          Spacer(),
          ScaleButton(onTap: () {}, child: SvgPicture.asset(SvgPath.icMore)),
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
            onTap: () => controller.likePost(news),
            child: Row(
              children: [
                SvgPicture.asset(controller.isPostLiked(news) ? SvgPath.icHeartFilled : SvgPath.icHeart),
                const SizedBox(width: 5),
                Text(news.post.likes?.length.toShortString() ?? '', style: AppTextStyles.s14w600),
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
                Text(news.post.comments?.length.toShortString() ?? '', style: AppTextStyles.s14w600),
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
    return Visibility(
      visible: (news.post.content?.isNotEmpty ?? false),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ReadMoreText(
          news.post.content ?? '',
          trimMode: TrimMode.Line,
          trimLines: (news.post.images?.isNotEmpty ?? false) ? 3 : 5,
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
        ),
      ),
    );
  }
}

import 'package:base/common/constants/app_assets_path.dart';
import 'package:base/common/constants/app_strings.dart';
import 'package:base/common/constants/app_text_styles.dart';
import 'package:base/common/utils/extension.dart';
import 'package:base/domain/data/entities/post_entity.dart';
import 'package:base/presentation/modules/home/home_controller.dart';
import 'package:base/presentation/shared/animated/animated_scale_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostView extends GetView<HomeController> {
  const PostView({super.key, required this.post});

  final PostEntity post;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAvatarName(),
              Spacer(),
              GestureDetector(onTap: () {}, child: const Icon(Icons.more_vert)),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SelectableText(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              ScaleButton(
                onTap: () {},
                child: Row(
                  children: [
                    SvgPicture.asset(SvgPath.icHeart),
                    const SizedBox(width: 5),
                    Text(post.likeCount?.toShortString() ?? '', style: AppTextStyles.s14w600),
                  ],
                ),
              ),
              SizedBox(width: 15),
              GestureDetector(
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
              GestureDetector(
                onTap: () {},
                child: SvgPicture.asset(SvgPath.icShare),
              ),
            ],
          ),
        ),
        Divider(),
      ],
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

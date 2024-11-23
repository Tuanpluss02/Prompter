import 'package:base/common/constants/app_assets_path.dart';
import 'package:base/common/constants/app_text_styles.dart';
import 'package:base/presentation/shared/animated/animated_scale_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PostInputAction extends StatelessWidget {
  final Function() onTapImage;
  final Function() onTapLink;
  final Function() onTapMention;
  final Function() onTapHastag;

  const PostInputAction({
    super.key,
    required this.onTapImage,
    required this.onTapLink,
    required this.onTapMention,
    required this.onTapHastag,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ScaleButton(
          onTap: onTapImage,
          child: SvgPicture.asset(
            SvgPath.icImage,
            colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
          ),
        ),
        SizedBox(width: 10),
        ScaleButton(
          onTap: onTapLink,
          child: SvgPicture.asset(
            SvgPath.icLink,
            colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
          ),
        ),
        SizedBox(width: 10),
        ScaleButton(
          onTap: onTapHastag,
          child: Text('#', style: AppTextStyles.s22w400.copyWith(color: Colors.grey)),
        ),
        SizedBox(width: 10),
        ScaleButton(
          onTap: onTapMention,
          child: Text('@', style: AppTextStyles.s22w400.copyWith(color: Colors.grey)),
        ),
      ],
    );
  }
}

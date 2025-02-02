import 'package:base/common/constants/app_assets_path.dart';
import 'package:base/common/constants/app_text_styles.dart';
import 'package:base/domain/data/entities/user_entity.dart';
import 'package:base/presentation/shared/animated/animated_scale_button.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserSection extends StatelessWidget {
  final UserEntity user;

  final Widget? additionalWidget;
  final Function()? onTap;
  final bool showOptions;
  final Function()? onOptionsTap;
  const UserSection({
    super.key,
    required this.user,
    this.onTap,
    this.showOptions = false,
    this.onOptionsTap,
    this.additionalWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 1.0,
            ),
          ),
          child: ClipOval(
              child: Image(
            image: ExtendedNetworkImageProvider(user.profileImage ?? ''),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => SvgPicture.asset(SvgPath.icPersonFilled),
          )),
        ),
        SizedBox(width: 20),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.displayName ?? '',
              style: AppTextStyles.s16w700,
            ),
            Text(
              '@${user.username}',
              style: AppTextStyles.s12w400.copyWith(color: Colors.grey),
            ),
            additionalWidget ?? SizedBox.shrink(),
          ],
        ),
        if (showOptions) ...[
          Spacer(),
          ScaleButton(
            onTap: onOptionsTap ?? () {},
            child: SvgPicture.asset(SvgPath.icMore),
          ),
        ]
      ],
    );
  }
}

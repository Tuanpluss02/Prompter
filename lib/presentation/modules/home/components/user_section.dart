import 'package:base/common/constants/app_strings.dart';
import 'package:base/common/constants/app_text_styles.dart';
import 'package:base/domain/data/entities/user_entity.dart';
import 'package:base/presentation/shared/animated/animated_scale_button.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class UserSection extends StatelessWidget {
  const UserSection({
    super.key,
    required this.user,
    this.timeAgo,
    this.onTap,
    this.showOptions = true,
    this.onOptionsTap,
  });

  final UserEntity user;
  final DateTime? timeAgo;
  final Function()? onTap;
  final bool showOptions;
  final Function()? onOptionsTap;

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
            color: const Color(0xff7c94b6),
            image: DecorationImage(
              image: NetworkImage(user.profileImage ?? AppStrings.defaultNetworkAvatar),
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
              user.displayName ?? '',
              style: AppTextStyles.s16w700,
            ),
            Text(
              '@${user.username}',
              style: AppTextStyles.s12w400.copyWith(color: Colors.grey),
            ),
            Visibility(
              visible: timeAgo != null,
              child: Text(
                timeago.format(timeAgo ?? DateTime.now()),
                style: AppTextStyles.s12w400.copyWith(color: Colors.grey),
              ),
            ),
          ],
        ),
        if (showOptions) ...[
          Spacer(),
          ScaleButton(
            onTap: onOptionsTap ?? () {},
            child: Icon(Icons.more_vert),
          ),
        ]
      ],
    );
  }
}

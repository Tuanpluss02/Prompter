import 'package:flutter/material.dart';
import 'package:base/app/constants/app_assets_path.dart';
import 'package:base/app/constants/app_color.dart';
import 'package:flutter_svg/svg.dart';

/// Represents the type of avatar to be displayed.
enum AvatarType {
  /// Guest avatar, displays the default logo with a black background and white icon.
  guest,

  /// User avatar, displays the default logo with a yellow background and a purple icon.
  user,

  /// Custom avatar, allows for customization of background and icon colors.
  custom
}

/// A widget that displays a `F1 Trading` default avatar with customization options.
class DefaultAvatar extends StatelessWidget {
  /// The size of the avatar. Defaults to 64.
  final double avatarSize;

  /// The color of the icon. Required when [avatarType] is [AvatarType.custom].
  final Color? iconColor;

  /// The background color of the avatar. Required when [avatarType] is [AvatarType.custom].
  final Color? backgroundColor;

  /// The type of avatar. Defaults to [AvatarType.guest].
  final AvatarType avatarType;

  /// Creates a new [DefaultAvatar].
  ///
  /// [iconColor] and [backgroundColor] cannot be null when [avatarType] is [AvatarType.custom].
  const DefaultAvatar({
    super.key,
    this.avatarType = AvatarType.guest,
    this.avatarSize = 64,
    this.iconColor,
    this.backgroundColor,
  }) : assert(
          avatarType != AvatarType.custom ||
              (iconColor != null && backgroundColor != null),
          'iconColor and backgroundColor cannot be null when avatarType is custom',
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: avatarSize,
      height: avatarSize,
      padding: const EdgeInsets.fromLTRB(8, 21, 14, 21.63),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: avatarType == AvatarType.custom
            ? backgroundColor
            : (avatarType == AvatarType.guest
                ? Colors.black
                : AppColors.yellowFFDC00),
      ),
      child: SvgPicture.asset(
        SvgPath.icF1Logo,
        colorFilter: ColorFilter.mode(
            avatarType == AvatarType.custom
                ? iconColor!
                : (avatarType == AvatarType.guest
                    ? Colors.white
                    : AppColors.purple6D15A2),
            BlendMode.srcIn),
      ),
    );
  }
}

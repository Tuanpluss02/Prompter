import 'package:flutter/material.dart';

import '../utils/constants/constants.dart';
import '../values/enumeration.dart';
import '../values/typedefs.dart';
import 'profile_image_widget.dart';

class ProfileCircle extends StatelessWidget {
  const ProfileCircle({
    super.key,
    required this.bottomPadding,
    this.imageUrl,
    this.profileCirclePadding,
    this.circleRadius,
    this.onTap,
    this.onLongPress,
    this.defaultAvatarImage = profileImage,
    this.assetImageErrorBuilder,
    this.networkImageErrorBuilder,
    this.imageType = ImageType.network,
    this.networkImageProgressIndicatorBuilder,
  });

  /// Allow users to give  default bottom padding according to user case.
  final double bottomPadding;

  /// Allow user to pass image url, asset image of user's profile.
  /// Or
  /// Allow user to pass image data of user's profile picture in base64.
  final String? imageUrl;

  /// Field to define image type [network, asset or base64]
  final ImageType? imageType;

  /// Allow user to set whole padding of profile circle view.
  final EdgeInsetsGeometry? profileCirclePadding;

  /// Allow user to set radius of circle avatar.
  final double? circleRadius;

  /// Allow user to do operation when user tap on profile circle.
  final VoidCallback? onTap;

  /// Allow user to do operation when user long press on profile circle.
  final VoidCallback? onLongPress;

  /// Field to set default avatar image if profile image link not provided
  final String defaultAvatarImage;

  /// Error builder to build error widget for asset image
  final AssetImageErrorBuilder? assetImageErrorBuilder;

  /// Error builder to build error widget for network image
  final NetworkImageErrorBuilder? networkImageErrorBuilder;

  /// Progress indicator builder for network image
  final NetworkImageProgressIndicatorBuilder? networkImageProgressIndicatorBuilder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: profileCirclePadding ?? EdgeInsets.only(left: 6.0, right: 4, bottom: bottomPadding),
      child: InkWell(
        onLongPress: onLongPress,
        onTap: onTap,
        child: ProfileImageWidget(
          circleRadius: circleRadius ?? 16,
          imageUrl: imageUrl,
          defaultAvatarImage: defaultAvatarImage,
          assetImageErrorBuilder: assetImageErrorBuilder,
          networkImageErrorBuilder: networkImageErrorBuilder,
          imageType: imageType,
          networkImageProgressIndicatorBuilder: networkImageProgressIndicatorBuilder,
        ),
      ),
    );
  }
}

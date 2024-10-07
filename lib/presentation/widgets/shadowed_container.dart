import 'package:flutter/material.dart';

/// A container widget with a shadow effect.
///
/// This widget is used to create a container with a customizable shadow effect.
/// It can be used to add depth and visual appeal to your UI elements.
///
/// The [width] and [height] parameters are required to define the container's dimensions.
/// The [color] parameter, which defaults to [Colors.white], sets the background color.
///
/// You can customize the shadow effect using the [borderRadius] parameter to round the corners.
/// The shadow itself is created using a [BoxShadow] with predefined properties.
///
/// Additionally, you can provide [margin] and [padding] to control the spacing around the container and its content.
///
/// Example usage:
/// ```dart
/// ShadowedContainer(
///   width: 200,
///   height: 150,
///   color: Colors.blue,
///   borderRadius: BorderRadius.circular(16),
///   child: Center(child: Text('Shadowed Container')),
/// )
/// ```
class ShadowedContainer extends StatelessWidget {
  /// The child widget to be placed inside the container.
  final Widget child;

  /// The width of the container.
  final double? width;

  /// The height of the container.
  final double? height;

  /// The background color of the container. Defaults to [Colors.white].
  final Color color;

  /// The border radius of the container. Defaults to a circular radius of 32.
  final BorderRadiusGeometry? borderRadius;

  /// The margin around the container.
  final EdgeInsetsGeometry? margin;

  /// The padding inside the container.
  final EdgeInsetsGeometry? padding;

  /// Creates a new ShadowedContainer widget.
  const ShadowedContainer({
    super.key,
    this.width,
    this.height,
    this.color = Colors.white,
    this.borderRadius,
    required this.child,
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius ?? BorderRadius.circular(32),
        boxShadow: const [
          BoxShadow(
            color: Color(0x28000000),
            blurRadius: 47,
            offset: Offset(10, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: child,
    );
  }
}

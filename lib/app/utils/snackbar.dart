// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:base/app/constants/app_assets_path.dart';
// import 'package:base/app/constants/app_text_styles.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';

// /// Defines the type of snackbar to be displayed.
// enum SnackbarType { error, success }

// /// Displays a customized snackbar with the given title and message.
// ///
// /// [title] The title of the snackbar.
// /// [message] The main message of the snackbar.
// /// [position] The position of the snackbar on the screen (default is TOP).
// /// [type] The type of snackbar (success or error, default is success).
// void showSnackBar({
//   required String title,
//   required String message,
//   SnackPosition position = SnackPosition.TOP,
//   SnackbarType type = SnackbarType.success,
// }) {
//   Get.showSnackbar(
//     GetSnackBar(
//       messageText: _buildSnackbarContent(type, title, message),
//       snackPosition: position,
//       backgroundColor: Colors.transparent,
//       barBlur: 1,
//       borderRadius: 10,
//       margin: const EdgeInsets.only(bottom: 30),
//       duration: const Duration(seconds: 3),
//       animationDuration: const Duration(milliseconds: 350),
//       forwardAnimationCurve: Curves.fastEaseInToSlowEaseOut,
//       borderWidth: 1,
//       snackStyle: SnackStyle.FLOATING,
//     ),
//   );
// }

// /// Builds the content of the snackbar based on the given type, title, and message.
// ///
// /// [type] The type of snackbar (success or error).
// /// [title] The title of the snackbar.
// /// [message] The main message of the snackbar.
// ///
// /// Returns a Widget representing the snackbar content.
// Widget _buildSnackbarContent(SnackbarType type, String title, String message) {
//   final isSuccess = type == SnackbarType.success;
//   final color = isSuccess ? const Color(0xFF0DAA0A) : const Color(0xFFF32F2F);
//   final icon = isSuccess ? SvgPath.icSuccess : SvgPath.icError;

//   return Container(
//     padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(12),
//       border: isSuccess ? Border(left: BorderSide(width: 5, color: color)) : null,
//       boxShadow: [
//         BoxShadow(
//           color: isSuccess ? const Color(0x1E0EAA0B) : const Color(0x19000000),
//           blurRadius: isSuccess ? 12 : 20,
//           offset: const Offset(0, 4),
//           spreadRadius: 0,
//         )
//       ],
//     ),
//     child: Row(
//       mainAxisSize: MainAxisSize.min,
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         // Icon container
//         Container(
//           width: 39,
//           height: 39,
//           padding: const EdgeInsets.all(8),
//           decoration: ShapeDecoration(
//             color: color,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//           child: SvgPicture.asset(icon),
//         ),
//         const SizedBox(width: 12),
//         // Title and message column
//         Expanded(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Title
//               AutoSizeText(
//                 title,
//                 style: AppTextStyles.s14w800.copyWith(color: color),
//               ),
//               // Message
//               AutoSizeText(
//                 message,
//                 style: AppTextStyles.s12w500.copyWith(color: const Color(0xFF99909B)),
//                 maxLines: 2,
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }
